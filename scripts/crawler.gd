class_name Crawler
extends Enemy
## Rastejador de Fenda: anda na plataforma, vira nas bordas e dispara pelo olho
## quando o jogador está à frente. Usa o AnimatedSprite2D com as animações
## idle / walk / attack / hurt / death definidas em rastejador_frames.tres.

const FRAMES := preload("res://assets/inimigos/rastejador/rastejador_frames.tres")
const SPRITE_SCALE := 0.78
const WALK_SPEED := 75.0
const SHOT_RANGE := 380.0
const SHOT_COOLDOWN := 2.6
const WINDUP := 0.35          # tempo no quadro de preparo antes do disparo
const ATTACK_TOTAL := 0.75    # duração total do ataque
const BASE_TINT := Color(1.45, 1.45, 1.6)

var dir := -1
var pivot: Node2D            # espelha o sprite para a esquerda/direita
var sprite: AnimatedSprite2D
var attack_t := -1.0         # >= 0 enquanto ataca
var shot_done := false
var cooldown := 1.0


func _ready() -> void:
	hp = 2
	max_hp = 2
	main_color = Color(0.65, 0.4, 1.0)
	setup_body(Vector2(70, 36))
	setup_hurt(Vector2(88, 50), Vector2(0, -25))

	var g := Art.glow(Color(0.6, 0.35, 1.0, 0.45), 75)
	g.position = Vector2(0, -20)
	add_child(g)

	pivot = Node2D.new()
	add_child(pivot)
	sprite = AnimatedSprite2D.new()
	sprite.sprite_frames = FRAMES
	sprite.scale = Vector2.ONE * SPRITE_SCALE
	# a célula tem 175x78; os pés estão na linha y=77 e o centro do corpo em x≈67
	sprite.offset = Vector2(20.5, -38.0)
	pivot.add_child(sprite)
	sprite.play("walk")
	sprite.frame = randi() % 7
	cooldown = randf_range(0.6, 2.0)


func _physics_process(dt: float) -> void:
	tick(dt)
	if dead:
		velocity.y = minf(velocity.y + 2000.0 * dt, 900.0)
		velocity.x = move_toward(velocity.x, 0.0, 1200.0 * dt)
		move_and_slide()
		return
	velocity.y = minf(velocity.y + 2000.0 * dt, 900.0)
	cooldown -= dt

	if knock_t > 0.0:
		attack_t = -1.0
		velocity.x = move_toward(velocity.x, 0.0, 1400.0 * dt)
		_anim("hurt")
	elif stun > 0.0:
		attack_t = -1.0
		velocity.x = 0.0
		_anim("idle")
	elif attack_t >= 0.0:
		_attacking(dt)
	else:
		velocity.x = dir * WALK_SPEED
		if is_on_wall() or (is_on_floor() and not _floor_ahead()):
			dir = -dir
			velocity.x = dir * WALK_SPEED
		_anim("walk")
		if cooldown <= 0.0 and _player_in_front():
			_start_attack()

	move_and_slide()
	pivot.scale.x = float(dir)
	sprite.modulate = Color(2.6, 2.6, 2.6) if flash > 0.0 else BASE_TINT
	queue_redraw()


func _anim(n: String) -> void:
	if sprite.animation != n:
		sprite.play(n)


func _player_in_front() -> bool:
	var p := player()
	if p == null:
		return false
	var d := p.global_position - global_position
	return signf(d.x) == float(dir) and absf(d.x) < SHOT_RANGE and absf(d.y) < 70.0


func _start_attack() -> void:
	attack_t = 0.0
	shot_done = false
	velocity.x = 0.0
	sprite.play("attack")
	sprite.pause()
	sprite.frame = 0           # quadro de preparo


func _attacking(dt: float) -> void:
	attack_t += dt
	velocity.x = 0.0
	if attack_t >= WINDUP and not shot_done:
		shot_done = true
		sprite.frame = 1       # quadro do disparo
		_fire()
	if attack_t >= ATTACK_TOTAL:
		attack_t = -1.0
		cooldown = SHOT_COOLDOWN
		sprite.play("walk")


func _fire() -> void:
	AudioMgr.sfx("rastejador_tiro", global_position, -4.0, 0.08)
	var b := EnemyBullet.new()
	b.color = Color(0.7, 0.4, 1.0)
	b.radius = 7.0
	b.vel = Vector2(dir * 360.0, 0.0)
	b.position = global_position + Vector2(dir * 44.0, -26.0)
	level.add_fx(b)
	Fx.burst(level.fx, b.position, Color(0.75, 0.5, 1.0), 8, 160, 0.25, 0.05, 0)


func _floor_ahead() -> bool:
	var q := PhysicsRayQueryParameters2D.create(global_position + Vector2(dir * 38, -4), global_position + Vector2(dir * 38, 24), 1)
	return not get_world_2d().direct_space_state.intersect_ray(q).is_empty()


func die() -> void:
	if dead:
		return
	dead = true
	AudioMgr.sfx("inimigo_morre", global_position, -2.0, 0.1)
	hurt_area.set_deferred("monitorable", false)
	Fx.burst(level.fx, global_position + Vector2(0, -20), main_color, 14, 260, 0.6, 0.07)
	for i in drops:
		level.drop_cell(global_position + Vector2(0, -24))
	level.main.add_shake(6.0)
	# animação de morte desenhada (sheet própria, mesma escala)
	sprite.sprite_frames = load(SpriteMeta.RASTEJADOR_MORTE_FRAMES)
	sprite.offset = SpriteMeta.RASTEJADOR_MORTE_OFFSET
	sprite.modulate = BASE_TINT
	sprite.play("death")
	sprite.animation_finished.connect(queue_free)


func _draw() -> void:
	draw_stun(Vector2(0, -64))
