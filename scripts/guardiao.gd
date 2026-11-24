class_name Guardiao
extends Node2D
## Guardião Glacial (D08, GL03 v2, esquema GL03_esquema_arena_v2): 3,0 D (~273 px), o fragmento no
## peito atrás de três placas de gelo. Cada sequência termina na Investida: ele bate na parede e fica
## atordoado por 2 s. Um Pulso Térmico perto do peito derrete uma placa; o núcleo fica exposto por 3 s,
## tempo para 4 tiros. Fase 1 (3 placas): Investida + Estacas. Fase 2 (2): soma a Onda de Gelo.
## Fase 3 (1): chão escorregadio (Nivaria), 2 Gelinhos e ataques encadeados.
## Arte: frontal e poses recortadas da GL03 (placeholder até as folhas GL100–GL114 do lote 3).

const FLOOR_Y := -100.0
const X_MIN := 7780.0
const X_MAX := 8860.0
const H := 273.0
const CHEST := Vector2(6, -156)
const HITS := 4
const PLAN := {1: ["estacas", "investida"], 2: ["estacas", "onda", "investida"], 3: ["onda", "estacas", "onda", "investida"]}

var level: Level
var nv
var active := false
var dead := false
var phase := 1
var hp := 12
var max_hp := 12
var boss_name := "GUARDIÃO GLACIAL"
var stun := 99.0                  # nunca fere por contato pela meta "enemy" (o corpo tem área própria)
var act := ""
var act_t := 0.0
var next_t := 1.5
var step := 0
var facing := -1
var stunned := 0.0
var exposed := 0.0
var exp_hits := 0
var flash := 0.0
var t := 0.0
var spr: Sprite2D
var chest: Sprite2D
var body_hit: Area2D
var core_area: Area2D
var k_small := 1.0


class IceSpike extends Node2D:
	## Estaca de gelo (GL04): rachadura vermelha 0,45 s, sobe por 0,5 s, some.
	var st := 0.0
	var delay := 0.0
	var spr: Sprite2D
	var hit: Area2D

	func _ready() -> void:
		spr = NvArt.sprite("gl04_estaca0", 70.0, "w", "base")
		spr.visible = false
		add_child(spr)
		hit = Nivaria.make_area(Rect2(-16, -104, 32, 100), self)
		hit.collision_layer = 0
		z_index = 3

	func _physics_process(dt: float) -> void:
		st += dt
		var u := st - delay
		if u < 0.0:
			return
		spr.visible = true
		if u < 0.45:
			spr.texture = NvArt.tex("gl04_estaca0")
			spr.modulate.a = 0.6 + 0.4 * sin(u * 30.0)
		elif u < 0.95:
			if spr.texture != NvArt.tex("gl04_estaca2"):
				spr.texture = NvArt.tex("gl04_estaca2")
				spr.scale = Vector2.ONE * NvArt.fit("gl04_estaca2", 110.0)
				spr.offset = Vector2(0, -NvArt.tex("gl04_estaca2").get_height() / 2.0)
				spr.modulate.a = 1.0
				AudioMgr.sfx("plataforma_quebra", global_position, -6.0, 0.15)
			hit.collision_layer = 16
		else:
			hit.collision_layer = 0
			spr.modulate.a = maxf(0.0, 1.0 - (u - 0.95) * 3.0)
			if u > 1.35:
				queue_free()


class Wave extends Node2D:
	## Onda de Gelo: sopro rente ao chão (~60 px), congela na hora (+3 geadas).
	var dir := -1.0
	var hit: Area2D
	var t := 0.0

	func _ready() -> void:
		hit = Nivaria.make_area(Rect2(-34, -60, 68, 60), self, "frost")
		hit.set_meta("geada", 3)
		z_index = 6

	func _physics_process(dt: float) -> void:
		t += dt
		position.x += dir * 520.0 * dt
		if position.x < 7650.0 or position.x > 8990.0:
			queue_free()
		queue_redraw()

	func _draw() -> void:
		var pts := PackedVector2Array([Vector2(-40 * dir, 0)])
		for i in 9:
			var x := lerpf(-40.0 * dir, 36.0 * dir, i / 8.0)
			pts.append(Vector2(x, -(20.0 + 40.0 * sin(i / 8.0 * PI)) + sin(t * 30.0 + i) * 4.0))
		pts.append(Vector2(36 * dir, 0))
		draw_colored_polygon(pts, Color(0.75, 0.88, 1.0, 0.75))
		draw_polyline(pts, Color(0.95, 0.98, 1.0), 2.0, true)
		for i in 5:
			draw_circle(Vector2(randf_range(-40, 30) * dir, randf_range(-58, -4)), randf_range(1.5, 3.0), Color(1, 1, 1, 0.8))


