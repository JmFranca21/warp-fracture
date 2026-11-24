"""Importa os fundos refeitos do Deserto (DF200 e DF201, das entregas aprovadas) para assets/deserto/fundo/.
Cópias fiéis, com uma exceção: na DF201_proximo (repetida a cada 2.560 px) as colunas 0 e 2.559 vieram
iguais entre si, ~2 níveis mais claras que as vizinhas, entre duas colunas mais escuras de cada lado (a borda
foi espelhada), e formavam um fio de 2 px na emenda. A cópia do jogo troca as 8 colunas da emenda
(2.556–2.559 e 0–3) pela interpolação entre as colunas 2.555 e 4.
O script também confere as medidas que a montagem em scripts/desert.gd supõe.
uso: python tools/import_deserto_fundos.py
"""
from pathlib import Path
import shutil
import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
DST = ROOT / "assets/deserto/fundo"
PECAS = {  # arquivo: (pasta da entrega, tamanho esperado)
    "DF200_ceu.png": ("DF200", (2560, 1440)),
    "DF201_distante.png": ("DF201", (2560, 840)),
    "DF201_proximo.png": ("DF201", (2560, 840)),
}


def main() -> None:
    DST.mkdir(parents=True, exist_ok=True)
    for n, (pasta, size) in PECAS.items():
        src = ROOT / "colaboracao/entregas" / pasta / n
        im = Image.open(src)
        assert im.size == size, f"{n}: {im.size} (esperado {size})"
        if n == "DF201_proximo.png":
            a = np.asarray(im.convert("RGBA")).astype(float)
            # a borda veio espelhada: duas colunas mais escuras de cada lado e o par claro no centro;
            # as 8 colunas da emenda (2556–2559 e 0–3) viram a interpolação entre a 2555 e a 4
            left, right = a[:, -5].copy(), a[:, 4].copy()
            for j, c in enumerate([-4, -3, -2, -1, 0, 1, 2, 3]):
                t = (j + 1) / 9
                a[:, c] = left * (1 - t) + right * t
            Image.fromarray(np.clip(np.rint(a), 0, 255).astype(np.uint8)).save(DST / n)
            print(f"{n:22s} {im.size} {im.mode}  emenda refeita: colunas 2556–2559 e 0–3 interpoladas entre 2555 e 4")
        else:
            shutil.copyfile(src, DST / n)
            print(f"{n:22s} {im.size} {im.mode}")
    a = np.asarray(Image.open(DST / "DF201_proximo.png").convert("RGBA")).astype(int)
    lum = 0.2126 * a[..., 0] + 0.7152 * a[..., 1] + 0.0722 * a[..., 2]
    print("DF201_proximo: luma média (0–255) das colunas 2554, 2556, 2558, 2559 | 0, 1, 3, 5:",
          [round(lum[200:, c].mean(), 2) for c in (2554, 2556, 2558, 2559, 0, 1, 3, 5)])
    for n in ("DF201_distante.png", "DF201_proximo.png"):
        b = np.asarray(Image.open(DST / n).convert("RGBA"))[..., 3]
        print(f"{n}: alpha máx acima de y 190 = {b[:190].max()}, alpha mín de y 490 para baixo = {b[490:].min()}")


if __name__ == "__main__":
    main()
