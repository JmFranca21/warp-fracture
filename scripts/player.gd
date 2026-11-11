class_name Player
extends CharacterBody2D
## Daymon Sagan. Forma "human" (laboratório) ou "lince" (Lince-Vagalume, Verdâmia).

const GRAV := 2000.0
const MAX_FALL := 950.0

var main
var level
var form := "human"
var run_speed := 320.0
var jump_v := 760.0
var max_air_jumps := 0
var facing := 1
var coyote := 0.0
var jbuf := 0.0
var air_jumps := 0
var dash_t := 0.0
var dash_cd := 0.0
var air_dash := true
var inv := 0.0
var knock_t := 0.0
var atk_cd := 0.0
var atk_anim := 0.0
var wall_dir := 0
var wall_coyote := 0.0
var last_wall := 0
var wall_lock := 0.0
var hp := 5
var max_hp := 5
var energy := 0.0
var t := 0.0
var aim := Vector2.RIGHT
var use_mouse := false
var dead := false
var controls_locked := false
var hurtbox: Area2D
var last_safe := Vector2.ZERO
var safe_t := 0.0
var squash := 0.0
var was_floor := true
var walk_phase := 0.0
var glow_a: Sprite2D
var glow_b: Sprite2D
var flash_t := 0.0
var warping := false
var warp_to := Vector2.ZERO
var warp_t := 0.0
# Lince-Vagalume: animação de ação em curso ("claw", "pogo", "flash", "doublejump") e tempos de pose
var act := ""
var act_t := 0.0
var hurt_t := 0.0
var held_pose := false
# rig de sprites (humano: corpo + braço; lince: corpo)
const BODY_SCALE := 0.58
const ARM_SCALE := 0.40
const FX_SCALE := 0.55
const ONEWAY_LAYER := 256
var rig: Node2D = null
var body_spr: AnimatedSprite2D
var arm_pivot: Node2D
var arm_spr: AnimatedSprite2D
var muzzle: AnimatedSprite2D
var arm_len := 0.0
var drop_t := 0.0
var land_t := 0.0
# Arpão de Fase
const HOOK_RANGE := 380.0
const HOOK_SPEED := 980.0
var hook: Node2D = null
var hook_shoot := 0.0       # tempo da "corda" se esticando até o gancho
var hook_len := 0.0
var hook_pull_t := 0.0
var last_hook: Node2D = null
var last_hook_t := 0.0
# posição do ombro (pés = origem, olhando para a direita) por animação
const SHOULDER := {
	"idle": Vector2(3, -50), "run": Vector2(8, -47), "jump": Vector2(6, -48),
	"fall": Vector2(4, -50), "dash": Vector2(8, -36), "hurt": Vector2(0, -48), "death": Vector2(0, -40),
}


func _ready() -> void:
	collision_layer = 2
	collision_mask = 1 | ONEWAY_LAYER
	floor_snap_length = 6.0
	var size := Vector2(24, 62) if form == "human" else Vector2(32, 34)
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = size
	cs.shape = r
	cs.position = Vector2(0, -size.y / 2.0)
	add_child(cs)
	hurtbox = Area2D.new()
	hurtbox.collision_layer = 0
	hurtbox.collision_mask = 4 | 16 | 32
	var hc := CollisionShape2D.new()
	var hr := RectangleShape2D.new()
	hr.size = size - Vector2(6, 8)
	hc.shape = hr
	hc.position = cs.position
	hurtbox.add_child(hc)
	add_child(hurtbox)
	if form == "human":
		run_speed = 320.0
		max_air_jumps = 0
		jump_v = 760.0
		glow_a = Art.glow(Color(0.3, 0.9, 1.0, 0.6), 22)
		_build_rig()
	else:
		run_speed = 360.0
		max_air_jumps = 1
		jump_v = 740.0
		glow_a = Art.glow(Color(1.0, 0.78, 0.35, 0.8), 30)
		_build_lynx()
	add_child(glow_a)
	glow_b = Art.glow(Color(0.4, 0.9, 1.0, 0.0), 120)
	glow_b.position = Vector2(0, -24)
	add_child(glow_b)
	# halo suave atrás do personagem; mais forte no Lince, que é escuro contra a floresta
	var amb := Art.glow(Color(0.5, 0.7, 1.0, 0.10), 150) if form == "human" else Art.glow(Color(0.55, 0.95, 0.9, 0.20), 120)
	amb.position = Vector2(0, -30)
	amb.z_index = -1
	add_child(amb)
	last_safe = position
	if main != null:
		max_hp = 5 + Upgrades.extra_hp(main)
	hp = max_hp


