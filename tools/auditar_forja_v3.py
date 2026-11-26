"""Auditoria da Forja-Mãe v3 (DF100–DF108, DF110–DF112), a partir de DF100_atlas_v3.json e dos ENTREGA_v3.md.
Estende tools/auditar_entregas_deserto.py para a v3. Não altera nada em colaboracao/entregas/.

Confere, por ID:
  - SHA-256 do mestre contra o atlas e contra o ENTREGA_v3.md; SHA do WebP contra o ENTREGA_v3.md;
  - medidas, grade e célula;
  - quadros ocupados e células vazias (o atlas diz 54 ocupados e 17 reservados);
  - limites RGBA de cada quadro contra o atlas;
  - pixels soltos (componentes pequenos e longe do corpo) e cortes na borda da célula;
  - quadros iguais (diferença média < 0,5 nível) quando deveriam mudar;
  - se o *_jogo_v3.webp é o mestre reduzido a 50 % nos dois eixos;
  - DF100: alfa zero nos cinco vãos e as constantes LENS/CHEST/HATCH/GRATE de scripts/forja.gd.

uso: python tools/auditar_forja_v3.py [--json saida.json] > relatorio.md
"""
import hashlib, json, re, sys
from pathlib import Path
import numpy as np
from PIL import Image
from scipy import ndimage

ROOT = Path(__file__).resolve().parents[1]
E = ROOT / "colaboracao/entregas"
ATLAS = json.loads((E / "DF100/DF100_atlas_v3.json").read_text(encoding="utf-8"))
BASE_ART = np.array([1024, 2008])
BASE_MUNDO = np.array([7770.0, 770.0])
K = 0.214


def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def entrega_shas(pasta):
    t = (pasta / "ENTREGA_v3.md").read_text(encoding="utf-8")
    out = {}
    for f, h in re.findall(r"`([\w.\-]+\.(?:png|webp|json))`\s+[—·]\s+`([0-9a-f]{64})`", t):
        out[f] = h
    m = re.search(r"`(DF\d+_jogo_v3\.webp)`[\s\S]*?SHA-256 `([0-9a-f]{64})`", t)
    if m:
        out[m.group(1)] = m.group(2)
    return out


def soltos(alpha):
    """Componentes opacos pequenos (< 0,4 % do maior, ≥ 4 px) — fragmentos e respingos."""
    lab, n = ndimage.label(alpha > 40)
    if n <= 1:
        return 0, []
    sizes = ndimage.sum(np.ones_like(lab), lab, range(1, n + 1))
    big = sizes.max()
    idx = [i + 1 for i, s in enumerate(sizes) if s < big * 0.004 and s >= 4]
    pos = [tuple(int(v) for v in ndimage.center_of_mass(lab == i)[::-1]) for i in idx[:6]]
    return len(idx), pos


def bbox(alpha):
    ys, xs = np.nonzero(alpha > 0)
    if len(xs) == 0:
        return None
    return [int(xs.min()), int(ys.min()), int(xs.max()) + 1, int(ys.max()) + 1]


def forja_consts():
    src = (ROOT / "scripts/forja.gd").read_text(encoding="utf-8")
    out = {}
    for name in ["BASE", "LENS", "CHEST", "HATCH_L", "HATCH_R", "HATCH", "GRATE"]:
        m = re.search(r"const %s\s*:?=\s*(.+)" % name, src)
        if m:
            out[name] = m.group(1).strip()
    return out


