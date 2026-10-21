class_name Art
extends RefCounted
## Utilitários de desenho vetorial (arte 2D suave, sem pixel art).

static var _glow: Texture2D
static var _add: CanvasItemMaterial


static func glow_tex() -> Texture2D:
	if _glow == null:
		var g := Gradient.new()
		g.offsets = PackedFloat32Array([0.0, 0.22, 1.0])
		g.colors = PackedColorArray([Color(1, 1, 1, 1), Color(1, 1, 1, 0.42), Color(1, 1, 1, 0)])
		var t := GradientTexture2D.new()
		t.gradient = g
		t.width = 128
		t.height = 128
		t.fill = GradientTexture2D.FILL_RADIAL
		t.fill_from = Vector2(0.5, 0.5)
		t.fill_to = Vector2(1.0, 0.5)
		_glow = t
	return _glow


static func add_mat() -> CanvasItemMaterial:
	if _add == null:
		_add = CanvasItemMaterial.new()
		_add.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	return _add


static func glow(color: Color, radius: float) -> Sprite2D:
	var s := Sprite2D.new()
	s.texture = glow_tex()
	s.material = add_mat()
	s.modulate = color
	s.scale = Vector2.ONE * (radius * 2.0 / 128.0)
	return s


static func circle(c: Vector2, r: float, n: int = 20) -> PackedVector2Array:
	return ellipse(c, r, r, n)


static func ellipse(c: Vector2, rx: float, ry: float, n: int = 24, rot: float = 0.0) -> PackedVector2Array:
	var pts := PackedVector2Array()
	for i in n:
		var a := TAU * float(i) / float(n)
		pts.append(c + Vector2(cos(a) * rx, sin(a) * ry).rotated(rot))
	return pts


static func poly(ci: CanvasItem, pts: PackedVector2Array, col: Color) -> void:
	if pts.size() < 3:
		return
	ci.draw_colored_polygon(pts, col)
	var closed := pts.duplicate()
	closed.append(pts[0])
	ci.draw_polyline(closed, col, 1.0, true)


static func font() -> Font:
	return ThemeDB.fallback_font


static func text(ci: CanvasItem, pos: Vector2, s: String, size: int, col: Color,
		align: HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT, width: float = -1.0,
		outline: int = 0, ocol: Color = Color(0, 0, 0, 0.8)) -> void:
	var f := font()
	if outline > 0:
		ci.draw_string_outline(f, pos, s, align, width, size, outline, Color(ocol.r, ocol.g, ocol.b, ocol.a * col.a))
	ci.draw_string(f, pos, s, align, width, size, col)


static func shard(c: Vector2, s: float) -> PackedVector2Array:
	return PackedVector2Array([c + Vector2(0, -14) * s, c + Vector2(8, -5) * s, c + Vector2(6, 10) * s,
		c + Vector2(0, 14) * s, c + Vector2(-6, 10) * s, c + Vector2(-8, -5) * s])
