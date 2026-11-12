#!/usr/bin/env python3
"""Gera o pacote de evidências para o revisor (que não executa comandos).

Uso: python tools/fluxo/evidencias.py <pasta_saida> <ID> [<ID> ...] [--diff <commit>]

Para cada ID: roda check_art.py com as medidas do pedido (tabela SPECS), mede a altura da
figura em cada quadro, compara quadros que devem ser iguais (CONTINUIDADE) e gera uma
prancha de contato (<ID>_prancha.png) sobre fundo xadrez, com o número de cada quadro.
Com --diff, grava também o `git show` do commit em diff_<commit>.txt.
"""
import subprocess
import sys
from pathlib import Path

from PIL import Image, ImageChops, ImageDraw

ROOT = Path(__file__).resolve().parents[2]
ENT = ROOT / "colaboracao" / "entregas"
SHEET = ["--grid", "4x2", "--cell", "384x512"]
SPECS = {  # ID -> argumentos do check_art.py
    "A1_eco_appear": SHEET, "A2_eco_float": SHEET, "A3_eco_avanco": SHEET,
    "A4_eco_grab": SHEET, "A5_eco_vanish": SHEET, "A9_fx_dobra_eco": SHEET,
    "A7_fx_poeira": SHEET + ["--feet", "40"], "A8_fx_rachadura_teto": SHEET + ["--margin", "0"],
    "A6_entulho": ["--size", "1024x1024", "--fill", "0.6-0.7"],
}
VERSIONED = {"A1_eco_appear", "A2_eco_float", "A3_eco_avanco", "A4_eco_grab", "A5_eco_vanish", "A7_fx_poeira", "A8_fx_rachadura_teto", "A9_fx_dobra_eco"}
# (descrição, (ID, quadro), (ID, quadro)) — quadros numerados a partir de 1
CONTINUIDADE = [
    ("A1 quadro 8 = A2 quadro 1", ("A1_eco_appear", 8), ("A2_eco_float", 1)),
    ("A5 quadro 1 = A2 quadro 1", ("A5_eco_vanish", 1), ("A2_eco_float", 1)),
    ("A4 quadro 1 ~ A3 quadro 1", ("A4_eco_grab", 1), ("A3_eco_avanco", 1)),
    ("A4 quadro 6 ~ A3 quadro 1", ("A4_eco_grab", 6), ("A3_eco_avanco", 1)),
    ("A3 quadro 1 ~ A2 quadro 1", ("A3_eco_avanco", 1), ("A2_eco_float", 1)),
]


def main_png(id_):
    pngs = sorted(p for p in (ENT / id_).glob("*.png") if "previa" not in p.stem.lower())
    return pngs


def latest(id_):
    """PNG principal mais recente (o de maior sufixo _vN; sem sufixo = v1)."""
    import re
    pngs = main_png(id_)
    ver = lambda p: int(m.group(1)) if (m := re.search(r"_v(\d+)$", p.stem)) else 1
    return sorted(pngs, key=ver)[-1:] if pngs else []


def cell(img, n, cw=384, ch=512, cols=4):
    r, c = divmod(n - 1, cols)
    return img.crop((c * cw, r * ch, (c + 1) * cw, (r + 1) * ch))


def bbox(im):
    return im.convert("RGBA").getchannel("A").point(lambda a: 255 if a > 16 else 0).getbbox()


