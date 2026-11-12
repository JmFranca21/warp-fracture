#!/usr/bin/env python3
"""Verificação técnica objetiva de uma entrega de arte (usada pelo revisor e pelo artista).

Exemplos:
  python tools/fluxo/check_art.py colaboracao/entregas/A6_entulho/A6_entulho_1.png --size 1024x1024
  python tools/fluxo/check_art.py colaboracao/entregas/A1_eco_appear/A1_eco_appear.png --grid 4x2 --cell 384x512 --feet 40

Imprime um relatório em texto e termina com código 1 se alguma regra falhar.
Regras: tamanho exato, canal alfa ou fundo verde chapado, conteúdo de cada célula sem
encostar na borda da célula (vazamento), linha dos pés (pixel opaco mais baixo) e
ocupação do objeto em imagens estáticas.
"""
import argparse
import sys

from PIL import Image


def parse_wh(text):
    w, h = text.lower().split("x")
    return int(w), int(h)


def opaque_mask(img):
    """Devolve uma imagem 'L' com 255 onde há conteúdo (alfa > 16, ou não verde chapado)."""
    rgba = img.convert("RGBA")
    px = rgba.load()
    w, h = rgba.size
    mask = Image.new("L", (w, h), 0)
    mp = mask.load()
    for y in range(h):
        for x in range(w):
            r, g, b, a = px[x, y]
            green = g > 200 and r < 80 and b < 80
            if a > 16 and not green:
                mp[x, y] = 255
    return mask


def main():
    sys.stdout.reconfigure(encoding="utf-8")
    ap = argparse.ArgumentParser()
    ap.add_argument("png")
    ap.add_argument("--size", help="tamanho total esperado, ex. 1024x1024")
    ap.add_argument("--grid", help="colunas x linhas, ex. 4x2")
    ap.add_argument("--cell", help="tamanho da célula, ex. 384x512")
    ap.add_argument("--feet", type=int, help="px entre os pés e a borda de baixo da célula")
    ap.add_argument("--feet-tol", type=int, default=4)
    ap.add_argument("--margin", type=int, default=2, help="px livres exigidos na borda da célula")
    ap.add_argument("--fill", default="0.55-0.75", help="ocupação esperada (estático), ex. 0.6-0.7")
    ap.add_argument("--tile", action="store_true", help="textura repetível: não checa ocupação nem borda")
    a = ap.parse_args()

    img = Image.open(a.png)
    fails = []
    print(f"arquivo: {a.png}")
    print(f"tamanho: {img.size[0]}x{img.size[1]}  modo: {img.mode}")

    if a.grid and a.cell and not a.size:
        cols, rows = parse_wh(a.grid)
        cw, ch = parse_wh(a.cell)
        a.size = f"{cols * cw}x{rows * ch}"
    if a.size and img.size != parse_wh(a.size):
        fails.append(f"tamanho {img.size[0]}x{img.size[1]} difere do pedido {a.size}")

    has_alpha = img.mode in ("RGBA", "LA") or "transparency" in img.info
    if has_alpha:
        alpha = img.convert("RGBA").getchannel("A")
        lo, hi = alpha.getextrema()
        print(f"alfa: min {lo} max {hi}")
        if lo > 16:
            fails.append("sem pixels transparentes: o fundo não foi removido")
    else:
        print("alfa: ausente (verificando fundo verde #00FF00)")

    mask = opaque_mask(img)
    W, H = img.size
    if a.grid and a.cell:
        cols, rows = parse_wh(a.grid)
        cw, ch = parse_wh(a.cell)
        for r in range(rows):
            for c in range(cols):
                n = r * cols + c + 1
                box = (c * cw, r * ch, min((c + 1) * cw, W), min((r + 1) * ch, H))
                bb = mask.crop(box).getbbox()
                if not bb:
                    print(f"quadro {n}: vazio")
                    continue
                x0, y0, x1, y1 = bb
                line = f"quadro {n}: caixa x{x0}-{x1} y{y0}-{y1}"
                if x0 < a.margin or y0 < a.margin or x1 > cw - a.margin or y1 > ch - a.margin:
                    fails.append(f"quadro {n}: conteúdo encosta na borda da célula (possível vazamento)")
                if a.feet is not None:
                    gap = ch - y1
                    line += f"  pés a {gap} px da base"
                    if abs(gap - a.feet) > a.feet_tol:
                        fails.append(f"quadro {n}: pés a {gap} px da base (pedido {a.feet} ± {a.feet_tol})")
                print(line)
    elif not a.tile:
        bb = mask.getbbox()
        if not bb:
            fails.append("imagem vazia")
        else:
            x0, y0, x1, y1 = bb
            occ = max((x1 - x0) / W, (y1 - y0) / H)
            lo, hi = (float(v) for v in a.fill.split("-"))
            print(f"objeto: caixa x{x0}-{x1} y{y0}-{y1}  ocupação {occ:.2f}")
            if not lo - 0.05 <= occ <= hi + 0.05:
                fails.append(f"ocupação {occ:.2f} fora de {a.fill}")
            if x0 < a.margin or y0 < a.margin or x1 > W - a.margin or y1 > H - a.margin:
                fails.append("objeto encosta na borda da imagem")

    if fails:
        print("FALHOU:")
        for f in fails:
            print(f"  - {f}")
        sys.exit(1)
    print("OK")


if __name__ == "__main__":
    main()
