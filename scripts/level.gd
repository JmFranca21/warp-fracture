class_name Level
extends Node2D
## Constrói uma fase a partir de LevelData.

var main
var id := ""
var data: Dictionary
var player: Player
var bg_layers: Array = []
var fg_layers: Array = []
var objects: Node2D
var entities: Node2D
var fx: Node2D
var door: Door = null
var portal: Portal = null
var gate: Gate = null
var boss: Queen = null
var boss_active := false


func _ready() -> void:
	var theme: String = data["theme"]
	var bounds: Rect2 = data["bounds"]
	_build_sky(theme)
	for i in 3:
		var b := BgLayer.new()
		b.theme = theme
		b.depth = [0.12, 0.3, 0.55][i]
		b.layer_index = i
		b.span = Vector2(-1600.0, bounds.end.x + 1600.0)
		b.z_index = -60 + i * 10
		add_child(b)
		bg_layers.append(b)
	_build_ambient(theme, bounds)

	if data.has("backwall"):
		var bw := BackWall.new()
		var d: Dictionary = data["backwall"]
		bw.spans = d.get("spans", [])
		bw.columns = d.get("columns", [])
		bw.breaches = d.get("breaches", [])
		bw.pipes = d.get("pipes", [])
		bw.drops = d.get("drops", [])
		for pl in data.get("platforms", []):
			if pl[0] == "movel" and pl.size() > 2:
				var r0: Rect2 = pl[1]
				var a := r0.position + Vector2(r0.size.x / 2.0, 40.0)
				var tv: Vector2 = pl[2]
				if absf(tv.y) > 1.0:
					a = r0.position + Vector2(r0.size.x / 2.0, 12.0)
				bw.rails.append([a - tv.normalized() * 30.0, a + tv + tv.normalized() * 30.0])
		add_child(bw)

	var terr := TerrainDraw.new()
	terr.theme = theme
	terr.rects = data["solids"]
	add_child(terr)
	for r in data["solids"]:
		_solid(r)
	if data.has("decor"):
		_build_decor(data["decor"])
	for r in data["hazards"]:
		var h := Hazard.new()
		h.theme = theme
		h.rect = r
		add_child(h)

	objects = Node2D.new()
	objects.z_index = 2
	add_child(objects)
	for s in data["signs"]:
		var sg := Sign.new()
		sg.main = main
		sg.theme = theme
		sg.text = s[1]
		sg.position = s[0]
		objects.add_child(sg)
	for c in data["checkpoints"]:
		var cp := Checkpoint.new()
		cp.main = main
		cp.theme = theme
		cp.position = c
		objects.add_child(cp)
	for tdata in data["terminals"]:
		var tm := Terminal.new()
		tm.main = main
		tm.level = self
		tm.tid = tdata[0]
		tm.position = tdata[1]
		objects.add_child(tm)
	if data.has("door"):
		door = Door.new()
		door.rect = data["door"]["rect"]
		objects.add_child(door)
		if _door_ready():
			door.open(true)
	if data.has("portal"):
		portal = Portal.new()
		portal.main = main
		portal.target = data["portal"]["target"]
		portal.position = data["portal"]["pos"]
		objects.add_child(portal)
	for pk in data["pickups"]:
		if main.collected.has(pk[2]):
			continue
		var p := Pickup.new()
		p.main = main
		p.kind = pk[0]
		p.pid = pk[2]
		p.position = pk[1]
		if pk.size() > 3:
			p.respawn = pk[3]
			p.pid = ""
		objects.add_child(p)

	for pl in data.get("platforms", []):
		var sp := SpritePlatform.new()
		sp.kind = pl[0]
		sp.rect = pl[1]
		if pl.size() > 2 and pl[2] is Vector2:
			sp.travel = pl[2]
		var opts: Dictionary = pl[pl.size() - 1] if pl[pl.size() - 1] is Dictionary else {}
		sp.hang_y = opts.get("hang", NAN)
		sp.sid = opts.get("sid", "")
		sp.period = opts.get("period", 4.0)
		sp.level = self
		add_child(sp)
	for lz in data.get("lasers", []):
		var lg := LaserGate.new()
		lg.level = self
		lg.position = Vector2(lz[0], 0)
		lg.phase = lz[1]
		objects.add_child(lg)

	for lv in data.get("levers", []):
		var l := Lever.new()
		l.main = main
		l.level = self
		l.position = lv[0]
		l.target = lv[1]
		l.hint = lv[2] if lv.size() > 2 else ""
		objects.add_child(l)
	for fd in data.get("fields", []):
		var f := EnergyField.new()
		f.sid = fd[0]
		f.rect = fd[1]
		objects.add_child(f)
	for lk in data.get("locks", []):
		var k := EnergyLock.new()
		k.main = main
		k.level = self
		k.position = lk[0]
		k.target = lk[1]
		objects.add_child(k)
	for bp in data.get("benches", []):
		var bn := Bench.new()
		bn.main = main
		bn.level = self
		bn.position = bp
		objects.add_child(bn)
	for hk in data.get("hooks", []):
		var gh := GrappleHook.new()
		gh.level = self
		gh.position = hk[0]
		gh.ceil_y = hk[1] if hk.size() > 1 else NAN
		objects.add_child(gh)
	for cm in data.get("cameras", []):
		var sc := SecurityCam.new()
		sc.level = self
		sc.position = cm[0]
		sc.side = cm[1]
		sc.spawns = cm[2]
		objects.add_child(sc)

	entities = Node2D.new()
	entities.z_index = 5
	add_child(entities)
	for e in data["enemies"]:
		spawn_enemy(e[0], e[1])
	for c in data.get("crates", []):
		var cr := Crate.new()
		cr.level = self
		cr.kind = c[0]
		cr.position = c[1]
		if c.size() > 2:
			cr.drop = c[2]
		entities.add_child(cr)
	if data.has("boss"):
		var bd: Dictionary = data["boss"]
		if main.boss_done.has(id):
			spawn_fragment()
		else:
			boss = Queen.new()
			boss.level = self
			boss.position = bd["pos"]
			entities.add_child(boss)

	fx = Node2D.new()
	fx.z_index = 8
	add_child(fx)

	var fg := FgLayer.new()
	fg.theme = theme
	fg.depth = 1.0
	fg.span = Vector2(-600.0, bounds.end.x + 900.0)
	fg.ground_rects = data["solids"]
	fg.z_index = 30
	add_child(fg)
	fg_layers.append(fg)


