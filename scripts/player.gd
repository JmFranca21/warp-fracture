class_name Player
extends CharacterBody2D
## Daymon Sagan. Forma "human" (laboratório), "lince" (Lince-Vagalume, Verdâmia) ou
## "automato" (Autômato de Fase, Deserto de Ferrugem — D03) ou "yeti" (Nivária: pesado,
## bola de neve mirada no ataque e chute giratório no botão direito).

const GRAV := 2000.0
const MAX_FALL := 950.0

var main
var level
var form := "human"
var run_speed := 320.0
var jump_v := 760.0
var grav := GRAV            # o Yeti cai mais devagar (pulo lento e pesado)
var accel_ground := 4200.0
var accel_air := 4200.0     # o Yeti mantém o embalo no ar (inércia de bicho pesado)
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
# Yeti: bola de neve (throw_t), chute giratório (kick_t) e virada de frente (turn_t)
const YETI_SCALE := 0.5
const SNOW_SPAWN := 0.22    # throw_t em que a bola sai da mão (quadro do braço esticado)
var throw_t := 0.0
var throw_aim := Vector2.RIGHT
var kick_t := 0.0
var kick_cd := 0.0
var turn_t := 0.0
var vis_facing := 1
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
# Autômato (DF90–DF97): ombro do braço-ímã por animação, medido nas entregas (pés = origem)
# v2: ombro por quadro (DF97_ancoras.json, px da célula 384 × 512, pés em (192, 472)); o jogo usa (ombro − pés) × K
const SHOULDER_AUT_PX := {
	"idle": [Vector2(178, 279), Vector2(178, 278), Vector2(178, 277), Vector2(178, 278), Vector2(178, 278), Vector2(178, 278)],
	"walk": [Vector2(171, 293), Vector2(171, 291), Vector2(185, 289), Vector2(178, 278), Vector2(166, 295),
		Vector2(165, 294), Vector2(185, 289), Vector2(178, 278)],
	"jump": [Vector2(159, 313), Vector2(178, 264), Vector2(179, 306), Vector2(180, 307)],
	"fall": [Vector2(180, 306), Vector2(177, 272), Vector2(177, 270)],
	"dash": [Vector2(159, 314), Vector2(189, 334), Vector2(189, 334), Vector2(178, 278)],
	"hurt": [Vector2(133, 262), Vector2(178, 278)],
	"death": [Vector2(134, 266), Vector2(135, 272), Vector2(133, 381), Vector2(133, 381), Vector2(210, 369), Vector2(210, 369)],
}
const ARM_TIP_AUT := [280.0, 270.0, 276.0, 280.0]     # ponta nominal do braço por quadro de DF97 (pivô em x 60)
const PULSE_R := 150.0
var beam_t := 0.0           # feixe do ímã visível (puxando um drone)
var beam_to := Vector2.ZERO
var pulse_cd := 0.0
const SHOULDER := {
	"idle": Vector2(3, -50), "run": Vector2(8, -47), "jump": Vector2(6, -48),
	"fall": Vector2(4, -50), "dash": Vector2(8, -36), "hurt": Vector2(0, -48), "death": Vector2(0, -40),
}


func _ready() -> void:
	collision_layer = 2
	collision_mask = 1 | ONEWAY_LAYER
	floor_snap_length = 6.0
	var size := Vector2(24, 62)
	match form:
		"automato": size = Vector2(30, 62)
		"lince": size = Vector2(32, 34)
		"yeti": size = Vector2(38, 76)
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
	elif form == "automato":
		run_speed = 272.0          # 0,85 × humano
		max_air_jumps = 0
		jump_v = 721.0             # ~130 px de pulo (90% do humano)
		glow_a = Art.glow(Color(0.3, 0.9, 1.0, 0.6), 22)
		_build_automato()
	elif form == "yeti":
		# lento e pesado, mas com o mesmo alcance de pulo do humano (a fase foi medida com ele):
		# corre 78% e fica ~25% mais tempo no ar; a mesma altura (~139 px) para os degraus
		run_speed = 250.0
		max_air_jumps = 0
		grav = 1250.0
		jump_v = 590.0
		accel_ground = 1700.0      # demora a embalar e a parar
		accel_air = 760.0          # carrega o embalo do pulo e do Arpão; corrige pouco no ar
		glow_a = Art.glow(Color(0.8, 0.92, 1.0, 0.5), 22)
		_build_yeti()
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
	var amb := Art.glow(Color(0.5, 0.7, 1.0, 0.10), 150) if form in ["human", "yeti"] else Art.glow(Color(0.55, 0.95, 0.9, 0.20), 120)
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


