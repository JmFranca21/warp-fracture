"""Importa spritesheets já montadas em grade 4x2 (células 384x512, fundo transparente),
como as entregues pelo diretor de arte em colaboracao/entregas/<ID>/.

Para cada conjunto: remove franja verde residual (despill), reduz para a escala de textura,
monta atlas + SpriteFrames (.tres) e gera scripts/sprite_meta_cells.gd com caminho e offset.
A âncora é um ponto fixo da célula (ex.: linha dos pés x=192, y=472), igual em todos os quadros,
então o sprite não "pula" entre quadros.

uso: python tools/import_cells.py <projeto_godot>
Os conjuntos ficam em CELL_SETS abaixo. O PNG original da entrega nunca é alterado.
"""
import sys, os, math
import numpy as np
from PIL import Image

PROJ = sys.argv[1] if len(sys.argv) > 1 else "."
CW, CH = 384, 512

# Altura de referência: Daymon idle no jogo = 488 px desenhados × 0.30 (tex) = 146.4 px de textura.
DAYMON_REF_TEX_H = 488 * 0.30

# nome: (pasta de saída, altura visível desenhada (px), âncora na célula, {anim: (png, quadros, fps, loop)})
CELL_SETS = {
    "eco": ("assets/inimigos/eco", 380, (192, 472), {
        "float": ("colaboracao/entregas/A2_eco_float/A2_eco_float.png", 6, 8, True),
    }),
}


def despill(im):
    a = np.array(im.convert("RGBA")).astype(np.int32)
    r, g, b, al = a[..., 0], a[..., 1], a[..., 2], a[..., 3]
    lim = np.maximum(r, b)
    mask = (g > lim) & (al < 255)
    a[..., 1] = np.where(mask, lim, g)
    a[..., 3] = np.where(al < 6, 0, al)
    return Image.fromarray(a.astype(np.uint8), "RGBA")


def build(name, folder, drawn_h, anchor, anims):
    ts = DAYMON_REF_TEX_H / drawn_h
    cw, ch = math.ceil(CW * ts), math.ceil(CH * ts)
    frames = []
    for an, (png, n, fps, loop) in anims.items():
        sheet = despill(Image.open(os.path.join(PROJ, png)))
        assert sheet.size == (4 * CW, 2 * CH), f"{png}: tamanho {sheet.size}"
        for i in range(n):
            c = sheet.crop(((i % 4) * CW, (i // 4) * CH, (i % 4) * CW + CW, (i // 4) * CH + CH))
            frames.append((an, c.resize((cw, ch), Image.LANCZOS)))
    cols = min(len(frames), max(1, 2048 // cw))
    rows = math.ceil(len(frames) / cols)
    atlas = Image.new("RGBA", (cols * cw, rows * ch), (0, 0, 0, 0))
    regions = []
    for i, (an, im) in enumerate(frames):
        x, y = (i % cols) * cw, (i // cols) * ch
        atlas.alpha_composite(im, (x, y))
        regions.append((an, x, y))
    os.makedirs(os.path.join(PROJ, folder), exist_ok=True)
    png_out = f"{folder}/{name}_sheet.png"
    atlas.save(os.path.join(PROJ, png_out))
    lines = [f'[gd_resource type="SpriteFrames" load_steps={len(frames) + 2} format=3]', "",
             f'[ext_resource type="Texture2D" path="res://{png_out}" id="1_sheet"]', ""]
    for i, (an, x, y) in enumerate(regions):
        lines += [f'[sub_resource type="AtlasTexture" id="f{i}"]', 'atlas = ExtResource("1_sheet")',
                  f"region = Rect2({x}, {y}, {cw}, {ch})", ""]
    lines.append("[resource]")
    parts = []
    for an, (png, n, fps, loop) in anims.items():
        ids = [i for i, r in enumerate(regions) if r[0] == an]
        frs = ", ".join('{\n"duration": 1.0,\n"texture": SubResource("f%d")\n}' % i for i in ids)
        parts.append('{\n"frames": [%s],\n"loop": %s,\n"name": &"%s",\n"speed": %s\n}' % (
            frs, "true" if loop else "false", an, float(fps)))
    lines.append("animations = [%s]" % ", ".join(parts))
    tres = f"{folder}/{name}_frames.tres"
    open(os.path.join(PROJ, tres), "w").write("\n".join(lines) + "\n")
    # offset para centered=true: a âncora fica na origem do nó
    ax, ay = anchor[0] * ts, anchor[1] * ts
    off = (cw / 2.0 - ax, ch / 2.0 - ay)
    print(f"{name}: tex_scale={ts:.4f} célula={cw}x{ch} quadros={len(frames)} offset=({off[0]:.2f},{off[1]:.2f})")
    return tres, off, ts


out = ["class_name SpriteMetaCells", "extends RefCounted",
       "## Gerado por tools/import_cells.py (entregas do diretor de arte em grade 4x2).",
       "## Use com AnimatedSprite2D centered=true e a mesma escala de nó do Daymon (0.58).", ""]
for name, (folder, drawn_h, anchor, anims) in CELL_SETS.items():
    tres, off, ts = build(name, folder, drawn_h, anchor, anims)
    const = name.upper()
    out.append(f'const {const}_FRAMES := "res://{tres}"')
    out.append(f"const {const}_OFFSET := Vector2({off[0]:.2f}, {off[1]:.2f})")
    out.append(f"const {const}_TEX_SCALE := {ts:.4f}")
    out.append("")
open(os.path.join(PROJ, "scripts/sprite_meta_cells.gd"), "w").write("\n".join(out) + "\n")
