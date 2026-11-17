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


var absorb := false


func _process(dt: float) -> void:
	t += dt
	if absorb:
		spr.rotation += dt * 9.0
		return
	position.y = base_y + sin(t * 2.0) * 8.0
	g.modulate.a = 0.45 + 0.2 * sin(t * 3.0)
	spr.rotation = sin(t * 1.3) * 0.06


func _on_body(b: Node) -> void:
	if taken or not (b is Player):
		return
	taken = true
	absorb = true
	var at := Vector2(global_position.x, base_y + 30.0)
	Fx.burst(get_parent(), global_position, Color(0.7, 0.9, 1.0), 50, 500, 1.0, 0.1, 0)
	main.collect_fragment(at)
	# o cristal sobe, gira e entra no Traje Âncora com um anel de luz
	var p: Player = b
	var tw := create_tween()
	tw.tween_property(self, "position:y", position.y - 60.0, 0.9).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tw.tween_method(func(k: float):
		if is_instance_valid(p):
			global_position = global_position.lerp(p.global_position + Vector2(0, -36), k)
		scale = Vector2.ONE * (1.0 - k * 0.85), 0.0, 1.0, 0.8)
	tw.tween_callback(func():
		Fx.ring(get_parent(), global_position, Color(0.8, 0.95, 1.0), 260, 0.7, 8)
		visible = false)