func _build_rig() -> void:
	rig = Node2D.new()
	add_child(rig)
	body_spr = AnimatedSprite2D.new()
	body_spr.sprite_frames = load(SpriteMeta.DAYMON_FRAMES)
	body_spr.offset = SpriteMeta.DAYMON_OFFSET
	body_spr.scale = Vector2.ONE * BODY_SCALE
	rig.add_child(body_spr)
	body_spr.play("idle")
	arm_pivot = Node2D.new()
	arm_pivot.position = SHOULDER["idle"]
	rig.add_child(arm_pivot)
	arm_spr = AnimatedSprite2D.new()
	arm_spr.sprite_frames = load(SpriteMeta.BRACO_FRAMES)
	arm_spr.offset = SpriteMeta.BRACO_OFFSET
	arm_spr.scale = Vector2.ONE * ARM_SCALE
	arm_spr.play("braco")
	arm_pivot.add_child(arm_spr)
	var tex := arm_spr.sprite_frames.get_frame_texture("braco", 0)
	arm_len = (tex.get_width() - 4) * ARM_SCALE
	muzzle = AnimatedSprite2D.new()
	muzzle.sprite_frames = load(SpriteMeta.DISPARO_FRAMES)
	muzzle.offset = SpriteMeta.DISPARO_OFFSET
	muzzle.scale = Vector2.ONE * FX_SCALE
	muzzle.position = Vector2(arm_len + 6, -3)
	muzzle.visible = false
	muzzle.animation_finished.connect(func(): muzzle.visible = false)
	arm_pivot.add_child(muzzle)


## Lince-Vagalume: 11 animações (D_lince_*) em um AnimatedSprite2D; âncora nos pés.
func _build_lynx() -> void:
	rig = Node2D.new()
	add_child(rig)
	body_spr = AnimatedSprite2D.new()
	body_spr.sprite_frames = load(SpriteMetaVerd.LINCE_FRAMES)
	body_spr.offset = SpriteMetaVerd.LINCE_OFFSET
	body_spr.scale = Vector2.ONE * SpriteMetaVerd.LINCE_SCALE
	rig.add_child(body_spr)
	body_spr.play("idle")


## ponta do cano em coordenadas globais
func gun_tip() -> Vector2:
	if arm_pivot == null:
		return global_position + Vector2(0, -32) + aim * 28.0
	return arm_pivot.to_global(Vector2(arm_len, -3))


func shoulder_global() -> Vector2:
	if arm_pivot == null:
		return global_position + Vector2(0, -18)
	return rig.to_global(arm_pivot.position)


func _fire_fx(big: bool) -> void:
	if muzzle == null:
		return
	muzzle.visible = true
	muzzle.scale = Vector2.ONE * FX_SCALE * (1.6 if big else 1.0)
	muzzle.play("fire")
	muzzle.frame = 0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and (event as InputEventMouseMotion).relative.length() > 2.0:
		use_mouse = true
	elif event is InputEventMouseButton:
		use_mouse = true
	elif event is InputEventJoypadMotion and (event as InputEventJoypadMotion).axis in [JOY_AXIS_RIGHT_X, JOY_AXIS_RIGHT_Y] and absf((event as InputEventJoypadMotion).axis_value) > 0.35:
		use_mouse = false
	elif event is InputEventKey or event is InputEventJoypadButton:
		if event.is_action_pressed("attack") or event.is_action_pressed("special"):
			use_mouse = false


