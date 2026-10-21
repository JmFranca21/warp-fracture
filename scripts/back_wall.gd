class_name BackWall
extends Node2D
## Parede de fundo do laboratório: painéis, colunas, rodapé, tubulações e brechas.
## Serve de "apoio" para a decoração (janelas, válvulas, tanques), para nada parecer flutuando.

var spans: Array = []      # [x0, x1, y_topo, y_base]
var columns: Array = []    # x das colunas
var breaches: Array = []   # [x, y, raio]  (rombos na parede com vista para fora)
var pipes: Array = []      # [x0, x1, y]   (cano horizontal preso na parede)
var drops: Array = []      # [x, y0, y1]   (cano vertical: do tanque até o cano da parede)
var rails: Array = []      # [a, b]        (trilho de plataforma móvel)
var t := 0.0

const PANEL := Color("0e1622")
const PANEL2 := Color("111a27")
const SEAM := Color("090f17")
const COLUMN := Color("151f2d")
const COL_EDGE := Color("26364d")
const PIPE := Color("1a2638")
const PIPE_HI := Color("2d4060")


func _ready() -> void:
	z_index = -20
	queue_redraw()


func _process(dt: float) -> void:
	t += dt
	if int(t * 10.0) != int((t - dt) * 10.0):
		queue_redraw()


func _span_of(x: float, y: float) -> Array:
	for s in spans:
		if x >= s[0] and x <= s[1] and y >= s[2] and y <= s[3]:
			return s
	return []


func _draw() -> void:
	for s in spans:
		_draw_span(s)
	for p in pipes:
		_draw_pipe(Vector2(p[0], p[2]), Vector2(p[1], p[2]))
	for d in drops:
		_draw_pipe(Vector2(d[0], d[1]), Vector2(d[0], d[2]))
		draw_rect(Rect2(d[0] - 11, d[2] - 8, 22, 16), PIPE_HI)
	for r in rails:
		var a: Vector2 = r[0]
		var b: Vector2 = r[1]
		draw_line(a, b, Color("0b121c"), 10.0)
		draw_line(a, b, Color("22324a"), 3.0)
		for e in [a, b]:
			draw_rect(Rect2(e - Vector2(9, 9), Vector2(18, 18)), Color("1c2a3e"))
			draw_circle(e, 3.0, Color(0.35, 0.9, 1.0, 0.6))
	for c in columns:
		for sp in spans:
			if c >= sp[0] and c <= sp[1]:
				_draw_column(c, sp[2], sp[3])


func _draw_span(s: Array) -> void:
	var x0: float = s[0]
	var x1: float = s[1]
	var y0: float = s[2]
	var y1: float = s[3]
	var cols: Array = [x0]
	for c in columns:
		if c > x0 and c < x1:
			cols.append(c)
	cols.append(x1)
	cols.sort()
	for i in cols.size() - 1:
		var bx0: float = cols[i]
		var bx1: float = cols[i + 1]
		var bay := Rect2(bx0, y0, bx1 - bx0, y1 - y0)
		var hole: PackedVector2Array = PackedVector2Array()
		for b in breaches:
			if b[0] > bx0 and b[0] < bx1 and b[1] > y0 and b[1] < y1:
				hole = _jagged(Vector2(b[0], b[1]), b[2])
		if hole.is_empty():
			draw_rect(bay, PANEL)
		else:
			# desenha o painel em duas metades recortadas pelo rombo (sem polígono com furo)
			var mid: float = 0.0
			for p in hole:
				mid += p.x
			mid /= hole.size()
			for half in [Rect2(bx0, y0, mid - bx0, y1 - y0), Rect2(mid, y0, bx1 - mid, y1 - y0)]:
				var poly := PackedVector2Array([half.position, Vector2(half.end.x, half.position.y), half.end, Vector2(half.position.x, half.end.y)])
				for piece in Geometry2D.clip_polygons(poly, hole):
					if piece.size() >= 3:
						draw_colored_polygon(piece, PANEL)
		# painéis: faixas horizontais e costuras
		var y := y0 + 70.0
		var k := 0
		while y < y1 - 40.0:
			var band := Rect2(bx0 + 6, y, bx1 - bx0 - 12, 3)
			if hole.is_empty() or not Geometry2D.is_point_in_polygon(band.get_center(), hole):
				draw_rect(band, SEAM)
			y += 120.0
			k += 1
		if hole.is_empty():
			draw_rect(Rect2(bx0 + 10, y0 + 20, bx1 - bx0 - 20, 30), PANEL2)
		else:
			_draw_breach(hole)
	# cornija (junto ao teto) e rodapé (junto ao chão)
	draw_rect(Rect2(x0, y0, x1 - x0, 14), Color("16202e"))
	draw_rect(Rect2(x0, y1 - 34, x1 - x0, 34), Color("0b111a"))
	draw_line(Vector2(x0, y1 - 34), Vector2(x1, y1 - 34), Color("1d2a3c"), 2.0)
	var lx := x0 + 30.0
	while lx < x1 - 20.0:
		var a := 0.35 + 0.25 * sin(t * 1.5 + lx * 0.01)
		draw_rect(Rect2(lx, y1 - 20, 10, 3), Color(0.35, 0.9, 1.0, a))
		lx += 90.0