## Autômato: corpo (DF90–DF96) + braço-ímã (DF97) que gira para mirar, como o braço humano.
func _build_automato() -> void:
	rig = Node2D.new()
	add_child(rig)
	var sf := SpriteFrames.new()
	DFArt.add_anim(sf, "idle", "DF90", range(6), 8.0, true)
	DFArt.add_anim(sf, "walk", "DF91", range(8), 12.0, true)
	DFArt.add_anim(sf, "jump", "DF92", range(4), 12.0, false)
	DFArt.add_anim(sf, "fall", "DF93", range(3), 8.0, false)
	DFArt.add_anim(sf, "dash", "DF94", range(4), 18.0, false)
	DFArt.add_anim(sf, "hurt", "DF95", range(2), 10.0, false)
	DFArt.add_anim(sf, "death", "DF96", range(6), 8.0, false)
	body_spr = AnimatedSprite2D.new()
	body_spr.sprite_frames = sf
	body_spr.offset = DFArt.offset(Vector2(384, 512), Vector2(192, 472))
	body_spr.scale = Vector2.ONE * DFArt.NODE
	rig.add_child(body_spr)
	body_spr.play("idle")
	arm_pivot = Node2D.new()
	arm_pivot.position = shoulder_aut("idle", 0)
	rig.add_child(arm_pivot)
	var af := SpriteFrames.new()
	DFArt.add_anim(af, "braco", "DF97", [0], 1.0, false)
	DFArt.add_anim(af, "fire", "DF97", [1, 2, 0], 14.0, false)
	DFArt.add_anim(af, "beam", "DF97", [3], 1.0, false)
	arm_spr = AnimatedSprite2D.new()
	arm_spr.sprite_frames = af
	arm_spr.offset = DFArt.offset(Vector2(384, 512), Vector2(60, 256))
	arm_spr.scale = Vector2.ONE * DFArt.NODE
	arm_spr.play("braco")
	arm_pivot.add_child(arm_spr)
	arm_len = (ARM_TIP_AUT[0] - 60.0) * DFArt.K
	var mf := SpriteFrames.new()
	DFArt.add_anim(mf, "fire", "DF88", range(3), 20.0, false)
	muzzle = AnimatedSprite2D.new()
	muzzle.sprite_frames = mf
	muzzle.offset = DFArt.offset(Vector2(384, 512), Vector2(40, 256))
	muzzle.scale = Vector2.ONE * DFArt.NODE
	muzzle.position = Vector2(arm_len - 2, 0)
	muzzle.visible = false
	muzzle.animation_finished.connect(func(): muzzle.visible = false)
	arm_pivot.add_child(muzzle)


## Ombro do braço-ímã no quadro i da animação (pés = origem, olhando para a direita).
func shoulder_aut(an: String, i: int) -> Vector2:
	var l: Array = SHOULDER_AUT_PX.get(an, SHOULDER_AUT_PX["idle"])
	return (l[clampi(i, 0, l.size() - 1)] - Vector2(192, 472)) * DFArt.K


## Yeti (Nivária): folha montada por tools/import_yeti.py a partir das pranchas em assets/nivaria.
## Uma animação por linha; células de 380×250 com os pés em (190, 240).
func _build_yeti() -> void:
	rig = Node2D.new()
	add_child(rig)
	var tex: Texture2D = load("res://assets/nivaria/yeti/yeti_sheet.png")
	var sf := SpriteFrames.new()
	sf.remove_animation("default")
	var anims := {"idle": [0, 1, 1.0, true], "turn": [1, 4, 1.0, false], "run": [2, 8, 10.0, true],
		"jump": [3, 8, 1.0, false], "throw": [4, 8, 1.0, false], "kick": [5, 8, 18.0, false]}
	for an in anims:
		var row: int = anims[an][0]
		sf.add_animation(an)
		sf.set_animation_speed(an, anims[an][2])
		sf.set_animation_loop(an, anims[an][3])
		for i in int(anims[an][1]):
			var at := AtlasTexture.new()
			at.atlas = tex
			at.region = Rect2(i * 380, row * 250, 380, 250)
			sf.add_frame(an, at)
	body_spr = AnimatedSprite2D.new()
	body_spr.sprite_frames = sf
	body_spr.offset = Vector2(0, 125 - 240)
	body_spr.scale = Vector2.ONE * YETI_SCALE
	rig.add_child(body_spr)
	body_spr.play("idle")


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
	if form == "yeti":
		return shoulder_global() + aim * 26.0
	if arm_pivot == null:
		return global_position + Vector2(0, -32) + aim * 28.0
	return arm_pivot.to_global(Vector2(arm_len, -3))


