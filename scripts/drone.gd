class_name Drone
extends Enemy
## Drone de Segurança: paira, persegue de lado, carrega o olho e dispara em linha reta.
## Animações (drone_frames.tres): fly, charge, shoot, hurt, death.

const SPR_SCALE := 0.72
const EYE := Vector2(15, 1)      # posição do olho em relação ao centro (olhando à direita)
var home := Vector2.ZERO
var shoot_t := 1.5
var charge := 0.0
var aware := false
var eye: Sprite2D
var spr: AnimatedSprite2D
var face := 1
var shoot_anim_t := 0.0
var patrol := 60.0


func _ready() -> void:
	hp = 3
	max_hp = 3
	drops = 3
	main_color = Color(1.0, 0.35, 0.25)
	home = position
	collision_layer = 0
	collision_mask = 1
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = 18
	cs.shape = c
	add_child(cs)
	setup_hurt(Vector2(52, 44), Vector2.ZERO)
	spr = AnimatedSprite2D.new()
	spr.sprite_frames = load(SpriteMeta.DRONE_FRAMES)
	spr.offset = SpriteMeta.DRONE_OFFSET
	spr.scale = Vector2.ONE * SPR_SCALE
	add_child(spr)
	spr.play("fly")
	spr.frame = randi() % 6
	eye = Art.glow(Color(1.0, 0.25, 0.2, 0.7), 30)
	add_child(eye)
	var under := Art.glow(Color(1.0, 0.3, 0.3, 0.25), 36)
	under.position = Vector2(0, 30)
	add_child(under)


func _physics_process(dt: float) -> void:
	tick(dt)
	if dead:
		velocity = velocity.move_toward(Vector2(0, 120), 300.0 * dt)
		move_and_slide()
		return
	var p := player()
	shoot_anim_t -= dt
	if knock_t > 0.0:
		velocity = velocity.move_toward(Vector2.ZERO, 900.0 * dt)
	elif stun > 0.0:
		velocity = velocity.move_toward(Vector2(0, 50), 400.0 * dt)
		charge = 0.0
	else:
		var target := home + Vector2(sin(t * 0.8) * patrol, sin(t * 2.1) * 12.0)
		aware = p != null and p.global_position.distance_to(global_position) < 560.0 and _sees(p)
		if aware:
			var side := signf(global_position.x - p.global_position.x)
			if side == 0.0:
				side = 1.0
			target = Vector2(clampf(p.global_position.x + side * 260.0, home.x - 320.0, home.x + 320.0), home.y + sin(t * 2.0) * 14.0)
			shoot_t -= dt
			if shoot_t <= 0.55:
				if charge <= 0.0:
					AudioMgr.sfx("drone_carrega", global_position, -8.0, 0.05)
				charge = 1.0 - shoot_t / 0.55
			if shoot_t <= 0.0:
				_fire(p)
				shoot_t = 1.9
				charge = 0.0
		else:
			charge = move_toward(charge, 0.0, dt * 3.0)
		var v := (target - global_position) * 2.4
		velocity = v.limit_length(190.0)
	move_and_slide()
	if p != null and absf(p.global_position.x - global_position.x) > 8.0:
		face = 1 if p.global_position.x > global_position.x else -1
	_animate()
	queue_redraw()


func _sees(p: Player) -> bool:
	var q := PhysicsRayQueryParameters2D.create(global_position, p.global_position + Vector2(0, -32), 1)
	return get_world_2d().direct_space_state.intersect_ray(q).is_empty()


func _animate() -> void:
	var an := "fly"
	if knock_t > 0.0:
		an = "hurt"
	elif shoot_anim_t > 0.0:
		an = "shoot"
	elif charge > 0.02:
		an = "charge"
	if spr.animation != an:
		spr.play(an)
	if an == "charge":
		spr.pause()
		spr.frame = clampi(int(charge * 4.0), 0, 3)
	spr.scale = Vector2(SPR_SCALE * face, SPR_SCALE)
	spr.rotation = clampf(velocity.x * 0.0012 * face, -0.2, 0.2) * face
	spr.modulate = Color(2.2, 2.2, 2.2) if flash > 0.0 else Color(1, 1, 1)
	eye.position = Vector2(EYE.x * face, EYE.y)
	eye.modulate.a = 0.3 + charge * 0.7
	eye.scale = Vector2.ONE * (30.0 + charge * 34.0) * 2.0 / 128.0


func _fire(p: Player) -> void:
	var b := EnemyBullet.new()
	b.color = Color(1.0, 0.35, 0.25)
	b.radius = 7.0
	var tgt := p.global_position + Vector2(0, -32)
	var origin := global_position + eye.position
	b.vel = (tgt - origin).normalized() * 330.0
	b.position = origin + b.vel.normalized() * 8.0
	level.add_fx(b)
	shoot_anim_t = 0.25
	spr.play("shoot")
	AudioMgr.sfx("drone_tiro", global_position, -4.0, 0.08)


func die() -> void:
	if dead:
		return
	dead = true
	hurt_area.set_deferred("monitorable", false)
	AudioMgr.sfx("explosao", global_position, -8.0, 0.1)
	for i in drops:
		level.drop_cell(global_position)
	level.main.add_shake(8.0)
	eye.visible = false
	spr.modulate = Color(1, 1, 1)
	spr.play("death")
	spr.animation_finished.connect(queue_free)


func _draw() -> void:
	draw_stun(Vector2(0, -36))
