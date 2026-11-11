class_name Queen
extends Enemy
## Chefe: Rainha Micélia (Verdâmia). Chuva de esporos, raízes do chão, rajada e invocação de mariposas.
## Arte: 16 folhas E_rainha_* (2 quadros cada) → idle 6, raizes 6, esporos 6, rugido 4, hurt 2, death 8.
## Cada ataque começa pela animação; o efeito sai no quadro em que a arte o mostra (WINDUP).

var state := "sleep"
var st := 0.0
var phase2 := false
var last_attack := ""
var attack_glow := 0.0
var spr: AnimatedSprite2D
var anim_t := 0.0           # tempo restante da animação de ação em curso
const ARENA_L := 3900.0
const ARENA_R := 4600.0
# segundos entre o início da animação e o efeito
const WINDUP := {"rain": 0.45, "roots": 0.5, "volley": 0.4, "summon": 0.35}


func _ready() -> void:
	hp = 22
	max_hp = 22
	heavy = true
	drops = 0
	main_color = Color(0.7, 0.5, 1.0)
	collision_layer = 0
	collision_mask = 0
	setup_hurt(Vector2(150, 220), Vector2(0, -110))
	var big := Art.glow(Color(0.55, 0.4, 1.0, 0.22), 230)
	big.position = Vector2(0, -170)
	add_child(big)
	# a arte olha para a direita; a Rainha fica no canto direito da arena, então é espelhada
	spr = make_sprite(SpriteMetaVerd.RAINHA_FRAMES, SpriteMetaVerd.RAINHA_OFFSET, SpriteMetaVerd.RAINHA_SCALE, "idle")
	spr.scale.x = -SpriteMetaVerd.RAINHA_SCALE
	spr.position = Vector2(0, 6)
	spr.speed_scale = 0.45
	spr.animation_finished.connect(_anim_done)


func _play(an: String, dur: float) -> void:
	spr.speed_scale = 1.0
	spr.play(an)
	spr.frame = 0
	anim_t = dur


func _anim_done() -> void:
	if not dead:
		spr.play("idle")


func wake() -> void:
	AudioMgr.sfx("rainha_ruge", Vector2.INF, 0.0, 0.0)
	AudioMgr.music("chefe")
	state = "idle"
	st = 1.6
	_play("rugido", 0.7)


func _physics_process(dt: float) -> void:
	tick(dt)
	attack_glow = maxf(0.0, attack_glow - dt)
	anim_t -= dt
	if not dead:
		var base := Color(0.72, 0.72, 0.8) if state == "sleep" else (Color(1.0, 0.86, 0.92) if phase2 else Color(1, 1, 1))
		spr.modulate = flash_mod(base)
	if state == "sleep" or dead:
		return
	if not phase2 and hp <= max_hp / 2:
		phase2 = true
		level.main.add_shake(16.0)
		AudioMgr.sfx("rainha_ruge", Vector2.INF, 0.0, 0.05)
		level.main.hud.notice("A Rainha se enfurece!")
		Fx.ring(level.fx, global_position + Vector2(0, -150), Color(0.8, 0.5, 1.0), 400, 0.7, 10)
		_play("rugido", 0.7)
		st = 1.0
	st -= dt
	if st <= 0.0:
		_next_attack()


## agenda o efeito do ataque para o quadro certo da animação
func _after(delay: float, fn: Callable) -> void:
	get_tree().create_timer(delay, false).timeout.connect(func():
		if not dead and is_instance_valid(level):
			fn.call())


func _next_attack() -> void:
	var opts := ["rain", "roots", "volley", "summon"]
	opts.erase(last_attack)
	var moths := 0
	for e in get_tree().get_nodes_in_group("enemies"):
		# só contam as mariposas dentro da arena (as do resto da fase não impedem a invocação)
		if e is Moth and e.global_position.x > ARENA_L - 120.0:
			moths += 1
	if moths >= 2:
		opts.erase("summon")
	var a: String = opts[randi() % opts.size()]
	last_attack = a
	attack_glow = 1.0
	var idle := 0.9 if phase2 else 1.5
	match a:
		"rain":
			_play("esporos", 0.75)
			_after(WINDUP["rain"], _rain)
			st = 2.2 + idle + WINDUP["rain"]
		"roots":
			_play("raizes", 0.75)
			_after(WINDUP["roots"], _roots)
			st = 2.0 + idle + WINDUP["roots"]
		"volley":
			_play("esporos", 0.75)
			_after(WINDUP["volley"], _volley)
			st = 1.2 + idle + WINDUP["volley"]
		"summon":
			_play("rugido", 0.7)
			_after(WINDUP["summon"], _summon)
			st = 1.0 + idle + WINDUP["summon"]


