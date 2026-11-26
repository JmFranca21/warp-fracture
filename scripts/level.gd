class_name Level
extends Node2D
## Uma fase. O Laboratório, Verdâmia e o Deserto vêm prontos em cena (scenes/fases/*.tscn, com montada = true): os
## nós já estão lá, e preparar() aplica o estado do jogo antes de a cena entrar na árvore. Nivária tem a cena própria
## (fases/nivaria.tscn, do Caio) e é montada pelo _build a partir de LevelData.

# dados da fase guardados na cena (LevelData.get_level lê daqui, por descrever())
@export var montada := false               # true nas cenas: o _ready não monta nada pelo código
@export var nome := ""
@export var subtitulo := ""
@export var tema := ""
@export var forma := "human"
@export var limites := Rect2()
@export var kill_y := 1300.0
@export var salas: Array = []              # [id, retângulo, nome] das salas do mapa
@export var porta_requer: Array = []       # terminais que destravam a porta
@export var chefe: Dictionary = {}         # trigger_x, gate e fragment da luta (a Rainha é o nó RainhaMicelia)

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
var boss = null                 # Queen (Verdâmia) ou Forja (Deserto)
var boss_active := false
var fuga: Fuga = null
var receptacle: Receptacle = null
var return_rift: Rift = null
var arrival_rift: Rift = null
var boss_cam := Vector2.INF       # centro fixo da câmera durante a luta (INF = segue o jogador)
var desert: Desert = null
var nivaria: Nivaria = null


func _ready() -> void:
	if montada:
		_ready_cena()
		return
	_build()


## Monta a fase pelo código, a partir de data (Deserto e Nivária; também gera as cenas, em tools/gerar_cenas_fases.gd).
func _build() -> void:
	var theme: String = data["theme"]
	var bounds: Rect2 = data["bounds"]
	_build_sky(theme)
	var own_art: bool = theme in ["deserto", "nivaria"]      # fases que desenham o próprio cenário
	if theme == "verd":
		_build_verd_bg(bounds)
	elif not own_art:
		for i in 3:
			var b := BgLayer.new()
			b.theme = theme
			b.depth = [0.12, 0.3, 0.55][i]
			b.layer_index = i
			b.span = Vector2(-1600.0, bounds.end.x + 1600.0)
			b.z_index = -60 + i * 10
			add_child(b)
			bg_layers.append(b)
	if not own_art:
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
	terr.thin_art = data.get("thin_art", [])
	if own_art:
		terr.free()          # Deserto e Nivária desenham o próprio terreno
	else:
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
	if data.has("receptacle"):
		receptacle = Receptacle.new()
		receptacle.main = main
		receptacle.position = data["receptacle"]
		receptacle.portal_x = portal.position.x if portal != null else 0.0
		objects.add_child(receptacle)
	if data.has("arrival_rift"):
		arrival_rift = Rift.new()
		arrival_rift.main = main
		arrival_rift.target = "lab"
		arrival_rift.position = data["arrival_rift"]
		objects.add_child(arrival_rift)
	if data.has("return_rift") and main.frags.has(id):
		open_return_rift(false)
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
			if not main.frags.has(id):   # Rainha vencida, mas o fragmento ainda não foi pego
				spawn_fragment()
		else:
			boss = Queen.new()
			boss.level = self
			boss.position = bd["pos"]
			entities.add_child(boss)

	fx = Node2D.new()
	fx.z_index = 8
	add_child(fx)

	if data.has("fuga") and not main.events.has("fuga_" + id):
		fuga = Fuga.new()
		fuga.level = self
		fuga.main = main
		fuga.cfg = data["fuga"]
		add_child(fuga)

	if theme == "deserto":
		desert = Desert.new()
		desert.level = self
		add_child(desert)
		return
	if theme == "nivaria":
		var niv: Nivaria = load(Nivaria.SCENE_PATH).instantiate()     # layout editável em fases/nivaria.tscn
		niv.level = self
		nivaria = niv
		add_child(niv)
		return

	var fg := FgLayer.new()
	fg.theme = theme
	fg.depth = 1.0
	fg.span = Vector2(-600.0, bounds.end.x + 900.0)
	fg.ground_rects = data["solids"]
	fg.clear = data.get("fg_clear", [])
	if theme == "verd":
		fg.depth = 1.2
		fg.base_y = bounds.end.y + 40.0
		fg.span = Vector2(-400.0, bounds.end.x * 1.2 + 900.0)
	fg.z_index = 30
	add_child(fg)
	fg_layers.append(fg)


