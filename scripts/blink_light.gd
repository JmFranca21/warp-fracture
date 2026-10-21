class_name BlinkLight
extends Node2D
## Luz de alerta que pisca. Em alarme, pisca rápido e mais forte.

var color := Color(1, 0.2, 0.1, 0.8)
var g: Sprite2D
var t := 0.0
var alarm := false


func _ready() -> void:
	add_to_group("alarm_lights")
	g = Art.glow(color, 46)
	add_child(g)
	t = randf() * 3.0


func _process(dt: float) -> void:
	t += dt
	var speed := 12.0 if alarm else 4.0
	var amp := 1.4 if alarm else 1.0
	g.modulate = Color(color, color.a * amp * (0.2 + 0.8 * maxf(0.0, sin(t * speed))))
	g.scale = Vector2.ONE * (46.0 * (1.5 if alarm else 1.0)) * 2.0 / 128.0
