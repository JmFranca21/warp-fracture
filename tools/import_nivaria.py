"""Recorta das fichas aprovadas de Nivária (GL01–GL04 v2) as peças usadas como PLACEHOLDER no jogo.

uso: python tools/import_nivaria.py [--sheet pasta]

As fichas são pranchas de referência, não folhas de produção. Enquanto o lote 2 não chega,
o jogo usa recortes delas: cada peça é cortada de um retângulo aproximado, o fundo da prancha
é removido por preenchimento a partir das bordas (só o fundo ligado à borda some, então o
contorno escuro interno é preservado) e a peça é salva em assets/nivaria/<id>.webp.
Os nomes dos arquivos dizem de que ficha e de que vista vêm (ver PECAS). Com --sheet, monta
uma prancha de conferência com todas as peças sobre fundo cinza.
"""
import sys
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageFilter
from scipy import ndimage

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "colaboracao/entregas"
OUT = ROOT / "assets/nivaria"
FICHAS = {
    "GL01": "GL01/GL01_ficha_daymon_inverno_v2.png",
    "GL02": "GL02/GL02_ficha_inimigos_nivaria_v2.png",
    "GL03": "GL03/GL03_ficha_guardiao_v2.png",
    "GL04": "GL04/GL04_prancha_objetos_v2.png",
}

# id: (ficha, (x0, y0, x1, y1) aproximado, tolerância do fundo)
PECAS = {
    # GL01 — Daymon de inverno
    "gl01_bloco": ("GL01", (1410, 535, 1478, 646), 26),
    # GL02 — inimigos
    "gl02_gelinho": ("GL02", (350, 150, 480, 281), 26),
    "gl02_gelinho_aviso": ("GL02", (945, 112, 1120, 281), 26),
    "gl02_gelinho_sopro": ("GL02", (1236, 150, 1450, 281), 26),
    "gl02_drone": ("GL02", (285, 400, 545, 515), 26),
    "gl02_drone_mira": ("GL02", (903, 400, 1162, 515), 26),
    "gl02_esfera": ("GL02", (1262, 368, 1422, 410), 26),
    "gl02_gelo_chao": ("GL02", (1230, 466, 1455, 513), 26),
    "gl02_morcego_teto": ("GL02", (388, 596, 446, 742), 26),
    "gl02_morcego_voo": ("GL02", (915, 594, 1155, 742), 26),
    # GL03 — Guardião Glacial
    "gl03_frontal": ("GL03", (40, 96, 676, 678), 22),
    "gl03_aviso": ("GL03", (28, 728, 236, 888), 22),
    "gl03_investida": ("GL03", (266, 728, 490, 888), 22),
    "gl03_estacas": ("GL03", (506, 728, 730, 888), 22),
    "gl03_onda": ("GL03", (748, 728, 1004, 888), 22),
    "gl03_atordoado": ("GL03", (1042, 722, 1264, 888), 22),
    "gl03_derrota": ("GL03", (1278, 728, 1502, 888), 22),
    "gl03_peito3": ("GL03", (1186, 128, 1302, 228), 22),
    "gl03_peito2": ("GL03", (1336, 128, 1454, 228), 22),
    "gl03_peito1": ("GL03", (1186, 258, 1302, 352), 22),
    "gl03_peito0": ("GL03", (1336, 258, 1458, 352), 22),
    # GL04 — objetos e perigos
    "gl04_gelo_fino0": ("GL04", (26, 160, 124, 205), 22),
    "gl04_gelo_fino1": ("GL04", (125, 160, 220, 205), 22),
    "gl04_gelo_fino2": ("GL04", (220, 160, 314, 205), 22),
    "gl04_gelo_fino3": ("GL04", (315, 160, 404, 205), 22),
    "gl04_estalactite": ("GL04", (458, 138, 544, 226), 22),
    "gl04_estalactite_quebrada": ("GL04", (672, 138, 752, 226), 22),
    "gl04_cristal_off": ("GL04", (804, 168, 918, 230), 22),
    "gl04_cristal_aviso": ("GL04", (930, 168, 1052, 230), 22),
    "gl04_cristal_on": ("GL04", (1056, 155, 1168, 230), 22),
    "gl04_nevoa": ("GL04", (1222, 165, 1503, 222), 22),
    "gl04_espinhos": ("GL04", (96, 336, 294, 466), 22),
    "gl04_bloco": ("GL04", (406, 346, 516, 446), 22),
    "gl04_plataforma": ("GL04", (544, 388, 672, 426), 22),
    "gl04_parede": ("GL04", (866, 342, 1004, 456), 22),
    "gl04_parede_meio": ("GL04", (1016, 356, 1160, 456), 22),
    "gl04_gelo_liso": ("GL04", (1234, 378, 1490, 444), 22),
    "gl04_bola_p": ("GL04", (58, 568, 100, 604), 22),
    "gl04_bola_p_trinca": ("GL04", (258, 571, 316, 606), 22),
    "gl04_bola_g": ("GL04", (42, 642, 116, 710), 22),
    "gl04_bola_g_trinca": ("GL04", (254, 642, 328, 710), 22),
    "gl04_bola_g_explode": ("GL04", (346, 630, 430, 714), 22),
    "gl04_gancho": ("GL04", (536, 566, 712, 704), -22),   # tolerância negativa: também fura o miolo do aro
    "gl04_braseiro_off": ("GL04", (836, 596, 940, 684), 22),
    "gl04_braseiro_on": ("GL04", (980, 550, 1090, 684), 22),
    "gl04_elevador": ("GL04", (1166, 580, 1316, 684), 22),
    "gl04_observatorio": ("GL04", (14, 810, 266, 958), 22),
    "gl04_painel": ("GL04", (364, 834, 444, 924), 22),
    "gl04_celula": ("GL04", (494, 810, 562, 928), 22),
    "gl04_nucleo": ("GL04", (584, 816, 692, 924), 22),
    "gl04_registro": ("GL04", (710, 808, 796, 934), 22),
    "gl04_estaca0": ("GL04", (842, 916, 948, 954), 22),
    "gl04_estaca1": ("GL04", (960, 846, 1040, 954), 22),
    "gl04_estaca2": ("GL04", (1046, 800, 1164, 958), 22),
}


