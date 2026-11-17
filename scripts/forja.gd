class_name Forja
extends Node2D
## Forja-Mãe (D04): IA da fábrica, fixa na parede da Câmara da Forja. O fragmento virou o núcleo dela.
## Montada em peças (lote 3): corpo DF100; atrás das aberturas, lente DF101, escotilhas DF107, peito DF102
## e grade DF108; dois braços-guindaste no trilho do teto (carrinho DF103, segmentos DF104, martelo DF105,
## núcleo do pistão DF106). Efeitos: feixe DF110, carga DF111, explosão de núcleo DF112.
## Fases: 1) pistão do braço esquerdo (6 rebites); 2) pistão do direito (6), esteira e drones;
##        3) núcleo central (8), aberto pelo Pulso Magnético perto do peito, com feixe e sobrecarga.

const BASE := Vector2(7770, 770)
const FLOOR_Y := 770.0
const RAIL_Y := 300.0             # trilho pendurado do teto (y 150) por tirantes
const PIVOT_Y := 360.0             # pivô do braço: 280 px do original abaixo das rodinhas
const SEG := 171.0                 # segmento: 800 px do original entre as juntas
const HOVER_Y := 560.0             # junta do martelo em repouso
const SLAM_Y := 698.0              # junta do martelo batido (face do martelo no chão)
const HAMMER_TOP := 35.0           # chapa do martelo começa 35 px abaixo da junta
const ROOM_X := Vector2(7050, 8490)
const BELT := Vector2(7470, 8070)
const CHEST := Vector2(7771, 634)
const LENS := Vector2(7770, 540)
const GRATE := Vector2(7770, 730)
const HATCH := [Vector2(7691.5, 556), Vector2(7848.5, 556)]
const CORE_HP := [6, 6, 8]

var level: Level
var desert
var boss_name := "FORJA-MÃE"
var active := false
var dead := false
var phase := 0                     # 0 = antes da luta; 1–3 fases; 4 = derrotada
var t := 0.0
var hp := 6
var max_hp := 6
# peças
var body: Sprite2D
var lens: Sprite2D
var chest: Sprite2D
var grate: AnimatedSprite2D
var hatches: Array = []
var arms: Array = []               # [Arm, Arm]
var chest_core: Core
var grate_area: Core
# ataques
var act := ""                      # ataque em curso
var act_t := 0.0
var next_t := 2.0
var turn := 0
var belt_on := 0.0                 # > 0: esteira ligada (s restantes)
var belt_warn := 0.0
var belt_dir := 1.0
var beam_x := -1.0
var beam_warn := 0.0
var lens_dark := 0.0
var chest_open := 0.0
var grate_open := 0.0
var drones_t := 6.0
var vent_clock := 0.0
var vents: Array = []
var belt_spr: Sprite2D
var drones: Array = []


class Core extends Node2D:
	## Ponto fraco que recebe rebites (o Bullet procura a meta "enemy" e chama take_hit).
	var forja
	var kind := ""               # "arm0", "arm1", "chest", "grate"
	var dead := false
	var stun := 99.0             # nunca fere por contato
	var area: Area2D
	var shape: CollisionShape2D

	func setup(r: float, box := Vector2.ZERO) -> void:
		area = Area2D.new()
		area.collision_layer = 0
		area.collision_mask = 0
		area.monitoring = false
		area.set_meta("enemy", self)
		shape = CollisionShape2D.new()
		if box != Vector2.ZERO:
			var rr := RectangleShape2D.new()
			rr.size = box
			shape.shape = rr
		else:
			var c := CircleShape2D.new()
			c.radius = r
			shape.shape = c
		area.add_child(shape)
		add_child(area)

	func set_on(on: bool) -> void:
		area.collision_layer = 4 if on else 0

	func take_hit(dmg: int, from: Vector2) -> void:
		forja.core_hit(self, dmg, from)


