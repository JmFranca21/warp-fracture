class_name FgLayer
extends Node2D
## Primeiro plano escuro (tufos, entulho) na frente dos personagens, para dar profundidade.

var theme := "lab"
var depth := 1.0
var span := Vector2(-600, 6000)
var ground_rects: Array = []


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = 991
	for rv in ground_rects:
		var r: Rect2 = rv
		if r.size.x < 300.0 or r.size.y < 300.0:
			continue
		var x := r.position.x + rng.randf_range(20, 120)
		while x < r.end.x - 40.0:
			if theme == "verd":
				_tuft(Vector2(x, r.position.y + 6), rng)
			else:
				_rubble(Vector2(x, r.position.y + 4), rng)
			x += rng.randf_range(180, 420)


func _tuft(p: Vector2, rng: RandomNumberGenerator) -> void:
	var c := Color("010304")
	for i in 7 + rng.randi() % 6:
		var h := rng.randf_range(18, 46)
		var dx := rng.randf_range(-22, 22)
		var lean := dx * 0.6 + rng.randf_range(-6, 6)
		var pts := PackedVector2Array([p + Vector2(dx - 3, 0), p + Vector2(dx + lean, -h), p + Vector2(dx + 3, 0)])
		draw_colored_polygon(pts, c)
	if rng.randf() < 0.4:
		draw_circle(p + Vector2(rng.randf_range(-10, 10), -rng.randf_range(30, 46)), 2.2, Color(0.85, 1.0, 0.5, 0.9))


func _rubble(p: Vector2, rng: RandomNumberGenerator) -> void:
	var c := Color("020406")
	var pts := PackedVector2Array()
	var w := rng.randf_range(30, 70)
	pts.append(p + Vector2(-w, 2))
	for i in 5:
		pts.append(p + Vector2(-w + (i + 0.5) * w * 2.0 / 5.0, -rng.randf_range(6, 22)))
	pts.append(p + Vector2(w, 2))
	draw_colored_polygon(pts, c)
	if rng.randf() < 0.5:
		draw_line(p + Vector2(-w * 0.3, -10), p + Vector2(-w * 0.3 + 14, -40), c, 3, true)