func _ready() -> void:
	position = Vector2(8800, FLOOR_Y)
	spr = Sprite2D.new()
	add_child(spr)
	k_small = H / NvArt.tex("gl03_aviso").get_height()
	chest = NvArt.sprite("gl03_peito3", 112.0, "w", "centro")
	chest.position = CHEST
	add_child(chest)
	_pose("frontal")
	body_hit = Nivaria.make_area(Rect2(-88, -250, 176, 246), self)
	body_hit.collision_layer = 0
	core_area = Area2D.new()
	core_area.collision_layer = 4
	core_area.collision_mask = 0
	core_area.monitoring = false
	core_area.set_meta("enemy", self)
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = Vector2(170, 240)
	cs.shape = r
	cs.position = Vector2(0, -130)
	core_area.add_child(cs)
	add_child(core_area)
	z_index = 3
	if level.main.boss_done.has("nivaria"):
		dead = true
		_pose("derrota")
		chest.visible = false
		core_area.collision_layer = 0
		if not level.main.frags.has("nivaria"):
			_spawn_fragment()


func _pose(id: String) -> void:
	if id == "frontal":
		spr.texture = NvArt.tex("gl03_frontal")
		spr.scale = Vector2.ONE * (H / spr.texture.get_height())
	else:
		spr.texture = NvArt.tex("gl03_" + id)
		spr.scale = Vector2.ONE * k_small
	spr.offset = Vector2(0, -spr.texture.get_height() / 2.0)
	spr.position = Vector2.ZERO
	spr.flip_h = facing > 0 and id != "frontal"
	chest.visible = id in ["frontal", "atordoado"] and not dead


func start() -> void:
	if active or dead:
		return
	active = true
	level.boss = self
	level.boss_active = true
	level.boss_cam = Vector2(8320, -330)
	var cam: Camera2D = level.main.cam
	if cam != null:
		cam.create_tween().tween_property(cam, "zoom", Vector2(0.85, 0.85), 0.8)
	AudioMgr.music("chefe")
	level.main.add_shake(12.0)
	level.main.hud.show_title("GUARDIÃO GLACIAL", "O inverno de Nivária em volta do fragmento")
	next_t = 2.0


func _physics_process(dt: float) -> void:
	t += dt
	flash = maxf(0.0, flash - dt)
	var p: Player = level.player if is_instance_valid(level.player) and not level.player.dead else null
	if dead:
		return
	if not active:
		if p != null and p.global_position.x > 7800.0 and p.global_position.y < -40.0 and not level.main.transitioning:
			start()
		return
	if p == null:
		return
	# núcleo exposto (placa derretida pelo Pulso Térmico)
	if exposed > 0.0:
		exposed -= dt
		if exposed <= 0.0:
			exp_hits = 0
			chest.texture = NvArt.tex("gl03_peito%d" % (4 - phase))
			AudioMgr.sfx("rachadura", global_position + CHEST, -4.0, 0.0)
			level.main.hud.notice("A placa congelou de novo.")
	if stunned > 0.0:
		stunned -= dt
		spr.position.x = sin(t * 40.0) * 1.5 if stunned > 1.6 else 0.0
		if stunned <= 0.0 and exposed <= 0.0:
			_pose("frontal")
			next_t = 0.9
		return
	match act:
		"":
			facing = -1 if p.global_position.x < global_position.x else 1
			next_t -= dt
			if next_t <= 0.0:
				var plan: Array = PLAN[phase]
				act = plan[step % plan.size()]
				step += 1
				act_t = 0.0
				match act:
					"investida":
						_pose("frontal")
						body_hit.collision_layer = 0
					"estacas":
						_pose("estacas")
					"onda":
						_pose("onda")
		"investida":
			act_t += dt
			if act_t < 0.6:
				# aviso: bate os pés
				spr.position.y = -absf(sin(act_t * 16.0)) * 6.0
				if int(act_t * 10.0) % 3 == 0:
					level.main.add_shake(2.0)
			else:
				if spr.texture != NvArt.tex("gl03_investida"):
					_pose("investida")
					spr.position.y = 0.0
					body_hit.collision_layer = 16
					AudioMgr.sfx("arranque", global_position, 0.0, 0.0)
				position.x += facing * 640.0 * dt
				if position.x <= X_MIN or position.x >= X_MAX:
					position.x = clampf(position.x, X_MIN, X_MAX)
					_impact()
		"estacas":
			act_t += dt
			if act_t >= 0.5:
				var x := global_position.x + facing * 110.0
				var i := 0
				while x > 7660.0 and x < 8990.0 and i < 12:
					var s := IceSpike.new()
					s.position = Vector2(x, FLOOR_Y)
					s.delay = i * 0.12
					nv.add_child(s)
					x += facing * 70.0
					i += 1
				level.main.add_shake(8.0)
				AudioMgr.sfx("martelo", global_position, -2.0, 0.0)
				act = ""
				next_t = 1.5 if phase < 3 else 1.0
				_pose("frontal")
		"onda":
			act_t += dt
			if act_t >= 0.5:
				var w := Wave.new()
				w.dir = facing
				w.position = Vector2(global_position.x + facing * 120.0, FLOOR_Y)
				nv.add_child(w)
				AudioMgr.sfx("pulso", global_position, -2.0, 0.0)
				act = ""
				next_t = 1.3 if phase < 3 else 0.9
				_pose("frontal")
	spr.modulate = Color(2.2, 2.2, 2.2) if flash > 0.0 else Color(1, 1, 1)