class Arm extends Node2D:
	## Braço-guindaste: carrinho no trilho, dois segmentos (IK de duas juntas) e o martelo.
	var forja
	var idx := 0
	var x := 7350.0
	var tx := 7350.0
	var jy := 560.0               # altura da junta do martelo
	var state := "idle"           # idle, track, warn, slam, stuck, recover, broken, fallen
	var st := 0.0
	var cart: Sprite2D
	var seg_a: Sprite2D
	var seg_b: Sprite2D
	var hammer: AnimatedSprite2D
	var core_spr: AnimatedSprite2D
	var core: Core
	var hook: GrappleHook
	var plat: StaticBody2D
	var plat_cs: CollisionShape2D
	var hit_done := false

	func build() -> void:
		seg_a = _seg()
		seg_b = _seg()
		var hf := SpriteFrames.new()
		DFArt.add_anim(hf, "st", "DF105", range(4), 1.0, false, 2, 2)
		hammer = AnimatedSprite2D.new()
		hammer.sprite_frames = hf
		hammer.offset = DFArt.offset(Vector2(1024, 512), Vector2(512, 96))
		hammer.scale = Vector2.ONE * DFArt.NODE
		hammer.animation = "st"
		add_child(hammer)
		var cf := SpriteFrames.new()
		DFArt.add_anim(cf, "st", "DF106", range(3), 1.0, false)
		core_spr = AnimatedSprite2D.new()
		core_spr.sprite_frames = cf
		core_spr.scale = Vector2.ONE * DFArt.NODE * 0.8
		core_spr.animation = "st"
		add_child(core_spr)
		cart = DFArt.sprite("DF103", Vector2(512, 120))
		add_child(cart)
		core = Core.new()
		core.forja = forja
		core.kind = "arm%d" % idx
		core.setup(0.0, Vector2(110, 40))     # junta exposta: de pé na chapa, o rebite acerta à queima-roupa
		add_child(core)
		hook = GrappleHook.new()
		hook.level = forja.level
		add_child(hook)
		hook.remove_from_group("hooks")
		hook.visible = false
		plat = StaticBody2D.new()
		plat.collision_layer = 256
		plat.collision_mask = 0
		plat_cs = CollisionShape2D.new()
		var r := RectangleShape2D.new()
		r.size = Vector2(112, 14)
		plat_cs.shape = r
		plat_cs.one_way_collision = true
		plat_cs.one_way_collision_margin = 10.0
		plat_cs.disabled = true
		plat.add_child(plat_cs)
		add_child(plat)

	func _seg() -> Sprite2D:
		var s := DFArt.sprite("DF104", Vector2(112, 256))
		add_child(s)
		return s

	func set_hook(on: bool) -> void:
		if on and not hook.is_in_group("hooks"):
			hook.add_to_group("hooks")
		elif not on and hook.is_in_group("hooks"):
			hook.remove_from_group("hooks")
		hook.visible = on

	func layout() -> void:
		var p := Vector2(x, PIVOT_Y)
		var h := Vector2(x, jy)
		cart.position = Vector2(x, RAIL_Y)
		# IK de duas juntas: o cotovelo dobra para fora da sala (para longe do corpo da Forja)
		var d := h - p
		var L := clampf(d.length(), 1.0, SEG * 2.0 - 1.0)
		var a := acos(clampf(L / (2.0 * SEG), -1.0, 1.0))
		var side := -1.0 if idx == 0 else 1.0
		var base := d.angle()
		var elbow := p + Vector2.from_angle(base - a * side) * SEG
		_place(seg_a, p, elbow)
		_place(seg_b, elbow, p + d.normalized() * L)
		hammer.position = h
		core_spr.position = h + Vector2(0, 14)
		core.position = h + Vector2(0, 10)
		hook.position = h + Vector2(0, -46)
		plat.position = h + Vector2(0, HAMMER_TOP + 7.0)

	func _place(s: Sprite2D, a: Vector2, b: Vector2) -> void:
		s.position = a
		s.rotation = (b - a).angle()
		s.scale = Vector2(DFArt.NODE * a.distance_to(b) / (800.0 * DFArt.K), DFArt.NODE)


