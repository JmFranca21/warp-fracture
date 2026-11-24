"""Monta a folha do Yeti (Nivária) a partir das pranchas em assets/nivaria/.

Cada prancha é uma grade de figuras com fundo transparente "sujo" (pixels quase invisíveis).
Para cada figura: limpa o alfa, isola a figura (componentes conectados), normaliza a altura
entre pranchas, alinha pelos pés (centro da célula, linha do chão da fileira) e cola numa
célula fixa da folha final.

Saída: assets/nivaria/yeti/yeti_sheet.png (1 animação por linha) e yeti_meta.json.
Rodar:  python tools/import_yeti.py
"""
import json
import os

import numpy as np
from PIL import Image
from scipy import ndimage

ROOT = os.path.join(os.path.dirname(__file__), "..")
SRC = os.path.join(ROOT, "assets", "nivaria")
OUT = os.path.join(SRC, "yeti")

# altura de pé de referência (px da folha final) e célula de saída
STAND_H = 190
CELL = (380, 250)          # largura, altura
ANCHOR = (190, 240)        # pés na célula de saída

# prancha: (arquivo, colunas, linhas, altura de pé medida na prancha original)
SHEETS = {
    "idle": ("Personagem.png", 1, 1, 1160),
    "turn": ("Turn Around Personagem.png", 4, 1, 646),
    "run": ("correndo.png", 4, 2, 400),
    "jump": ("Pulo.png", 4, 2, 379),
    "throw": ("Ataque bola de neve.png", 4, 2, 382),
    "kick": ("Ataque secundario.png", 4, 2, 341),
}


def clean(a: np.ndarray) -> np.ndarray:
    a = a.copy()
    a[a[..., 3] < 40] = 0
    return a


def figure(img: np.ndarray, cols: int, rows: int, idx: int, ground: int):
    H, W = img.shape[:2]
    c, r = idx % cols, idx // cols
    x0, x1 = int(c * W / cols), int((c + 1) * W / cols)
    y0, y1 = int(r * H / rows), int((r + 1) * H / rows)
    # janela com margem: pernas e braços podem passar da célula
    m = 90
    wx0, wx1 = max(0, x0 - m), min(W, x1 + m)
    win = img[y0:y1, wx0:wx1]
    mask = win[..., 3] > 0
    lab, n = ndimage.label(mask, structure=np.ones((3, 3)))
    if n == 0:
        return None
    # componente principal: maior área dentro da célula própria
    inner = np.zeros_like(mask)
    inner[:, x0 - wx0:x1 - wx0] = True
    areas_in = ndimage.sum(inner & mask, lab, range(1, n + 1))
    areas = ndimage.sum(mask, lab, range(1, n + 1))
    main = int(np.argmax(areas_in)) + 1
    ys, xs = np.nonzero(lab == main)
    bx0, by0, bx1, by1 = xs.min(), ys.min(), xs.max(), ys.max()
    keep = lab == main
    # pedaços soltos (tufos de pelo) dentro da caixa da figura principal
    for i in range(1, n + 1):
        if i == main or areas[i - 1] < 30:
            continue
        ys2, xs2 = np.nonzero(lab == i)
        if xs2.min() >= bx0 - 10 and xs2.max() <= bx1 + 10 and ys2.min() >= by0 - 10 and ys2.max() <= by1 + 10:
            keep |= lab == i
    out = win.copy()
    out[~keep] = 0
    cx = (x0 + x1) / 2.0 - wx0
    return out, cx, ground - y0


def main() -> None:
    os.makedirs(OUT, exist_ok=True)
    rows_out = []
    meta = {"cell": CELL, "anchor": ANCHOR, "stand_h": STAND_H, "anims": {}}
    for name, (fn, cols, rows, stand) in SHEETS.items():
        img = clean(np.array(Image.open(os.path.join(SRC, fn)).convert("RGBA")))
        H, W = img.shape[:2]
        k = STAND_H / stand
        # linha do chão de cada fileira: o pé mais baixo da fileira
        grounds = []
        for r in range(rows):
            y0, y1 = int(r * H / rows), int((r + 1) * H / rows)
            ys = np.nonzero((img[y0:y1, ..., 3] > 100).any(axis=1))[0]
            grounds.append(y0 + ys.max())
        frames = []
        for i in range(cols * rows):
            res = figure(img, cols, rows, i, grounds[i // cols])
            if res is None:
                continue
            fig, cx, gy = res
            pil = Image.fromarray(fig)
            pil = pil.resize((max(1, round(pil.width * k)), max(1, round(pil.height * k))), Image.LANCZOS)
            cell = Image.new("RGBA", CELL, (0, 0, 0, 0))
            px, py = round(ANCHOR[0] - cx * k), round(ANCHOR[1] - gy * k)
            cell.paste(pil, (px, py), pil)
            frames.append(cell)
        meta["anims"][name] = {"row": len(rows_out), "frames": len(frames)}
        rows_out.append(frames)
    maxc = max(len(f) for f in rows_out)
    sheet = Image.new("RGBA", (CELL[0] * maxc, CELL[1] * len(rows_out)), (0, 0, 0, 0))
    for r, frames in enumerate(rows_out):
        for c, f in enumerate(frames):
            sheet.paste(f, (c * CELL[0], r * CELL[1]))
    sheet.save(os.path.join(OUT, "yeti_sheet.png"))
    with open(os.path.join(OUT, "yeti_meta.json"), "w") as fh:
        json.dump(meta, fh, indent=1)
    print("ok", sheet.size, meta["anims"])


if __name__ == "__main__":
    main()