# ---------------------------------------------------------------- física
func _physics_process(dt: float) -> void:
	t += dt
	last_hook_t -= dt
	dash_cd -= dt
	atk_cd -= dt
	atk_anim -= dt
	inv -= dt
	flash_t -= dt
	if warping:
		warp_t += dt
		global_position = global_position.lerp(warp_to, 1.0 - exp(-dt * 4.0))
		velocity = Vector2.ZERO
		queue_redraw()
		return
	if dead:
		velocity.y = minf(velocity.y + GRAV * dt, MAX_FALL)
		velocity.x *= 0.9
		move_and_slide()
		queue_redraw()
		return

	var dir := 0.0
	if not controls_locked:
		dir = Input.get_axis("left", "right")
	var on_floor := is_on_floor()
	if on_floor:
		coyote = 0.1
		air_jumps = max_air_jumps
		air_dash = true
	else:
		coyote -= dt
	drop_t -= dt
	if drop_t <= 0.0 and collision_mask & ONEWAY_LAYER == 0:
		collision_mask |= ONEWAY_LAYER
	if not controls_locked and Input.is_action_just_pressed("jump"):
		if on_floor and Input.is_action_pressed("down") and _on_oneway():
			collision_mask &= ~ONEWAY_LAYER
			drop_t = 0.28
			position.y += 3.0
			on_floor = false
			coyote = 0.0
		else:
			jbuf = 0.13
	jbuf -= dt

	wall_dir = 0
	if form == "lince" and not on_floor and is_on_wall():
		var n := get_wall_normal()
		if absf(n.x) > 0.5:
			wall_dir = -int(signf(n.x))
	if wall_dir != 0:
		wall_coyote = 0.12
		last_wall = wall_dir
	else:
		wall_coyote -= dt

	if hook != null:
		_hook_physics(dt)
	elif dash_t > 0.0:
		dash_t -= dt
		velocity = Vector2(facing * 760.0, 0.0)
		if int(t * 60.0) % 2 == 0:
			_spawn_ghost()
		if dash_t <= 0.0:
			velocity.x = facing * run_speed
	elif knock_t > 0.0:
		knock_t -= dt
		velocity.y = minf(velocity.y + GRAV * dt, MAX_FALL)
	else:
		var target := dir * run_speed
		var accel := 900.0 if wall_lock > 0.0 else 4200.0
		wall_lock -= dt
		velocity.x = move_toward(velocity.x, target, accel * dt)
		if dir != 0.0 and not (form == "human" and use_mouse):
			facing = int(signf(dir))
		var g := GRAV
		if velocity.y < 0.0 and (controls_locked or not Input.is_action_pressed("jump")):
			g *= 2.8
		velocity.y = minf(velocity.y + g * dt, MAX_FALL)
		if wall_dir != 0 and velocity.y > 0.0 and int(signf(dir)) == wall_dir:
			velocity.y = minf(velocity.y, 120.0)
			if randf() < 0.15:
				Fx.burst(level.fx, global_position + Vector2(wall_dir * 16, -20), Color(0.6, 1.0, 0.8, 0.6), 2, 60, 0.4, 0.04, 100)
		if jbuf > 0.0:
			if coyote > 0.0:
				_jump(1.0)
			elif form == "lince" and wall_coyote > 0.0:
				velocity = Vector2(-last_wall * 420.0, -jump_v * 0.95)
				wall_lock = 0.17
				facing = -last_wall
				jbuf = 0.0
				wall_coyote = 0.0
				squash = -0.6
				Fx.burst(level.fx, global_position + Vector2(last_wall * 16, -18), Color(0.7, 1.0, 0.8, 0.8), 8, 180, 0.35, 0.05)
			elif air_jumps > 0:
				air_jumps -= 1
				_jump(0.92)
				if form == "lince":
					act = "doublejump"      # cambalhota (a arte já traz os riscos do impulso)
					act_t = 0.28
				Fx.burst(level.fx, global_position, Color(0.85, 1.0, 0.5, 0.9), 8, 180, 0.35, 0.05, 200)
		if not controls_locked and Input.is_action_just_pressed("dash") and dash_cd <= 0.0 and (on_floor or air_dash):
			if dir != 0.0:
				facing = int(signf(dir))
			dash_t = 0.16
			dash_cd = Upgrades.dash_cd(main)
			AudioMgr.sfx("esquiva", Vector2.INF, -2.0)
			if not on_floor:
				air_dash = false
			Fx.burst(level.fx, global_position + Vector2(-facing * 10, -24), Color(0.5, 0.9, 1.0, 0.8), 10, 200, 0.3, 0.06, 0)

	if not controls_locked and Input.is_action_just_pressed("hook") and has_module("arpao"):
		var hc := hook_candidate()
		if hc != null:
			_start_hook(hc)
		else:
			AudioMgr.sfx("negado", Vector2.INF, -8.0, 0.0)
	if not controls_locked:
		_update_aim()
		if hook != null:
			aim = (hook.global_position - shoulder_global()).normalized()
		if Input.is_action_just_pressed("attack") and atk_cd <= 0.0:
			_attack()
		if Input.is_action_just_pressed("special"):
			_special()
		if Input.is_action_just_pressed("interact") and main.interact_target != null and is_instance_valid(main.interact_target):
			main.interact_target.interact()

	move_and_slide()
	if hook != null and hook_pull_t > 0.06 and get_real_velocity().length() < HOOK_SPEED * 0.25:
		_end_hook(0.0)

	var now_floor := is_on_floor()
	if now_floor and not was_floor:
		squash = 1.0
		AudioMgr.sfx("pouso", Vector2.INF, -6.0, 0.1)
		if form == "lince":
			land_t = 0.09
			FxAnim.verd(level.fx, "poeira", global_position + Vector2(0, 2)).z_index = 4
		elif level.id == "deserto" and position.x < 1700:
			Desert.effect(level.fx, "DF83", 6, position - Vector2(0, 31), Vector2(92, 74))
		else:
			Fx.burst(level.fx, global_position, Color(0.75, 0.8, 0.85, 0.5), 8, 120, 0.35, 0.05, 50)
	was_floor = now_floor
	squash = move_toward(squash, 0.0, dt * 6.0)
	if now_floor and absf(velocity.x) > 10.0:
		walk_phase += dt * 15.0 * (absf(velocity.x) / run_speed)
	_update_safe(dt, now_floor)
	_check_hurt()
	if global_position.y > float(level.data["kill_y"]):
		hurt(global_position, 1, true)
	queue_redraw()