func _ready() -> void:
	z_index = 1
	# interior escuro da fornalha, só atrás das aberturas do corpo (lente, escotilhas, peito e grade)
	for r in [Rect2(LENS - Vector2(26, 38), Vector2(52, 76)), Rect2(HATCH[0] - Vector2(22, 19), Vector2(44, 38)),
			Rect2(HATCH[1] - Vector2(22, 19), Vector2(44, 38)), Rect2(CHEST - Vector2(43, 42), Vector2(86, 84)),
			Rect2(GRATE - Vector2(58, 27), Vector2(116, 54))]:
		var back := ColorRect.new()
		back.position = r.position
		back.size = r.size
		back.color = Color("1c0e09")
		back.z_index = -9
		add_child(back)
	lens = Sprite2D.new()
	lens.texture = DFArt.cell("DF101", 0)
	lens.position = LENS
	lens.scale = Vector2.ONE * DFArt.NODE
	lens.z_index = -8
	add_child(lens)
	chest = Sprite2D.new()
	chest.texture = DFArt.cell("DF102", 0)
	chest.position = CHEST
	chest.scale = Vector2.ONE * DFArt.NODE * 1.05
	chest.z_index = -8
	add_child(chest)
	for hp_ in HATCH:
		var hs := Sprite2D.new()
		hs.texture = DFArt.cell("DF107", 0)
		hs.position = hp_
		hs.scale = Vector2.ONE * DFArt.NODE * 0.95
		hs.z_index = -8
		add_child(hs)
		hatches.append(hs)
	var gf := SpriteFrames.new()
	DFArt.add_anim(gf, "fogo", "DF108", range(6), 9.0, true)
	DFArt.add_anim(gf, "aberta", "DF108", [6], 1.0, false)
	DFArt.add_anim(gf, "fria", "DF108", [7], 1.0, false)
	grate = AnimatedSprite2D.new()
	grate.sprite_frames = gf
	grate.position = GRATE
	grate.scale = Vector2.ONE * DFArt.NODE * 1.55
	grate.z_index = -8
	add_child(grate)
	grate.play("fogo")
	body = DFArt.sprite("DF100", Vector2(1024, 2008))
	body.position = BASE
	body.z_index = -7
	add_child(body)
	var rail := Sprite2D.new()
	rail.texture = Desert.texture("DF55b")
	rail.centered = false
	rail.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	rail.region_enabled = true
	rail.region_rect = Rect2(0, 0, 1400 / 0.3, 16 / 0.25)
	rail.scale = Vector2(0.3, 0.25)
	rail.position = Vector2(7070, RAIL_Y - 8)
	rail.z_index = 2
	add_child(rail)
	for hx in [7110.0, 7560.0, 7980.0, 8430.0]:     # tirantes do trilho até o teto
		var rod := ColorRect.new()
		rod.position = Vector2(hx - 3, 150)
		rod.size = Vector2(6, RAIL_Y - 158)
		rod.color = Color("3a2418")
		rod.z_index = 1
		add_child(rod)
	belt_spr = Sprite2D.new()
	belt_spr.texture = Desert.texture("DF26")
	belt_spr.centered = false
	belt_spr.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	belt_spr.region_enabled = true
	belt_spr.region_rect = Rect2(0, 0, (BELT.y - BELT.x) / 0.62, 60 / 0.625)
	belt_spr.scale = Vector2(0.62, 0.625)
	belt_spr.position = Vector2(BELT.x, FLOOR_Y)
	belt_spr.z_index = 1
	add_child(belt_spr)
	for i in 2:
		var a := Arm.new()
		a.forja = self
		a.idx = i
		a.x = 7350.0 if i == 0 else 8190.0
		a.tx = a.x
		a.z_index = 3
		add_child(a)
		a.build()
		a.layout()
		a.core.set_on(false)
		arms.append(a)
	chest_core = Core.new()
	chest_core.forja = self
	chest_core.kind = "chest"
	chest_core.position = CHEST
	chest_core.setup(30.0)
	add_child(chest_core)
	grate_area = Core.new()
	grate_area.forja = self
	grate_area.kind = "grate"
	grate_area.position = GRATE
	grate_area.setup(34.0)
	add_child(grate_area)
	for x in [7110.0, 8430.0]:
		var r := Rect2(x - 36, FLOOR_Y - 11, 72, 12)
		desert.prop("DF56_inativa", r)
		var lamp: Sprite2D = desert.prop("DF56_aviso", r, 1)
		var jet := Desert.effect(self, "DF81", 8, Vector2(x, FLOOR_Y - 77), Vector2(85, 150), true)
		vents.append([lamp, jet, x])
		lamp.visible = false
		jet.visible = false
	if level.main.boss_done.has("deserto"):
		_set_defeated(false)