func _draw_breach(hole: PackedVector2Array) -> void:
	var c := Vector2.ZERO
	for p in hole:
		c += p
	c /= hole.size()
	# interior: escuridão com o brilho roxo da fenda dimensional
	draw_colored_polygon(hole, Color("05070c"))
	for k in [0.75, 0.5, 0.28]:
		var inner := PackedVector2Array()
		for p in hole:
			inner.append(c + (p - c) * k)
		draw_colored_polygon(inner, Color(0.45, 0.25, 0.9, 0.10 + 0.04 * sin(t * 2.0)))
	# borda quebrada
	var hp := hole.duplicate()
	hp.append(hole[0])
	draw_polyline(hp, Color("1e2a3d"), 7.0, true)
	draw_polyline(hp, Color(0.6, 0.4, 1.0, 0.35 + 0.15 * sin(t * 2.0)), 2.0, true)
	# rachaduras saindo do rombo
	var rng := RandomNumberGenerator.new()
	rng.seed = int(c.x)
	for i in 6:
		var p0: Vector2 = hole[(i * 3) % hole.size()]
		var d := (p0 - c).normalized()
		var pts := PackedVector2Array([p0])
		var q := p0
		for j in 4:
			q += d.rotated(rng.randf_range(-0.6, 0.6)) * rng.randf_range(14, 30)
			pts.append(q)
		draw_polyline(pts, Color("070b11"), 3.0, true)
		draw_polyline(pts, Color(0.6, 0.4, 1.0, 0.25), 1.0, true)


func _draw_column(x: float, y0: float, y1: float) -> void:
	var w := 46.0
	draw_rect(Rect2(x - w / 2, y0, w, y1 - y0), COLUMN)
	draw_line(Vector2(x - w / 2, y0), Vector2(x - w / 2, y1), COL_EDGE, 2.0)
	draw_line(Vector2(x + w / 2, y0), Vector2(x + w / 2, y1), Color("0b111a"), 2.0)
	draw_rect(Rect2(x - w / 2 - 6, y0, w + 12, 22), Color("1b2738"))
	draw_rect(Rect2(x - w / 2 - 8, y1 - 40, w + 16, 40), Color("182333"))
	var y := y0 + 60.0
	while y < y1 - 60.0:
		draw_circle(Vector2(x - 12, y), 2.0, Color("2a3a52"))
		draw_circle(Vector2(x + 12, y), 2.0, Color("2a3a52"))
		y += 70.0
	# luminária na coluna
	draw_rect(Rect2(x - 4, y0 + 40, 8, 26), Color(0.35, 0.9, 1.0, 0.55))


func _draw_pipe(a: Vector2, b: Vector2) -> void:
	draw_line(a, b, Color("080d14"), 20.0)
	draw_line(a, b, PIPE, 16.0)
	var n := (b - a).normalized().orthogonal()
	draw_line(a + n * 4, b + n * 4, PIPE_HI, 3.0)
	var L := a.distance_to(b)
	var d := 60.0
	while d < L:
		var p := a.lerp(b, d / L)
		draw_line(p - n * 11, p + n * 11, Color("24344c"), 6.0)
		d += 140.0


func _jagged(c: Vector2, r: float) -> PackedVector2Array:
	var pts := PackedVector2Array()
	var rng := RandomNumberGenerator.new()
	rng.seed = int(c.x * 7.0 + c.y)
	for i in 14:
		var a := TAU * i / 14.0
		var rr := r * rng.randf_range(0.65, 1.1)
		pts.append(c + Vector2(cos(a) * rr * 1.15, sin(a) * rr))
	return pts