## Fenda de retorno ao Hélix, aberta pela energia do fragmento (D02 passo 2).
func open_return_rift(animated: bool) -> void:
	if return_rift != null or not data.has("return_rift"):
		return
	return_rift = Rift.new()
	return_rift.main = main
	return_rift.target = "lab"
	return_rift.position = data["return_rift"]
	objects.add_child(return_rift)
	if animated:
		return_rift.open_anim()
		main.add_shake(8.0)
	else:
		return_rift.open_now()
	if desert != null:
		desert.on_fragment_taken()


func add_player(p: Player) -> void:
	player = p
	entities.add_child(p)
	p.z_index = 1
	if montada:      # como na montagem pelo código: o jogador entra antes dos inimigos (que chegam adiados)
		for c in entities.get_children():
			if c is Enemy and not c is Queen:
				entities.move_child(p, c.get_index())
				break


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
	if data.has("boss") and boss != null and not boss_active and not boss.dead and is_instance_valid(player):
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


## Parallax de Verdâmia com a arte entregue: floresta distante (opaca) e fungos intermediários.
func _build_verd_bg(bounds: Rect2) -> void:
	var defs := [["bg_distante.png", 0.06, 0.9, Color(1, 1, 1)], ["bg_intermediario.png", 0.26, 0.8, Color(0.46, 0.54, 0.58)]]
	for i in defs.size():
		var b := VerdBg.new()
		b.tex = load(SpriteMetaVerd.FUNDO_DIR + String(defs[i][0]))
		b.depth = defs[i][1]
		b.escala_min = defs[i][2]
		_verd_fit(b, bounds)
		b.modulate = defs[i][3]
		b.z_index = -60 + i * 10
		add_child(b)
		bg_layers.append(b)


## Enquadra um fundo de Verdâmia para cobrir a tela em qualquer ponto da fase (também nas cenas, em preparar()).
func _verd_fit(b: VerdBg, bounds: Rect2) -> void:
	var view := Vector2(1280, 720) / 1.1 + Vector2(240, 40)   # folga para telas mais largas (aspect expand)
	var cam_x := Vector2(bounds.position.x + 580.0, bounds.end.x - 580.0)
	var cam_y := Vector2(bounds.position.y + 327.0, bounds.end.y - 327.0)
	b.fit(view, cam_x, cam_y, b.escala_min)


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
	elif theme == "deserto":
		g.set_color(0, Color("e8b07a"))
		g.set_color(1, Color("7a3d22"))
	elif theme == "nivaria":
		g.set_color(0, Color("0B0F1E"))
		g.set_color(1, Color("1B2943"))
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


# --- Fases em cena -------------------------------------------------------------------------------------------------

## Antes de a cena entrar na árvore: liga as referências (main e level) de cada nó, encontra os nós que o resto do
## jogo usa e aplica o estado salvo (itens já pegos, Rainha vencida, Fuga já feita), como a montagem pelo código fazia.
func preparar() -> void:
	var marc := get_node_or_null("Marcadores")    # só para o editor e para descrever(); não fazem parte da fase
	if marc != null:
		remove_child(marc)
		marc.free()
	objects = $Objetos
	entities = $Entidades
	fx = $Efeitos
	for n in _descendentes(self):
		if "main" in n and n.get("main") == null:
			n.set("main", main)
		if "level" in n and n.get("level") == null:
			n.set("level", self)
	for c in get_children():
		if c is VerdBg and c.escala_min > 0.0:
			_verd_fit(c, data["bounds"])     # a cena guarda a escala e a posição com menos casas; refaz a conta
		if c is BgLayer or c is VerdBg or c is DFCamada:
			bg_layers.append(c)
		elif c is FgLayer:
			fg_layers.append(c)
		elif c is Fuga:
			fuga = c
		elif c is Desert:
			desert = c
	for c in objects.get_children():
		if c is Door:
			door = c
		elif c is Portal:
			portal = c
		elif c is Receptacle:
			receptacle = c
		elif c is Rift:
			arrival_rift = c
		elif c is Pickup and c.pid != "" and main.collected.has(c.pid):
			objects.remove_child(c)
			c.free()
	if desert != null:
		for n in _descendentes(desert):
			if "desert" in n and n.get("desert") == null:
				n.set("desert", desert)          # Forja
	for c in entities.get_children():
		if c is Queen:
			boss = c
		elif c is DesertEnemy and main.collected.has(c.pid):    # máquina já destruída
			entities.remove_child(c)
			c.free()
	if boss != null and main.boss_done.has(id):
		entities.remove_child(boss)
		boss.free()
		boss = null
		if not main.frags.has(id):   # Rainha vencida, mas o fragmento ainda não foi pego
			spawn_fragment()
	if fuga != null and main.events.has("fuga_" + id):
		remove_child(fuga)
		fuga.free()
		fuga = null