func start() -> void:
	if active or dead:
		return
	active = true
	phase = 1
	hp = CORE_HP[0]
	max_hp = hp
	level.boss = self
	level.boss_active = true
	level.boss_cam = Vector2(7770, 420)
	var cam: Camera2D = level.main.cam
	if cam != null:
		var tw := cam.create_tween()
		tw.tween_property(cam, "zoom", Vector2(0.85, 0.85), 0.8)
	desert.set_door("in", false)
	AudioMgr.sfx("porta", Vector2(7020, 700), 0.0, 0.0)
	AudioMgr.music("chefe")
	level.main.add_shake(12.0)
	var first: bool = not level.main.events.has("forja_intro")
	level.main.events["forja_intro"] = true
	level.main.hud.show_title("FORJA-MÃE", "IA da fábrica autônoma")
	next_t = 2.0 if first else 0.8
	lens.texture = DFArt.cell("DF101", 0)
	arms[0].core.set_on(false)


func _physics_process(dt: float) -> void:
	t += dt
	var p: Player = level.player
	if not active:
		if not dead and is_instance_valid(p) and p.global_position.x > 7110.0 and not level.main.transitioning:
			start()
		_layout_arms(dt)
		return
	if dead or not is_instance_valid(p):
		return
	lens_dark -= dt
	chest_open -= dt
	grate_open -= dt
	_update_belt(dt, p)
	_update_vents(dt, p)
	_update_arms(dt, p)
	_update_beam(dt, p)
	_update_drones(dt)
	grate_area.set_on(grate_open > 0.0)
	if grate_open <= 0.0 and grate.animation == "aberta":
		grate.play("fogo")
	chest_core.set_on(phase == 3 and chest_open > 0.0)
	if phase == 3:
		chest.texture = DFArt.cell("DF102", (1 if hp > 4 else 2) if chest_open > 0.0 else 0)
	if lens_dark <= 0.0 and act != "beam" and act != "volley":
		lens.texture = DFArt.cell("DF101", 0)
	# escolhe o próximo ataque
	next_t -= dt
	if act == "" and next_t <= 0.0:
		_next_attack()
	if act == "volley":
		act_t -= dt
		if act_t <= 0.0:
			_fire_volley()
			act = ""
			next_t = 1.4
	queue_redraw()


func _next_attack() -> void:
	turn += 1
	match phase:
		1:
			if turn % 3 == 0:
				_start_volley()
			else:
				_start_hammer(arms[0], 0.7)
		2:
			if turn % 4 == 0:
				_start_volley()
			elif turn % 4 == 2 and belt_on <= 0.0:
				belt_warn = 1.0
				belt_dir = -1.0 if randf() < 0.5 else 1.0
				next_t = 1.2
				AudioMgr.sfx("esteira", Vector2(7770, 760), -3.0, 0.0)
			else:
				_start_hammer(arms[1], 0.55)
		3:
			if turn % 3 == 1:
				_start_beam()
			elif turn % 3 == 2:
				_start_volley()
			else:
				belt_warn = 1.0
				belt_dir = -1.0 if randf() < 0.5 else 1.0
				next_t = 2.0
				AudioMgr.sfx("esteira", Vector2(7770, 760), -3.0, 0.0)


# ---------------------------------------------------------------- martelo
func _start_hammer(a: Arm, warn: float) -> void:
	if a.state in ["broken", "fallen"]:
		next_t = 0.5
		return
	act = "hammer"
	a.state = "track"
	a.st = 0.6
	a.set_meta("warn", warn)
	AudioMgr.sfx("trilho", Vector2(a.x, RAIL_Y), -4.0, 0.05)


