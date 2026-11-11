class_name Fragment
extends Area2D
## Fragmento da Máquina de Dobra.

var main
var t := 0.0
var taken := false
var g: Sprite2D
var base_y := 0.0
var spr: Sprite2D


func _ready() -> void:
	collision_layer = 64
	collision_mask = 2
	z_index = 4
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = 26.0
	cs.shape = c
	add_child(cs)
	g = Art.glow(Color(0.6, 0.85, 1.0, 0.55), 120)
	add_child(g)
	spr = Props.centered(SpriteMetaVerd.OBJ_DIR + "fragmento.png", SpriteMetaVerd.OBJ_SCALE)
	add_child(spr)
	base_y = position.y
	body_entered.connect(_on_body)
	Fx.ring(get_parent(), position, Color(0.7, 0.9, 1.0), 200, 0.7, 8)


func _process(dt: float) -> void:
	t += dt
	position.y = base_y + sin(t * 2.0) * 8.0
	g.modulate.a = 0.45 + 0.2 * sin(t * 3.0)
	spr.rotation = sin(t * 1.3) * 0.06


func _on_body(b: Node) -> void:
	if taken or not (b is Player):
		return
	taken = true
	Fx.burst(get_parent(), global_position, Color(0.7, 0.9, 1.0), 50, 500, 1.0, 0.1, 0)
	Fx.ring(get_parent(), global_position, Color(0.8, 0.95, 1.0), 500, 1.0, 10)
	main.collect_fragment()
	visible = false
