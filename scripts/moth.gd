class_name Moth
extends Enemy
## Mariposa Lanterna — voa em ondas e persegue a luz (o jogador).

var home := Vector2.ZERO
var g: Sprite2D
var spr: AnimatedSprite2D
var face := 1.0


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
	g = Art.glow(Color(1.0, 0.82, 0.4, 0.5), 34)
	add_child(g)
	spr = make_sprite(SpriteMetaVerd.MARIPOSA_FRAMES, SpriteMetaVerd.MARIPOSA_OFFSET, SpriteMetaVerd.MARIPOSA_SCALE, "fly")
	spr.frame = randi() % 6
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
	# a arte olha para a direita; vira para onde voa (com folga para não tremer ao pairar)
	if absf(velocity.x) > 25.0:
		face = signf(velocity.x)
	spr.scale.x = SpriteMetaVerd.MARIPOSA_SCALE * face
	spr.speed_scale = 0.35 if stun > 0.0 else 1.0
	spr.modulate = flash_mod()
	g.position = Vector2(-9.0 * face, 7.0)      # abdômen luminoso
	g.modulate.a = 0.4 + 0.2 * sin(t * 7.0)
	queue_redraw()


func die() -> void:
	if dead:
		return
	# o corpo cai e some (E_mariposa_death)
	var f := FxAnim.spawn(level.fx, SpriteMetaVerd.MARIPOSA_FRAMES, SpriteMetaVerd.MARIPOSA_OFFSET,
		global_position, SpriteMetaVerd.MARIPOSA_SCALE, "death")
	if f != null:
		f.scale.x *= face
		f.vel = Vector2(velocity.x * 0.3, -60.0)
		f.grav = 520.0
		f.linger = 0.15
		f.z_index = 6
	super.die()


func _draw() -> void:
	draw_stun(Vector2(0, -26))