def main():
    rows, det, resumo = [], {}, {"ocupados": 0, "vazios": 0}
    for key, a in ATLAS["ativos"].items():
        aid = a["id"]
        pasta = E / aid
        p = pasta / a["arquivo"]
        im = Image.open(p)
        rgba = np.array(im.convert("RGBA"))
        H, W = rgba.shape[:2]
        cols, rws = a["grade"]
        cw, ch = a["celula"]
        info = {"arquivo": a["arquivo"], "problemas": []}
        prob = info["problemas"]
        # SHA
        h = sha(p)
        esh = entrega_shas(pasta)
        info["sha_atlas"] = "ok" if h == a["sha256"] else "DIFERENTE"
        info["sha_entrega"] = "ok" if esh.get(a["arquivo"]) == h else ("sem SHA" if a["arquivo"] not in esh else "DIFERENTE")
        if info["sha_atlas"] != "ok" or info["sha_entrega"] != "ok":
            prob.append("SHA do mestre não confere")
        # medidas e grade
        info["medidas"] = [W, H]
        if [W, H] != a["dimensoes"] or W != cols * cw or H != rws * ch:
            prob.append("medidas/grade: %dx%d, esperado %s com %dx%d de %dx%d" % (W, H, a["dimensoes"], cols, rws, cw, ch))
        # quadros
        n_esp = len(a["quadros"])
        vazias_esp = set(a.get("celulas_vazias", []))
        cells = []
        occ, vaz = [], []
        for r in range(rws):
            for c in range(cols):
                i = r * cols + c + 1
                cell = rgba[r * ch:(r + 1) * ch, c * cw:(c + 1) * cw]
                cells.append(cell)
                (occ if (cell[:, :, 3] > 0).any() else vaz).append(i)
        info["ocupados"] = len(occ)
        info["vazios"] = len(vaz)
        resumo["ocupados"] += len(occ)
        resumo["vazios"] += len(vaz)
        if len(occ) != n_esp or set(vaz) != vazias_esp:
            prob.append("quadros ocupados %s / vazios %s; esperado %d e vazios %s" % (occ, vaz, n_esp, sorted(vazias_esp)))
        # limites, borda, soltos
        lim = a.get("limites_rgba", [])
        borda, slt, bbs = [], [], []
        for k, i in enumerate(occ):
            cell = cells[i - 1]
            al = cell[:, :, 3]
            bb = bbox(al)
            bbs.append(bb)
            if k < len(lim):
                d = max(abs(bb[j] - lim[k][j]) for j in range(4))
                if d > 3:
                    prob.append("quadro %d: limites %s, atlas %s" % (i, bb, lim[k]))
            # DF110 (faixa repetível) encosta de propósito nas bordas esquerda/direita da linha de feixe
            repet_x = aid == "DF110" and i <= 4
            touch = []
            if (al[0, :] > 8).any():
                touch.append("topo")
            if (al[-1, :] > 8).any():
                touch.append("base")
            if not repet_x and (al[:, 0] > 8).any():
                touch.append("esq")
            if not repet_x and (al[:, -1] > 8).any():
                touch.append("dir")
            if touch:
                borda.append("%d:%s" % (i, "/".join(touch)))
            n, pos = soltos(al)
            if n:
                slt.append("%d:%d %s" % (i, n, pos))
        info["limites"] = bbs
        info["borda"] = borda
        info["soltos"] = slt
        if borda:
            prob.append("encosta na borda da célula: " + ", ".join(borda))
        if slt:
            prob.append("pixels soltos: " + "; ".join(slt))
        # quadros iguais
        iguais = []
        for x in range(len(occ)):
            for y in range(x + 1, len(occ)):
                A = cells[occ[x] - 1].astype(np.float32)
                B = cells[occ[y] - 1].astype(np.float32)
                dm = np.abs(A - B).mean()
                if dm < 0.5:
                    iguais.append("%d=%d (%.2f)" % (occ[x], occ[y], dm))
        info["iguais"] = iguais
        if iguais:
            prob.append("quadros iguais: " + ", ".join(iguais))
        # diferença entre quadros consecutivos (para animações que devem mudar)
        difs = []
        for x in range(len(occ) - 1):
            A = cells[occ[x] - 1].astype(np.float32)
            B = cells[occ[x + 1] - 1].astype(np.float32)
            m = (A[:, :, 3] > 0) | (B[:, :, 3] > 0)
            difs.append(round(float(np.abs(A - B)[m].mean()) if m.any() else 0.0, 2))
        info["dif_consecutivos"] = difs
        # WebP = mestre / 2
        wp = pasta / ("%s_jogo_v3.webp" % aid)
        if wp.exists():
            wim = Image.open(wp)
            info["webp_medidas"] = list(wim.size)
            info["webp_sha_entrega"] = "ok" if esh.get(wp.name) == sha(wp) else ("sem SHA" if wp.name not in esh else "DIFERENTE")
            if list(wim.size) != [W // 2, H // 2]:
                prob.append("WebP %s, esperado %dx%d" % (wim.size, W // 2, H // 2))
            else:
                ref = np.array(im.convert("RGBA").resize((W // 2, H // 2), Image.LANCZOS)).astype(np.float32)
                ww = np.array(wim.convert("RGBA")).astype(np.float32)
                m = (ref[:, :, 3] > 20) | (ww[:, :, 3] > 20)
                drgb = float(np.abs(ref[:, :, :3] - ww[:, :, :3])[m].mean())
                dal = float(np.abs(ref[:, :, 3] - ww[:, :, 3]).mean())
                info["webp_dif_rgb"] = round(drgb, 2)
                info["webp_dif_alfa"] = round(dal, 3)
                # centros dos quadros não podem andar: compara o centroide do alfa célula a célula
                desl = 0.0
                for r in range(rws):
                    for c in range(cols):
                        a1 = ref[r * ch // 2:(r + 1) * ch // 2, c * cw // 2:(c + 1) * cw // 2, 3]
                        a2 = ww[r * ch // 2:(r + 1) * ch // 2, c * cw // 2:(c + 1) * cw // 2, 3]
                        if a1.sum() > 0 and a2.sum() > 0:
                            c1 = np.array(ndimage.center_of_mass(a1))
                            c2 = np.array(ndimage.center_of_mass(a2))
                            desl = max(desl, float(np.abs(c1 - c2).max()))
                info["webp_desloc_px"] = round(desl, 2)
                if drgb > 6 or dal > 2 or desl > 0.75:
                    prob.append("WebP difere do mestre reduzido (rgb %.1f, alfa %.2f, desloc. %.2f px)" % (drgb, dal, desl))
            if info["webp_sha_entrega"] != "ok":
                prob.append("SHA do WebP: %s" % info["webp_sha_entrega"])
        else:
            prob.append("sem *_jogo_v3.webp")
        det[aid] = info

    # DF100: vãos com alfa zero e constantes do jogo
    corpo = np.array(Image.open(E / "DF100/DF100_forja_corpo_v3.png").convert("RGBA"))[:, :, 3]
    anc = ATLAS["coordenadas_ancoras"]["DF100"]
    vaos = {"lente": ("circ", anc["lente"], 360), "peito": ("ret", anc["peito"], (420, 360)),
            "escotilha_esquerda": ("ret", anc["escotilha_esquerda"], (240, 160)),
            "escotilha_direita": ("ret", anc["escotilha_direita"], (240, 160)),
            "grade": ("ret", anc["grade"], (700, 240))}
    enc = {}
    yy, xx = np.mgrid[0:corpo.shape[0], 0:corpo.shape[1]]
    for nome, (tipo, c, med) in vaos.items():
        if tipo == "circ":
            m = (xx - c[0]) ** 2 + (yy - c[1]) ** 2 <= (med / 2 - 1) ** 2
            # anel logo fora do furo deve ser opaco (moldura)
            anel = ((xx - c[0]) ** 2 + (yy - c[1]) ** 2 > (med / 2 + 4) ** 2) & ((xx - c[0]) ** 2 + (yy - c[1]) ** 2 <= (med / 2 + 14) ** 2)
        else:
            w, h = med
            m = (abs(xx - c[0]) <= w / 2 - 1) & (abs(yy - c[1]) <= h / 2 - 1)
            anel = ((abs(xx - c[0]) <= w / 2 + 14) & (abs(yy - c[1]) <= h / 2 + 14)) & ~((abs(xx - c[0]) <= w / 2 + 4) & (abs(yy - c[1]) <= h / 2 + 4))
        frac_opaca = float((corpo[m] > 0).mean())
        borda_op = float((corpo[anel] > 200).mean())
        # medida real do vão: maior retângulo de alfa zero centrado no ponto
        cx, cy = c
        def run(dx, dy):
            n = 0
            x, y = cx, cy
            while 0 <= x < corpo.shape[1] and 0 <= y < corpo.shape[0] and corpo[y, x] == 0:
                n += 1
                x += dx
                y += dy
            return n
        real = (run(-1, 0) + run(1, 0) - 1, run(0, -1) + run(0, 1) - 1)
        mundo = BASE_MUNDO + (np.array(c) - BASE_ART) * K
        enc[nome] = {"centro_arte": c, "medida_pedida": med, "medida_real_no_centro": real,
                     "alfa_nao_zero_no_vao": round(frac_opaca, 4), "moldura_opaca": round(borda_op, 3),
                     "centro_mundo": [round(float(mundo[0]), 2), round(float(mundo[1]), 2)]}
    resumo["encaixes"] = enc
    resumo["forja_gd"] = forja_consts()

    # relatório
    print("# Auditoria da Forja-Mãe v3 (gerada por `tools/auditar_forja_v3.py`)\n")
    print("Total: %d quadros ocupados e %d células vazias (a entrega diz 54 e 17).\n" % (resumo["ocupados"], resumo["vazios"]))
    print("| ID | medidas | SHA mestre (atlas / ENTREGA) | quadros | WebP = mestre/2 | borda | soltos | quadros iguais | dif. entre quadros seguidos |")
    print("|---|---|---|---|---|---|---|---|---|")
    for aid, i in det.items():
        wp = "%s · rgb %.1f · alfa %.2f · desloc %.2f" % (i.get("webp_sha_entrega", "-"), i.get("webp_dif_rgb", -1), i.get("webp_dif_alfa", -1), i.get("webp_desloc_px", -1))
        print("| %s | %dx%d | %s / %s | %d ocup. · %d vaz. | %s | %s | %s | %s | %s |" % (
            aid, i["medidas"][0], i["medidas"][1], i["sha_atlas"], i["sha_entrega"], i["ocupados"], i["vazios"], wp,
            ", ".join(i["borda"]) or "—", "; ".join(i["soltos"]) or "—", ", ".join(i["iguais"]) or "—", i["dif_consecutivos"]))
    print("\n## Encaixes do corpo DF100\n")
    print("| vão | centro (arte) | pedido | medida real no centro | alfa ≠ 0 dentro | moldura opaca em volta | centro no mundo |")
    print("|---|---|---|---|---|---|---|")
    for n, e in enc.items():
        print("| %s | %s | %s | %s | %.2f %% | %.0f %% | %s |" % (n, e["centro_arte"], e["medida_pedida"], e["medida_real_no_centro"],
              e["alfa_nao_zero_no_vao"] * 100, e["moldura_opaca"] * 100, e["centro_mundo"]))
    print("\nConstantes atuais de `scripts/forja.gd`: `%s`\n" % resumo["forja_gd"])
    print("## Problemas por ID\n")
    for aid, i in det.items():
        print("- **%s**: %s" % (aid, "; ".join(i["problemas"]) or "nenhum problema técnico"))
    if "--json" in sys.argv:
        Path(sys.argv[sys.argv.index("--json") + 1]).write_text(json.dumps({"ativos": det, "resumo": resumo}, indent=1, ensure_ascii=False), encoding="utf-8")


if __name__ == "__main__":
    main()
