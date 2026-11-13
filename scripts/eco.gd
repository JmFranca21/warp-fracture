class_name Eco
extends Node2D
## O Eco na Fuga do Laboratório (decisão D01).
## Não pode ser morto. Segue o rastro do jogador pelo ar, com velocidade elástica: acelera quando
## fica para trás e não acelera quando está perto, então quem corre bem escapa. Perto do jogador,
## agarra (A4) com aviso nos quadros 1–3; a esquiva atravessa o golpe. Se ficar longe demais
## (gancho, queda, desvio), usa a Dobra espectral: some (A5 1–4), abre uma fenda visível atrás
## do jogador (A9, 0,4 s de aviso) e sai por ela (A1).
## Estados: appear → watch → advance ⇄ grab, advance → dobra_out → dobra_wait → appear; hold; gone.

const TORSO := Vector2(0, -44)          # altura do tronco do Daymon (o Eco paira nela)
const GRAB_RANGE := 95.0
const GRAB_CD := 1.3
const DOBRA_CD := 4.0
const DOBRA_MIN_DIST := 250.0           # nunca reaparece a menos disso do jogador
const DOBRA_BACK := 330.0               # reaparece ~330 px atrás do jogador, sobre o rastro
const DOBRA_FAR := 820.0                # rastro mais longo que isso dispara a Dobra
const DOBRA_WARN := 0.4                 # a fenda fica visível antes de o Eco sair

var level
var player: Player
var spr: AnimatedSprite2D
var glow: Sprite2D
var state := "appear"
var st := 0.0
var trail: Array = []                   # pontos do rastro (mundo), do mais antigo ao mais novo
var rec_t := 0.0
var grab_cd := 0.0
var dobra_cd := DOBRA_CD
var dobra_to := Vector2.ZERO
var face := 1.0
var hold_x := INF                       # zona protegida do portal: o Eco não passa deste x
var hit_done := false
var speed := 0.0


func _ready() -> void:
	z_index = 4
	glow = Art.glow(Color(0.55, 0.45, 1.0, 0.35), 90)
	glow.position = Vector2(0, -36)
	add_child(glow)
	spr = AnimatedSprite2D.new()
	spr.sprite_frames = FxAnim.frames(SpriteMetaCells.ECO_FRAMES)
	spr.offset = SpriteMetaCells.ECO_OFFSET
	spr.scale = Vector2.ONE * 0.58
	add_child(spr)
	spr.animation_finished.connect(_anim_done)
	_play("appear")


## Começa o rastro em linha reta do Eco até o jogador (pela porta aberta).
func seed_trail() -> void:
	trail.clear()
	var a := global_position
	var b := player.global_position + TORSO
	var n := int(a.distance_to(b) / 24.0)
	for i in range(1, n + 1):
		trail.append(a.lerp(b, float(i) / n))


func _play(an: String) -> void:
	spr.speed_scale = 1.0
	spr.play(an)


func _anim_done() -> void:
	match state:
		"appear":
			state = "watch"
			st = 0.45
			_play("float")
		"grab":
			state = "advance"
			grab_cd = GRAB_CD
			_play("advance")
		"gone":
			queue_free()


func _physics_process(dt: float) -> void:
	if not is_instance_valid(player) or state == "gone":
		return
	st -= dt
	grab_cd -= dt
	dobra_cd -= dt
	_record(dt)
	var busy: bool = level.main.transitioning or player.dead
	match state:
		"watch":
			_face_player()
			if st <= 0.0 and not busy:
				state = "advance"
				_play("advance")
		"advance":
			if busy:
				return
			var L := _trail_len()
			if L > DOBRA_FAR and dobra_cd <= 0.0 and hold_x == INF:
				_start_dobra()
				return
			_follow(dt, L)
			var d := global_position.distance_to(player.global_position + TORSO)
			if d < GRAB_RANGE and grab_cd <= 0.0:
				_start_grab()
		"grab":
			_face_player()
			# quadros 1–3 são o aviso (mais lentos); o golpe é o quadro 4
			spr.speed_scale = 0.62 if spr.frame < 3 else 1.0
			if spr.frame == 3:
				position.x += face * 140.0 * dt          # avança no golpe
				if not hit_done:
					hit_done = true
					_strike()
		"dobra_out":
			if st <= 0.0:
				spr.visible = false
				glow.visible = false
				global_position = dobra_to
				var f := FxAnim.spawn(level.fx, SpriteMetaCells.ECO_DOBRA_FRAMES, SpriteMetaCells.ECO_DOBRA_OFFSET,
					dobra_to, 0.58)
				if f != null:
					f.z_index = 3
				AudioMgr.sfx("eco_dobra", dobra_to, 0.0, 0.04)
				state = "dobra_wait"
				st = DOBRA_WARN
		"dobra_wait":
			if st <= 0.0:
				_trim_trail_to(global_position)
				spr.visible = true
				glow.visible = true
				state = "appear"
				_play("appear")
				spr.frame = 2     # sai pela fenda já formado (quadros 3–8 da A1)
		"hold":
			_face_player()
			# zona do portal: paira na borda, observando
			var tx := minf(hold_x, player.global_position.x - 120.0)
			global_position.x = move_toward(global_position.x, tx, 160.0 * dt)
			global_position.y = move_toward(global_position.y, player.global_position.y + TORSO.y - 20.0, 120.0 * dt)
	glow.modulate.a = 0.75 + 0.25 * sin(Time.get_ticks_msec() * 0.006)