func _process(dt: float) -> void:
	var f := float(facing)
	if form == "human":
		_update_rig(dt)
		glow_a.global_position = gun_tip()
		glow_a.modulate.a = 0.25 + (0.6 if atk_anim > 0.0 else 0.0)
	else:
		_update_lynx(dt)
		# o brilho acompanha a lanterna da cauda, quadro a quadro
		var pts: Array = SpriteMetaVerd.LINCE_LANTERN[String(body_spr.animation)]
		var lp: Vector2 = pts[mini(body_spr.frame, pts.size() - 1)]
		glow_a.position = Vector2(lp.x * f, lp.y)
		glow_a.modulate.a = 0.0 if dead else 0.5 + 0.15 * sin(t * 4.0)
	var gb := 0.0
	if flash_t > 0.0:
		gb = flash_t / 0.4 * 0.9
	elif atk_anim > 0.0 and form == "human":
		gb = 0.25
	glow_b.modulate = Color(0.6, 1.0, 0.8, gb) if form == "lince" else Color(0.4, 0.9, 1.0, gb)
	if warping:
		modulate = Color(1, 1, 1, maxf(0.0, 1.0 - warp_t * 1.2))
		scale = Vector2.ONE * maxf(0.05, 1.0 - warp_t * 0.9)
		rotation = warp_t * 8.0


