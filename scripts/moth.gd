class_name Moth
extends Enemy
## Mariposa Lanterna — voa em ondas e persegue a luz (o jogador).

var home := Vector2.ZERO
var g: Sprite2D


func _ready() -> void:
	hp = 2
	max_hp = 2
	main_color = Color(1.0, 0.9, 0.5)
	home = position
	collision_layer = 0
	collision_mask = 1
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = 12
	cs.shape = c
	add_child(cs)
	setup_hurt(Vector2(40, 32), Vector2.ZERO)
	g = Art.glow(Color(1.0, 0.88, 0.45, 0.75), 50)
	g.position = Vector2(0, 6)
	add_child(g)
	t = randf() * 5.0


func _physics_process(dt: float) -> void:
	tick(dt)
	var p := player()
	if knock_t > 0.0:
		velocity = velocity.move_toward(Vector2.ZERO, 900.0 * dt)
	elif stun > 0.0:
		velocity = velocity.move_toward(Vector2(0, 70), 400.0 * dt)
	elif p != null and p.global_position.distance_to(global_position) < 420.0:
		var tgt := p.global_position + Vector2(0, -30)
		var desired := (tgt - global_position).normalized() * 150.0 + Vector2(0, sin(t * 5.0) * 90.0)
		velocity = velocity.lerp(desired, 2.2 * dt)
	else:
		var target := home + Vector2(cos(t * 0.9) * 70.0, sin(t * 1.7) * 30.0)
		velocity = ((target - global_position) * 1.5).limit_length(120.0)
	move_and_slide()
	g.modulate.a = 0.55 + 0.25 * sin(t * 7.0)
	queue_redraw()


func _draw() -> void:
	var flap := 0.3 + 0.7 * absf(sin(t * 13.0))
	if stun > 0.0:
		flap = 0.3
	var wing := fc(Color(0.88, 0.85, 0.76, 0.85))
	var wing2 := fc(Color(0.7, 0.66, 0.58, 0.8))
	for s: float in [-1.0, 1.0]:
		Art.poly(self, Art.ellipse(Vector2(s * 13.0, -4.0 * flap), 13.0, 10.0 * flap + 1.0, 18, s * -0.5), wing)
		Art.poly(self, Art.ellipse(Vector2(s * 9.0, 7.0), 8.0, 6.0 * flap + 1.0, 14, s * 0.6), wing2)
		draw_circle(Vector2(s * 15.0, -5.0 * flap), 2.5, fc(Color(0.25, 0.2, 0.3, 0.8)))
	Art.poly(self, Art.ellipse(Vector2(0, 2), 4.0, 10.0, 14), fc(Color("2a2232")))
	Art.poly(self, Art.ellipse(Vector2(0, 8), 3.5, 5.0, 12), Color(1.0, 0.9, 0.55))
	draw_line(Vector2(-2, -8), Vector2(-6, -15), fc(Color("2a2232")), 1.5, true)
	draw_line(Vector2(2, -8), Vector2(6, -15), fc(Color("2a2232")), 1.5, true)
	draw_stun(Vector2(0, -22))