func shoulder_global() -> Vector2:
	if form == "yeti":
		return global_position + Vector2(vis_facing * 6.0, -72.0)
	if arm_pivot == null:
		return global_position + Vector2(0, -18)
	return rig.to_global(arm_pivot.position)


func _fire_fx(big: bool) -> void:
	if muzzle == null:
		return
	muzzle.visible = true
	if form == "automato":
		arm_spr.play("fire")
		muzzle.play("fire")
		muzzle.frame = 0
		return
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
	kick_cd -= dt
	inv -= dt
	flash_t -= dt
	if warping:
		warp_t += dt
		global_position = global_position.lerp(warp_to, 1.0 - exp(-dt * 4.0))
		velocity = Vector2.ZERO
		queue_redraw()
		return
	if dead:
		velocity.y = minf(velocity.y + grav * dt, MAX_FALL)
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
		velocity = Vector2(facing * (600.0 if form in ["automato", "yeti"] else 760.0), 0.0)
		if int(t * 60.0) % 2 == 0:
			_spawn_ghost()
		if dash_t <= 0.0:
			velocity.x = facing * run_speed
	elif knock_t > 0.0:
		knock_t -= dt
		velocity.y = minf(velocity.y + grav * dt, MAX_FALL)
	else:
		var target := dir * run_speed
		if kick_t > 0.0 and on_floor:
			target *= 0.35            # o chute giratório quase planta o Yeti no chão
		var accel := 900.0 if wall_lock > 0.0 else (accel_ground if on_floor else accel_air)
		wall_lock -= dt
		velocity.x = move_toward(velocity.x, target, accel * dt)
		if dir != 0.0 and not (form != "lince" and use_mouse):
			facing = int(signf(dir))
		var g := grav
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
		if not controls_locked and Input.is_action_just_pressed("dash") and dash_cd <= 0.0 and (on_floor or (air_dash and form not in ["automato", "yeti"])):
			if dir != 0.0:
				facing = int(signf(dir))
			dash_t = 0.2 if form in ["automato", "yeti"] else 0.16
			dash_cd = Upgrades.dash_cd(main)
			AudioMgr.sfx("arranque" if form in ["automato", "yeti"] else "esquiva", Vector2.INF, -2.0)
			if not on_floor:
				air_dash = false
			Fx.burst(level.fx, global_position + Vector2(-facing * 10, -24), Color(0.5, 0.9, 1.0, 0.8), 10, 200, 0.3, 0.06, 0)

	beam_t -= dt
	pulse_cd -= dt
	if not controls_locked and Input.is_action_just_pressed("hook") and (has_module("arpao") or form == "automato"):
		var hc := hook_candidate()
		if hc != null:
			_start_hook(hc)
		elif form == "automato" and _magnet_drone():
			pass
		else:
			AudioMgr.sfx("negado", Vector2.INF, -8.0, 0.0)
	if not controls_locked:
		_update_aim()
		if hook != null:
			aim = (hook.global_position - shoulder_global()).normalized()
		if Input.is_action_just_pressed("attack") and atk_cd <= 0.0 and kick_t <= 0.0:
			_attack()
		if Input.is_action_just_pressed("special"):
			if form == "yeti":
				_spin_kick()
			else:
				_special()
		if Input.is_action_just_pressed("interact") and main.interact_target != null and is_instance_valid(main.interact_target):
			main.interact_target.interact()

	if form == "yeti":
		_yeti_actions(dt)
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
		elif form == "automato":
			land_t = 0.08
			if level.id == "deserto" and position.x < 1700:
				Desert.effect(level.fx, "DF83", 6, position, 1.3)
			else:
				Fx.burst(level.fx, global_position, Color(0.85, 0.6, 0.4, 0.5), 8, 120, 0.35, 0.05, 50)
		elif form == "yeti":
			land_t = 0.12
			main.add_shake(3.0)       # pesado: o chão treme um pouco
			Fx.burst(level.fx, global_position, Color(0.92, 0.96, 1.0, 0.75), 14, 170, 0.45, 0.06, 60)
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
	elif form == "yeti":
		_update_yeti(dt)
		glow_a.global_position = gun_tip()
		glow_a.modulate.a = 0.0 if dead else (0.5 if throw_t > 0.0 else 0.0)
	elif form == "automato":
		_update_automato(dt)
		glow_a.global_position = gun_tip()
		glow_a.modulate.a = 0.2 + (0.6 if atk_anim > 0.0 or hook != null or beam_t > 0.0 else 0.0)
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
	glow_b.modulate = Color(0.6, 1.0, 0.8, gb) if form == "lince" else (Color(0.85, 0.95, 1.0, gb) if form == "yeti" else Color(0.4, 0.9, 1.0, gb))
	if warping:
		modulate = Color(1, 1, 1, maxf(0.0, 1.0 - warp_t * 1.2))
		scale = Vector2.ONE * maxf(0.05, 1.0 - warp_t * 0.9)
		rotation = warp_t * 8.0