func has_module(id: String) -> bool:
	return main != null and main.modules.has(id)


## gancho mais próximo dentro do alcance, à frente/acima, com linha de visão livre
func hook_candidate() -> Node2D:
	if form != "human" or dead:
		return null
	var best: Node2D = null
	var best_score := INF
	var from := shoulder_global()
	for h in get_tree().get_nodes_in_group("hooks"):
		var d: Vector2 = h.global_position - from
		var L := d.length()
		if L > HOOK_RANGE or L < 30.0:
			continue
		if h == hook or (h == last_hook and last_hook_t > 0.0):
			continue
		var q := PhysicsRayQueryParameters2D.create(from, h.global_position, 1)
		if not get_world_2d().direct_space_state.intersect_ray(q).is_empty():
			continue
		# prefere ganchos na direção da mira/do movimento
		var pref := 1.0 - 0.4 * maxf(0.0, d.normalized().dot(aim))
		var score := L * pref
		if score < best_score:
			best_score = score
			best = h
	return best


func _start_hook(h: Node2D) -> void:
	hook = h
	hook_shoot = 0.09
	hook_len = 0.0
	hook_pull_t = 0.0
	dash_t = 0.0
	knock_t = 0.0
	AudioMgr.sfx("arpao", Vector2.INF, -2.0, 0.05)


func _end_hook(keep: float) -> void:
	velocity = velocity.normalized() * minf(velocity.length(), HOOK_SPEED) * keep
	last_hook = hook
	last_hook_t = 0.5
	hook = null
	air_jumps = max_air_jumps
	air_dash = true
	coyote = 0.08


func _hook_physics(dt: float) -> void:
	if not is_instance_valid(hook):
		hook = null
		return
	var target: Vector2 = hook.global_position + Vector2(0, 46)   # o corpo para logo abaixo do gancho
	var to := target - global_position
	if hook_shoot > 0.0:
		hook_shoot -= dt
		hook_len = clampf(1.0 - hook_shoot / 0.09, 0.0, 1.0)
		velocity *= 0.85
		if hook_shoot <= 0.0:
			AudioMgr.sfx("arpao_prende", hook.global_position, -2.0, 0.05)
		return
	hook_len = 1.0
	hook_pull_t += dt
	if to.length() < 22.0:
		_end_hook(0.55)
		return
	velocity = to.normalized() * HOOK_SPEED
	# pular cancela o arpão com um impulso
	if Input.is_action_just_pressed("jump"):
		_end_hook(0.6)
		velocity.y = minf(velocity.y, -jump_v * 0.7)
		jbuf = 0.0


func _on_oneway() -> bool:
	# está no chão, mas sem a camada das plataformas não haveria chão logo abaixo → é plataforma
	var m := collision_mask
	collision_mask = 1
	var solid := test_move(global_transform, Vector2(0, 4))
	collision_mask = m
	return not solid


func _spawn_ghost() -> void:
	var tex := body_spr.sprite_frames.get_frame_texture(body_spr.animation, body_spr.frame)
	if tex == null:
		return
	var g := Sprite2D.new()
	g.texture = tex
	g.offset = body_spr.offset
	g.global_position = global_position
	g.scale = Vector2(body_spr.scale.x * facing, body_spr.scale.y)
	g.modulate = Color(0.4, 0.9, 1.0, 0.45) if form == "human" else Color(0.7, 1.0, 0.55, 0.4)
	g.material = Art.add_mat()
	g.z_index = 4
	level.fx.add_child(g)
	var tw := g.create_tween()
	tw.tween_property(g, "modulate:a", 0.0, 0.25)
	tw.tween_callback(g.queue_free)