## Depois que os nós da cena ficaram prontos: o que a montagem fazia com eles já na árvore.
func _ready_cena() -> void:
	if door != null and _door_ready():
		door.open(true)
	if data.has("return_rift") and main.frags.has(id):
		open_return_rift(false)
		# na montagem pelo código, a fenda entrava antes dos itens e dos objetos que vêm depois deles
		for c in objects.get_children():
			if c is Pickup or c is LaserGate or c is Lever or c is EnergyField or c is EnergyLock \
					or c is Bench or c is GrappleHook or c is SecurityCam:
				objects.move_child(return_rift, c.get_index())
				break
	if fuga != null and fuga.slab != null:
		add_child(fuga.slab)
		move_child(fuga.slab, fuga.get_index() + 1)    # a laje que desaba vinha logo depois da Fuga


func _descendentes(n: Node) -> Array:
	var out := []
	for c in n.get_children():
		out.append(c)
		out.append_array(_descendentes(c))
	return out


## Os dados da fase no formato de LevelData, lidos dos nós da cena (o minimapa, o salvamento e o resto do jogo
## continuam lendo o dicionário). Chamado numa instância da cena que não entrou na árvore.
func descrever() -> Dictionary:
	var marc := get_node("Marcadores")
	var d := {"name": nome, "sub": subtitulo, "theme": tema, "form": forma, "bounds": limites, "kill_y": kill_y,
		"rooms": salas.duplicate(true), "spawn": (marc.get_node("Inicio") as Node2D).position}
	if marc.has_node("FendaDeRetorno"):
		d["return_rift"] = (marc.get_node("FendaDeRetorno") as Node2D).position
	var solids := []
	var platforms := []
	var hazards := []
	solids = TerrainDraw.solidos(self)
	for c in get_children():
		if c is SpritePlatform:
			var opts := {}
			if not is_nan(c.hang_y):
				opts["hang"] = c.hang_y
			if c.sid != "":
				opts["sid"] = c.sid
			if c.period != 4.0:
				opts["period"] = c.period
			platforms.append([c.kind, c.rect, c.travel, opts] if c.travel != Vector2.ZERO else [c.kind, c.rect, opts])
		elif c is Hazard:
			hazards.append(c.rect)
		elif c is TerrainDraw and not c.thin_art.is_empty():
			d["thin_art"] = c.thin_art.duplicate()
		elif c is Fuga:
			d["fuga"] = c.cfg.duplicate(true)
	d["solids"] = solids
	d["platforms"] = platforms
	d["hazards"] = hazards
	var keys := ["signs", "checkpoints", "benches", "terminals", "pickups", "hooks", "lasers", "cameras", "levers",
		"fields", "locks", "enemies", "crates"]
	for k in keys:
		d[k] = []
	for c in get_node("Objetos").get_children():
		if c is Sign:
			d["signs"].append([c.position, c.text])
		elif c is Checkpoint:
			d["checkpoints"].append(c.position)
		elif c is Bench:
			d["benches"].append(c.position)
		elif c is Terminal:
			d["terminals"].append([c.tid, c.position])
		elif c is Door:
			d["door"] = {"rect": c.rect, "needs": porta_requer.duplicate()}
		elif c is Portal:
			d["portal"] = {"pos": c.position, "target": c.target}
		elif c is Receptacle:
			d["receptacle"] = c.position
		elif c is Rift:
			d["arrival_rift"] = c.position
		elif c is Pickup:
			d["pickups"].append([c.kind, c.position, c.pid] if c.respawn <= 0.0 else [c.kind, c.position, c.pid, c.respawn])
		elif c is GrappleHook:
			d["hooks"].append([c.position, c.ceil_y])
		elif c is LaserGate:
			d["lasers"].append([c.position.x, c.phase])
		elif c is SecurityCam:
			d["cameras"].append([c.position, c.side, c.spawns.duplicate()])
		elif c is Lever:
			d["levers"].append([c.position, c.target, c.hint])
		elif c is EnergyField:
			d["fields"].append([c.sid, c.rect])
		elif c is EnergyLock:
			d["locks"].append([c.position, c.target])
	for c in get_node("Entidades").get_children():
		if c is Queen:
			d["boss"] = chefe.duplicate(true)
			d["boss"]["pos"] = c.position
		elif c is Crate:
			d["crates"].append([c.kind, c.position] if c.drop == "" else [c.kind, c.position, c.drop])
		elif c is Turret:
			d["enemies"].append(["turret_l" if c.dir < 0 else "turret_r", c.position])
		elif c is Crawler:
			d["enemies"].append(["crawler", c.position])
		elif c is Drone:
			d["enemies"].append(["drone", c.position])
		elif c is Moth:
			d["enemies"].append(["moth", c.position])
		elif c is SporePlant:
			d["enemies"].append(["spore", c.position])
	return d
