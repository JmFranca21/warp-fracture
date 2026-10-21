class_name EnemyBullet
extends Area2D
## Projétil inimigo (laser do drone, esporos). Pode ter "delay" = aviso antes de cair.

var vel := Vector2.ZERO
var grav := 0.0
var color := Color(1.0, 0.35, 0.3)
var radius := 7.0
var life := 5.0
var delay := 0.0
var t := 0.0
var gl: Sprite2D


func _ready() -> void:
	collision_layer = 16
	collision_mask = 1
	add_to_group("enemy_attack")
	z_index = 7
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = radius
	cs.shape = c
	add_child(cs)
	gl = Art.glow(color, radius * 4.5)
	add_child(gl)
	if delay > 0.0:
		monitoring = false
	body_entered.connect(func(_b): pop())


func _physics_process(dt: float) -> void:
	t += dt
	if delay > 0.0:
		delay -= dt
		gl.modulate.a = 0.4 + 0.4 * sin(t * 25.0)
		if delay <= 0.0:
			set_deferred("monitoring", true)
			gl.modulate.a = 1.0
		queue_redraw()
		return
	vel.y += grav * dt
	position += vel * dt
	life -= dt
	if life <= 0.0:
		queue_free()
	queue_redraw()


func is_harmful() -> bool:
	return delay <= 0.0


func on_hit_player() -> void:
	pop()


func pop() -> void:
	if is_queued_for_deletion() or delay > 0.0:
		return
	Fx.burst(get_parent(), global_position, color, 10, 200, 0.35, 0.06)
	queue_free()


func _draw() -> void:
	if delay > 0.0:
		var r := radius * (1.6 + 0.4 * sin(t * 25.0))
		draw_arc(Vector2.ZERO, r, 0.0, TAU, 24, Color(color, 0.8), 2.0, true)
		draw_circle(Vector2.ZERO, radius * 0.4, Color(color, 0.9))
		return
	draw_circle(Vector2.ZERO, radius, Color(color, 0.85))
	draw_circle(Vector2.ZERO, radius * 0.5, Color(1, 1, 1, 0.9))
	draw_arc(Vector2.ZERO, radius + 2.0, 0.0, TAU, 24, Color(color, 0.5), 2.0, true)
