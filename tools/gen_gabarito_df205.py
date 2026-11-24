"""Gabarito de colisões do Deserto para o pedido DF205 (terreno).

Desenha, a partir das constantes de scripts/desert.gd, os sólidos, fossos, portas, âncoras e peças que encostam
no terreno, em coordenadas do mundo (1 px = 1 px do jogo). Sai uma visão geral e sete recortes nas emendas.
uso: python tools/gen_gabarito_df205.py  →  docs/auditoria_cena/DF205_gabarito_colisoes.png
"""
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

R = lambda x, y, w, h: (x, y, x + w, y + h)
# scripts/desert.gd (FLOOR, paredes de layout(), PITS, HOOKS, portas, máquinas e adereços que tocam o chão)
FLOOR = [R(-120,700,900,360), R(1180,700,520,360), R(1700,700,1080,360), R(2870,625,145,26), R(3100,545,240,28),
         R(3580,415,430,40), R(4410,415,450,40), R(4980,770,510,320), R(6030,770,2870,320)]
WALLS = [R(-60,-200,60,1350), R(6990,-200,60,780), R(7050,-200,1440,350), R(8490,-200,60,780),
         R(8550,-200,350,600), R(8900,-200,60,1350)]
PITS = [R(780,850,400,60), R(2780,900,2200,60), R(5490,900,540,60)]
HOOKS = [(975,510), (3510,345), (4205,230), (7400,470), (8080,470)]
DOORS = [R(6990,580,60,190), R(8490,580,60,190)]
PROPS = [("DF26 esteira (fica)", R(1700,700,1080,60)), ("DF53a máquina", R(2870,490,145,157)),
         ("DF53b máquina", R(3100,410,240,157)), ("DF27 coluna do elevador", R(4875,415,74,365)),
         ("elevador 4860→y770", R(4830,400,60,20)), ("DF55b trilho", R(5480,650,560,16)),
         ("vagonete 5490→5920", R(5490,750,60,20)), ("DF31 guindaste", R(686,463,310,237))]
CHECK = [(1650,700), (4730,415), (6650,770)]
SPAWN = (185,690)
METRIC = [(500,700), (2300,700), (5200,770), (6500,770)]
CROPS = [("1 · Dunas: fosso entre 780 e 1180", (560,460,1420,1000)),
         ("2 · Dunas → Fábrica (x 1700)", (1420,460,2280,1000)),
         ("3 · Fábrica: plataformas de máquina e início do fosso", (2600,340,3460,1000)),
         ("4 · Salão: passarelas suspensas e elevador", (3480,140,5040,1000)),
         ("5 · Salão: chão, fosso 5490–6030 e chão", (4900,500,6160,1000)),
         ("6 · Câmara da Forja: cantos de parede, teto e portas", (6900,80,8620,1000)),
         ("7 · Saída e parede final", (8440,300,8980,1000))]

BG, SOLID, TOP, PIT, WALL, TXT = (15,20,34), (70,52,48), (57,230,255), (224,48,58), (37,48,69), (220,226,236)
AMBER, GREY = (239,170,85), (140,150,168)
try:
    F = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 15)
    FB = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 20)
except OSError:
    F = FB = ImageFont.load_default()


