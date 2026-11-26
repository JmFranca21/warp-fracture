"""Auditoria automática das entregas do Deserto (pacotes 11–20): medidas, SHA, quadros, âncoras, cortes na borda,
pixels soltos, quadros repetidos, emendas dos módulos repetíveis e diferença para a v1.
uso: python tools/auditar_entregas_deserto.py > relatorio.md
"""
import glob, hashlib, os, re, sys
from pathlib import Path
import numpy as np
from PIL import Image
from scipy import ndimage

ROOT = Path(__file__).resolve().parents[1]
E = ROOT / "colaboracao/entregas"
# id: (arquivo, grade (cols, rows), quadros esperados, âncora esperada: ("pe", y) | ("centro", (x, y)) | None)
FIG = ("pe", 472)
FOLHAS = {
 "DF60": ("DF60_robo_idle_v2.png", (4, 2), 4, FIG), "DF61": ("DF61_robo_andar_v2.png", (4, 2), 6, FIG),
 "DF62": ("DF62_robo_aviso_v2.png", (4, 2), 3, FIG), "DF63": ("DF63_robo_tiro_v2.png", (4, 2), 3, FIG),
 "DF64": ("DF64_robo_dano_v2.png", (4, 2), 2, FIG), "DF64b": ("DF64b_robo_paralisado.png", (4, 2), 4, FIG),
 "DF65": ("DF65_robo_destruido_v2.png", (4, 2), 6, FIG), "DF66": ("DF66_drone_voo_v2.png", (4, 2), 6, ("centro", (192, 256))),
 "DF67": ("DF67_drone_aviso_v2.png", (4, 2), 3, ("centro", (192, 256))), "DF68": ("DF68_drone_tiro_v2.png", (4, 2), 3, ("centro", (192, 256))),
 "DF69": ("DF69_drone_dano_v2.png", (4, 2), 2, ("centro", (192, 256))), "DF69b": ("DF69b_drone_destruido_v2.png", (4, 2), 6, None),
 "DF69c": ("DF69c_drone_derrubado.png", (4, 2), 4, FIG), "DF70": ("DF70_projetil_robo_v2.png", (4, 2), 4, ("centro", (192, 256))),
 "DF71": ("DF71_projetil_drone_v2.png", (4, 2), 4, ("centro", (192, 256))),
 "DF80": ("DF80_fumaca_chamine_v2.png", (4, 2), 6, ("pe", 500)), "DF81": ("DF81_jato_vapor_v2.png", (4, 2), 8, ("pe", 500)),
 "DF82": ("DF82_faiscas_prensa_v2.png", (4, 2), 6, ("pe", 472)), "DF83": ("DF83_poeira_areia_v2.png", (4, 2), 6, ("pe", 472)),
 "DF84": ("DF84_explosao_maquina_v2.png", (4, 2), 8, ("centro", (192, 256))), "DF85": ("DF85_impacto_projetil_v2.png", (4, 2), 4, ("centro", (192, 256))),
 "DF87": ("DF87_rebite_v2.png", (4, 2), 4, ("centro", (192, 256))), "DF88": ("DF88_disparo_rebite_v2.png", (4, 2), 3, None),
 "DF90": ("DF90_automato_parado_v2.png", (4, 2), 6, FIG), "DF91": ("DF91_automato_andar_v2.png", (4, 2), 8, FIG),
 "DF92": ("DF92_automato_pulo_v2.png", (4, 2), 4, FIG), "DF93": ("DF93_automato_queda_v2.png", (4, 2), 3, FIG),
 "DF94": ("DF94_automato_arranque_v2.png", (4, 2), 4, FIG), "DF95": ("DF95_automato_dano_v2.png", (4, 2), 2, FIG),
 "DF96": ("DF96_automato_derrota_v2.png", (4, 2), 6, FIG), "DF97": ("DF97_automato_braco_v2.png", (4, 2), 4, None),
 "DF98": ("DF98_feixe_ima_v2.png", (4, 2), 8, None), "DF99": ("DF99_pulso_magnetico_v2.png", (4, 2), 6, ("centro", (192, 256))),
 "DF100": ("DF100_forja_corpo_v2.png", (1, 1), 1, ("pe", 2008)), "DF101": ("DF101_forja_lente_v2.png", (4, 2), 4, ("centro", (192, 256))),
 "DF102": ("DF102_forja_peito_v2.png", (4, 2), 6, ("centro", (192, 256))), "DF103": ("DF103_forja_carrinho_v2.png", (1, 1), 1, None),
 "DF104": ("DF104_forja_segmento_v2.png", (1, 1), 1, None), "DF105": ("DF105_forja_martelo_v2.png", (2, 2), 4, None),
 "DF106": ("DF106_forja_nucleo_pistao_v2.png", (4, 2), 3, ("centro", (192, 256))), "DF107": ("DF107_forja_escotilha_v2.png", (4, 2), 4, ("centro", (192, 256))),
 "DF108": ("DF108_forja_grade_v2.png", (4, 2), 8, ("centro", (192, 256))), "DF110": ("DF110_forja_feixe_v2.png", (4, 2), 8, None),
 "DF111": ("DF111_forja_carga_lente_v2.png", (4, 2), 6, ("centro", (192, 256))), "DF112": ("DF112_forja_explosao_nucleo_v2.png", (4, 2), 8, ("centro", (192, 256))),
 "DF210": ("DF210_objetos.png", (4, 2), 8, None), "DF210 ": ("DF210_coletaveis.png", (4, 3), 12, ("centro", (256, 256))),
}
REPET = {  # módulos repetíveis: eixo
 "DF222/DF26_esteira_v2.png": "x", "DF222/DF27_trilho_vertical_v2.png": "y", "DF222/DF55b_trilho_horizontal_v2.png": "x",
 "DF223/DF50b_prensa_haste_v2.png": "y", "DF223/DF51b_prensa_pequena_haste_v2.png": "y"}
