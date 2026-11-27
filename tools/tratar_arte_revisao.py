"""Tratamentos de arte sem desenho novo (revisão geral, 26/11/2026). Os originais em colaboracao/entregas/
nunca são alterados: estas funções recebem a imagem já carregada e devolvem uma cópia tratada, que o
tools/import_deserto_v2_folhas.py grava em assets/deserto/ (meia resolução).

- DF91 (Autômato andando) e DF96 (derrota): apaga os fragmentos soltos, componentes opacos com menos
  de 0,4 % do maior componente da célula (as lascas laranja que apareciam abaixo dos pés).
- DF91: desce os quadros 1, 2, 3 e 7, desenhados 35–36 px acima da linha dos pés.

Não tratável sem desenho (vai para colaboracao/pedidos/REV_pedidos_de_arte.md): a lente do Drone vem
cortada reta na linha 342 da célula em todos os quadros da DF66 e no quadro 3 da DF68 (que é cópia do
quadro 1 da DF66); não existe outro quadro com a lente inteira e sem efeito para recompor.

uso direto (relatório, sem gravar nada): python tools/tratar_arte_revisao.py
"""
from pathlib import Path

import numpy as np
from PIL import Image
from scipy import ndimage

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "colaboracao/entregas"
CELL = (384, 512)


def _cells(arr, n, cols=4):
    w, h = CELL
    for k in range(n):
        r, c = divmod(k, cols)
        yield k, (slice(r * h, (r + 1) * h), slice(c * w, (c + 1) * w))


def limpar_soltos(img: Image.Image, n: int, limiar=0.004) -> tuple[Image.Image, list]:
    """Apaga componentes opacos (alfa > 40) pequenos (≥ 4 px e < limiar do maior), com a borda suave
    deles (2 px em volta), sem encostar em nenhum outro componente."""
    arr = np.array(img.convert("RGBA"))
    log = []
    for k, sl in _cells(arr, n):
        cell = arr[sl].copy()
        a = cell[:, :, 3]
        lab, nn = ndimage.label(a > 40)
        if nn <= 1:
            continue
        sizes = ndimage.sum(np.ones_like(lab), lab, range(1, nn + 1))
        big = sizes.max()
        small = [i + 1 for i, s in enumerate(sizes) if 4 <= s < big * limiar]
        if not small:
            continue
        keep = np.isin(lab, [i + 1 for i, s in enumerate(sizes) if s >= big * limiar])
        protect = ndimage.binary_dilation(keep, iterations=2)
        for i in small:
            m = ndimage.binary_dilation(lab == i, iterations=2) & ~protect
            cy, cx = ndimage.center_of_mass(lab == i)
            cell[m] = 0
            log.append("q%d: fragmento de %d px em (%d, %d)" % (k + 1, int(sizes[i - 1]), cx, cy))
        arr[sl] = cell
    return Image.fromarray(arr), log


# DF91 v2: os quadros 1, 2, 3 e 7 vieram desenhados 35–36 px acima da linha dos pés (y 470 nos outros
# quadros, âncora em 472): no jogo o Autômato flutuava 7,7 px a cada passo. Desce o desenho inteiro do
# quadro até os pés tocarem y 470. Os ombros desses quadros em Player.SHOULDER_AUT_PX descem junto.
DF91_DESCE = {1: 36, 2: 36, 3: 35, 7: 35}


def descer_quadros(img: Image.Image, desce: dict) -> tuple[Image.Image, list]:
    arr = np.array(img.convert("RGBA"))
    log = []
    for k, sl in _cells(arr, 8):
        d = desce.get(k + 1, 0)
        if d == 0:
            continue
        cell = arr[sl].copy()
        resto = int((cell[-d:, :, 3] > 40).sum())
        if resto > 400:
            log.append("q%d: não desce, há %d px nas últimas %d linhas" % (k + 1, resto, d))
            continue
        if resto:
            # só lascas soltas abaixo dos pés (o desenho termina 36 px acima): saem antes de descer
            cell[-d:] = 0
            log.append("q%d: apaga %d px de lascas abaixo dos pés" % (k + 1, resto))
        moved = np.zeros_like(cell)
        moved[d:] = cell[:-d]
        arr[sl] = moved
        log.append("q%d: desce %d px (pés em y 470)" % (k + 1, d))
    return Image.fromarray(arr), log


def df91(img):
    a, l1 = limpar_soltos(img, 8)
    b, l2 = descer_quadros(a, DF91_DESCE)
    return b, l1 + l2


TRATAMENTOS = {
    "DF91": df91,
    "DF96": lambda im: limpar_soltos(im, 6),
}


def tratar(code: str, img: Image.Image) -> Image.Image:
    fn = TRATAMENTOS.get(code)
    if fn is None:
        return img
    out, log = fn(img)
    for linha in log:
        print("  tratado %s · %s" % (code, linha))
    return out


if __name__ == "__main__":
    for code, nome in [("DF91", "DF91_automato_andar_v2.png"), ("DF96", "DF96_automato_derrota_v2.png"),
]:
        tratar(code, Image.open(SRC / code / nome))
