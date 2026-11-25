"""Recorta os objetos do Cume de Nivária a partir das pranchas em assets/nivaria/.

Saídas em assets/nivaria/props/:
  plat_gelo.png    placa de gelo (arquivo de origem: elevador.png)
  plat_quebra.png  placa quebradiça, 6 quadros lado a lado (elevador quebrando.png)
  alpinista.png    alpinista: linha 0 = preso no gelo e se soltando (8), linha 1 = correndo (8)
  props_meta.json  tamanhos de célula e âncoras

As pranchas têm fundo "sujo" (manchas quase transparentes e ruído colorido). Cada figura é
isolada pelo componente conectado principal de alfa alto e depois recebe de volta a borda suave.
Rodar:  python tools/import_nivaria_props.py
"""
import json
import os

import numpy as np
from PIL import Image
from scipy import ndimage

ROOT = os.path.join(os.path.dirname(__file__), "..")
SRC = os.path.join(ROOT, "assets", "nivaria")
OUT = os.path.join(SRC, "props")


def load(fn: str) -> np.ndarray:
    return np.array(Image.open(os.path.join(SRC, fn)).convert("RGBA"))


def isolate(win: np.ndarray, core: int = 170, soft: int = 60, margin: int = 12, cell_x=None) -> np.ndarray:
    """Mantém o componente principal (alfa >= core) e os pedaços dentro da caixa dele;
    devolve a janela com o resto zerado (bordas com alfa >= soft coladas ao que ficou)."""
    a = win[..., 3]
    mask = a >= core
    lab, n = ndimage.label(mask, structure=np.ones((3, 3)))
    if n == 0:
        return np.zeros_like(win)
    if cell_x is not None:
        inner = np.zeros_like(mask)
        inner[:, cell_x[0]:cell_x[1]] = True
        areas = ndimage.sum(inner & mask, lab, range(1, n + 1))
    else:
        areas = ndimage.sum(mask, lab, range(1, n + 1))
    main = int(np.argmax(areas)) + 1
    ys, xs = np.nonzero(lab == main)
    bx0, by0, bx1, by1 = xs.min() - margin, ys.min() - margin, xs.max() + margin, ys.max() + margin
    keep = lab == main
    all_areas = ndimage.sum(mask, lab, range(1, n + 1))
    for i in range(1, n + 1):
        if i == main or all_areas[i - 1] < 40:
            continue
        ys2, xs2 = np.nonzero(lab == i)
        if xs2.min() >= bx0 and xs2.max() <= bx1 and ys2.min() >= by0 and ys2.max() <= by1:
            keep |= lab == i
    # borda suave: pixels de alfa médio encostados no que ficou
    grown = ndimage.binary_dilation(keep, iterations=3) & (a >= soft)
    out = win.copy()
    out[~grown] = 0
    return out


def chunks(win: np.ndarray, core: int = 170, soft: int = 60, min_area: int = 120) -> np.ndarray:
    """Mantém todos os componentes de alfa alto com área >= min_area (pedaços de uma placa partida)."""
    a = win[..., 3]
    mask = a >= core
    lab, n = ndimage.label(mask, structure=np.ones((3, 3)))
    areas = ndimage.sum(mask, lab, range(1, n + 1))
    keep = np.isin(lab, [i + 1 for i in range(n) if areas[i] >= min_area])
    # o ruído ciano acima da placa é saturado e quase sem verde-escuro; pedaços de gelo têm textura
    grown = ndimage.binary_dilation(keep, iterations=3) & (a >= soft)
    out = win.copy()
    out[~grown] = 0
    return out


def bbox(a: np.ndarray, thr: int = 1):
    ys, xs = np.nonzero(a[..., 3] >= thr)
    return xs.min(), ys.min(), xs.max() + 1, ys.max() + 1


