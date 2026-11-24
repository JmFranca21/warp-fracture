class_name NvEnemy
extends Enemy
## Inimigos de Nivária (GL02 v2): Gelinho, Drone Gélido e Morcego-de-Cristal.
## Tamanhos de jogo (D = 400 px → 91 px): Gelinho 0,6 D de altura (~55 px), Drone 1,15 D de largura
## (~105 px), Morcego ~0,88 D de envergadura (~80 px). Arte: recortes da GL02 (placeholder do lote 2),
## todos com o mesmo fator da ficha para cada inimigo. O foco vermelho aponta para onde ele ataca.

var kind := "gelinho"            # gelinho, drone, morcego
var pid := ""
var patrol := Vector2.ZERO       # x mínimo e máximo da patrulha
var facing := -1
var state := "patrulha"
var st := 0.0
var cd := 0.0
var spr: Sprite2D
var k := 1.0
var home := Vector2.ZERO
var origin := Vector2.ZERO
var frost_touch := true          # encostar também deixa geada (player._check_hurt)
var breath: Area2D
var swoop_a := Vector2.ZERO
var swoop_b := Vector2.ZERO
var swoop_depth := 200.0


class Sphere extends Node2D:
	## Esfera de geada do Drone (GL02): lenta; no chão vira mancha de gelo escorregadio por 3 s.
	var vel := Vector2.ZERO
	var lvl
	var area: Area2D
	var life := 4.0

	func _ready() -> void:
		var s := NvArt.sprite("gl02_esfera", 30.0, "w", "centro")
		add_child(s)
		area = Nivaria.make_area(Rect2(-12, -8, 24, 16), self, "frost")
		area.set_meta("geada", 1)
		area.set_meta("owner", self)
		z_index = 6

	func _physics_process(dt: float) -> void:
		life -= dt
		vel.y = minf(vel.y + 260.0 * dt, 520.0)
		position += vel * dt
		rotation += dt * 6.0
		var q := PhysicsPointQueryParameters2D.new()
		q.position = position + Vector2(0, 8)
		q.collision_mask = 1
		if not get_world_2d().direct_space_state.intersect_point(q, 1).is_empty():
			if lvl.nivaria != null:
				lvl.nivaria.add_patch(_ground(position))
			Fx.burst(lvl.fx, position, Color(0.8, 0.92, 1.0), 8, 140, 0.3, 0.05, 200)
			queue_free()
		elif life <= 0.0:
			queue_free()

	func _ground(p: Vector2) -> Vector2:
		var q := PhysicsRayQueryParameters2D.create(p + Vector2(0, -20), p + Vector2(0, 60), 1)
		var r := get_world_2d().direct_space_state.intersect_ray(q)
		return r["position"] if not r.is_empty() else p

	func popped() -> void:
		queue_free()


func _ready() -> void:
	main_color = Color(0.75, 0.88, 1.0)
	origin = position
	home = position
	spr = Sprite2D.new()
	add_child(spr)
	match kind:
		"gelinho":
			hp = 2
			drops = 2
			setup_body(Vector2(40, 46))
			setup_hurt(Vector2(46, 46), Vector2(0, -24))
			k = NvArt.fit("gl02_gelinho", 55.0)
			breath = Nivaria.make_area(Rect2(20, -46, 100, 36), self, "frost")
			breath.set_meta("geada", 1)
			breath.collision_layer = 0
			_tex("gl02_gelinho")
		"drone":
			hp = 1
			drops = 2
			collision_layer = 0
			collision_mask = 0
			setup_hurt(Vector2(96, 36), Vector2(0, 0))
			k = NvArt.fit("gl02_drone", 105.0, "w")
			_tex("gl02_drone")
		"morcego":
			hp = 1
			drops = 1
			collision_layer = 0
			collision_mask = 0
			setup_hurt(Vector2(46, 34), Vector2(0, 14))
			k = NvArt.fit("gl02_morcego_voo", 80.0, "w")
			state = "teto"
			_tex("gl02_morcego_teto")
	max_hp = hp
	spr.scale = Vector2(k, k)


## Troca a peça mantendo o apoio: Gelinho pelos pés, Morcego preso ao teto, Drone pelo centro.
func _tex(id: String) -> void:
	spr.texture = NvArt.tex(id)
	var h := spr.texture.get_height()
	if kind == "gelinho":
		spr.offset = Vector2(0, -h / 2.0)
	elif kind == "morcego" and state == "teto":
		spr.offset = Vector2(0, h / 2.0)
	else:
		spr.offset = Vector2.ZERO


