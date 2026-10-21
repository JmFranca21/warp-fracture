class_name Bullet
extends Area2D
## Tiro do Estabilizador de Fase (Daymon humano).

var dir := Vector2.RIGHT
var speed := 1000.0
var dmg := 1
var pierce := false
var big := false
var player
var life := 0.9
var hit := {}
var g: Sprite2D


func _ready() -> void:
	collision_layer = 8
	collision_mask = 1 | 4
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = 16.0 if big else 9.0
	cs.shape = c
	add_child(cs)
	g = Art.glow(Color(0.4, 0.9, 1.0, 0.9), 70.0 if big else 30.0)
	add_child(g)
	body_entered.connect(_on_body)
	z_index = 8


func _physics_process(dt: float) -> void:
	position += dir * speed * dt
	life -= dt
	for a in get_overlapping_areas():
		if a.has_meta("enemy") and not hit.has(a):
			hit[a] = true
			var e = a.get_meta("enemy")
			if is_instance_valid(e) and not e.dead:
				e.take_hit(dmg, global_position - dir * 30.0)
				if is_instance_valid(player):
					player.on_hit_enemy(Vector2.ZERO)
				if not pierce:
					_pop()
					return
	if life <= 0.0:
		queue_free()
	queue_redraw()


func _on_body(b: Node) -> void:
	if b.has_meta("breakable"):
		var c = b.get_meta("breakable")
		if is_instance_valid(c) and not c.broken and not hit.has(c):
			hit[c] = true
			c.take_hit(dmg, global_position)
			if pierce and not c.broken:
				_pop()
				return
			if pierce:
				return
	_pop()


func _pop() -> void:
	if is_queued_for_deletion():
		return
	FxAnim.impact(get_parent(), global_position, 0.75 if big else 0.5)
	queue_free()


func _draw() -> void:
	var l := 34.0 if big else 18.0
	var w := 14.0 if big else 6.0
	draw_line(-dir * l, Vector2.ZERO, Color(0.4, 0.9, 1.0, 0.45), w, true)
	draw_line(-dir * l * 0.5, Vector2.ZERO, Color(0.85, 1.0, 1.0, 1.0), w * 0.45, true)
	draw_circle(Vector2.ZERO, w * 0.5, Color(1, 1, 1))