def platforms(meta: dict) -> None:
    # placa inteira
    img = isolate(load("elevador.png"), margin=30)
    x0, y0, x1, y1 = bbox(img, 60)
    Image.fromarray(img[y0:y1, x0:x1]).save(os.path.join(OUT, "plat_gelo.png"))
    meta["plat_gelo"] = {"size": [int(x1 - x0), int(y1 - y0)]}
    # placa quebradiça: grade 2 colunas x 3 linhas; mesmo recorte relativo em todas as células
    src = load("elevador quebrando.png")
    H, W = src.shape[:2]
    cw, ch = W // 2, H // 3
    cells = []
    for i in range(6):
        c, r = i % 2, i // 2
        cell = src[r * ch:(r + 1) * ch, c * cw:(c + 1) * cw]
        # placa rachada = vários pedaços: fica todo pedaço de gelo grande o bastante (o ruído é miúdo)
        cells.append(chunks(cell))
    # topo da placa no quadro 0 define o alinhamento; a caixa de recorte vale para todos
    x0, y0, x1, _ = bbox(cells[0], 60)
    top = y0
    crop_h = ch - top
    frames = []
    for i, cell in enumerate(cells):
        # alinha o topo de cada quadro inteiro pelo topo do quadro 0 (quadros 4 e 5 caem de verdade)
        if i < 4:
            _, ty, _, _ = bbox(cell, 60)
        else:
            ty = top
        f = np.zeros((crop_h, x1 - x0, 4), np.uint8)
        part = cell[ty:ty + crop_h, x0:x1]
        f[:part.shape[0]] = part
        frames.append(f)
    sheet = np.concatenate(frames, axis=1)
    Image.fromarray(sheet).save(os.path.join(OUT, "plat_quebra.png"))
    meta["plat_quebra"] = {"frame": [int(x1 - x0), int(crop_h)], "frames": 6}


def figures(fn: str, cols: int, rows: int, target_h: float, ref: str):
    """Isola as figuras de uma prancha; devolve [(img, cx, chão)] já escaladas para target_h."""
    img = load(fn)
    H, W = img.shape[:2]
    cw, ch = W // cols, H // rows
    out = []
    for i in range(cols * rows):
        c, r = i % cols, i // cols
        m = 40
        wx0, wx1 = max(0, c * cw - m), min(W, (c + 1) * cw + m)
        win = img[r * ch:(r + 1) * ch, wx0:wx1]
        fig = isolate(win, margin=60, cell_x=(c * cw - wx0, (c + 1) * cw - wx0))
        out.append((fig, (c * cw + cw / 2) - wx0))
    # altura de referência: última figura (de pé) ou mediana
    hs = [bbox(f, 120)[3] - bbox(f, 120)[1] for f, _ in out]
    href = hs[-1] if ref == "last" else float(np.median(hs))
    k = target_h / href
    res = []
    for f, cx in out:
        _, _, _, gy = bbox(f, 120)
        pil = Image.fromarray(f)
        pil = pil.resize((max(1, round(pil.width * k)), max(1, round(pil.height * k))), Image.LANCZOS)
        res.append((pil, cx * k, gy * k))
    return res


def alpinist(meta: dict) -> None:
    cell = (300, 300)
    anchor = (150, 292)
    rows = [figures("alpinista gelo.png", 4, 2, 168, "last"), figures("alpinista correndo.png", 4, 2, 160, "median")]
    sheet = Image.new("RGBA", (cell[0] * 8, cell[1] * 2), (0, 0, 0, 0))
    for r, figs in enumerate(rows):
        for c, (pil, cx, gy) in enumerate(figs):
            px, py = round(anchor[0] - cx), round(anchor[1] - gy)
            tile = Image.new("RGBA", cell, (0, 0, 0, 0))
            tile.paste(pil, (px, py), pil)
            sheet.paste(tile, (c * cell[0], r * cell[1]))
    sheet.save(os.path.join(OUT, "alpinista.png"))
    meta["alpinista"] = {"cell": list(cell), "anchor": list(anchor), "rows": {"gelo": 0, "corre": 1}, "frames": 8}


def main() -> None:
    os.makedirs(OUT, exist_ok=True)
    meta = {}
    platforms(meta)
    alpinist(meta)
    with open(os.path.join(OUT, "props_meta.json"), "w") as fh:
        json.dump(meta, fh, indent=1)
    print("ok", meta)


if __name__ == "__main__":
    main()