func _update_arms(dt: float, p: Player) -> void:
	for a: Arm in arms:
		a.st -= dt
		match a.state:
			"idle":
				a.jy = move_toward(a.jy, HOVER_Y, 200.0 * dt)
			"track":
				a.tx = clampf(p.global_position.x, ROOM_X.x + 80.0, ROOM_X.y - 80.0)
				a.x = move_toward(a.x, a.tx, 900.0 * dt)
				if randf() < 0.4:
					Desert.effect(level.fx, "DF82", 6, Vector2(a.x, RAIL_Y + 6), Vector2(40, 30))
				if a.st <= 0.0:
					a.state = "warn"
					a.st = float(a.get_meta("warn"))
					a.hammer.frame = 1
					AudioMgr.sfx("martelo_carga", Vector2(a.x, HOVER_Y), -2.0, 0.0)
			"warn":
				a.jy = move_toward(a.jy, HOVER_Y - 40.0, 300.0 * dt)
				if a.st <= 0.0:
					a.state = "slam"
					a.st = 0.15
					a.hit_done = false
			"slam":
				a.jy = move_toward(a.jy, SLAM_Y, 1100.0 * dt)
				_hammer_hurt(a, p)
				if a.jy >= SLAM_Y - 0.5 and not a.hit_done:
					a.hit_done = true
					a.state = "stuck"
					a.st = 1.6
					a.hammer.frame = 2
					a.core.set_on(true)
					a.set_hook(true)
					a.plat_cs.set_deferred("disabled", false)
					level.main.add_shake(12.0)
					AudioMgr.sfx("martelo", Vector2(a.x, FLOOR_Y), 0.0, 0.05)
					Desert.effect(level.fx, "DF82", 6, Vector2(a.x, FLOOR_Y - 31), Vector2(150, 90))
					# onda no chão: 40 px de cada lado
					if p.is_on_floor() and absf(p.global_position.x - a.x) < 60.0 + 40.0 and p.dash_t <= 0.0:
						p.hurt(Vector2(a.x, FLOOR_Y), 1)
			"stuck":
				if a.st <= 0.0:
					a.state = "recover"
					a.st = 0.5
					a.hammer.frame = 0
					a.core.set_on(false)
					a.set_hook(false)
					a.plat_cs.set_deferred("disabled", true)
					if p.hook != null and p.hook == a.hook:
						p.hook = null
					act = ""
					next_t = 1.0 if phase == 1 else 0.7
			"recover":
				a.jy = move_toward(a.jy, HOVER_Y, 280.0 * dt)
				if a.st <= 0.0 and absf(a.jy - HOVER_Y) < 1.0:
					a.state = "idle"
			"broken":
				a.jy = move_toward(a.jy, SLAM_Y, 600.0 * dt)
		a.layout()


func _layout_arms(_dt: float) -> void:
	for a: Arm in arms:
		a.layout()


func _hammer_hurt(a: Arm, p: Player) -> void:
	var face := a.jy + 72.0
	var r := Rect2(a.x - 60.0, face - 40.0, 120.0, 40.0)
	var pr := Rect2(p.global_position + Vector2(-15, -62), Vector2(30, 62))
	if r.intersects(pr) and p.dash_t <= 0.0:
		p.hurt(Vector2(a.x, face), 1)


# ---------------------------------------------------------------- rajada de rebites
func _start_volley() -> void:
	act = "volley"
	act_t = 0.5
	lens.texture = DFArt.cell("DF101", 1)
	AudioMgr.sfx("turreta_carrega", LENS, -2.0, 0.0)


func _fire_volley() -> void:
	grate.play("aberta")
	grate_open = 0.8
	AudioMgr.sfx("rebite", GRATE, 2.0, 0.0)
	var p: Player = level.player
	var dir := -1.0 if is_instance_valid(p) and p.global_position.x < BASE.x else 1.0
	for i in 3:
		var shot := DesertEnemy.DesertShot.new()
		shot.drone = false
		var high := i == 1
		shot.vel = Vector2(dir * (300.0 + i * 30.0), 0)
		shot.position = Vector2(BASE.x + dir * 70.0 - dir * i * 46.0, FLOOR_Y - (52.0 if high else 16.0))
		level.fx.add_child(shot)


