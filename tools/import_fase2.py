"""Importa a arte da Fase 2 (lotes 2 e 3) para o jogo, sem tocar nos originais.

uso: python tools/import_fase2.py

- Autômato e efeitos dele (DF87–DF99) e a Forja-Mãe (DF100–DF112) vão para assets/deserto/.
- Portais (PT10–PT23) vão para assets/portais/.
- Tudo em meia resolução (fator 0,5), mantendo a grade e os pontos de apoio dos pedidos:
  no jogo, a escala da Fase 2 é K = 0,214 do original (D = 400 px vira ~86 px), então o
  nó usa 0,428 sobre a textura importada. O gelo das bordas é preservado (sem corte).
"""
from pathlib import Path
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "colaboracao/entregas"
OUT_DF = ROOT / "assets/deserto"
OUT_PT = ROOT / "assets/portais"
OUT_PT.mkdir(exist_ok=True)

DF_IDS = ["DF87", "DF88", "DF90", "DF91", "DF92", "DF93", "DF94", "DF95", "DF96", "DF97", "DF98", "DF99",
          "DF100", "DF101", "DF102", "DF103", "DF104", "DF105", "DF106", "DF107", "DF108", "DF110", "DF111", "DF112"]
PT_IDS = ["PT10", "PT11", "PT12", "PT13", "PT15", "PT20", "PT21", "PT22", "PT23"]


def convert(code: str, out_dir: Path) -> None:
    src = next((SRC / code).glob(code + "_*.png"))
    img = Image.open(src).convert("RGBA")
    img = img.resize((img.width // 2, img.height // 2), Image.Resampling.LANCZOS)
    img.save(out_dir / (code + ".webp"), lossless=True, method=5)
    print(code, "->", img.size)


for c in DF_IDS:
    convert(c, OUT_DF)
for c in PT_IDS:
    convert(c, OUT_PT)