func _physics_process(dt: float) -> void:
	tick(dt)
	st += dt
	cd -= dt
	var p := player()
	match kind:
		"gelinho":
			_gelinho(dt, p)
		"drone":
			_drone(dt, p)
		"morcego":
			_morcego(dt, p)
	spr.flip_h = facing < 0
	spr.modulate = flash_mod()
	queue_redraw()


func _gelinho(dt: float, p: Player) -> void:
	velocity.y = minf(velocity.y + 2000.0 * dt, 900.0)
	if knock_t > 0.0:
		move_and_slide()
		return
	match state:
		"patrulha":
			velocity.x = facing * 70.0
			if position.x < patrol.x:
				facing = 1
			elif position.x > patrol.y:
				facing = -1
			elif is_on_wall() or not _floor_ahead():
				facing = -facing
			if p != null and cd <= 0.0 and absf(p.global_position.y - global_position.y) < 70.0:
				var dx := p.global_position.x - global_position.x
				if absf(dx) < 240.0 and (signf(dx) == facing or absf(dx) < 120.0):
					facing = int(signf(dx)) if dx != 0.0 else facing
					state = "aviso"
					st = 0.0
					_tex("gl02_gelinho_aviso")
		"aviso":
			velocity.x = 0.0
			if st >= 0.5:
				state = "sopro"
				st = 0.0
				_tex("gl02_gelinho_sopro")
				AudioMgr.sfx("esporo", global_position, -6.0, 0.1)
		"sopro":
			velocity.x = 0.0
			breath.position.x = 70.0 * facing      # o sopro sai pela boca, à frente
			breath.collision_layer = 16
			if st >= 0.6:
				breath.collision_layer = 0
				state = "patrulha"
				cd = 2.5
				_tex("gl02_gelinho")
	if stun > 0.0:
		velocity.x = 0.0
	move_and_slide()


func _floor_ahead() -> bool:
	var a := global_position + Vector2(facing * 26.0, -6.0)
	var q := PhysicsRayQueryParameters2D.create(a, a + Vector2(0, 40), 1)
	return not get_world_2d().direct_space_state.intersect_ray(q).is_empty()


func _drone(dt: float, p: Player) -> void:
	position.y = home.y + sin(t * 2.2) * 6.0
	match state:
		"patrulha":
			position.x += facing * 60.0 * dt
			if position.x < patrol.x:
				facing = 1
			elif position.x > patrol.y:
				facing = -1
			if p != null and cd <= 0.0:
				var d := p.global_position + Vector2(0, -40) - global_position
				if d.length() < 340.0 and d.y > -30.0:
					facing = int(signf(d.x)) if d.x != 0.0 else facing
					state = "mira"
					st = 0.0
					_tex("gl02_drone_mira")
					AudioMgr.sfx("drone_carrega", global_position, -6.0, 0.05)
		"mira":
			if st >= 0.6:
				var sp := Sphere.new()
				sp.lvl = level
				sp.position = global_position + Vector2(facing * 40.0, 6.0)
				var tgt := (p.global_position + Vector2(0, -30)) if p != null else sp.position + Vector2(facing * 100, 100)
				sp.vel = (tgt - sp.position).normalized() * 230.0
				level.add_fx(sp)
				AudioMgr.sfx("drone_tiro", global_position, -4.0, 0.08)
				state = "patrulha"
				cd = 2.6
				_tex("gl02_drone")


func _morcego(dt: float, p: Player) -> void:
	match state:
		"teto":
			if p != null and cd <= 0.0 and absf(p.global_position.x - position.x) < 90.0 \
					and p.global_position.y > position.y and p.global_position.y - position.y < 380.0:
				state = "rasante"
				st = 0.0
				var dir := signf(p.global_position.x - position.x)
				if dir == 0.0:
					dir = 1.0
				facing = int(dir)
				swoop_a = position
				swoop_b = Vector2(clampf(position.x + dir * 280.0, origin.x - 320.0, origin.x + 320.0), home.y)
				swoop_depth = clampf(p.global_position.y - 40.0 - position.y, 120.0, 300.0)
				_tex("gl02_morcego_voo")
				AudioMgr.sfx("esquiva", global_position, -6.0, 0.15)
		"rasante":
			var u := clampf(st / 1.1, 0.0, 1.0)
			position = swoop_a.lerp(swoop_b, u) + Vector2(0, sin(u * PI) * swoop_depth)
			if u >= 1.0:
				state = "teto"
				home = swoop_b
				position = home
				cd = 2.0
				_tex("gl02_morcego_teto")
	if state == "teto":
		position = home


func die() -> void:
	if dead:
		return
	if pid != "":
		level.main.collected[pid] = true
	super.die()


func _draw() -> void:
	draw_stun(Vector2(0, -60) if kind == "gelinho" else Vector2(0, -30))