func _impact() -> void:
	act = ""
	body_hit.collision_layer = 0
	stunned = 2.0
	_pose("atordoado")
	level.main.add_shake(14.0)
	level.main.hitstop(0.06)
	AudioMgr.sfx("desaba", global_position, 0.0, 0.0)
	Fx.burst(level.fx, global_position + Vector2(facing * 90.0, -120), Color(0.85, 0.93, 1.0), 26, 320, 0.6, 0.08, 300)
	nv.arena_impact(global_position.x)
	if not level.main.events.has("dica_guardiao"):
		level.main.events["dica_guardiao"] = true
		level.main.hud.notice("Atordoado! Chegue perto do peito e use o PULSO TÉRMICO para derreter uma placa.")


## Pulso Térmico (Nivaria.on_heat): perto do peito, durante o atordoamento, derrete uma placa.
func on_heat(c: Vector2, radius: float) -> void:
	if dead or not active or stunned <= 0.0 or exposed > 0.0:
		return
	if c.distance_to(global_position + CHEST) > radius + 70.0:
		return
	exposed = 3.0
	exp_hits = 0
	stunned = maxf(stunned, 3.0)        # fica no chão enquanto o núcleo está exposto
	chest.texture = NvArt.tex("gl03_peito0")
	AudioMgr.sfx("placas", global_position + CHEST, 0.0, 0.0)
	Fx.burst(level.fx, global_position + CHEST, Color(0.95, 0.7, 0.4), 24, 280, 0.6, 0.07, 200)


func take_hit(_dmg: int, from: Vector2) -> void:
	if dead or not active:
		return
	if exposed <= 0.0:
		AudioMgr.sfx("negado", from, -10.0, 0.1)
		Fx.burst(level.fx, from, Color(0.8, 0.9, 1.0), 4, 120, 0.2, 0.04)
		return
	exp_hits += 1
	hp -= 1
	flash = 0.1
	AudioMgr.sfx("acerto", from, -2.0, 0.1)
	Fx.burst(level.fx, from, Color(0.6, 0.95, 1.0), 10, 240, 0.3, 0.05)
	if exp_hits >= HITS:
		_plate_done()


func _plate_done() -> void:
	exposed = 0.0
	exp_hits = 0
	stunned = 0.4
	level.main.add_shake(12.0)
	level.main.hitstop(0.1)
	phase += 1
	hp = (4 - phase) * HITS
	if phase > 3:
		_defeat()
		return
	chest.texture = NvArt.tex("gl03_peito%d" % (4 - phase))
	step = 0
	if phase == 2:
		level.main.hud.notice("Uma placa a menos. O Guardião respira gelo: fuja da Onda pelo alto.")
	else:
		level.main.hud.notice("Última placa! O chão da arena congela.")
		for x in [7900.0, 8650.0]:
			var e := NvEnemy.new()
			e.level = level
			e.kind = "gelinho"
			e.position = Vector2(x, FLOOR_Y)
			e.patrol = Vector2(7700.0, 8950.0)
			level.entities.add_child.call_deferred(e)


func _defeat() -> void:
	dead = true
	active = false
	hp = 0
	body_hit.collision_layer = 0
	core_area.collision_layer = 0
	_pose("derrota")
	chest.visible = false
	level.boss_active = false
	level.boss_cam = Vector2.INF
	var cam: Camera2D = level.main.cam
	if cam != null:
		cam.create_tween().tween_property(cam, "zoom", Vector2(1.1, 1.1), 1.0)
	level.main.boss_done["nivaria"] = true
	AudioMgr.music("menu")
	AudioMgr.sfx("desaba", global_position, 0.0, 0.0)
	level.main.hud.notice("O gelo do Guardião se desfaz em neve...")
	Fx.burst(level.fx, global_position + Vector2(0, -140), Color(0.9, 0.95, 1.0), 50, 420, 1.0, 0.1, 200)
	for e in level.get_tree().get_nodes_in_group("enemies"):
		if e is NvEnemy and not e.dead and e.global_position.y < 0.0:
			e.die()
	await get_tree().create_timer(1.2, false).timeout
	_spawn_fragment()


func _spawn_fragment() -> void:
	var f := Fragment.new()
	f.main = level.main
	f.position = global_position + Vector2(0, -70)
	level.objects.add_child.call_deferred(f)