## Escolhe a animação do Lince pelo estado real do personagem.
## Prioridade: morte > dano > ação (garras no chão, pogo, clarão, cambalhota) > esquiva > parede > ar > pouso > corrida > idle.
func _update_lynx(dt: float) -> void:
	act_t -= dt
	land_t -= dt
	hurt_t -= dt
	var on_floor := is_on_floor()
	if act == "claw" and not on_floor:
		act_t = 0.0             # garras no chão: se sair do chão, volta para a pose de ar
	if act_t <= 0.0:
		act = ""
	var an := "idle"
	var pose := -1              # >= 0: quadro fixo (pose), sem tocar a animação
	if dead:
		an = "death"
	elif hurt_t > 0.0:
		an = "hurt"
	elif act != "":
		an = act
	elif dash_t > 0.0:
		an = "run"
		pose = 2                # corpo todo esticado
	elif wall_dir != 0 and velocity.y > 0.0:
		an = "wall"
	elif not on_floor:
		if velocity.y < 0.0:
			an = "jump"
			pose = 1 if velocity.y < -300.0 else 2
		else:
			an = "fall"
			pose = 0 if velocity.y < 220.0 else (1 if velocity.y < 640.0 else 2)
	elif land_t > 0.0:
		an = "jump"
		pose = 0                # agachamento do pouso
	elif absf(velocity.x) > 30.0:
		an = "run"
	if body_spr.animation != an or (pose < 0 and held_pose):
		body_spr.play(an)
	held_pose = pose >= 0
	if held_pose:
		body_spr.pause()
		body_spr.frame = pose
	body_spr.speed_scale = clampf(absf(velocity.x) / run_speed, 0.5, 1.2) if an == "run" else 1.0
	var sx := 1.0 + squash * 0.08
	var sy := 1.0 - squash * 0.07
	rig.scale = Vector2(sx * facing, sy)
	var a := 1.0
	if inv > 0.0 and inv < 50.0 and not dead and int(t * 20.0) % 2 == 0:
		a = 0.35
	rig.modulate = Color(1, 1, 1, a)


func _update_rig(dt: float) -> void:
	var an := "idle"
	var on_floor := is_on_floor()
	if dead:
		an = "death"
	elif knock_t > 0.0:
		an = "hurt"
	elif dash_t > 0.0:
		an = "dash"
	elif not on_floor:
		an = "jump" if velocity.y < 60.0 else "fall"
	elif absf(velocity.x) > 30.0:
		an = "run"
	if body_spr.animation != an:
		body_spr.play(an)
		if an == "jump":
			body_spr.frame = 1
	if an == "jump":
		body_spr.pause()
		body_spr.frame = 1 if velocity.y < -280.0 else 2
	elif an == "run":
		body_spr.speed_scale = clampf(absf(velocity.x) / run_speed, 0.5, 1.2)
	else:
		body_spr.speed_scale = 1.0
	var sx := 1.0 + squash * 0.10
	var sy := 1.0 - squash * 0.08
	rig.scale = Vector2(sx * facing, sy)
	var a := 1.0
	if inv > 0.0 and inv < 50.0 and not dead and int(t * 20.0) % 2 == 0:
		a = 0.35
	rig.modulate = Color(1, 1, 1, a)
	# braço: some em dano, morte e dash
	var show_arm := an in ["idle", "run", "jump", "fall"]
	arm_pivot.visible = show_arm
	var target: Vector2 = SHOULDER[an]
	if an == "run":
		target.y += absf(sin(body_spr.frame / 8.0 * TAU)) * -2.0
	if an == "idle":
		target.y += sin(t * 2.6) * 0.8
	arm_pivot.position = target
	var la := Vector2(aim.x * facing, aim.y)
	if la.x < -0.2:
		la.x = -0.2
	arm_pivot.rotation = la.angle()
	# recuo do tiro
	arm_spr.position.x = -4.0 if atk_anim > 0.0 else 0.0


