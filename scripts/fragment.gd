class_name Fragment
extends Area2D
## Fragmento da Máquina de Dobra.

var main
var t := 0.0
var taken := false
var g: Sprite2D
var base_y := 0.0


func _ready() -> void:
	collision_layer = 64
	collision_mask = 2
	z_index = 4
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = 26.0
	cs.shape = c
	add_child(cs)
	g = Art.glow(Color(0.6, 0.85, 1.0, 0.8), 140)
	add_child(g)
	base_y = position.y
	body_entered.connect(_on_body)
	Fx.ring(get_parent(), position, Color(0.7, 0.9, 1.0), 200, 0.7, 8)


func _process(dt: float) -> void:
	t += dt
	position.y = base_y + sin(t * 2.0) * 8.0
	g.modulate.a = 0.6 + 0.25 * sin(t * 3.0)
	queue_redraw()


func _on_body(b: Node) -> void:
	if taken or not (b is Player):
		return
	taken = true
	Fx.burst(get_parent(), global_position, Color(0.7, 0.9, 1.0), 50, 500, 1.0, 0.1, 0)
	Fx.ring(get_parent(), global_position, Color(0.8, 0.95, 1.0), 500, 1.0, 10)
	main.collect_fragment()
	visible = false


func _draw() -> void:
	var rot := t * 0.8
	var pts := PackedVector2Array()
	for i in 6:
		var a := rot + TAU * i / 6.0
		var r := 26.0 if i % 2 == 0 else 14.0
		pts.append(Vector2(cos(a) * r * 0.7, sin(a) * r))
	Art.poly(self, pts, Color(0.75, 0.9, 1.0, 0.9))
	Art.poly(self, Art.ellipse(Vector2.ZERO, 6, 10, 12), Color(1, 1, 1))
	draw_arc(Vector2.ZERO, 36.0, rot * 2.0, rot * 2.0 + 2.0, 24, Color(0.55, 0.4, 1.0, 0.8), 2.0, true)
	draw_arc(Vector2.ZERO, 36.0, rot * 2.0 + PI, rot * 2.0 + PI + 2.0, 24, Color(0.4, 0.95, 1.0, 0.8), 2.0, true)