# ---------------------------------------------------------------- esteira
func _update_belt(dt: float, p: Player) -> void:
	if belt_warn > 0.0:
		belt_warn -= dt
		if belt_warn <= 0.0:
			belt_on = 4.5
	if belt_on > 0.0:
		belt_on -= dt
		belt_spr.region_rect.position.x -= dt * 140.0 * belt_dir * (-1.0 if p.global_position.x < BASE.x else 1.0)
		var x := p.global_position.x
		if p.is_on_floor() and x > BELT.x and x < BELT.y and absf(p.global_position.y - FLOOR_Y) < 6.0:
			p.move_and_collide(Vector2(signf(BASE.x - x) * 120.0 * dt, 0))
			# a grade da fornalha fere quem a esteira leva até ela
			if absf(x - BASE.x) < 50.0 and p.dash_t <= 0.0:
				p.hurt(Vector2(BASE.x, FLOOR_Y), 1)


# ---------------------------------------------------------------- válvulas (sobrecarga, fase 3)
func _update_vents(dt: float, p: Player) -> void:
	if phase != 3:
		return
	vent_clock += dt
	for i in vents.size():
		var v: Array = vents[i]
		var ph := fmod(vent_clock + i * 1.8, 3.6)
		v[0].visible = ph >= 1.45 and ph < 2.15
		v[1].visible = ph >= 2.15 and ph < 2.95
		v[1].pause()
		v[1].frame = clampi(int((ph - 2.15) * 10), 0, 7)
		if v[1].visible and v[1].frame in [2, 3, 4, 5]:
			if absf(p.global_position.x - float(v[2])) < 26.0 and p.global_position.y > FLOOR_Y - 140.0 and p.dash_t <= 0.0:
				p.hurt(Vector2(v[2], FLOOR_Y), 1)


# ---------------------------------------------------------------- feixe da lente (fase 3)
func _start_beam() -> void:
	act = "beam"
	beam_warn = 1.0
	beam_x = -1.0
	DFArt.fx(level.fx, "DF111", 6, LENS, 6.0, false)
	lens.texture = DFArt.cell("DF101", 2)
	AudioMgr.sfx("feixe_carga", LENS, -1.0, 0.0)


func _update_beam(dt: float, p: Player) -> void:
	if act != "beam":
		return
	if beam_warn > 0.0:
		beam_warn -= dt
		if beam_warn <= 0.0:
			beam_x = ROOM_X.y - 30.0
			AudioMgr.sfx("turreta_feixe", LENS, 2.0, 0.0)
		return
	beam_x -= 1000.0 * dt
	if randf() < 0.5:
		# ponto de impacto no chão (faixa de baixo da DF110; contato em x 128, y 480 da célula)
		DFArt.fx(level.fx, "DF110", 4, Vector2(beam_x, FLOOR_Y - 12.0), 20.0, false, 0.6, 4)
	var pr := Rect2(p.global_position + Vector2(-15, -62), Vector2(30, 62))
	if pr.has_point(Vector2(beam_x, FLOOR_Y - 20.0)) and p.dash_t <= 0.0:
		p.hurt(Vector2(beam_x, FLOOR_Y), 1)
	if beam_x < ROOM_X.x + 30.0:
		beam_x = -1.0
		act = ""
		lens_dark = 1.0
		lens.texture = DFArt.cell("DF101", 3)
		next_t = 1.6


# ---------------------------------------------------------------- drones (fase 2)
func _update_drones(dt: float) -> void:
	if phase != 2:
		return
	drones = drones.filter(func(d): return is_instance_valid(d) and not d.dead)
	drones_t -= dt
	if drones_t <= 1.0 and drones_t + dt > 1.0 and drones.size() < 2:
		for h in hatches:
			h.texture = DFArt.cell("DF107", 1)
		AudioMgr.sfx("alarme", HATCH[0], -8.0, 0.0)
	if drones_t <= 0.0:
		drones_t = 10.0
		if drones.size() >= 2:
			for h in hatches:
				h.texture = DFArt.cell("DF107", 0)
			return
		for i in 2:
			hatches[i].texture = DFArt.cell("DF107", 3)
			var d := DesertEnemy.new()
			d.level = level
			d.drone = true
			d.drops = 0
			var x0 := 7250.0 if i == 0 else 8090.0
			d.patrol = Vector2(x0 - 140.0, x0 + 140.0)
			d.position = HATCH[i]
			d.altitude = 470.0
			level.entities.add_child.call_deferred(d)
			drones.append(d)
			var tw := create_tween()
			tw.tween_interval(1.2)
			var hs: Sprite2D = hatches[i]
			tw.tween_callback(func(): hs.texture = DFArt.cell("DF107", 0))