PECAS = sorted(glob.glob(str(E / "DF22[2-5]/DF*_v2.png")))


def manifesto(pasta):
    out = {}
    for md in pasta.glob("ENTREGA*.md"):
        t = md.read_text(encoding="utf-8")
        for h, f in re.findall(r"([0-9a-f]{64})\s+`?([\w.\-]+\.(?:png|gif|json))`?", t):
            out[f] = h
        for f, h in re.findall(r"`([\w.\-]+\.(?:png|gif|json))`\s+[—·]\s+`([0-9a-f]{64})`", t):
            out[f] = h
    return out


def sha_ok(p):
    m = manifesto(p.parent).get(p.name)
    h = hashlib.sha256(p.read_bytes()).hexdigest()
    return "sem SHA" if m is None else ("ok" if m == h else "DIFERENTE")


def soltos(alpha):
    lab, n = ndimage.label(alpha > 40)
    if n <= 1:
        return 0
    sizes = ndimage.sum(np.ones_like(lab), lab, range(1, n + 1))
    big = sizes.max()
    return int(((sizes < big * 0.004) & (sizes >= 4)).sum())


def v1_de(code, nome):
    c = [f for f in glob.glob(str(E / code / f"{code}_*.png")) if "_v2" not in f and "montagem" not in f
         and "mira" not in f and "encaixe" not in f and "previa" not in f]
    return c[0] if c else None


print("| ID | arquivo | medidas | SHA | quadros (esperado) | âncora | encosta na borda | pixels soltos | quadros iguais | dif. média p/ v1 |")
print("|---|---|---|---|---|---|---|---|---|---|")
for code, (nome, (cols, rows), esperado, anc) in FOLHAS.items():
    code = code.strip()
    p = E / code / nome
    im = np.asarray(Image.open(p).convert("RGBA")).astype(np.int16)
    H, W = im.shape[:2]
    ch, cw = H // rows, W // cols
    cheios, borda, solto, anc_err, frames = 0, [], 0, [], []
    for i in range(cols * rows):
        r, c = divmod(i, cols)
        cell = im[r * ch:(r + 1) * ch, c * cw:(c + 1) * cw]
        a = cell[:, :, 3]
        ys, xs = np.where(a > 40)
        if len(xs) == 0:
            continue
        cheios += 1
        frames.append(cell)
        if xs.min() == 0 or ys.min() == 0 or xs.max() == cw - 1 or ys.max() == ch - 1:
            borda.append(i + 1)
        s = soltos(a)
        if s:
            solto += s
            borda_s = f"{i + 1}"
        if anc and anc[0] == "pe" and not (code == "DF96" and i >= 2) and code != "DF65":
            if abs(ys.max() - anc[1]) > 3:
                anc_err.append(f"q{i + 1}: base {ys.max()}")
        elif anc and anc[0] == "centro":
            cx, cy = (xs.min() + xs.max()) / 2, (ys.min() + ys.max()) / 2
            if abs(cx - anc[1][0]) > 12 or abs(cy - anc[1][1]) > 12:
                anc_err.append(f"q{i + 1}: centro ({cx:.0f}, {cy:.0f})")
    iguais = sum(1 for k in range(1, len(frames)) if np.abs(frames[k] - frames[k - 1]).mean() < 0.3)
    v1 = v1_de(code, nome) if "_v2" in nome else None
    dif = "—"
    if v1:
        b = np.asarray(Image.open(v1).convert("RGBA")).astype(np.int16)
        dif = f"{np.abs(b - im).mean():.1f}" if b.shape == im.shape else "medida diferente"
    print(f"| {code} | `{nome}` | {W} × {H} | {sha_ok(p)} | {cheios} ({esperado}){' **≠**' if cheios != esperado else ''} | "
          f"{'ok' if not anc_err else '**' + '; '.join(anc_err[:3]) + '**'} {'' if anc else '(livre)'} | "
          f"{', '.join(map(str, borda)) or '—'} | {solto or '—'} | {iguais or '—'} | {dif} |")

print()
print("| peça | medidas | SHA | emenda (dif. média entre bordas opostas) | pixels soltos |")
print("|---|---|---|---|---|")
for f in PECAS:
    p = Path(f)
    im = np.asarray(Image.open(p).convert("RGBA")).astype(np.int16)
    k = f"{p.parent.name}/{p.name}"
    em = "—"
    if k in REPET:
        em = f"{np.abs(im[:, 0] - im[:, -1]).mean():.1f}" if REPET[k] == "x" else f"{np.abs(im[0] - im[-1]).mean():.1f}"
    print(f"| `{p.name}` | {im.shape[1]} × {im.shape[0]} | {sha_ok(p)} | {em} | {soltos(im[:, :, 3]) or '—'} |")
