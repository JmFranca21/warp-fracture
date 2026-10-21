class_name Spike
extends Area2D
## Raiz espinhosa que irrompe do chão (ataque da Rainha Micélia). Avisa antes de subir.

var t := 0.0
var warn := 0.6
var up := 0.5
var height := 140.0
var active := false


func _ready() -> void:
	collision_layer = 16
	collision_mask = 0
	monitoring = false
	add_to_group("enemy_attack")
	z_index = 6
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = Vector2(40, height)
	cs.shape = r
	cs.position = Vector2(0, -height / 2.0)
	add_child(cs)
	var g := Art.glow(Color(0.7, 0.35, 1.0, 0.6), 50)
	g.position = Vector2(0, -6)
	add_child(g)


func _physics_process(dt: float) -> void:
	t += dt
	if t > warn and not active and t < warn + up:
		active = true
		get_tree().root.get_node("Main").add_shake(5.0)
		AudioMgr.sfx("raiz", global_position, -4.0, 0.1)
	if t >= warn + up and active:
		active = false
	if t > warn + up + 0.35:
		queue_free()
	queue_redraw()


func is_harmful() -> bool:
	return active


func _draw() -> void:
	if t < warn:
		var k := t / warn
		var c := Color(0.75, 0.45, 1.0, 0.4 + 0.5 * k)
		draw_line(Vector2(-22, -2), Vector2(22, -2), c, 3.0 + 3.0 * k, true)
		for i in 3:
			draw_line(Vector2(-10 + i * 10, -2), Vector2(-14 + i * 12, -8 - 10 * k), c, 2.0, true)
		return
	var h := height
	if t < warn + 0.12:
		h = height * ((t - warn) / 0.12)
	elif t > warn + up:
		h = height * maxf(0.0, 1.0 - (t - warn - up) / 0.35)
	var dark := Color("1b0f2c")
	for i in 3:
		var x := -14.0 + i * 14.0
		var hh := h * (0.75 + 0.25 * float(i % 2))
		draw_colored_polygon(PackedVector2Array([Vector2(x - 10, 0), Vector2(x + 2, -hh), Vector2(x + 10, 0)]), dark)
		draw_line(Vector2(x + 2, -hh), Vector2(x, -hh * 0.6), Color(0.85, 0.65, 1.0, 0.8), 2.0, true)