# ---------------------------------------------------------------- dano nos núcleos
func core_hit(c: Core, dmg: int, from: Vector2) -> void:
	if dead or not active:
		return
	var target := ""
	match phase:
		1:
			target = "arm0"
		2:
			target = "arm1"
		3:
			target = "chest"
	if c.kind == "grate":
		dmg *= 2                 # grade aberta: o dobro de dano no núcleo da fase
	elif c.kind != target:
		return
	hp -= dmg
	AudioMgr.sfx("acerto", from, -2.0, 0.1)
	Fx.burst(level.fx, from, Color(1.0, 0.7, 0.3), 10, 240, 0.3, 0.05)
	if phase < 3:
		arms[phase - 1].core_spr.frame = 0 if hp * 2 > max_hp else 1
	if hp <= 0:
		_core_destroyed()


func _core_destroyed() -> void:
	level.main.add_shake(16.0)
	level.main.hitstop(0.12)
	AudioMgr.sfx("explosao", Vector2(7770, 600), 0.0, 0.0)
	if phase < 3:
		var a: Arm = arms[phase - 1]
		DFArt.fx(level.fx, "DF112", 8, a.core.global_position, 16.0)
		a.core_spr.frame = 2
		a.hammer.frame = 3
		a.state = "broken"
		a.core.set_on(false)
		a.set_hook(false)
		a.plat_cs.set_deferred("disabled", false)    # o martelo caído vira degrau
		act = ""
		phase += 1
		hp = CORE_HP[phase - 1]
		max_hp = hp
		next_t = 2.0
		if phase == 2:
			level.main.hud.notice("O braço esquerdo cede... a fábrica acelera.")
			drones_t = 4.0
		else:
			# fase 3: os braços caem; as placas do peito só abrem com o Pulso Magnético
			for b: Arm in arms:
				b.state = "broken"
				b.hammer.frame = 3
				b.core_spr.frame = 2
				b.plat_cs.set_deferred("disabled", false)
			for v in vents:
				v[0].visible = true
			level.main.hud.notice("Sobrecarga! As placas do peito são magnéticas: use o PULSO perto delas.")
			AudioMgr.sfx("alarme", BASE, -2.0, 0.0)
		return
	DFArt.fx(level.fx, "DF112", 8, CHEST, 16.0, false, 1.4)
	_set_defeated(true)


## Pulso Magnético perto do peito (fase 3): as placas voam por 3 s e o fragmento fica exposto.
func on_pulse(c: Vector2) -> void:
	if phase != 3 or dead or chest_open > 0.0:
		return
	if c.distance_to(CHEST) > 150.0 + 10.0:
		return
	chest_open = 3.0
	AudioMgr.sfx("placas", CHEST, 0.0, 0.0)
	for i in 3:
		var pl := Sprite2D.new()
		pl.texture = DFArt.cell("DF102", 3 + i)
		pl.position = CHEST + Vector2((i - 1) * 26.0, 0)
		pl.scale = Vector2.ONE * DFArt.NODE
		pl.z_index = 4
		add_child(pl)
		var tw := pl.create_tween()
		tw.set_parallel(true)
		tw.tween_property(pl, "position", pl.position + Vector2((i - 1) * 140.0 + randf_range(-30, 30), -160.0 + i * 20.0), 0.5).set_ease(Tween.EASE_OUT)
		tw.tween_property(pl, "rotation", randf_range(-3.0, 3.0), 0.5)
		tw.chain().tween_property(pl, "position:y", FLOOR_Y - 10.0, 0.5).set_ease(Tween.EASE_IN)
		tw.chain().tween_interval(1.4)
		tw.chain().tween_property(pl, "modulate:a", 0.0, 0.4)
		tw.chain().tween_callback(pl.queue_free)