func _rain() -> void:
	var n := 9 if phase2 else 7
	var p := player()
	for i in n:
		var b := EnemyBullet.new()
		b.color = Color(0.75, 0.5, 1.0)
		b.radius = 9.0
		b.grav = 650.0
		b.sprite = "esporo_violeta"
		b.delay = 0.6 + i * 0.12
		var x := randf_range(ARENA_L, ARENA_R)
		if i == 0 and p != null:
			x = p.global_position.x
		b.position = Vector2(x, 360)
		level.add_fx(b)


func _roots() -> void:
	var count := 4 if phase2 else 3
	_spawn_spike()
	for i in range(1, count):
		get_tree().create_timer(i * 0.5, false).timeout.connect(_spawn_spike)


func _spawn_spike() -> void:
	if dead or not is_instance_valid(level):
		return
	var p := player()
	if p == null:
		return
	var s := Spike.new()
	s.position = Vector2(clampf(p.global_position.x, ARENA_L, ARENA_R + 100.0), 800)
	level.add_fx(s)


func _volley() -> void:
	var count := 5 if phase2 else 3
	_shoot_spore()
	for i in range(1, count):
		get_tree().create_timer(i * 0.22, false).timeout.connect(_shoot_spore)


func _shoot_spore() -> void:
	if dead:
		return
	var p := player()
	if p == null:
		return
	var start := global_position + Vector2(-78, -212)      # borda do chapéu, de onde a arte solta os esporos
	var tgt := p.global_position + Vector2(randf_range(-60, 60), -20)
	var T := clampf(absf(tgt.x - start.x) / 500.0, 0.6, 1.4)
	var g := 900.0
	var b := EnemyBullet.new()
	b.color = Color(0.45, 1.0, 0.75)
	b.radius = 9.0
	b.grav = g
	b.sprite = "esporo_verde"
	b.vel = Vector2((tgt.x - start.x) / T, (tgt.y - start.y - 0.5 * g * T * T) / T)
	b.position = start
	level.add_fx(b)


func _summon() -> void:
	for i in 2:
		var pos := global_position + Vector2(-120 - i * 80, -260 + i * 40)
		FxAnim.verd(level.fx, "invocacao", pos)
		get_tree().create_timer(0.22, false).timeout.connect(func():
			if not dead and is_instance_valid(level):
				level.spawn_enemy("moth", pos))


func take_hit(dmg: int, from: Vector2) -> void:
	if state == "sleep":
		return
	super.take_hit(dmg, from)
	if not dead and anim_t <= 0.0:
		_play("hurt", 0.25)


func die() -> void:
	if dead:
		return
	dead = true
	state = "dead"
	AudioMgr.sfx("explosao", Vector2.INF, -2.0, 0.0)
	AudioMgr.music("verdamia")
	level.main.add_shake(22.0)
	for i in 5:
		Fx.burst(level.fx, global_position + Vector2(randf_range(-80, 80), randf_range(-240, -20)), Color(0.75, 0.55, 1.0), 30, 420, 1.0, 0.12)
	Fx.ring(level.fx, global_position + Vector2(0, -150), Color(0.85, 1.0, 0.7), 600, 1.0, 12)
	for e in get_tree().get_nodes_in_group("enemies"):
		if e is Moth and is_instance_valid(e):
			e.die()
	for i in 12:
		level.drop_cell(global_position + Vector2(randf_range(-60, 60), -120))
	level.on_boss_dead()
	spr.modulate = Color(1, 1, 1)
	spr.speed_scale = 1.0
	spr.play("death")
	var tw := create_tween()
	tw.tween_interval(1.7)
	tw.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.9)
	tw.tween_callback(queue_free)
