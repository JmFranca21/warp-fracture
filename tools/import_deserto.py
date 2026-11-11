"""Prepara texturas de jogo a partir das entregas DF, mantendo os originais."""
from pathlib import Path
from PIL import Image
import re

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / "assets/deserto"
TARGET.mkdir(exist_ok=True)
for path in sorted((ROOT / "colaboracao/entregas").glob("DF*/DF*.png")):
    code = path.stem.split("_")[0]
    number = int(re.search(r"\d+", code).group())
    if number < 10 or "previa" in path.name:
        continue
    img = Image.open(path).convert("RGBA")
    name = code
    if number in (30, 38, 56):
        name += "_" + path.stem.split("_")[-1]
    if number >= 60:
        img = img.resize((512, 384), Image.Resampling.LANCZOS)
    elif number in (10, 11, 12):
        img.thumbnail((1024, 512), Image.Resampling.LANCZOS)
    elif number >= 30 and code not in ("DF50b", "DF51b", "DF55b"):
        img = img.crop(img.getbbox())
        img.thumbnail((480, 560), Image.Resampling.LANCZOS)
    repeat_x = number in (10, 11, 12, 20, 21, 22, 23, 24, 25, 26, 28) or code == "DF55b"
    repeat_y = number in (22, 23, 24, 27) or code in ("DF50b", "DF51b")
    if repeat_x or repeat_y:
        # Preserve matching edge pixels even after the parallax downsample.
        if repeat_x:
            img.paste(img.crop((0, 0, 1, img.height)), (img.width - 1, 0))
        if repeat_y:
            img.paste(img.crop((0, 0, img.width, 1)), (0, img.height - 1))
        img.save(TARGET / (name + ".webp"), lossless=True, method=5)
    else:
        img.save(TARGET / (name + ".webp"), quality=86, method=5)
