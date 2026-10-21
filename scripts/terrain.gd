class_name TerrainDraw
extends Node2D
## Desenha o terreno sólido (chão, paredes, plataformas).

var theme := "lab"
var rects: Array = []


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 4242
	for rv in rects:
		var r: Rect2 = rv
		if theme == "lab":
			_lab_rect(r, rng)
		else:
			_verd_rect(r, rng)


func _lab_rect(r: Rect2, rng: RandomNumberGenerator) -> void:
	var fill := Color("0b1018")
	var edge := Color("4a5d73")
	var seam := Color("141c27")
	draw_rect(r, fill)
	var thin := r.size.y < 40.0
	draw_rect(Rect2(r.position, Vector2(r.size.x, minf(26.0, r.size.y))), Color("121a25"))
	var x := r.position.x + 60.0
	while x < r.end.x - 10.0:
		draw_line(Vector2(x, r.position.y + 4), Vector2(x, minf(r.end.y, r.position.y + 400)), seam, 2)
		x += 120.0
	draw_line(r.position, Vector2(r.end.x, r.position.y), edge, 3)
	draw_line(r.position + Vector2(0, 5), Vector2(r.end.x, r.position.y + 5), Color(0.29, 0.36, 0.45, 0.35), 1)
	if thin:
		draw_line(Vector2(r.position.x, r.end.y), r.end, Color("27323f"), 2)
		var px := r.position.x + 20.0
		while px < r.end.x - 10.0:
			draw_line(Vector2(px, r.end.y), Vector2(px - 8, r.end.y + 10), Color("0b1018"), 3)
			px += 40.0
	var rv := r.position.x + 20.0
	while rv < r.end.x:
		draw_circle(Vector2(rv, r.position.y + 12), 1.6, Color("2a3646"))
		rv += 40.0
	# teto: acabamento na face de baixo com suportes
	if r.end.y <= 240.0 and r.size.y > 100.0 and r.size.x > 100.0:
		draw_rect(Rect2(r.position.x, r.end.y - 16, r.size.x, 16), Color("16202e"))
		draw_line(Vector2(r.position.x, r.end.y), r.end, Color("2c3b52"), 2)
		var bx := r.position.x + 80.0
		while bx < r.end.x - 40.0:
			draw_rect(Rect2(bx - 14, r.end.y - 22, 28, 22), Color("1b2738"))
			draw_circle(Vector2(bx, r.end.y - 11), 3.0, Color("2f4058"))
			bx += 240.0
	# parede que termina acima do chão = batente de passagem (verga com faixa de aviso)
	if r.size.x < 200.0 and r.size.y > 200.0 and r.end.y < 790.0 and r.end.y > 300.0:
		var lt := Rect2(r.position.x - 8, r.end.y - 20, r.size.x + 16, 20)
		draw_rect(lt, Color("1b2738"))
		var sx := lt.position.x
		var on := false
		while sx < lt.end.x:
			if on:
				var a := Vector2(sx, lt.end.y - 9)
				draw_colored_polygon(PackedVector2Array([a, a + Vector2(10, 0), a + Vector2(16, 9), a + Vector2(6, 9)]), Color(0.85, 0.65, 0.15, 0.85))
			sx += 10.0
			on = not on
		draw_line(Vector2(lt.position.x, lt.end.y), lt.end, Color("2c3b52"), 2)
	# paredes verticais: borda lateral iluminada
	if r.size.y > 300 and r.size.x < 200:
		draw_line(Vector2(r.position.x, r.position.y), Vector2(r.position.x, r.end.y), Color(0.29, 0.36, 0.45, 0.6), 2)
		draw_line(Vector2(r.end.x, r.position.y), Vector2(r.end.x, r.end.y), Color(0.29, 0.36, 0.45, 0.6), 2)


func _verd_rect(r: Rect2, rng: RandomNumberGenerator) -> void:
	var fill := Color("05090b")
	var moss := Color("0f2e2a")
	var glow := Color(0.35, 0.95, 0.75, 0.55)
	draw_rect(r, fill)
	# musgo ondulado no topo
	var top := PackedVector2Array()
	var x := r.position.x
	while x <= r.end.x:
		top.append(Vector2(x, r.position.y - 3.0 - 3.0 * sin(x * 0.05) - 2.0 * sin(x * 0.13 + 1.0)))
		x += 8.0
	top.append(Vector2(r.end.x, r.position.y - 3.0))
	var poly := top.duplicate()
	poly.append(Vector2(r.end.x, r.position.y + minf(16.0, r.size.y)))
	poly.append(Vector2(r.position.x, r.position.y + minf(16.0, r.size.y)))
	draw_colored_polygon(poly, moss)
	draw_polyline(top, glow, 1.6, true)
	# folhas de grama
	var gx := r.position.x + 4.0
	while gx < r.end.x - 4.0:
		var h := rng.randf_range(5, 15)
		var lean := rng.randf_range(-5, 5)
		draw_line(Vector2(gx, r.position.y - 2), Vector2(gx + lean, r.position.y - 2 - h), Color("1d5248"), 2, true)
		gx += rng.randf_range(6, 16)
	# laterais com musgo
	if r.size.y > 300 and r.size.x < 200:
		draw_line(Vector2(r.position.x, r.position.y), Vector2(r.position.x, r.end.y), Color(0.2, 0.55, 0.45, 0.45), 2)
		draw_line(Vector2(r.end.x, r.position.y), Vector2(r.end.x, r.end.y), Color(0.2, 0.55, 0.45, 0.45), 2)
	# raízes penduradas em plataformas finas
	if r.size.y < 40.0:
		var rx := r.position.x + 10.0
		while rx < r.end.x - 6.0:
			var l := rng.randf_range(12, 50)
			var pts := PackedVector2Array([Vector2(rx, r.end.y), Vector2(rx + 3, r.end.y + l * 0.5), Vector2(rx - 2, r.end.y + l)])
			draw_polyline(pts, Color("0c1a1a"), 2.5, true)
			if rng.randf() < 0.35:
				draw_circle(pts[2], 2.5, Color(0.85, 1.0, 0.5, 0.8))
			rx += rng.randf_range(14, 30)
