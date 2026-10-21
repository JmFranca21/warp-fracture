"""Extrai quadros de pranchas 4x2 (fundo verde ou transparente).
- remove fundo com alfa suave e tira o verde vazado das bordas (despill)
- separa quadros por componentes conectados (atribuídos à célula pelo centróide)
- salva cada quadro recortado + âncora (pés ou centro) em JSON
uso: python extract.py <src_dir> <out_dir>
"""
import sys, json, os
import numpy as np
from PIL import Image
from scipy import ndimage

SRC, OUT = sys.argv[1], sys.argv[2]
CW, CH = 384, 512

# nome_saida: (arquivo, modo_âncora, quadros_esperados)
SPECS = {
    "daymon/idle": ("01_Daymon_sem_braco/idle_v1_fundo_escuro.png", "feet", 6),
    "daymon/run": ("01_Daymon_sem_braco/run_v2_verde.png", "feet", 8),
    "daymon/jump": ("01_Daymon_sem_braco/jump_v1.png", "feet", 3),
    "daymon/fall": ("01_Daymon_sem_braco/fall_v1.png", "feet", 3),
    "daymon/dash": ("01_Daymon_sem_braco/dash.png", "feet", 4),
    "daymon/hurt": ("02_Daymon_com_bracos/hurt_v1.png", "feet", 2),
    "daymon/death": ("02_Daymon_com_bracos/death_v1.png", "feet", 6),
    "arma/braco": ("03_Arma/braco_arma_v2.png", "box", 1),
    "arma/disparo": ("03_Arma/disparo.png", "center", 3),
    "drone/fly": ("04_Drone/fly.png", "body", 6),
    "drone/charge": ("04_Drone/charge.png", "body", 4),
    "drone/shoot": ("04_Drone/shoot_v2.png", "body", 3),
    "drone/hurt": ("04_Drone/hurt.png", "body", 2),
    "drone/death": ("04_Drone/death.png", "center", 6),
    "rastejador/death": ("05_Rastejador/death.png", "feet", 6),
    "fx/explosao": ("06_Efeitos/explosao_barril.png", "center", 8),
    "fx/caixa": ("06_Efeitos/caixa_quebrando.png", "center", 6),
    "fx/impacto": ("06_Efeitos/impacto_tiro.png", "center", 4),
    "fx/campo": ("06_Efeitos/campo_energia.png", "center", 6),
}


def key(a):
    rgb = a[..., :3].astype(np.float32)
    r, g, b = rgb[..., 0], rgb[..., 1], rgb[..., 2]
    al = a[..., 3].astype(np.float32) / 255.0
    # "verdice": quanto o verde excede os outros canais
    gx = g - np.maximum(r, b)
    green_alpha = np.clip(1.0 - (gx - 25.0) / 110.0, 0.0, 1.0)
    alpha = np.minimum(al, green_alpha)
    # despill: limita o verde ao maior dos outros canais nas áreas esverdeadas
    spill = gx > 0
    g2 = np.where(spill, np.maximum(r, b) + np.clip(gx, 0, 0) , g)
    # mantém leve verde em pixels que são realmente ciano/verde-claros (b alto)
    g2 = np.where(spill & (b > 150), np.minimum(g, np.maximum(r, b) + 10), g2)
    out = np.dstack([r, g2, b, alpha * 255.0]).clip(0, 255).astype(np.uint8)
    return out


def main():
    meta = {}
    for name, (fn, mode, n_exp) in SPECS.items():
        a = np.array(Image.open(os.path.join(SRC, fn)).convert("RGBA"))
        k = key(a)
        alpha = k[..., 3] > 110
        lab, n = ndimage.label(alpha, structure=np.ones((3, 3)))
        if n == 0:
            print("vazio", name); continue
        idx = np.arange(1, n + 1)
        sizes = ndimage.sum(alpha, lab, idx)
        coms = ndimage.center_of_mass(alpha, lab, idx)
        cell_of = {}
        for i, (sz, (cy, cx)) in enumerate(zip(sizes, coms)):
            if sz < 6:
                continue
            c = (int(min(cy // CH, 1)), int(min(cx // CW, 3)))
            cell_of[i + 1] = c
        cells = sorted(set(cell_of.values()))
        # descarta células só com poeira
        cell_mass = {c: sum(sizes[l - 1] for l, cc in cell_of.items() if cc == c) for c in cells}
        cells = [c for c in cells if cell_mass[c] > 400]
        if name == "arma/braco":
            cells = [max(cell_mass, key=cell_mass.get)]
            for l in list(cell_of):
                cell_of[l] = cells[0]
        os.makedirs(os.path.join(OUT, os.path.dirname(name)), exist_ok=True)
        frames = []
        for fi, c in enumerate(cells):
            labels = [l for l, cc in cell_of.items() if cc == c]
            m = np.isin(lab, labels)
            # inclui a borda suave (alfa baixo) ao redor dos componentes do quadro
            m_soft = ndimage.binary_dilation(m, iterations=3)
            # não pega pixels que pertencem a componentes de outras células
            other = np.isin(lab, [l for l, cc in cell_of.items() if cc != c])
            m_soft &= ~ndimage.binary_dilation(other, iterations=2)
            ys, xs = np.nonzero(m)
            y0, y1, x0, x1 = ys.min(), ys.max() + 1, xs.min(), xs.max() + 1
            pad = 4
            y0p, y1p = max(0, y0 - pad), min(a.shape[0], y1 + pad)
            x0p, x1p = max(0, x0 - pad), min(a.shape[1], x1 + pad)
            crop = k[y0p:y1p, x0p:x1p].copy()
            crop[..., 3] = np.where(m_soft[y0p:y1p, x0p:x1p], crop[..., 3], 0)
            mm = m[y0p:y1p, x0p:x1p]
            h, w = mm.shape
            if mode == "feet":
                top = np.nonzero(mm.any(1))[0][0]
                bot = np.nonzero(mm.any(1))[0][-1]
                band = mm[top: top + max(8, int((bot - top) * 0.35))]
                bx = np.nonzero(band)[1].mean()
                anchor = (float(bx), float(bot + 1))
            elif mode == "body":
                big = max(labels, key=lambda l: sizes[l - 1])
                cy, cx = coms[big - 1]
                anchor = (float(cx - x0p), float(cy - y0p))
            elif mode == "box":
                anchor = (0.0, h / 2.0)
            else:
                cy, cx = ndimage.center_of_mass(mm)
                anchor = (float(cx), float(cy))
            path = f"{name}_{fi:02d}.png"
            Image.fromarray(crop).save(os.path.join(OUT, path))
            frames.append({"file": path, "w": w, "h": h, "anchor": anchor, "cell": c})
        meta[name] = frames
        flag = "" if len(frames) == n_exp else f"  <-- esperado {n_exp}"
        print(f"{name:20s} quadros={len(frames)}{flag}")
    json.dump(meta, open(os.path.join(OUT, "meta.json"), "w"), indent=1)


main()