func has_module(id: String) -> bool:
	return main != null and main.modules.has(id)


## gancho mais próximo dentro do alcance, à frente/acima, com linha de visão livre
func hook_candidate() -> Node2D:
	if form == "lince" or dead:
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


## Animação do Autômato pelo estado real; o braço-ímã segue a mira (some no dano, na morte e no Arranque).
func _update_automato(dt: float) -> void:
	hurt_t -= dt
	land_t -= dt
	var an := "idle"
	var pose := -1
	var on_floor := is_on_floor()
	if dead:
		an = "death"
	elif hurt_t > 0.0:
		an = "hurt"
	elif dash_t > 0.0:
		an = "dash"
		pose = 1 if dash_t > 0.1 else 2
	elif hook != null:
		an = "jump"
		pose = 3
	elif not on_floor:
		if velocity.y < 0.0:
			an = "jump"
			pose = 1 if velocity.y < -500.0 else (2 if velocity.y < -150.0 else 3)
		else:
			an = "fall"
			pose = 0 if velocity.y < 250.0 else (1 if velocity.y < 600.0 else 2)
	elif land_t > 0.0:
		an = "jump"
		pose = 0
	elif absf(velocity.x) > 30.0:
		an = "walk"
	if body_spr.animation != an or (pose < 0 and held_pose):
		body_spr.play(an)
	held_pose = pose >= 0
	if held_pose:
		body_spr.pause()
		body_spr.frame = pose
	body_spr.speed_scale = clampf(absf(velocity.x) / run_speed, 0.6, 1.2) if an == "walk" else 1.0
	var sx := 1.0 + squash * 0.06
	var sy := 1.0 - squash * 0.05
	rig.scale = Vector2(sx * facing, sy)
	var a := 1.0
	if inv > 0.0 and inv < 50.0 and not dead and int(t * 20.0) % 2 == 0:
		a = 0.35
	rig.modulate = Color(1, 1, 1, a)
	# as folhas v2 do corpo não têm o braço-ímã: ele aparece em todas as poses, no ombro do quadro atual
	arm_pivot.visible = true
	arm_pivot.position = shoulder_aut(an, body_spr.frame)
	var la := Vector2(aim.x * facing, aim.y)
	if la.x < -0.2:
		la.x = -0.2
	arm_pivot.rotation = 1.1 if an == "death" else la.angle()     # na derrota o braço pende; nas outras, mira
	if hook != null or beam_t > 0.0:
		if arm_spr.animation != "beam":
			arm_spr.play("beam")
	elif arm_spr.animation == "beam":
		arm_spr.play("braco")


## Yeti: tempo do arremesso (a bola sai no quadro do braço esticado) e do chute giratório.
func _yeti_actions(dt: float) -> void:
	if throw_t > 0.0:
		var before := throw_t
		throw_t -= dt
		if before > SNOW_SPAWN and throw_t <= SNOW_SPAWN and not dead:
			throw_aim = aim
			var b := Snowball.new()
			b.dir = throw_aim
			b.player = self
			b.position = gun_tip()
			level.add_fx(b)
			AudioMgr.sfx("garras", Vector2.INF, -6.0, 0.15)
	if kick_t > 0.0:
		kick_t -= dt


## Chute giratório (botão direito): golpe em volta do corpo, sem custo de energia, com recarga curta.
func _spin_kick() -> void:
	if kick_t > 0.0 or kick_cd > 0.0 or dead:
		return
	kick_t = 0.46
	kick_cd = 0.75
	throw_t = 0.0
	var k := SpinKick.new()
	k.player = self
	add_child(k)
	AudioMgr.sfx("garras", Vector2.INF, -2.0, 0.05)


