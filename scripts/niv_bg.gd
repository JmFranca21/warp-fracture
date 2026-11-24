class_name NivBg
extends Node2D
## Parallax de Nivária desenhado por código (GL00, noite polar). O Level move a camada:
## posição = centro da câmera × (1 − depth).
##  0: céu (estrelas, lua e aurora rosa) · 1: picos distantes · 2: montanhas e arcos em ruína · 3: morros próximos

var layer := 0
var depth := 0.1
var span_x := 9400.0
var span_x0 := 0.0          # início da fase em x (o Cume pode começar à esquerda de 0)


func _ready() -> void:
	queue_redraw()


## y local para um ponto que deve aparecer "rel" px abaixo do centro da tela, com a câmera numa altura típica.
func _y(rel: float) -> float:
	return rel + depth * 560.0


func _draw() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 911 + layer * 131
	var x0 := minf(-900.0, span_x0 * depth - 900.0)
	var x1 := span_x * depth + 900.0
	match layer:
		0:
			_sky(rng, x0, x1)
		1:
			_range(rng, x0, x1, _y(-120), 150.0, 320.0, Color("1B2943"), Color("4F6386"), 0.0)
		2:
			_range(rng, x0, x1, _y(-20), 110.0, 260.0, Color("22304A"), Color("9FB3CF"), 0.35)
		3:
			_hills(rng, x0, x1, _y(150), Color("1A2135"))


func _sky(rng: RandomNumberGenerator, x0: float, x1: float) -> void:
	for i in 160:
		var p := Vector2(rng.randf_range(x0, x1), _y(rng.randf_range(-420, 60)))
		draw_circle(p, rng.randf_range(0.8, 1.8), Color(1, 1, 1, rng.randf_range(0.25, 0.8)))
	var moon := Vector2(260, _y(-250))
	var g := Art.glow(Color(0.85, 0.9, 1.0, 0.35), 110)
	g.position = moon
	add_child(g)
	draw_circle(moon, 30.0, Color("E6EEF7"))
	draw_circle(moon + Vector2(-8, -6), 7.0, Color("C9D4E6"))
	# faixas de aurora: ondas de cor com as bordas transparentes
	var aur := [[Color("FF8FD0"), -300.0, 46.0], [Color("B26CEB"), -250.0, 30.0], [Color("FF8FD0"), -200.0, 22.0]]
	for a in aur:
		var c: Color = a[0]
		var pts := PackedVector2Array()
		var cols := PackedColorArray()
		var x := x0
		var top: Array = []
		var bot: Array = []
		while x <= x1:
			var y := _y(a[1] + sin(x * 0.004 + a[1]) * 40.0 + sin(x * 0.011) * 14.0)
			top.append(Vector2(x, y - a[2]))
			bot.append(Vector2(x, y + a[2] * 0.4))
			x += 40.0
		for i in top.size() - 1:
			var quad := PackedVector2Array([top[i], top[i + 1], bot[i + 1], bot[i]])
			var k := 0.5 + 0.5 * sin(i * 0.21 + a[1])
			draw_polygon(quad, PackedColorArray([Color(c, 0.0), Color(c, 0.0), Color(c, 0.28 * k), Color(c, 0.28 * k)]))


func _range(rng: RandomNumberGenerator, x0: float, x1: float, base: float, hmin: float, hmax: float, col: Color, snow: Color, ruins: float) -> void:
	var x := x0
	var peaks: Array = []
	while x < x1:
		var w := rng.randf_range(260, 520)
		peaks.append([x, x + w, base - rng.randf_range(hmin, hmax)])
		x += w * rng.randf_range(0.55, 0.8)
	for pk in peaks:
		var a := Vector2(pk[0], base + 40)
		var b := Vector2(pk[1], base + 40)
		var tip := Vector2((pk[0] + pk[1]) / 2.0 + rng.randf_range(-40, 40), pk[2])
		var shoulder_l := tip.lerp(a, 0.45) + Vector2(rng.randf_range(-20, 10), rng.randf_range(-10, 20))
		var shoulder_r := tip.lerp(b, 0.45) + Vector2(rng.randf_range(-10, 20), rng.randf_range(-10, 20))
		draw_colored_polygon(PackedVector2Array([a, shoulder_l, tip, shoulder_r, b, b + Vector2(0, 1400), a + Vector2(0, 1400)]), col)
		# neve no topo do pico
		var sl := tip.lerp(shoulder_l, 0.5)
		var sr := tip.lerp(shoulder_r, 0.5)
		draw_colored_polygon(PackedVector2Array([tip, sr, sr.lerp(sl, 0.3) + Vector2(0, 10), sr.lerp(sl, 0.65) - Vector2(0, 4), sl]), snow)
	draw_rect(Rect2(x0, base + 30, x1 - x0, 1400), col)
	if ruins > 0.0:
		var rx := x0 + 300.0
		while rx < x1:
			if rng.randf() < ruins:
				_arches(Vector2(rx, base + 34), rng.randi_range(2, 4), Color(col.lightened(0.08)))
			rx += rng.randf_range(500, 900)


## Arcos em ruína das estações antigas, de pé sobre a encosta.
func _arches(base: Vector2, n: int, col: Color) -> void:
	var w := 44.0
	for i in n:
		var x := base.x + i * w
		var h := 110.0 - absf(i - n / 2.0) * 18.0
		draw_rect(Rect2(x, base.y - h, 10, h), col)
		if i < n - 1:
			var arc := PackedVector2Array()
			for k in 9:
				var a := PI + PI * k / 8.0
				arc.append(Vector2(x + 5 + w / 2 + cos(a) * (w / 2), base.y - h + 6 + sin(a) * 18.0))
			draw_polyline(arc, col, 8.0)
	draw_rect(Rect2(base.x - 6, base.y - 4, n * w, 8), col)


func _hills(rng: RandomNumberGenerator, x0: float, x1: float, base: float, col: Color) -> void:
	var pts := PackedVector2Array()
	pts.append(Vector2(x0, base + 1400))
	var x := x0
	while x <= x1 + 60:
		pts.append(Vector2(x, base - 40 + sin(x * 0.006) * 40.0 + rng.randf_range(-10, 10)))
		x += 60.0
	pts.append(Vector2(x1 + 60, base + 1400))
	draw_colored_polygon(pts, col)
	var crest := pts.slice(1, pts.size() - 1)
	draw_polyline(crest, Color("4F6386"), 5.0, true)
