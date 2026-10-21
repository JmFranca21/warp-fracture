"""Monta atlas + SpriteFrames (.tres) a partir dos quadros extraídos.
Cada conjunto tem célula única; o ponto de âncora (pés/centro) fica no mesmo lugar em todas.
Gera também scripts/sprite_meta.gd com os offsets para AnimatedSprite2D (centered=true).
uso: python build_sheets.py <raw_dir> <projeto_godot>
"""
import sys, json, os, math
from PIL import Image

RAW, PROJ = sys.argv[1], sys.argv[2]
meta = json.load(open(os.path.join(RAW, "meta.json")))

# conjunto: (pasta res, escala da textura, {anim: (chave raw, fator de normalização, fps, loop)})
SETS = {
    "daymon": ("assets/personagens/daymon", 0.30, {
        "idle": ("daymon/idle", 1.00, 7, True),
        "run": ("daymon/run", 1.00, 13, True),
        "jump": ("daymon/jump", 0.89, 10, False),
        "fall": ("daymon/fall", 0.93, 9, True),
        "dash": ("daymon/dash", 0.95, 22, False),
        "hurt": ("daymon/hurt", 0.85, 8, False),
        "death": ("daymon/death", 0.92, 8, False),
    }),
    "braco": ("assets/personagens/daymon", 0.35, {
        "braco": ("arma/braco", 1.0, 1, False),
    }),
    "disparo": ("assets/personagens/daymon", 0.40, {
        "fire": ("arma/disparo", 1.0, 24, False),
    }),
    "drone": ("assets/inimigos/drone", 0.50, {
        "fly": ("drone/fly", 1.00, 9, True),
        "charge": ("drone/charge", 0.79, 6, False),
        "shoot": ("drone/shoot", 1.18, 12, False),
        "hurt": ("drone/hurt", 0.81, 10, False),
        "death": ("drone/death", 0.96, 12, False),
    }),
    "rastejador_morte": ("assets/inimigos/rastejador", 0.285, {
        "death": ("rastejador/death", 1.0, 11, False),
    }),
    "fx_explosao": ("assets/efeitos", 0.50, {"play": ("fx/explosao", 1.0, 18, False)}),
    "fx_caixa": ("assets/efeitos", 0.35, {"play": ("fx/caixa", 1.0, 16, False)}),
    "fx_impacto": ("assets/efeitos", 0.40, {"play": ("fx/impacto", 1.0, 24, False)}),
    "fx_campo": ("assets/efeitos", 0.70, {"loop": ("fx/campo", 1.0, 10, True)}),
}


def build(set_name, folder, tex_scale, anims):
    items = []  # (anim, img, ax, ay)
    for an, (key, factor, fps, loop) in anims.items():
        for f in meta[key]:
            im = Image.open(os.path.join(RAW, f["file"]))
            s = tex_scale * factor
            w, h = max(1, round(f["w"] * s)), max(1, round(f["h"] * s))
            im = im.resize((w, h), Image.LANCZOS)
            ax, ay = f["anchor"][0] * s, f["anchor"][1] * s
            items.append((an, im, ax, ay))
    left = max(ax for _, _, ax, _ in items)
    right = max(im.width - ax for _, im, ax, _ in items)
    up = max(ay for _, _, _, ay in items)
    down = max(im.height - ay for _, im, _, ay in items)
    cw, ch = math.ceil(left + right) + 2, math.ceil(up + down) + 2
    ax0, ay0 = left + 1, up + 1
    n = len(items)
    cols = min(n, max(1, int(2048 // cw)))
    rows = math.ceil(n / cols)
    sheet = Image.new("RGBA", (cols * cw, rows * ch), (0, 0, 0, 0))
    regions = []
    for i, (an, im, ax, ay) in enumerate(items):
        cx, cy = (i % cols) * cw, (i // cols) * ch
        sheet.alpha_composite(im, (round(cx + ax0 - ax), round(cy + ay0 - ay)))
        regions.append((an, cx, cy))
    os.makedirs(os.path.join(PROJ, folder), exist_ok=True)
    png = f"{folder}/{set_name}_sheet.png"
    sheet.save(os.path.join(PROJ, png))
    # .tres
    lines = [f'[gd_resource type="SpriteFrames" load_steps={n + 2} format=3]', "",
             f'[ext_resource type="Texture2D" path="res://{png}" id="1_sheet"]', ""]
    for i, (an, cx, cy) in enumerate(regions):
        lines += [f'[sub_resource type="AtlasTexture" id="f{i}"]', 'atlas = ExtResource("1_sheet")',
                  f"region = Rect2({cx}, {cy}, {cw}, {ch})", ""]
    lines.append("[resource]")
    parts = []
    for an, (key, factor, fps, loop) in anims.items():
        ids = [i for i, r in enumerate(regions) if r[0] == an]
        frs = ", ".join('{\n"duration": 1.0,\n"texture": SubResource("f%d")\n}' % i for i in ids)
        parts.append('{\n"frames": [%s],\n"loop": %s,\n"name": &"%s",\n"speed": %s\n}' % (
            frs, "true" if loop else "false", an, float(fps)))
    lines.append("animations = [%s]" % ", ".join(parts))
    tres = f"{folder}/{set_name}_frames.tres"
    open(os.path.join(PROJ, tres), "w").write("\n".join(lines) + "\n")
    # offset para centered=true: a âncora fica na origem do nó
    off = (cw / 2.0 - ax0, ch / 2.0 - ay0)
    print(f"{set_name:18s} célula={cw}x{ch} quadros={n} atlas={sheet.size} offset=({off[0]:.1f},{off[1]:.1f})")
    return tres, off, (cw, ch), (ax0, ay0)


out = ["class_name SpriteMeta", "extends RefCounted",
       "## Gerado por tools/build_sheets.py: caminhos dos SpriteFrames e offsets da âncora.", ""]
for name, (folder, ts, anims) in SETS.items():
    tres, off, cell, anc = build(name, folder, ts, anims)
    const = name.upper()
    out.append(f'const {const}_FRAMES := "res://{tres}"')
    out.append(f"const {const}_OFFSET := Vector2({off[0]:.2f}, {off[1]:.2f})")
    out.append(f"const {const}_TEX_SCALE := {ts}")
    out.append("")
open(os.path.join(PROJ, "scripts/sprite_meta.gd"), "w").write("\n".join(out) + "\n")