## Escolhe a animação do Yeti pelo estado real; vira de frente (turnaround) ao trocar de lado no chão.
func _update_yeti(dt: float) -> void:
	land_t -= dt
	hurt_t -= dt
	var on_floor := is_on_floor()
	if facing != vis_facing:
		if on_floor and kick_t <= 0.0 and throw_t <= 0.0 and dash_t <= 0.0 and not dead:
			turn_t = 0.21
		vis_facing = facing
	turn_t -= dt
	var an := "idle"
	var pose := -1
	if dead:
		an = "jump"
		pose = 6
	elif hurt_t > 0.0:
		an = "jump"
		pose = 1
	elif kick_t > 0.0:
		an = "kick"
	elif throw_t > 0.0:
		# 4 = braço para trás, 5 = arremesso, 6–7 = acompanhamento
		an = "throw"
		pose = 4 if throw_t > SNOW_SPAWN + 0.04 else (5 if throw_t > SNOW_SPAWN - 0.06 else (6 if throw_t > 0.08 else 7))
	elif dash_t > 0.0:
		an = "run"
		pose = 3
	elif hook != null:
		an = "jump"
		pose = 4
	elif not on_floor:
		an = "jump"
		if velocity.y < -200.0:
			pose = 3
		elif velocity.y < 250.0:
			pose = 4
		else:
			pose = 5
	elif land_t > 0.0:
		an = "jump"
		pose = 6
	elif turn_t > 0.0:
		# 3/4 do lado antigo → de frente → 3/4 do lado novo
		an = "turn"
		pose = 1 if turn_t > 0.14 or turn_t < 0.07 else 0
	elif absf(velocity.x) > 30.0:
		an = "run"
	if body_spr.animation != an or (pose < 0 and held_pose):
		body_spr.play(an)
	held_pose = pose >= 0
	if held_pose:
		body_spr.pause()
		body_spr.frame = pose
	body_spr.speed_scale = clampf(absf(velocity.x) / run_speed, 0.6, 1.1) if an == "run" else 1.0
	var vf := float(vis_facing)
	if turn_t > 0.14:
		vf = -vf                  # primeira parte da virada ainda olha para o lado antigo
	var sx := 1.0 + squash * 0.07
	var sy := 1.0 - squash * 0.06
	if an == "idle":
		sy += sin(t * 2.2) * 0.012   # respiração
	rig.scale = Vector2(sx * vf, sy)
	var a := 1.0
	if inv > 0.0 and inv < 50.0 and not dead and int(t * 20.0) % 2 == 0:
		a = 0.35
	rig.modulate = Color(1, 1, 1, a)
	rig.rotation = lerp_angle(rig.rotation, -vf * 1.2 if dead and on_floor else 0.0, minf(1.0, dt * 6.0))


## Feixe do ímã sem âncora ao alcance: puxa o drone mais próximo até o chão à frente (D03).
func _magnet_drone() -> bool:
	var from := shoulder_global()
	var best = null
	var bd := HOOK_RANGE
	for e in get_tree().get_nodes_in_group("enemies"):
		if not (e is DesertEnemy) or e.dead or not e.drone or e.falling or e.downed > 0.0:
			continue
		var d: float = e.global_position.distance_to(from)
		if d < bd:
			var q := PhysicsRayQueryParameters2D.create(from, e.global_position, 1)
			if get_world_2d().direct_space_state.intersect_ray(q).is_empty():
				bd = d
				best = e
	if best == null:
		return false
	var dx := signf(best.global_position.x - global_position.x)
	if dx == 0.0:
		dx = facing
	best.magnet_pull(Vector2(global_position.x + dx * 80.0, global_position.y - 40.0))
	beam_t = 0.35
	beam_to = best.global_position
	aim = (best.global_position - from).normalized()
	AudioMgr.sfx("ima", Vector2.INF, -2.0, 0.05)
	return true


