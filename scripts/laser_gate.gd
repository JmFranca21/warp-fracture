class_name LaserGate
extends Node2D
## Barreira de laser vertical (teto → chão). Liga e desliga em ciclos: passe no intervalo.

var top_y := 220.0
var bottom_y := 800.0
var on_time := 1.6
var off_time := 1.4
var phase := 0.0
var t := 0.0
var on := false
var level
var area: Area2D


func _ready() -> void:
	z_index = 3
	var e1 := Props.centered("laser_emissor", 0.7)
	e1.rotation = PI / 2.0
	e1.position = Vector2(0, top_y + 18)
	add_child(e1)
	var e2 := Props.centered("laser_emissor", 0.7)
	e2.rotation = -PI / 2.0
	e2.position = Vector2(0, bottom_y - 18)
	add_child(e2)
	t = phase


func is_on() -> bool:
	return on


func _physics_process(dt: float) -> void:
	t += dt
	var cyc := fmod(t, on_time + off_time)
	var was := on
	on = cyc < on_time
	if on and not was:
		AudioMgr.sfx("laser_liga", global_position + Vector2(0, 500), -8.0, 0.05)
		Fx.burst(level.fx, global_position + Vector2(0, top_y + 30), Color(1, 0.3, 0.3), 6, 120, 0.3, 0.05, 0)
	var p = level.player
	if on and is_instance_valid(p):
		if absf(p.global_position.x - global_position.x) < 18.0 and p.global_position.y > top_y and p.global_position.y - 54 < bottom_y:
			p.hurt(Vector2(global_position.x, p.global_position.y - 20), 1, true)
	queue_redraw()


func _draw() -> void:
	var a := Vector2(0, top_y + 36)
	var b := Vector2(0, bottom_y - 36)
	var cyc := fmod(t, on_time + off_time)
	if on:
		var w := 6.0 + 2.0 * sin(t * 40.0)
		draw_line(a, b, Color(1.0, 0.2, 0.25, 0.3), w * 3.0, true)
		draw_line(a, b, Color(1.0, 0.35, 0.4, 0.95), w, true)
		draw_line(a, b, Color(1.0, 0.9, 0.9), w * 0.3, true)
	elif cyc > on_time + off_time - 0.45:
		draw_line(a, b, Color(1.0, 0.3, 0.3, 0.35), 1.5, true)