func _jump(m: float) -> void:
	AudioMgr.sfx("pulo" if m >= 1.0 else "pulo_duplo", Vector2.INF, -3.0)
	velocity.y = -jump_v * m
	jbuf = 0.0
	coyote = 0.0
	squash = -0.6


func pogo() -> void:
	velocity.y = -jump_v * 0.85
	air_jumps = max_air_jumps
	air_dash = true
	dash_t = 0.0
	squash = -0.5


func _update_aim() -> void:
	var chest := shoulder_global()
	if use_mouse:
		var m := get_global_mouse_position() - chest
		if m.length() > 4.0:
			aim = m.normalized()
		if form == "human" and absf(aim.x) > 0.15 and dash_t <= 0.0:
			facing = int(signf(aim.x))
	else:
		var rs := Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
		if rs.length() > 0.35:
			aim = rs.normalized()
			if form == "human" and absf(aim.x) > 0.15 and dash_t <= 0.0:
				facing = int(signf(aim.x))
		elif Input.is_action_pressed("up"):
			aim = Vector2(0, -1)
		elif Input.is_action_pressed("down") and not is_on_floor():
			aim = Vector2(0, 1)
		else:
			aim = Vector2(facing, 0)


func _attack() -> void:
	if form == "human":
		atk_cd = Upgrades.fire_cd(main)
		atk_anim = 0.12
		var tip := gun_tip()
		var b := Bullet.new()
		b.dir = aim
		b.player = self
		b.position = tip
		level.add_fx(b)
		_fire_fx(false)
		AudioMgr.sfx("tiro", Vector2.INF, -4.0, 0.08)
	else:
		atk_cd = 0.3
		atk_anim = 0.14
		var d := Vector2(facing, 0)
		if Input.is_action_pressed("up"):
			d = Vector2(0, -1)
		elif Input.is_action_pressed("down") and not is_on_floor():
			d = Vector2(0, 1)
		if d.y > 0.0:
			act = "pogo"
			act_t = 0.25
		elif d.y == 0.0 and is_on_floor():
			act = "claw"
			act_t = 0.25
		AudioMgr.sfx("garras", Vector2.INF, -3.0, 0.1)
		var s := Slash.new()
		s.dir = d
		s.player = self
		add_child(s)


func _special() -> void:
	if energy < 33.0:
		main.hud.energy_denied()
		return
	energy -= 33.0
	if form == "human":
		var tip := gun_tip()
		var b := Bullet.new()
		b.dir = aim
		b.player = self
		b.big = true
		b.dmg = 3
		b.pierce = true
		b.speed = 1100.0
		b.position = tip
		level.add_fx(b)
		atk_anim = 0.25
		velocity -= aim * 180.0
		main.add_shake(6.0)
		_fire_fx(true)
		AudioMgr.sfx("tiro_carregado", Vector2.INF, -1.0, 0.03)
		Fx.ring(level.fx, tip, Color(0.5, 0.95, 1.0, 0.8), 50, 0.25, 4)
	else:
		flash_t = 0.4
		act = "flash"
		act_t = 0.4
		AudioMgr.sfx("clarao", Vector2.INF, -2.0, 0.02)
		var c := global_position + Vector2(0, -18)
		# anel do clarão (VD_fx_clarao): o diâmetro máximo coincide com o alcance do golpe (190 px)
		FxAnim.verd(level.fx, "clarao", c)
		main.add_shake(8.0)
		for e in get_tree().get_nodes_in_group("enemies"):
			if is_instance_valid(e) and not e.dead and e.global_position.distance_to(c) < 190.0:
				e.take_hit(1, c)
				e.stun = 1.8
		for cr in get_tree().get_nodes_in_group("crates"):
			if is_instance_valid(cr) and not cr.broken and cr.global_position.distance_to(c) < 190.0:
				cr.take_hit(3, c)


