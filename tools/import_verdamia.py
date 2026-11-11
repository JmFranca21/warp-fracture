"""Importa o pacote de arte de Verdâmia (colaboracao/entregas/VD_verdamia) para assets/verdamia.

O que faz, sem nunca alterar os PNGs entregues:
  - personagens e efeitos em grade (4x2 ou 2x1): recorta cada quadro, normaliza a escala entre
    folhas (as folhas não vieram todas na mesma escala), alinha a âncora (pés, base ou centro do
    corpo) e monta atlas + SpriteFrames (.tres);
  - objetos: recorta pelos limites visuais e reduz para a escala do jogo;
  - terreno: prepara faixas repetíveis (emenda por fusão ou espelhamento) e mede a linha de apoio;
  - parallax: copia as camadas na resolução original;
  - gera scripts/sprite_meta_verd.gd com caminhos, escalas, âncoras e medidas.

uso: python tools/import_verdamia.py <projeto_godot>
"""
import sys, os, math
import numpy as np
from PIL import Image

PROJ = sys.argv[1] if len(sys.argv) > 1 else "."
SRC = os.path.join(PROJ, "colaboracao/entregas/VD_verdamia")
OUT = "assets/verdamia"
META = []          # linhas do sprite_meta_verd.gd
REPORT = []        # resumo impresso no fim


def load(name):
    return Image.open(os.path.join(SRC, name + ".png")).convert("RGBA")


def resize_pm(im, size):
    """Redimensiona com alfa pré-multiplicado (evita halo claro/escuro nas bordas)."""
    a = np.asarray(im).astype(np.float32) / 255.0
    a[..., :3] *= a[..., 3:4]
    chans = [Image.fromarray(a[..., i]).resize(size, Image.LANCZOS) for i in range(4)]
    b = np.stack([np.asarray(c) for c in chans], axis=-1)
    al = np.clip(b[..., 3:4], 1e-5, 1.0)
    b[..., :3] = np.clip(b[..., :3] / al, 0.0, 1.0)
    b[..., 3] = np.clip(b[..., 3], 0.0, 1.0)
    b[b[..., 3] < 0.012] = 0.0
    return Image.fromarray((b * 255.0 + 0.5).astype(np.uint8), "RGBA")


def clean(im):
    """Zera resíduos quase invisíveis de alfa (sujeira de recorte) para o bbox ficar correto."""
    a = np.array(im)
    a[a[..., 3] < 10] = 0
    return Image.fromarray(a, "RGBA")


def bbox(im, thr=40):
    a = np.asarray(im)[..., 3] > thr
    ys, xs = np.nonzero(a)
    if len(xs) == 0:
        return None
    return int(xs.min()), int(ys.min()), int(xs.max()) + 1, int(ys.max()) + 1


