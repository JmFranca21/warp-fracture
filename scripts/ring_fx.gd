class_name RingFx
extends Node2D

var color := Color(1, 1, 1)
var max_r := 160.0
var dur := 0.4
var width := 6.0
var t := 0.0


func _ready() -> void:
	z_index = 9
	material = Art.add_mat()


func _process(dt: float) -> void:
	t += dt
	if t >= dur:
		queue_free()
		return
	queue_redraw()


func _draw() -> void:
	var k := t / dur
	var r := max_r * (1.0 - pow(1.0 - k, 3.0))
	var c := Color(color, color.a * (1.0 - k))
	draw_arc(Vector2.ZERO, r, 0.0, TAU, 64, c, width * (1.0 - k * 0.6), true)
	draw_arc(Vector2.ZERO, r * 0.8, 0.0, TAU, 64, Color(c, c.a * 0.4), width * 2.0, true)