func on_hit_enemy(d: Vector2) -> void:
	energy = minf(99.0, energy + 11.0 * Upgrades.energy_mult(main))
	if d.y > 0.5:
		pogo()
	elif absf(d.x) > 0.5:
		velocity.x = -d.x * 260.0
	main.hitstop(0.035)
	main.add_shake(4.0)


func _update_safe(dt: float, floor_now: bool) -> void:
	if not floor_now:
		safe_t = 0.0
		return
	safe_t += dt
	if safe_t < 0.12:
		return
	var space := get_world_2d().direct_space_state
	for ox in [-20.0, 20.0]:
		var q := PhysicsRayQueryParameters2D.create(global_position + Vector2(ox, -4), global_position + Vector2(ox, 14), 1)
		if space.intersect_ray(q).is_empty():
			return
	for a in hurtbox.get_overlapping_areas():
		if a.is_in_group("hazard"):
			return
	last_safe = global_position + Vector2(0, -2)


func _check_hurt() -> void:
	var areas := hurtbox.get_overlapping_areas()
	for a in areas:
		if a.is_in_group("hazard"):
			hurt(a.global_position, 1, true)
			return
	if inv > 0.0 or dash_t > 0.0:
		return
	for a in areas:
		if a.has_meta("enemy"):
			var e = a.get_meta("enemy")
			if is_instance_valid(e) and not e.dead and e.stun <= 0.0:
				hurt(e.global_position)
				return
		elif a.is_in_group("enemy_attack"):
			if a.has_method("is_harmful") and not a.is_harmful():
				continue
			if a.has_method("on_hit_player"):
				a.on_hit_player()
			hurt(a.global_position)
			return


func hurt(from: Vector2, dmg: int = 1, hazard: bool = false) -> void:
	if dead or main.transitioning or warping:
		return
	if hazard:
		if inv <= 0.0:
			hp -= dmg
			main.on_player_hurt()
			Fx.burst(level.fx, global_position + Vector2(0, -25), Color(1, 1, 1), 16, 280, 0.4, 0.07)
		inv = 1.0
		if hp <= 0:
			die()
			return
		main.hazard_respawn(last_safe)
		return
	if inv > 0.0:
		return
	hook = null
	hp -= dmg
	inv = 1.2
	knock_t = 0.2
	hurt_t = 0.3
	act = ""
	dash_t = 0.0
	var sx := signf(global_position.x - from.x)
	if sx == 0.0:
		sx = -facing
	velocity = Vector2(sx * 340.0, -360.0)
	main.on_player_hurt()
	Fx.burst(level.fx, global_position + Vector2(0, -25), Color(1, 1, 1), 18, 300, 0.4, 0.07)
	if hp <= 0:
		die()


func heal(n: int) -> void:
	hp = mini(max_hp, hp + n)


func die() -> void:
	dead = true
	act = ""
	velocity = Vector2(-facing * 120.0, -300.0)
	Fx.burst(level.fx, global_position + Vector2(0, -25), Color(0.5, 0.9, 1.0), 40, 420, 0.9, 0.1, 100)
	main.add_shake(16.0)
	main.on_player_died()


func start_warp(target: Vector2) -> void:
	warping = true
	warp_to = target
	warp_t = 0.0
	inv = 99.0


# ---------------------------------------------------------------- desenho
func _draw() -> void:
	if hook != null and is_instance_valid(hook):
		var a := to_local(gun_tip())
		var b := to_local(hook.global_position)
		var e := a.lerp(b, hook_len)
		draw_line(a, e, Color(0.35, 0.92, 1.0, 0.35), 6.0, true)
		draw_line(a, e, Color(0.8, 1.0, 1.0, 0.95), 2.0, true)