func add_player(p: Player) -> void:
	player = p
	entities.add_child(p)
	p.z_index = 1


func spawn_enemy(kind: String, pos: Vector2) -> Enemy:
	var e: Enemy
	match kind:
		"crawler":
			e = Crawler.new()
		"drone":
			e = Drone.new()
		"moth":
			e = Moth.new()
		"spore":
			e = SporePlant.new()
		"turret_l", "turret_r":
			var tu := Turret.new()
			tu.dir = -1 if kind == "turret_l" else 1
			e = tu
		_:
			return null
	e.level = self
	e.position = pos
	entities.add_child.call_deferred(e)
	return e


func drop_cell(pos: Vector2) -> void:
	var p := Pickup.new()
	p.main = main
	p.kind = "cell"
	p.dropped = true
	p.position = pos
	p.vel = Vector2(randf_range(-160, 160), randf_range(-380, -220))
	objects.add_child.call_deferred(p)


func add_fx(n: Node) -> void:
	fx.add_child.call_deferred(n)


func trigger(target: String) -> void:
	for n in get_tree().get_nodes_in_group("switchable"):
		if n.get("sid") == target and n.has_method("activate"):
			n.activate()


func _door_ready() -> bool:
	for n in data["door"]["needs"]:
		if not main.terminals.has(n):
			return false
	return true


func check_door() -> void:
	if door != null and not door.opened and _door_ready():
		door.open(false)
		main.add_shake(9.0)
		main.hud.notice("Porta de emergência destravada!")


func start_boss() -> void:
	if boss == null or boss_active or boss.dead:
		return
	boss_active = true
	gate = Gate.new()
	gate.rect = data["boss"]["gate"]
	objects.add_child(gate)
	boss.wake()
	main.add_shake(14.0)
	main.hud.show_title("RAINHA MICÉLIA", "Guardiã do Templo de Raízes")


func on_boss_dead() -> void:
	boss_active = false
	if gate != null:
		gate.open()
	main.boss_defeated()
	await get_tree().create_timer(1.2).timeout
	spawn_fragment()


func spawn_fragment() -> void:
	var f := Fragment.new()
	f.main = main
	f.position = data["boss"]["fragment"]
	objects.add_child.call_deferred(f)


func _physics_process(_dt: float) -> void:
	if boss != null and not boss_active and not boss.dead and is_instance_valid(player):
		if player.global_position.x > float(data["boss"]["trigger_x"]):
			start_boss()