## Pulso Magnético (D03): onda de 150 px. Derruba drones, para robôs por 2 s, desvia projéteis
## inimigos e abre as placas imantadas do peito da Forja-Mãe (D04).
func _magnet_pulse() -> void:
	var c := global_position + Vector2(0, -32)
	DFArt.fx(level.fx, "DF99", 6, c, 18.0, false, 0.9)
	AudioMgr.sfx("pulso", Vector2.INF, -1.0, 0.03)
	main.add_shake(7.0)
	for e in get_tree().get_nodes_in_group("enemies"):
		if not is_instance_valid(e) or e.dead or e.global_position.distance_to(c) > PULSE_R + 20.0:
			continue
		if e.has_method("magnet_pulse"):
			e.magnet_pulse()
		else:
			e.stun = 2.0
	for b in get_tree().get_nodes_in_group("enemy_attack"):
		if b is EnemyBullet and is_instance_valid(b) and b.global_position.distance_to(c) < PULSE_R:
			b.pop()
	if level.desert != null and level.desert.forja != null:
		level.desert.forja.on_pulse(c)


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
		if form != "lince" and absf(aim.x) > 0.15 and dash_t <= 0.0:
			facing = int(signf(aim.x))
	else:
		var rs := Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
		if rs.length() > 0.35:
			aim = rs.normalized()
			if form != "lince" and absf(aim.x) > 0.15 and dash_t <= 0.0:
				facing = int(signf(aim.x))
		elif Input.is_action_pressed("up"):
			aim = Vector2(0, -1)
		elif Input.is_action_pressed("down") and not is_on_floor():
			aim = Vector2(0, 1)
		else:
			aim = Vector2(facing, 0)


func _attack() -> void:
	if form == "yeti":
		# Bola de neve: mira livre como o Estabilizador; sai da mão no quadro do arremesso
		atk_cd = 0.42
		throw_t = 0.32
		throw_aim = aim
		AudioMgr.sfx("esquiva", Vector2.INF, -8.0, 0.1)
		return
	if form == "automato":
		atk_cd = Upgrades.fire_cd(main) * 1.25      # cadência 20% menor que o Estabilizador
		atk_anim = 0.12
		var rb := Bullet.new()
		rb.dir = aim
		rb.player = self
		rb.rivet = true
		rb.speed = 900.0
		rb.position = gun_tip()
		level.add_fx(rb)
		_fire_fx(false)
		AudioMgr.sfx("rebite", Vector2.INF, -4.0, 0.08)
		return
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
	if form == "automato":
		_magnet_pulse()
		return
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
	hurt_t = 0.3
	act = ""
	dash_t = 0.0
	if form == "automato":
		knock_t = 0.0               # pesado: não sofre recuo (D03)
	else:
		knock_t = 0.2
		var sx := signf(global_position.x - from.x)
		if sx == 0.0:
			sx = -facing
		velocity = Vector2(sx * 340.0, -360.0)
		if form == "yeti":
			velocity *= 0.6           # pesado: recua menos
	throw_t = 0.0
	kick_t = 0.0
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
	if form == "automato":
		var tgt := Vector2.INF
		var k := 1.0
		if hook != null and is_instance_valid(hook):
			tgt = hook.global_position
			k = hook_len
		elif beam_t > 0.0:
			tgt = beam_to
		if tgt != Vector2.INF:
			_draw_beam(to_local(gun_tip()), to_local(tgt), k)
		return
	if hook != null and is_instance_valid(hook):
		var a := to_local(gun_tip())
		var b := to_local(hook.global_position)
		var e := a.lerp(b, hook_len)
		draw_line(a, e, Color(0.35, 0.92, 1.0, 0.35), 6.0, true)
		draw_line(a, e, Color(0.8, 1.0, 1.0, 0.95), 2.0, true)


## Feixe do Ímã de Fase (DF98): segmento repetível em loop + garra de luz na ponta.
func _draw_beam(a: Vector2, b: Vector2, k: float) -> void:
	var e := a.lerp(b, k)
	var d := e - a
	var L := d.length()
	if L < 4.0:
		return
	var fr := int(t * 16.0) % 4
	var seg := DFArt.strip("DF98", 0, fr)
	var tip := DFArt.strip("DF98_v1", 1, fr)
	var h := 256.0 * DFArt.K          # 48 px de espessura no original ≈ 10 px no jogo
	# DF98 v2: cada célula da faixa traz um ímã na ponta (x ≥ 145); só o trecho de feixe puro (0–140) se repete
	var sw := 140.0 * DFArt.K
	var src := Vector2(140.0 * DFArt.IMPORT, seg.region.size.y)
	draw_set_transform(a, d.angle(), Vector2.ONE)
	var x := 0.0
	while x < L - h * 0.6:
		var w := minf(sw, L - x)
		draw_texture_rect_region(seg.atlas, Rect2(x, -h / 2.0, w, h), Rect2(seg.region.position, Vector2(src.x * w / sw, src.y)))
		x += sw
	draw_texture_rect(tip, Rect2(L - h * 200.0 / 256.0, -h / 2.0, h, h), false)     # garra de luz da v1
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