def checker(w, h, s=16):
    bg = Image.new("RGBA", (w, h), (200, 200, 200, 255))
    d = ImageDraw.Draw(bg)
    for y in range(0, h, s):
        for x in range(0, w, s):
            if (x // s + y // s) % 2:
                d.rectangle([x, y, x + s - 1, y + s - 1], fill=(150, 150, 150, 255))
    return bg


def prancha(png, out, grid):
    img = Image.open(png).convert("RGBA")
    bg = checker(*img.size)
    bg.alpha_composite(img)
    d = ImageDraw.Draw(bg)
    if grid:
        for n in range(1, 9):
            r, c = divmod(n - 1, 4)
            d.rectangle([c * 384, r * 512, c * 384 + 383, r * 512 + 511], outline=(255, 0, 0, 255))
            d.text((c * 384 + 6, r * 512 + 4), str(n), fill=(255, 0, 0, 255))
            d.line([c * 384, r * 512 + 472, c * 384 + 383, r * 512 + 472], fill=(0, 120, 255, 255))
    bg.convert("RGB").resize((img.width // 2, img.height // 2)).save(out)


def main():
    args = sys.argv[1:]
    diff = None
    if "--diff" in args:
        i = args.index("--diff")
        diff = args[i + 1]
        del args[i:i + 2]
    out = Path(args[0])
    out.mkdir(parents=True, exist_ok=True)
    ids = args[1:]
    md = ["# Evidências para o revisor", "",
          "Geradas por `tools/fluxo/evidencias.py`. Pranchas: fundo xadrez, grade vermelha com o número",
          "do quadro e linha azul a 40 px da base da célula. Medidas em px da imagem original.", ""]
    for id_ in ids:
        md += [f"## {id_}", ""]
        pngs = latest(id_) if id_ in VERSIONED else main_png(id_)
        if not pngs:
            md += ["Nenhum PNG encontrado.", ""]
            continue
        spec = SPECS.get(id_, [])
        grid = "--grid" in spec
        for png in pngs:
            r = subprocess.run([sys.executable, str(ROOT / "tools/fluxo/check_art.py"), str(png), *spec],
                               capture_output=True, text=True, encoding="utf-8")
            md += [f"### {png.name}", "", "```", r.stdout.strip(), "```", ""]
            if grid:
                img = Image.open(png).convert("RGBA")
                rows = ["| quadro | altura da figura | largura | topo | base |", "|---|---|---|---|---|"]
                for n in range(1, 9):
                    b = bbox(cell(img, n))
                    rows.append(f"| {n} | {b[3]-b[1]} | {b[2]-b[0]} | {b[1]} | {b[3]} |" if b else f"| {n} | vazio | | | |")
                md += rows + [""]
            sheet = out / f"{png.stem}_prancha.png"
            prancha(png, sheet, grid)
            md += [f"Prancha: `{sheet.name}`", ""]
    pairs = [c for c in CONTINUIDADE if c[1][0] in ids or c[2][0] in ids]
    if pairs:
        md += ["## Continuidade entre pedidos", "", "| regra | pixels diferentes | diferença média (0-255) |", "|---|---|---|"]
        for desc, (ia, fa), (ib, fb) in pairs:
            pa, pb = latest(ia), latest(ib)
            if not pa or not pb:
                md.append(f"| {desc} | arquivo ausente | |")
                continue
            a = cell(Image.open(pa[0]).convert("RGBA"), fa)
            b = cell(Image.open(pb[0]).convert("RGBA"), fb)
            dif = ImageChops.difference(a, b).convert("L")
            hist = dif.histogram()
            changed = sum(hist[9:])
            mean = sum(i * v for i, v in enumerate(hist)) / (a.width * a.height)
            md.append(f"| {desc} | {changed} de {a.width * a.height} | {mean:.2f} |")
        md.append("")
    if diff:
        r = subprocess.run(["git", "show", "--stat", "--patch", diff], cwd=ROOT,
                           capture_output=True, text=True, encoding="utf-8")
        (out / f"diff_{diff}.txt").write_text(r.stdout, encoding="utf-8")
        md += [f"## Diff do desenvolvimento", "", f"`diff_{diff}.txt` (git show {diff})", ""]
    (out / "EVIDENCIAS.md").write_text("\n".join(md), encoding="utf-8")
    print(out / "EVIDENCIAS.md")


if __name__ == "__main__":
    main()