def cut(img: np.ndarray, box, tol: int) -> Image.Image:
    holes = tol < 0
    tol = abs(tol)
    x0, y0, x1, y1 = box
    a = img[y0:y1, x0:x1].astype(np.int32)
    h, w, _ = a.shape
    border = np.concatenate([a[0], a[-1], a[:, 0], a[:, -1]])
    bg = np.median(border, axis=0)
    near = np.sqrt(((a - bg) ** 2).sum(axis=2)) < tol
    lab, _ = ndimage.label(near)
    edge = set(np.unique(np.concatenate([lab[0], lab[-1], lab[:, 0], lab[:, -1]]))) - {0}
    bgmask = np.isin(lab, list(edge))
    if holes:      # miolos fechados com a cor do fundo (aro do gancho) também viram transparência
        sizes = ndimage.sum(near, lab, range(1, lab.max() + 1))
        bgmask |= np.isin(lab, [i + 1 for i, sz in enumerate(sizes) if sz > 120])
    fg = ~bgmask
    # remove fragmentos pequenos soltos (marcas de cruz, letras vizinhas)
    lab2, n = ndimage.label(fg)
    if n:
        sizes = ndimage.sum(fg, lab2, range(1, n + 1))
        keep = np.zeros(n + 1, bool)
        keep[1:] = sizes >= max(40, sizes.max() * 0.02)
        fg = keep[lab2]
    alpha = Image.fromarray((fg * 255).astype(np.uint8)).filter(ImageFilter.GaussianBlur(0.6))
    rgba = Image.fromarray(a.astype(np.uint8)).convert("RGBA")
    rgba.putalpha(alpha)
    bb = Image.fromarray((fg * 255).astype(np.uint8)).getbbox()
    return rgba.crop(bb) if bb else rgba


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    cache = {k: np.array(Image.open(SRC / v).convert("RGB")) for k, v in FICHAS.items()}
    pieces = {}
    for pid, (f, box, tol) in PECAS.items():
        im = cut(cache[f], box, tol)
        im.save(OUT / (pid + ".webp"), lossless=True, method=5)
        pieces[pid] = im
        print(pid, im.size)
    if "--sheet" in sys.argv:
        dest = Path(sys.argv[sys.argv.index("--sheet") + 1])
        cols, cw, ch = 8, 190, 190
        rows = (len(pieces) + cols - 1) // cols
        sheet = Image.new("RGBA", (cols * cw, rows * ch), (110, 116, 128, 255))
        d = ImageDraw.Draw(sheet)
        for i, (pid, im) in enumerate(pieces.items()):
            t = im.copy()
            t.thumbnail((cw - 10, ch - 26))
            x, y = (i % cols) * cw, (i // cols) * ch
            sheet.alpha_composite(t, (x + 5, y + 5))
            d.text((x + 5, y + ch - 18), pid, fill=(255, 255, 255, 255))
        sheet.save(dest)


if __name__ == "__main__":
    main()