def cells(name, gw, gh, n):
    sheet = clean(load(name))
    cw, ch = sheet.width // gw, sheet.height // gh
    out = []
    for i in range(n):
        out.append(sheet.crop(((i % gw) * cw, (i // gw) * ch, (i % gw) * cw + cw, (i // gw) * ch + ch)))
    # células excedentes precisam estar vazias (vazamento entre quadros)
    for i in range(n, gw * gh):
        c = sheet.crop(((i % gw) * cw, (i // gw) * ch, (i % gw) * cw + cw, (i // gw) * ch + ch))
        assert bbox(c, 64) is None, f"{name}: célula {i + 1} deveria estar vazia"
    return out


def mask(im, fn):
    a = np.asarray(im).astype(np.int32)
    r, g, b, al = a[..., 0], a[..., 1], a[..., 2], a[..., 3]
    return fn(r, g, b) & (al > 128)


def centroid(m):
    ys, xs = np.nonzero(m)
    if len(xs) < 20:
        return None
    return float(xs.mean()), float(ys.mean())


def pack(name, folder, frames, anims, tex, node_scale):
    """frames: [(anim, img, fator, (ax, ay))] em px da célula original; anims: {anim: (fps, loop)}."""
    items = []
    for an, im, f, (ax, ay) in frames:
        bb = bbox(im)
        im = im.crop(bb)
        ax, ay = ax - bb[0], ay - bb[1]
        s = tex * f
        w, h = max(1, round(im.width * s)), max(1, round(im.height * s))
        items.append((an, resize_pm(im, (w, h)), ax * s, ay * s))
    left = max(ax for _, _, ax, _ in items)
    right = max(im.width - ax for _, im, ax, _ in items)
    up = max(ay for _, _, _, ay in items)
    down = max(im.height - ay for _, im, _, ay in items)
    cw, ch = math.ceil(left + right) + 4, math.ceil(up + down) + 4
    cols = max(1, min(len(items), 4000 // cw))
    rows = math.ceil(len(items) / cols)
    atlas = Image.new("RGBA", (cols * cw, rows * ch), (0, 0, 0, 0))
    regions = []
    for i, (an, im, ax, ay) in enumerate(items):
        x, y = (i % cols) * cw, (i // cols) * ch
        atlas.alpha_composite(im, (x + 2 + round(left - ax), y + 2 + round(up - ay)))
        regions.append((an, x, y))
    os.makedirs(os.path.join(PROJ, folder), exist_ok=True)
    png = f"{folder}/{name}_sheet.png"
    atlas.save(os.path.join(PROJ, png), optimize=True)
    lines = [f'[gd_resource type="SpriteFrames" load_steps={len(items) + 2} format=3]', "",
             f'[ext_resource type="Texture2D" path="res://{png}" id="1_sheet"]', ""]
    for i, (an, x, y) in enumerate(regions):
        lines += [f'[sub_resource type="AtlasTexture" id="f{i}"]', 'atlas = ExtResource("1_sheet")',
                  f"region = Rect2({x}, {y}, {cw}, {ch})", ""]
    lines.append("[resource]")
    parts = []
    for an, (fps, loop) in anims.items():
        ids = [i for i, r in enumerate(regions) if r[0] == an]
        frs = ", ".join('{\n"duration": 1.0,\n"texture": SubResource("f%d")\n}' % i for i in ids)
        parts.append('{\n"frames": [%s],\n"loop": %s,\n"name": &"%s",\n"speed": %s\n}' % (
            frs, "true" if loop else "false", an, float(fps)))
    lines.append("animations = [%s]" % ", ".join(parts))
    tres = f"{folder}/{name}_frames.tres"
    open(os.path.join(PROJ, tres), "w").write("\n".join(lines) + "\n")
    off = (cw / 2.0 - (left + 2), ch / 2.0 - (up + 2))
    const = name.upper()
    META.append(f'const {const}_FRAMES := "res://{tres}"')
    META.append(f"const {const}_OFFSET := Vector2({off[0]:.2f}, {off[1]:.2f})")
    META.append(f"const {const}_SCALE := {node_scale:.4f}")
    REPORT.append(f"{name}: {len(items)} quadros, célula {cw}x{ch}, atlas {atlas.width}x{atlas.height}")


# ------------------------------------------------------------------ Lince-Vagalume
def is_dark(r, g, b):
    return (r < 70) & (g < 80) & (b < 110)


def is_amber(r, g, b):
    return (r > 200) & (g > 120) & (g < 215) & (b < 120)


def lince():
    D, K = 0.17, 2.0                 # px do desenho → px do jogo; resolução guardada = 2x
    IDLE_GROUND, IDLE_CY = 427.0, 285.0
    H = IDLE_GROUND - IDLE_CY        # altura do centro do corpo acima dos pés (na escala do idle)
    # anim: (arquivo, quadros, fator de escala, modo de âncora, fps, loop)
    #   chao:<y>  pés na linha y, x fixo no centro do corpo médio
    #   chao_q    pés na base de cada quadro (para a morte, em que o desenho "sobe" na célula)
    #   corre:<y> pés na linha y, x no centro do corpo de cada quadro (estabiliza o galope)
    #   ar        centro do corpo de cada quadro
    #   parede    patas encostadas na borda do colisor (16 px), centro do corpo na vertical
    T = {
        "idle": ("D_lince_idle", 6, 1.00, "chao:427", 7, True),
        "run": ("D_lince_run", 8, 1.12, "corre:411", 14, True),
        "jump": ("D_lince_jump", 3, 1.07, "ar", 10, False),
        "fall": ("D_lince_fall", 3, 1.06, "ar", 10, False),
        "doublejump": ("D_lince_doublejump", 4, 1.13, "ar", 14, False),
        "wall": ("D_lince_wall_v2", 3, 1.07, "parede", 6, True),
        "claw": ("D_lince_claw_v2", 4, 1.27, "chao:391", 16, False),
        "pogo": ("D_lince_pogo", 4, 1.10, "ar", 16, False),
        "flash": ("D_lince_flash_v2", 6, 1.12, "chao:404", 15, False),
        "hurt": ("D_lince_hurt", 2, 1.00, "chao:439", 8, False),
        "death": ("D_lince_death", 6, 1.09, "chao_q", 8, False),
    }
    frames, anims, lantern = [], {}, {}
    for an, (f, n, fac, mode, fps, loop) in T.items():
        cs = cells(f, 4, 2, n)
        dcs = [centroid(mask(c, is_dark)) for c in cs]
        mean_x = sum(d[0] for d in dcs) / n
        anims[an] = (fps, loop)
        lantern[an] = []
        last = None
        for i, c in enumerate(cs):
            bb = bbox(c)
            dc = dcs[i]
            if mode.startswith("chao:"):
                anc = (mean_x, float(mode.split(":")[1]))
            elif mode == "chao_q":
                anc = (mean_x, float(bb[3]))
            elif mode.startswith("corre:"):
                anc = (dc[0], float(mode.split(":")[1]))
            elif mode == "parede":
                anc = (bb[2] - 16.0 / (D * fac), dc[1] + H / fac)
            else:
                anc = (dc[0], dc[1] + H / fac)
            if an == "jump" and i == 0:      # quadro 1 do salto é o agachamento no chão
                anc = (dc[0], float(bb[3]))
            frames.append((an, c, fac, anc))
            lc = centroid(mask(c, is_amber)) or last or (anc[0] - 150, anc[1] - 250)
            last = lc
            lantern[an].append(((lc[0] - anc[0]) * D * fac, (lc[1] - anc[1]) * D * fac))
    pack("lince", OUT + "/lince", frames, anims, D * K, 1.0 / K)
    META.append("const LINCE_LANTERN := {")
    for an, pts in lantern.items():
        META.append('\t"%s": [%s],' % (an, ", ".join(f"Vector2({x:.1f}, {y:.1f})" for x, y in pts)))
    META.append("}")


# ------------------------------------------------------------------ inimigos
def base_span(c):
    a = np.asarray(c)[..., 3] > 128
    ys, xs = np.nonzero(a)
    yb = ys.max()
    row = a[yb - 40:yb - 10].any(axis=0)
    bx = np.nonzero(row)[0]
    return float(bx.min()), float(bx.max()), float(yb + 1)


def esporangio():
    D, K = 0.23, 2.0
    frames, anims = [], {}
    for an, f, n, fps, loop in [("idle", "E_esporangio_idle", 6, 7, True), ("attack", "E_esporangio_attack", 4, 10, False),
                                 ("death", "E_esporangio_death", 6, 10, False)]:
        cs = cells(f, 4, 2, n)
        sp = [base_span(c) for c in cs]
        w = sum(s[1] - s[0] for s in sp) / n
        cx = sum((s[0] + s[1]) / 2 for s in sp) / n
        gy = max(s[2] for s in sp)
        fac = 280.0 / w
        anims[an] = (fps, loop)
        for c in cs:
            frames.append((an, c, fac, (cx, gy)))
    pack("esporangio", OUT + "/inimigos", frames, anims, D * K, 1.0 / K)


def mariposa():
    D, K = 0.18, 2.0
    frames, anims = [], {}
    for an, f, n, fps, loop in [("fly", "E_mariposa_fly", 6, 14, True), ("death", "E_mariposa_death", 6, 10, False)]:
        anims[an] = (fps, loop)
        last = None
        for c in cells(f, 4, 2, n):
            dc = centroid(mask(c, lambda r, g, b: (r < 90) & (g < 80) & (b < 130))) or last
            last = dc
            frames.append((an, c, 1.0, dc))
    pack("mariposa", OUT + "/inimigos", frames, anims, D * K, 1.0 / K)


def rainha():
    D, K = 0.42, 1.5
    order = {
        "idle": (["idle_1", "idle_2", "idle_3"], 4, True),
        "raizes": (["raizes_1", "raizes_2", "raizes_3"], 8, False),
        "esporos": (["esporos_1", "esporos_2", "esporos_3"], 8, False),
        "rugido": (["rugido_1", "rugido_2"], 6, False),
        "hurt": (["hurt_1"], 8, False),
        "death": (["death_1", "death_2", "death_3", "death_4"], 5, False),
    }
    frames, anims = [], {}
    for an, (files, fps, loop) in order.items():
        anims[an] = (fps, loop)
        for f in files:
            for c in cells("E_rainha_" + f, 2, 1, 2):
                x0, x1, gy = base_span(c)
                frames.append((an, c, 700.0 / (x1 - x0), ((x0 + x1) / 2.0, gy)))
    pack("rainha", OUT + "/inimigos", frames, anims, D * K, 1.0 / K)


# ------------------------------------------------------------------ efeitos
def efeitos():
    # nome: (arquivo, quadros, escala no jogo, âncora na célula ou None = centro do conjunto, fps, resolução)
    FX = {
        "fx_raiz": ("VD_fx_raiz", 6, 0.36, (192, 460), 12, 2.0),
        "fx_aviso_raiz": ("VD_fx_aviso_raiz", 4, 0.36, (192, 468), 8, 2.0),
        "fx_impacto_esporo": ("VD_fx_impacto_esporo", 4, 0.22, None, 16, 2.0),
        "fx_invocacao": ("VD_fx_invocacao", 6, 0.45, None, 14, 2.0),
        "fx_poeira": ("VD_fx_poeira", 4, 0.25, (188, 424), 14, 2.0),
        "fx_garras": ("VD_fx_garras", 4, 0.25, None, 28, 2.0),
        "fx_clarao": ("VD_fx_clarao", 6, 1.09, None, 16, 1.0),
    }
    for name, (f, n, D, anc, fps, K) in FX.items():
        cs = cells(f, 4, 2, n)
        if anc is None:
            bbs = [bbox(c) for c in cs]
            big = max(bbs, key=lambda b: (b[2] - b[0]) * (b[3] - b[1]))
            anc = ((big[0] + big[2]) / 2.0, (big[1] + big[3]) / 2.0)
        pack(name, OUT + "/efeitos", [("play", c, 1.0, anc) for c in cs], {"play": (fps, False)}, D * K, 1.0 / K)
    META.append("## efeitos por nome: [SpriteFrames, offset, escala]")
    META.append("const FX := {")
    for name in FX:
        c = name.upper()
        META.append(f'\t"{name[3:]}": [{c}_FRAMES, {c}_OFFSET, {c}_SCALE],')
    META.append("}")


# ------------------------------------------------------------------ objetos
def objetos():
    # nome de saída: (arquivo, escala no jogo com escala de instância 1.0)
    OBJ = {
        "cogumelo_gigante": ("E1_cogumelo_gigante", 0.36), "grama": ("E1_grama", 0.10),
        "raiz_pendurada": ("E1_raiz_pendurada", 0.20), "pedra_musgo": ("E1_pedra_musgo", 0.14),
        "arco_templo": ("E1_arco_templo", 0.42), "altar": ("E1_altar", 0.20),
        "checkpoint": ("VD_checkpoint", 0.14), "barreira_arena": ("VD_barreira_arena", 0.146),
        "fragmento": ("VD_fragmento", 0.085), "esporo_verde": ("VD_esporo_verde", 0.06),
        "esporo_violeta": ("VD_esporo_violeta", 0.06),
    }
    os.makedirs(os.path.join(PROJ, OUT, "objetos"), exist_ok=True)
    for name, (f, D) in OBJ.items():
        im = clean(load(f))
        bb = bbox(im)
        im = im.crop(bb)
        s = D * 2.0
        im = resize_pm(im, (round(im.width * s), round(im.height * s)))
        im.save(os.path.join(PROJ, OUT, "objetos", name + ".png"), optimize=True)
        REPORT.append(f"objeto {name}: recorte {bb} → {im.width}x{im.height} (no jogo {im.width // 2}x{im.height // 2})")
    META.append('const OBJ_DIR := "res://assets/verdamia/objetos/"')
    META.append("const OBJ_SCALE := 0.5")


# ------------------------------------------------------------------ terreno
def wrap_blend(im, band):
    """Torna a faixa repetível na horizontal fundindo o fim com o começo (largura final = W - band)."""
    a = np.asarray(im).astype(np.float32)
    w = a.shape[1]
    out = a[:, :w - band].copy()
    k = np.linspace(0.0, 1.0, band, dtype=np.float32)[None, :, None]
    out[:, :band] = a[:, w - band:] * (1.0 - k) + a[:, :band] * k
    return Image.fromarray(np.clip(out + 0.5, 0, 255).astype(np.uint8), "RGBA")


def surface_row(im):
    """Linha de apoio: primeira linha opaca mais comum entre as colunas (o topo plano)."""
    a = np.asarray(im)[..., 3] > 128
    first = np.argmax(a, axis=0)[a.any(axis=0)]
    return int(np.bincount(first).argmax())


def terreno():
    d = os.path.join(PROJ, OUT, "terreno")
    os.makedirs(d, exist_ok=True)
    S = 0.6   # guardado em 2x; no jogo o terreno usa 0.30 do desenho original

    # chão com musgo: faixa repetível; o corpo de terra desvanece embaixo para fundir com o subsolo
    ch = clean(load("VD_chao_musgo"))
    top = bbox(ch)[1] - 4
    ch = wrap_blend(ch.crop((0, top, ch.width, ch.height)), 160)
    a = np.asarray(ch).astype(np.float32)
    h = a.shape[0]
    fade = np.clip((h - np.arange(h)) / (h * 0.42), 0.0, 1.0)[:, None]
    a[..., 3] *= fade
    ch = Image.fromarray(a.astype(np.uint8), "RGBA")
    surf = surface_row(ch)
    ch = resize_pm(ch, (round(ch.width * S), round(ch.height * S)))
    ch.save(os.path.join(d, "chao_musgo.png"), optimize=True)
    META.append(f"const CHAO_SURF := {surf * S / 2.0:.1f}   # linha de apoio (px do jogo a partir do topo da faixa)")

    # subsolo: mosaico 2x2 espelhado (a peça original não emenda sozinha)
    sb = load("VD_subsolo")
    t = Image.new("RGBA", (sb.width * 2, sb.height * 2))
    t.paste(sb, (0, 0))
    t.paste(sb.transpose(Image.FLIP_LEFT_RIGHT), (sb.width, 0))
    t.paste(sb.transpose(Image.FLIP_TOP_BOTTOM), (0, sb.height))
    t.paste(sb.transpose(Image.ROTATE_180), (sb.width, sb.height))
    t = t.resize((round(t.width * S), round(t.height * S)), Image.LANCZOS)
    t.convert("RGB").save(os.path.join(d, "subsolo.png"), optimize=True)

    # parede de escalada: só a borda com musgo (72 px no jogo), desvanecendo para dentro para fundir
    # com o subsolo; espelhada na vertical para repetir
    pw = clean(load("VD_parede_escalada"))
    x0 = bbox(pw)[0]
    pw = pw.crop((x0, 0, x0 + 240, pw.height))
    edge = int(np.median(np.argmax(np.asarray(pw)[..., 3] > 128, axis=1)))
    arr = np.asarray(pw).astype(np.float32)
    k = np.clip((240 - np.arange(240)) / 110.0, 0.0, 1.0)[None, :]
    arr[..., 3] *= k
    pw = Image.fromarray(arr.astype(np.uint8), "RGBA")
    t = Image.new("RGBA", (pw.width, pw.height * 2))
    t.paste(pw, (0, 0))
    t.paste(pw.transpose(Image.FLIP_TOP_BOTTOM), (0, pw.height))
    t = resize_pm(t, (round(t.width * S), round(t.height * S)))
    t.save(os.path.join(d, "parede_borda.png"), optimize=True)
    META.append(f"const PAREDE_EDGE := {edge * S / 2.0:.1f}   # onde começa a rocha (px do jogo a partir da esquerda)")

    # cantos: recorte da quina (90 x 130 px no jogo), desvanecendo para dentro e para baixo
    PW, PH = 300, 430
    for nm, f, side in [("canto_esquerdo", "VD_canto_esquerdo", 0), ("canto_direito", "VD_canto_direito", 1)]:
        c = clean(load(f))
        c = c.crop(bbox(c))
        if side == 1:
            c = c.transpose(Image.FLIP_LEFT_RIGHT)      # trabalha sempre como canto esquerdo
        al = np.asarray(c)[..., 3] > 128
        surf_c = surface_row(c)
        ex = int(np.median(np.argmax(al[al.shape[0] // 2:], axis=1)))
        c = c.crop((0, 0, PW, PH))
        arr = np.asarray(c).astype(np.float32)
        kx = np.clip((PW - np.arange(PW)) / 120.0, 0.0, 1.0)[None, :]
        ky = np.clip((PH - np.arange(PH)) / 150.0, 0.0, 1.0)[:, None]
        arr[..., 3] *= kx * ky
        c = Image.fromarray(arr.astype(np.uint8), "RGBA")
        if side == 1:
            c = c.transpose(Image.FLIP_LEFT_RIGHT)
        c = resize_pm(c, (round(c.width * S), round(c.height * S)))
        c.save(os.path.join(d, nm + ".png"), optimize=True)
        # quina = distância da borda externa da peça até a aresta da rocha, e do topo até a linha de apoio
        META.append(f"const {nm.upper()}_QUINA := Vector2({ex * S / 2.0:.1f}, {surf_c * S / 2.0:.1f})")

    # espinhos: faixa repetível, 0.20 do desenho no jogo (guardado em 2x)
    es = clean(load("VD_espinhos"))
    bb = bbox(es)
    es = wrap_blend(es.crop((0, bb[1] - 4, es.width, bb[3])), 90)
    a = np.asarray(es)[..., 3] > 128
    full = np.nonzero(a.mean(axis=1) > 0.97)[0]
    moss = int(full.min())
    es = resize_pm(es, (round(es.width * 0.4), round(es.height * 0.4)))
    es.save(os.path.join(d, "espinhos.png"), optimize=True)
    META.append(f"const ESPINHOS_BASE := {moss * 0.2:.1f}   # linha do musgo (px do jogo a partir do topo da faixa)")

    # plataformas: recorte + linha de apoio
    for nm, f in [("plataforma_raizes", "VD_plataforma_raizes"), ("tronco_plataforma", "E1_tronco_plataforma")]:
        p = clean(load(f))
        p = p.crop(bbox(p))
        surf_p = surface_row(p)
        p = resize_pm(p, (round(p.width * 0.25), round(p.height * 0.25)))
        p.save(os.path.join(d, nm + ".png"), optimize=True)
        META.append(f"const {nm.upper()}_SURF := {surf_p * 0.25:.1f}   # linha de apoio em px da textura")
    META.append('const TERRENO_DIR := "res://assets/verdamia/terreno/"')


def parallax():
    d = os.path.join(PROJ, OUT, "fundo")
    os.makedirs(d, exist_ok=True)
    load("VD_bg_distante").convert("RGB").save(os.path.join(d, "bg_distante.png"), optimize=True)
    clean(load("VD_bg_intermediario")).save(os.path.join(d, "bg_intermediario.png"), optimize=True)
    fg = clean(load("VD_fg_vegetacao"))
    bb = bbox(fg)
    fg.crop((0, bb[1] - 2, fg.width, fg.height)).save(os.path.join(d, "fg_vegetacao.png"), optimize=True)
    META.append('const FUNDO_DIR := "res://assets/verdamia/fundo/"')


lince()
esporangio()
mariposa()
rainha()
efeitos()
objetos()
terreno()
parallax()
head = ["class_name SpriteMetaVerd", "extends RefCounted",
        "## Gerado por tools/import_verdamia.py a partir de colaboracao/entregas/VD_verdamia. Não edite à mão.",
        "## Sprites animados: AnimatedSprite2D centered=true, offset = *_OFFSET e scale = *_SCALE.", ""]
open(os.path.join(PROJ, "scripts/sprite_meta_verd.gd"), "w").write("\n".join(head + META) + "\n")
print("\n".join(REPORT))
