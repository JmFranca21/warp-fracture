"""Calcula as medidas da DA-03 a partir das capturas de tools/scene_metrics.gd.

uso: python tools/scene_metrics.py <pasta>
Por fase (média dos pontos): luma média da tela, luma do terço de cima (fundo) e do terço de baixo
(chão e primeiro plano), desvio da luma (estrutura de valores), saturação média, densidade de bordas
(quanta estrutura/detalhe a cena tem), cobertura do primeiro plano e contraste do jogador contra o
entorno (luma do personagem menos a do anel de 8 px em volta, do joelho para cima).
"""
import sys, json, glob
from pathlib import Path
import numpy as np
from PIL import Image
from scipy import ndimage

d = Path(sys.argv[1])
def luma(a): return 0.2126*a[...,0]+0.7152*a[...,1]+0.0722*a[...,2]
res = {}
for f in sorted(glob.glob(str(d / "*_a_tudo.png"))):
    tag = Path(f).name.replace("_a_tudo.png", "")
    lid = tag.rsplit("_", 1)[0]
    a = np.asarray(Image.open(f).convert("RGB"), float) / 255.0
    b = np.asarray(Image.open(d / f"{tag}_b_sem_fg.png").convert("RGB"), float) / 255.0
    c = np.asarray(Image.open(d / f"{tag}_c_sem_jogador.png").convert("RGB"), float) / 255.0
    h = a.shape[0]
    hud = np.zeros(a.shape[:2], bool); hud[:130, :] = True     # canto do HUD fora da conta
    L = luma(a)
    mx, mn = a.max(2), a.min(2)
    sat = np.where(mx > 0, (mx - mn) / np.maximum(mx, 1e-6), 0)
    gx = ndimage.sobel(L, 1); gy = ndimage.sobel(L, 0)
    edges = (np.hypot(gx, gy) > 0.25)
    fg = np.abs(luma(a) - luma(b)) > 0.02
    pm = np.abs(luma(a) - luma(c)) > 0.04
    pm = ndimage.binary_opening(pm, iterations=1)
    ring = ndimage.binary_dilation(pm, iterations=8) & ~ndimage.binary_dilation(pm, iterations=2)
    if pm.sum() > 50:            # só do joelho para cima: o chão sob os pés não é o fundo contra o qual o personagem se lê
        ys = np.where(pm.any(1))[0]
        cut = ys.max() - (ys.max() - ys.min()) * 0.3
        rows = np.arange(pm.shape[0])[:, None] < cut
        pm = pm & rows
        ring = ring & rows
    Lc = luma(c)
    # "vazio": fração da área de jogo (sem o HUD) em blocos de 40 px sem estrutura (sem borda e quase sem variação)
    tiles = []
    for y in range(130, h - 40, 40):
        for x in range(0, a.shape[1] - 40, 40):
            tiles.append(edges[y:y+40, x:x+40].mean() < 0.004 and L[y:y+40, x:x+40].std() < 0.015)
    m = {
        "vazio": float(np.mean(tiles)),
        "luma": L[~hud].mean(), "luma_topo": L[130:h//3].mean(), "luma_base": L[2*h//3:].mean(),
        "desvio_luma": L[~hud].std(), "saturacao": sat[~hud].mean(), "bordas": edges[~hud].mean(),
        "primeiro_plano": fg.mean(),
        "contraste_jogador": (L[pm].mean() - Lc[ring].mean()) if pm.sum() > 50 else float("nan"),
    }
    res.setdefault(lid, []).append(m)
print(f"{'fase':10} {'luma':>6} {'topo':>6} {'base':>6} {'desvio':>7} {'satur':>6} {'bordas':>7} {'1ºplano':>8} {'contr.jog':>9} {'vazio':>6}")
out = {}
for lid, ms in res.items():
    avg = {k: float(np.nanmean([m[k] for m in ms])) for k in ms[0]}
    out[lid] = avg
    print(f"{lid:10} {avg['luma']:6.3f} {avg['luma_topo']:6.3f} {avg['luma_base']:6.3f} {avg['desvio_luma']:7.3f} {avg['saturacao']:6.3f} {avg['bordas']:7.3f} {avg['primeiro_plano']:8.3f} {avg['contraste_jogador']:9.3f} {avg['vazio']:6.2f}")
json.dump(out, open(d / "medidas.json", "w"), indent=2)
