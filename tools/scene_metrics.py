"""Calcula as medidas da DA-03 a partir das capturas de tools/scene_metrics.gd e diz, ponto a ponto, o que
passa nos limites de C2 e C3.

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
    dj = np.asarray(Image.open(d / f"{tag}_d_so_jogador.png").convert("RGB"), float) / 255.0
    pm = dj.max(2) > 0.12           # máscara exata: o personagem sozinho sobre preto (sem halo fraco)
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
    # separação da silhueta (como a R6 da DA-02): fração da borda do personagem com |ΔL| ≥ 0,10
    # entre o lado de dentro (quadro com o jogador) e o de fora (mesmo quadro sem ele), em janelas de 9 px
    full = dj.max(2) > 0.12
    inner = ndimage.binary_erosion(full, iterations=2)
    outer = ndimage.binary_dilation(full, iterations=4) & ~ndimage.binary_dilation(full, iterations=1)
    edge = full & ~ndimage.binary_erosion(full, iterations=1)
    k = np.ones((9, 9))
    si = ndimage.convolve(L * inner, k); ci = ndimage.convolve(inner.astype(float), k)
    so = ndimage.convolve(luma(c) * outer, k); co = ndimage.convolve(outer.astype(float), k)
    valid = edge & (ci > 3) & (co > 3)
    diff = np.abs(si / np.maximum(ci, 1) - so / np.maximum(co, 1))
    sep = float((diff[valid] >= 0.10).mean()) if valid.sum() > 20 else float("nan")
    Lb = luma(b)
    eb = (np.hypot(ndimage.sobel(Lb, 1), ndimage.sobel(Lb, 0)) > 0.25)
    m = {
        "vazio": float(np.mean(tiles)),
        "bordas_sem_fg": eb[~hud].mean(),
        "luma": L[~hud].mean(), "luma_topo": L[130:h//3].mean(), "luma_base": L[2*h//3:].mean(),
        "desvio_luma": L[~hud].std(), "saturacao": sat[~hud].mean(), "bordas": edges[~hud].mean(),
        "primeiro_plano": fg.mean(),
        "contraste_jogador": (L[pm].mean() - Lc[ring].mean()) if pm.sum() > 50 else float("nan"),
        "separacao_borda": sep,
    }
    res.setdefault(lid, []).append(m)
# Limites da DA-03 (C2, C3), calibrados nos 8 pontos do Laboratório e de Verdâmia
LIM = {"luma": (0.08, 0.18), "luma_topo": (None, 0.15), "contraste_jogador": (0.10, None), "separacao_borda": (0.667, None),
       "bordas": (0.04, 0.11), "vazio": (None, 0.60)}


def ok(k, v):
    lo, hi = LIM.get(k, (None, None))
    return (lo is None or v >= lo) and (hi is None or v <= hi)


cols = ["luma", "luma_topo", "separacao_borda", "contraste_jogador", "bordas", "bordas_sem_fg", "vazio"]
print(f"{'ponto':12} " + " ".join(f"{c[:10]:>10}" for c in cols) + "   DA-03 (C2, C3)")
out = {}
for lid, ms in res.items():
    for i, m in enumerate(ms):
        flags = [k for k in LIM if not ok(k, m[k])]
        print(f"{lid + '_' + str(i):12} " + " ".join(f"{m[c]:10.3f}" for c in cols) + ("   passa" if not flags else "   FORA: " + ", ".join(flags)))
    avg = {k: float(np.nanmean([m[k] for m in ms])) for k in ms[0]}
    out[lid] = {"media": avg, "pontos": ms}
    print(f"{lid + ' média':12} " + " ".join(f"{avg[c]:10.3f}" for c in cols))
    print()
json.dump(out, open(d / "medidas.json", "w"), indent=2, default=float)