def draw_world(crop, scale, labels=True):
    x0, y0, x1, y1 = crop
    im = Image.new("RGB", (int((x1-x0)*scale), int((y1-y0)*scale)), BG)
    d = ImageDraw.Draw(im)
    t = lambda r: [(r[0]-x0)*scale, (r[1]-y0)*scale, (r[2]-x0)*scale, (r[3]-y0)*scale]
    p = lambda x, y: ((x-x0)*scale, (y-y0)*scale)
    if scale >= 1:     # grade de 64 px (o tamanho de módulo pedido)
        for gx in range((x0//64)*64, x1, 64):
            d.line([p(gx,y0), p(gx,y1)], fill=(24,30,46))
        for gy in range((y0//64)*64, y1, 64):
            d.line([p(x0,gy), p(x1,gy)], fill=(24,30,46))
    for r in WALLS:
        d.rectangle(t(r), fill=WALL, outline=GREY)
    for r in PITS:
        d.rectangle(t(r), fill=(70,20,26), outline=PIT)
        if labels: d.text(p(r[0]+6, r[1]+4), f"fosso (dano) y {r[1]}", font=F, fill=PIT)
    for name, r in PROPS:
        d.rectangle(t(r), outline=AMBER)
        if labels: d.text(p(r[0]+4, r[1]+2), name, font=F, fill=AMBER)
    for r in FLOOR:
        d.rectangle(t(r), fill=SOLID)
        d.line([p(r[0], r[1]), p(r[2], r[1])], fill=TOP, width=max(2, int(3*scale)))
        if labels:
            d.text(p(r[0]+4, r[1]+6), f"x {r[0]}–{r[2]} · topo y {r[1]} · alt {r[3]-r[1]}", font=F, fill=TXT)
    for r in DOORS:
        d.rectangle(t(r), outline=(120,200,120), width=2)
        if labels: d.text(p(r[0]-10, r[1]-20), "porta DF38", font=F, fill=(120,200,120))
    for hx, hy in HOOKS:
        d.ellipse([*p(hx-8, hy-8), *p(hx+8, hy+8)], outline=TOP, width=2)
    for cx, cy in CHECK:
        d.rectangle([*p(cx-6, cy-40), *p(cx+6, cy)], outline=AMBER)
    for mx, my in METRIC:   # Autômato: caixa de colisão 30 × 62 e altura visual ~97 px
        d.rectangle([*p(mx-15, my-62), *p(mx+15, my)], outline=(255,255,255), width=2)
        d.line([p(mx+22, my), p(mx+22, my-97)], fill=(255,255,255), width=1)
        if labels: d.text(p(mx+26, my-97), "ponto DA-03", font=F, fill=(255,255,255))
    return im


out = Path(__file__).resolve().parent.parent / "docs/auditoria_cena/DF205_gabarito_colisoes.png"
over = draw_world((-120,-200,8960,1060), 0.25, labels=False)
tiles = [(name, draw_world(c, 0.5 if (c[2]-c[0]) > 1000 else 1.0)) for name, c in CROPS]
W = 2400
rows, row, rw = [], [], 0
for name, im in tiles:
    if rw + im.width + 20 > W and row:
        rows.append(row); row, rw = [], 0
    row.append((name, im)); rw += im.width + 20
rows.append(row)
H = 110 + over.height + 50 + sum(max(i.height for _, i in r) + 50 for r in rows) + 60
sheet = Image.new("RGB", (W, H), BG)
d = ImageDraw.Draw(sheet)
d.text((20, 14), "DF205 · gabarito de colisões do Deserto (scripts/desert.gd)", font=FB, fill=TXT)
d.text((20, 44), "Coordenadas do mundo do jogo. Ciano: linha de apoio (topo da colisão). Marrom: sólido. Azul: parede e teto. "
       "Vermelho: fosso com dano. Âmbar: peças que ficam (esteira, máquinas, elevador, trilho). Branco: Autômato (colisão 30 × 62, ~97 px de altura visual) nos pontos da DA-03.",
       font=F, fill=GREY)
d.text((20, 66), "Recortes 1, 2, 3, 5 e 7 em 1:1 (grade de 64 px); 4 e 6 em 1:2. Visão geral em 1:4.", font=F, fill=GREY)
sheet.paste(over, (20, 100)); y = 100 + over.height + 30
for r in rows:
    x = 20
    for name, im in r:
        d.text((x, y), name, font=FB, fill=AMBER); sheet.paste(im, (x, y + 30)); x += im.width + 20
    y += max(i.height for _, i in r) + 50
sheet = sheet.crop((0, 0, W, y + 10))
sheet.save(out)
print(out, sheet.size)