func _set_defeated(animated: bool) -> void:
	dead = true
	active = false
	phase = 4
	act = ""
	beam_x = -1.0
	belt_on = 0.0
	belt_warn = 0.0
	lens.texture = DFArt.cell("DF101", 3)
	grate.play("fria")
	chest.texture = DFArt.cell("DF102", 1)
	for a: Arm in arms:
		a.state = "broken"
		a.jy = SLAM_Y
		a.hammer.frame = 3
		a.core_spr.frame = 2
		a.core.set_on(false)
		a.set_hook(false)
		a.plat_cs.set_deferred("disabled", false)
		a.layout()
	for v in vents:
		v[0].visible = false
		v[1].visible = false
	chest_core.set_on(false)
	grate_area.set_on(false)
	for d in drones:
		if is_instance_valid(d) and not d.dead:
			d.die()
	if level.boss == self:
		level.boss_active = false
		level.boss_cam = Vector2.INF
	var cam: Camera2D = level.main.cam
	if cam != null:
		var tw := cam.create_tween()
		tw.tween_property(cam, "zoom", Vector2(1.1, 1.1), 1.0)
	if not animated:
		if not level.main.frags.has("deserto"):
			_spawn_fragment()
		chest.visible = false
		return
	level.main.boss_done["deserto"] = true
	AudioMgr.music("deserto")
	level.main.hud.notice("A lente da Forja-Mãe se apaga...")
	for a: Arm in arms:
		Desert.effect(level.fx, "DF84", 8, Vector2(a.x, SLAM_Y), Vector2(130, 135))
	await get_tree().create_timer(1.3, false).timeout
	_spawn_fragment()


## O fragmento 2/4 sobe da câmara do peito.
func _spawn_fragment() -> void:
	chest.visible = false             # o cristal deixa a câmara do peito vazia
	var f := Fragment.new()
	f.main = level.main
	f.position = CHEST + Vector2(0, -6)
	level.objects.add_child.call_deferred(f)


## Atalho de teste (killboss): destrói o núcleo da fase atual.
func take_hit(_dmg: int, _from: Vector2) -> void:
	if active and not dead:
		hp = 0
		_core_destroyed()


# ---------------------------------------------------------------- desenho (sinais feitos por código)
func _draw() -> void:
	if not active:
		return
	# marca tracejada do martelo no chão
	for a: Arm in arms:
		if a.state in ["track", "warn"]:
			var k := 0.45 + 0.45 * absf(sin(t * (10.0 if a.state == "warn" else 5.0)))
			var x0 := a.x - 60.0
			var i := 0
			while i * 14.0 < 120.0:
				draw_rect(Rect2(x0 + i * 14.0, FLOOR_Y - 5.0, 8.0, 5.0), Color(1.0, 0.22, 0.2, k))
				i += 1
	# setas da esteira
	if belt_warn > 0.0 or belt_on > 0.0:
		var n := 12
		for i in n:
			var x := BELT.x + (BELT.y - BELT.x) * (i + 0.5) / n
			var to_c := signf(BASE.x - x)
			var lit := belt_on > 0.0 or int((1.0 - belt_warn) * 12.0) % n >= (i if to_c > 0 else n - 1 - i)
			var c := Color(1.0, 0.75, 0.25, 0.85 if lit else 0.25)
			var y := FLOOR_Y + 8.0
			draw_colored_polygon(PackedVector2Array([Vector2(x - 6 * to_c, y - 6), Vector2(x + 6 * to_c, y), Vector2(x - 6 * to_c, y + 6)]), c)
	# mira do feixe: linha fina varrendo o chão
	if act == "beam" and beam_warn > 0.0:
		var sx := lerpf(ROOM_X.y - 30.0, ROOM_X.x + 30.0, 1.0 - beam_warn)
		draw_line(LENS, Vector2(sx, FLOOR_Y - 20.0), Color(1.0, 0.25, 0.2, 0.55), 1.5, true)
	if beam_x > 0.0:
		var a := LENS
		var b := Vector2(beam_x, FLOOR_Y - 20.0)
		draw_line(a, b, Color(1.0, 0.35, 0.25, 0.35), 14.0, true)
		draw_line(a, b, Color(1.0, 0.8, 0.6, 0.95), 4.0, true)
	# fragmento visível pelo peito aberto
	if chest_open > 0.0:
		draw_circle(CHEST, 26.0 + 3.0 * sin(t * 8.0), Color(0.55, 1.0, 0.95, 0.22))