func _process(_dt: float) -> void:
	var c := get_viewport().get_camera_2d()
	if c == null:
		return
	var cp := c.get_screen_center_position()
	for b in bg_layers:
		b.position = cp * (1.0 - b.depth)
	for f in fg_layers:
		f.position = Vector2(cp.x * (1.0 - f.depth), 0.0)


func _build_decor(list: Array) -> void:
	## [nome, posição, escala, espelhar, modo("chao"/"teto"/"centro"), brilho]
	var layer := Node2D.new()
	layer.z_index = -5
	add_child(layer)
	for d in list:
		var nm: String = d[0]
		var pos: Vector2 = d[1]
		var sc: float = d[2]
		var flip: bool = d[3] if d.size() > 3 else false
		var mode: String = d[4] if d.size() > 4 else "chao"
		var bright: float = d[5] if d.size() > 5 else 0.72
		var s: Sprite2D
		match mode:
			"teto":
				s = Props.hanging(nm, sc, flip)
			"centro":
				s = Props.centered(nm, sc, flip)
			_:
				s = Props.sprite(nm, sc, flip)
		s.position = pos
		s.modulate = Color(bright, bright, bright * 1.05)
		layer.add_child(s)
		match nm:
			"tanque":
				var g := Art.glow(Color(0.3, 0.85, 1.0, 0.3), 70 * sc)
				g.position = pos + Vector2(0, -70 * sc)
				layer.add_child(g)
			"alerta":
				var a := BlinkLight.new()
				a.position = pos + Vector2(0, -80 * sc)
				a.color = Color(1.0, 0.15, 0.1, 0.8)
				layer.add_child(a)
			"camera":
				var g2 := Art.glow(Color(1.0, 0.2, 0.15, 0.25), 30)
				g2.position = pos + Vector2((40 if not flip else -40) * sc, 45 * sc)
				layer.add_child(g2)


func _solid(r: Rect2) -> void:
	var sb := StaticBody2D.new()
	sb.collision_layer = 1
	sb.collision_mask = 0
	var cs := CollisionShape2D.new()
	var rs := RectangleShape2D.new()
	rs.size = r.size
	cs.shape = rs
	cs.position = r.get_center()
	sb.add_child(cs)
	add_child(sb)


func _build_sky(theme: String) -> void:
	var cl := CanvasLayer.new()
	cl.layer = -20
	add_child(cl)
	var tr := TextureRect.new()
	tr.set_anchors_preset(Control.PRESET_FULL_RECT)
	tr.stretch_mode = TextureRect.STRETCH_SCALE
	tr.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	var g := Gradient.new()
	if theme == "lab":
		g.set_color(0, Color("04070d"))
		g.set_color(1, Color("17263a"))
	else:
		g.set_color(0, Color("020a0e"))
		g.set_color(1, Color("10383a"))
	var gt := GradientTexture2D.new()
	gt.gradient = g
	gt.width = 4
	gt.height = 256
	gt.fill_from = Vector2(0, 0)
	gt.fill_to = Vector2(0, 1)
	tr.texture = gt
	cl.add_child(tr)


func _build_ambient(theme: String, b: Rect2) -> void:
	var cols: Array
	if theme == "lab":
		cols = [[Color(0.62, 0.45, 1.0, 0.8), 70], [Color(0.35, 0.85, 1.0, 0.6), 60]]
	else:
		cols = [[Color(0.85, 1.0, 0.45, 1.0), 140], [Color(0.4, 1.0, 0.85, 0.7), 80]]
	for cdat in cols:
		var p := CPUParticles2D.new()
		p.position = b.get_center()
		p.emission_shape = CPUParticles2D.EMISSION_SHAPE_RECTANGLE
		p.emission_rect_extents = b.size / 2.0
		p.amount = cdat[1]
		p.lifetime = 9.0
		p.preprocess = 9.0
		p.texture = Art.glow_tex()
		p.material = Art.add_mat()
		p.gravity = Vector2(0, -5)
		p.direction = Vector2(0, -1)
		p.spread = 180.0
		p.initial_velocity_min = 4.0
		p.initial_velocity_max = 22.0
		p.scale_amount_min = 0.03
		p.scale_amount_max = 0.1
		var c: Color = cdat[0]
		var g := Gradient.new()
		g.offsets = PackedFloat32Array([0.0, 0.2, 0.75, 1.0])
		g.colors = PackedColorArray([Color(c, 0), c, c, Color(c, 0)])
		p.color_ramp = g
		p.z_index = 3
		add_child(p)