func _record(dt: float) -> void:
	rec_t -= dt
	if rec_t > 0.0 or player.warping:
		return
	rec_t = 0.05
	var p := player.global_position + TORSO
	if trail.is_empty() or trail[-1].distance_to(p) > 4.0:
		trail.append(p)
	if trail.size() > 900:
		trail.pop_front()


func _trail_len() -> float:
	var L := 0.0
	var prev := global_position
	for p: Vector2 in trail:
		L += prev.distance_to(p)
		prev = p
	return L


## Velocidade elástica: 230 px/s perto, sobe até 410 px/s quando o rastro passa de 650 px.
func _follow(dt: float, L: float) -> void:
	speed = clampf(230.0 + (L - 220.0) * 0.42, 230.0, 410.0)
	var budget := speed * dt
	# não encosta no jogador: para a ~55 px (o perigo é o agarrão, não o contato)
	if global_position.distance_to(player.global_position + TORSO) < 55.0:
		budget = 0.0
	var p0 := global_position
	while budget > 0.0 and not trail.is_empty():
		var t: Vector2 = trail[0]
		var dist := global_position.distance_to(t)
		if dist <= budget:
			global_position = t
			budget -= dist
			trail.pop_front()
		else:
			global_position += (t - global_position) / dist * budget
			budget = 0.0
	if hold_x != INF and global_position.x > hold_x:
		global_position.x = hold_x
		state = "hold"
		_play("float")
	var mv := global_position - p0
	if absf(mv.x) > 0.5:
		face = signf(mv.x)
	spr.scale.x = 0.58 * face


func _face_player() -> void:
	var dx := player.global_position.x - global_position.x
	if absf(dx) > 8.0:
		face = signf(dx)
	spr.scale.x = 0.58 * face


func _start_grab() -> void:
	state = "grab"
	hit_done = false
	_face_player()
	_play("grab")
	AudioMgr.sfx("eco_agarra", global_position, -2.0, 0.05)


## Golpe do quadro 4: acerta quem estiver na frente, a menos que esteja na esquiva.
func _strike() -> void:
	var hit := Rect2(global_position + Vector2(-20 if face > 0 else -115, -70), Vector2(135, 120))
	var pp := player.global_position + Vector2(0, -30)
	if hit.has_point(pp) and player.dash_t <= 0.0 and player.inv <= 0.0:
		player.hurt(global_position, 1)
		level.main.add_shake(8.0)


func _start_dobra() -> void:
	# ponto do rastro ~330 px atrás do jogador (espaço por onde ele acabou de passar)
	var target := Vector2.INF
	var acc := 0.0
	var prev := player.global_position + TORSO
	for i in range(trail.size() - 1, -1, -1):
		var p: Vector2 = trail[i]
		acc += prev.distance_to(p)
		prev = p
		if acc >= DOBRA_BACK and p.distance_to(player.global_position + TORSO) >= DOBRA_MIN_DIST:
			target = p
			break
	if target == Vector2.INF:
		dobra_cd = 0.5
		return
	dobra_cd = DOBRA_CD
	dobra_to = target
	state = "dobra_out"
	st = 0.33              # quadros 1–4 da A5
	_play("vanish")


func _trim_trail_to(p: Vector2) -> void:
	var best := 0
	var bd := INF
	for i in trail.size():
		var d: float = trail[i].distance_to(p)
		if d < bd:
			bd = d
			best = i
	trail = trail.slice(best + 1)


## Entrada no portal: o Eco se desfaz por inteiro (A5).
func vanish() -> void:
	if state == "gone":
		return
	state = "gone"
	spr.visible = true
	_play("vanish")
	var tw := create_tween()
	tw.tween_property(glow, "modulate:a", 0.0, 0.5)
