extends Node
## Gerenciador do jogo: menu, fases, transições, câmera, checkpoints.

const VIGNETTE := """
shader_type canvas_item;
void fragment() {
	vec2 uv = UV - vec2(0.5);
	uv.x *= 1.35;
	float d = length(uv);
	COLOR = vec4(0.0, 0.0, 0.02, smoothstep(0.36, 0.92, d) * 0.88);
}
"""

var state := "menu"
var world: Node2D
var level: Level
var player: Player
var cam: Camera2D
var hud: Hud
var menu: MainMenu
var calib: Calibration
var bench_panel: BenchPanel
var log_panel: LogPanel
var fade_rect: ColorRect

var cells := 0
var deaths := 0
var play_time := 0.0
var fragments := 0
var terminals := {}
var collected := {}
var boss_done := {}
var visited := {}        # salas exploradas ("lab:A") — usadas pelo mapa
var modules := {}        # módulos da arma conquistados ("arpao")
var upgrades := {}       # melhorias compradas na bancada
var checkpoint_level := "lab"
var checkpoint_pos := Vector2.ZERO
var interact_target: Node = null
var shake := 0.0
var transitioning := false
var calib_portal: Node = null
var _hitstop := false

# Automação de testes (argumentos depois de "--")
var auto := {}
var auto_t := 0.0
var _auto_pressed := {}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	randomize()
	_setup_input()
	world = Node2D.new()
	world.process_mode = Node.PROCESS_MODE_PAUSABLE
	add_child(world)

	var vl := CanvasLayer.new()
	vl.layer = 4
	add_child(vl)
	var vr := ColorRect.new()
	vr.set_anchors_preset(Control.PRESET_FULL_RECT)
	vr.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var sh := Shader.new()
	sh.code = VIGNETTE
	var sm := ShaderMaterial.new()
	sm.shader = sh
	vr.material = sm
	vl.add_child(vr)

	var am := AudioMgr.new()
	am.main = self
	add_child(am)
	Settings.load_cfg()

	var hl := CanvasLayer.new()
	hl.layer = 6
	add_child(hl)
	hud = Hud.new()
	hud.main = self
	hl.add_child(hud)

	var cl := CanvasLayer.new()
	cl.layer = 7
	add_child(cl)
	calib = Calibration.new()
	calib.main = self
	cl.add_child(calib)
	calib.done.connect(_on_calib_done)
	bench_panel = BenchPanel.new()
	bench_panel.main = self
	cl.add_child(bench_panel)
	bench_panel.closed.connect(_on_panel_closed)
	log_panel = LogPanel.new()
	log_panel.main = self
	cl.add_child(log_panel)
	log_panel.closed.connect(_on_panel_closed)

	var ml := CanvasLayer.new()
	ml.layer = 8
	add_child(ml)
	menu = MainMenu.new()
	menu.main = self
	ml.add_child(menu)
	menu.chosen.connect(_on_menu)

	var fl := CanvasLayer.new()
	fl.layer = 10
	add_child(fl)
	fade_rect = ColorRect.new()
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_rect.color = Color(0, 0, 0, 0)
	fl.add_child(fade_rect)

	_parse_args()
	show_menu()
	if auto.has("level"):
		_reset_progress()
		if auto.has("terminals"):
			terminals = {"A": true, "B": true}
		menu.visible = false
		hud.visible = true
		var lid: String = auto["level"]
		var p: Vector2 = LevelData.get_level(lid)["spawn"]
		if auto.has("pos"):
			var xy: PackedStringArray = String(auto["pos"]).split(",")
			p = Vector2(float(xy[0]), float(xy[1]))
		checkpoint_level = lid
		checkpoint_pos = p
		load_level(lid, p, auto.has("title"))
		if auto.has("energy"):
			player.energy = float(auto["energy"])
		if auto.has("hp"):
			player.hp = int(auto["hp"])
		if auto.has("arpao"):
			modules["arpao"] = true
		if auto.has("cells"):
			cells = int(auto["cells"])


# ---------------------------------------------------------------- entrada
func _setup_input() -> void:
	_act("left", [_k(KEY_A), _k(KEY_LEFT), _jb(JOY_BUTTON_DPAD_LEFT), _ja(JOY_AXIS_LEFT_X, -1.0)])
	_act("right", [_k(KEY_D), _k(KEY_RIGHT), _jb(JOY_BUTTON_DPAD_RIGHT), _ja(JOY_AXIS_LEFT_X, 1.0)])
	_act("up", [_k(KEY_W), _k(KEY_UP), _jb(JOY_BUTTON_DPAD_UP), _ja(JOY_AXIS_LEFT_Y, -1.0)])
	_act("down", [_k(KEY_S), _k(KEY_DOWN), _jb(JOY_BUTTON_DPAD_DOWN), _ja(JOY_AXIS_LEFT_Y, 1.0)])
	_act("jump", [_k(KEY_SPACE), _jb(JOY_BUTTON_A)])
	_act("attack", [_k(KEY_J), _mb(MOUSE_BUTTON_LEFT), _jb(JOY_BUTTON_X)])
	_act("special", [_k(KEY_K), _mb(MOUSE_BUTTON_RIGHT), _jb(JOY_BUTTON_Y)])
	_act("dash", [_k(KEY_SHIFT), _k(KEY_L), _jb(JOY_BUTTON_B)])
	_act("hook", [_k(KEY_F), _mb(MOUSE_BUTTON_MIDDLE), _jb(JOY_BUTTON_RIGHT_SHOULDER)])
	_act("interact", [_k(KEY_E), _jb(JOY_BUTTON_LEFT_SHOULDER)])
	_act("pause", [_k(KEY_ESCAPE), _jb(JOY_BUTTON_START)])
	_act("confirm", [_k(KEY_ENTER), _k(KEY_KP_ENTER), _k(KEY_SPACE), _jb(JOY_BUTTON_A)])
	_act("quit_menu", [_k(KEY_Q)])
	_act("map", [_k(KEY_TAB), _k(KEY_M), _jb(JOY_BUTTON_BACK)])


func _act(n: String, evs: Array) -> void:
	if InputMap.has_action(n):
		InputMap.action_erase_events(n)
	else:
		InputMap.add_action(n, 0.35)
	for e in evs:
		InputMap.action_add_event(n, e)


func _k(code: Key) -> InputEventKey:
	var e := InputEventKey.new()
	e.physical_keycode = code
	return e


func _mb(b: MouseButton) -> InputEventMouseButton:
	var e := InputEventMouseButton.new()
	e.button_index = b
	return e


func _jb(b: JoyButton) -> InputEventJoypadButton:
	var e := InputEventJoypadButton.new()
	e.button_index = b
	return e


func _ja(axis: JoyAxis, v: float) -> InputEventJoypadMotion:
	var e := InputEventJoypadMotion.new()
	e.axis = axis
	e.axis_value = v
	return e


func _unhandled_input(event: InputEvent) -> void:
	match state:
		"menu":
			if not transitioning:
				menu.handle(event)
		"level":
			if transitioning:
				return
			if bench_panel.active:
				bench_panel.handle(event)
				return
			if log_panel.active:
				log_panel.handle(event)
				return
			if hud.map_open:
				if event.is_action_pressed("map") or event.is_action_pressed("pause"):
					close_map()
				return
			if get_tree().paused and hud.paused_shown:
				match hud.pause_input(event):
					"resume":
						toggle_pause()
					"map":
						hud.paused_shown = false
						open_map()
					"logs":
						hud.paused_shown = false
						paused_for_logs = true
						log_panel.show_archive()
					"menu":
						save_now()
						show_menu()
				return
			if event.is_action_pressed("pause"):
				toggle_pause()
			elif event.is_action_pressed("map"):
				open_map()
		"victory":
			if event.is_action_pressed("confirm"):
				show_menu()


# ---------------------------------------------------------------- fluxo
func _on_menu(action: String) -> void:
	match action:
		"new":
			SaveGame.erase()
			start_game(false)
		"continue":
			start_game(true)
		"quit":
			AudioMgr.inst.shutdown()
			get_tree().quit()


var paused_for_logs := false


func open_bench() -> void:
	if transitioning:
		return
	get_tree().paused = true
	hud.set_prompt("")
	bench_panel.open()


func read_log(id: String) -> void:
	get_tree().paused = true
	log_panel.show_log(id)
	save_now()


func _on_panel_closed() -> void:
	if paused_for_logs:
		paused_for_logs = false
		hud.open_pause()
		hud.paused_shown = true
		return
	get_tree().paused = false
	if interact_target != null and is_instance_valid(interact_target) and interact_target.player_near:
		hud.set_prompt(interact_target.prompt)


func apply_upgrades() -> void:
	if is_instance_valid(player):
		var new_max := 5 + Upgrades.extra_hp(self)
		player.hp += new_max - player.max_hp
		player.max_hp = new_max


func save_now() -> void:
	if not auto.is_empty() and not auto.has("save"):
		return
	SaveGame.write(self)


func open_map() -> void:
	hud.map_open = true
	get_tree().paused = true
	AudioMgr.sfx("ui_ok", Vector2.INF, -3.0, 0.0)


func close_map() -> void:
	hud.map_open = false
	get_tree().paused = false
	AudioMgr.sfx("ui_volta", Vector2.INF, -3.0, 0.0)


func _track_rooms() -> void:
	if level == null or not is_instance_valid(player):
		return
	var pp := player.global_position + Vector2(0, -20)
	for r in level.data.get("rooms", []):
		if (r[1] as Rect2).has_point(pp):
			var key := level.id + ":" + String(r[0])
			if not visited.has(key):
				visited[key] = true


func _reset_progress() -> void:
	visited = {}
	modules = {}
	upgrades = {}
	cells = 0
	deaths = 0
	play_time = 0.0
	fragments = 0
	terminals = {}
	collected = {}
	boss_done = {}


func show_menu() -> void:
	state = "menu"
	menu.refresh()
	AudioMgr.music("menu")
	get_tree().paused = false
	Engine.time_scale = 1.0
	_clear_world()
	hud.visible = false
	hud.reset()
	menu.visible = true
	fade_rect.color = Color(0, 0, 0, 0)
	transitioning = false


func start_game(from_save := false) -> void:
	if transitioning:
		return
	transitioning = true
	_reset_progress()
	checkpoint_level = "lab"
	checkpoint_pos = LevelData.get_level("lab")["spawn"]
	var d := SaveGame.read() if from_save else {}
	if not d.is_empty():
		checkpoint_level = String(d.get("level", "lab"))
		var pz: Array = d.get("pos", [checkpoint_pos.x, checkpoint_pos.y])
		checkpoint_pos = Vector2(float(pz[0]), float(pz[1]))
		terminals = SaveGame.to_set(d.get("terminals", []))
		collected = SaveGame.to_set(d.get("collected", []))
		boss_done = SaveGame.to_set(d.get("boss_done", []))
		visited = SaveGame.to_set(d.get("visited", []))
		modules = SaveGame.to_set(d.get("modules", []))
		upgrades = d.get("upgrades", {})
		fragments = int(d.get("fragments", 0))
		cells = int(d.get("cells", 0))
		deaths = int(d.get("deaths", 0))
		play_time = float(d.get("play_time", 0.0))
	await _fade_to(Color(0, 0, 0, 1), 0.5)
	menu.visible = false
	hud.visible = true
	hud.reset()
	load_level(checkpoint_level, checkpoint_pos, true)
	await _fade_to(Color(0, 0, 0, 0), 0.9)
	transitioning = false


func _clear_world() -> void:
	for c in world.get_children():
		world.remove_child(c)
		c.queue_free()
	level = null
	player = null
	cam = null
	interact_target = null


func load_level(id: String, pos: Vector2, show_title: bool) -> void:
	_clear_world()
	var d: Dictionary = LevelData.get_level(id)
	level = Level.new()
	level.main = self
	level.id = id
	level.data = d
	world.add_child(level)
	player = Player.new()
	player.main = self
	player.level = level
	player.form = d["form"]
	player.position = pos
	level.add_player(player)
	cam = Camera2D.new()
	var b: Rect2 = d["bounds"]
	cam.limit_left = int(b.position.x)
	cam.limit_top = int(b.position.y)
	cam.limit_right = int(b.end.x)
	cam.limit_bottom = int(b.end.y)
	world.add_child(cam)
	cam.zoom = Vector2(1.1, 1.1)
	cam.make_current()
	cam.position = _cam_target()
	cam.reset_smoothing()
	state = "level"
	AudioMgr.music("laboratorio" if d["theme"] == "lab" else "verdamia")
	hud.set_prompt("")
	hud.hide_tip()
	if show_title:
		hud.show_title(d["name"], d["sub"])


func _cam_target() -> Vector2:
	if player == null:
		return Vector2.ZERO
	var look := 0.0
	if player.is_on_floor() and Input.is_action_pressed("down") and absf(player.velocity.x) < 5.0:
		look = 140.0
	var tg := player.global_position + Vector2(player.facing * 70.0, -165.0 + look)
	if level != null and level.boss_active:
		tg.x = 4380.0
	return tg


func _process(delta: float) -> void:
	if state == "level" and not get_tree().paused:
		play_time += delta
		_track_rooms()
	if cam != null and is_instance_valid(player):
		cam.position = cam.position.lerp(_cam_target(), 1.0 - exp(-delta * 6.0))
		cam.offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * shake
	shake = move_toward(shake, 0.0, delta * 45.0)
	_auto_process(delta)


func toggle_pause() -> void:
	var p := not get_tree().paused
	if p:
		hud.open_pause()
	AudioMgr.sfx("ui_ok" if p else "ui_volta", Vector2.INF, 0.0, 0.0)
	get_tree().paused = p
	hud.paused_shown = p


func _fade_to(c: Color, dur: float) -> void:
	var tw := create_tween()
	tw.tween_property(fade_rect, "color", c, dur)
	await tw.finished


func add_shake(v: float) -> void:
	if not Settings.shake:
		return
	shake = maxf(shake, v)


func hitstop(d: float) -> void:
	if _hitstop:
		return
	_hitstop = true
	Engine.time_scale = 0.05
	await get_tree().create_timer(d, true, false, true).timeout
	Engine.time_scale = 1.0
	_hitstop = false


# ---------------------------------------------------------------- eventos de jogo
func on_player_hurt() -> void:
	AudioMgr.sfx("dano")
	hud.damage()
	add_shake(11.0)
	hitstop(0.09)


func on_player_died() -> void:
	if transitioning:
		return
	transitioning = true
	deaths += 1
	AudioMgr.sfx("morte")
	await get_tree().create_timer(1.0).timeout
	await _fade_to(Color(0, 0, 0, 1), 0.6)
	load_level(checkpoint_level, checkpoint_pos, false)
	hud.notice("Daymon se recompõe na Estação de Recarga...")
	await _fade_to(Color(0, 0, 0, 0), 0.7)
	transitioning = false


func hazard_respawn(pos: Vector2) -> void:
	if transitioning:
		return
	transitioning = true
	player.controls_locked = true
	await get_tree().create_timer(0.15).timeout
	await _fade_to(Color(0, 0, 0, 1), 0.25)
	if is_instance_valid(player):
		player.global_position = pos
		player.velocity = Vector2.ZERO
		player.knock_t = 0.0
		cam.position = _cam_target()
		cam.reset_smoothing()
	await _fade_to(Color(0, 0, 0, 0), 0.3)
	if is_instance_valid(player):
		player.controls_locked = false
	transitioning = false


func set_checkpoint(pos: Vector2) -> void:
	checkpoint_level = level.id
	checkpoint_pos = pos + Vector2(0, -10)
	player.hp = player.max_hp
	AudioMgr.sfx("estacao")
	save_now()
	hud.notice("Integridade restaurada · Ponto de retorno salvo")


func add_cells(n: int) -> void:
	cells += n
	hud.pulse_cells()


func open_calibration(portal: Node) -> void:
	if transitioning:
		return
	calib_portal = portal
	state = "calib"
	get_tree().paused = true
	hud.set_prompt("")
	calib.open()


func _on_calib_done(ok: bool) -> void:
	get_tree().paused = false
	state = "level"
	if ok:
		AudioMgr.sfx("calibra_ok")
	if ok and is_instance_valid(calib_portal):
		calib_portal.activate()
		await get_tree().create_timer(0.7).timeout
		enter_portal(calib_portal.target, calib_portal.global_position)
	elif is_instance_valid(calib_portal) and calib_portal.player_near:
		hud.set_prompt(calib_portal.prompt)


func enter_portal(target: String, portal_pos: Vector2) -> void:
	if transitioning:
		return
	transitioning = true
	player.controls_locked = true
	player.start_warp(portal_pos + Vector2(0, -80))
	AudioMgr.sfx("portal")
	add_shake(14.0)
	await get_tree().create_timer(0.9).timeout
	await _fade_to(Color(0.85, 0.95, 1.0, 1.0), 0.45)
	var sp: Vector2 = LevelData.get_level(target)["spawn"]
	checkpoint_level = target
	checkpoint_pos = sp
	load_level(target, sp, true)
	save_now()
	hud.show_banner("NOVA FORMA: LINCE-VAGALUME", "Pulo duplo  ·  Salto de parede  ·  Garras  ·  Clarão")
	await _fade_to(Color(0.85, 0.95, 1.0, 0.0), 1.4)
	fade_rect.color = Color(0, 0, 0, 0)
	transitioning = false


func gain_module(id: String) -> void:
	modules[id] = true
	AudioMgr.sfx("modulo", Vector2.INF, 0.0, 0.0)
	add_shake(6.0)
	if id == "arpao":
		hud.show_banner("MÓDULO OBTIDO: ARPÃO DE FASE", "F, botão do meio do mouse ou RB: se puxa até ganchos  ·  aperte de novo no ar para encadear")
	save_now()


func gain_core() -> void:
	upgrades["hp"] = int(upgrades.get("hp", 0)) + 1
	AudioMgr.sfx("modulo", Vector2.INF, 0.0, 0.0)
	if is_instance_valid(player):
		player.max_hp += 1
		player.hp = player.max_hp
	hud.show_banner("NÚCLEO DE UPGRADE", "+1 de Integridade máxima")
	save_now()


func boss_defeated() -> void:
	boss_done[level.id] = true
	hud.notice("A Rainha Micélia recua para as raízes...")


func collect_fragment() -> void:
	fragments += 1
	AudioMgr.sfx("cura", Vector2.INF, 2.0)
	AudioMgr.music("menu")
	state = "victory"
	player.controls_locked = true
	add_shake(10.0)
	hud.show_victory()
	save_now()


# ---------------------------------------------------------------- automação (testes)
var phys_t := 0.0


func _physics_process(delta: float) -> void:
	if auto.is_empty():
		return
	phys_t += delta
	if auto.has("act"):
		for spec in String(auto["act"]).split(";"):
			var p := spec.split("@")
			if p.size() != 2:
				continue
			var rng := p[1].split("-")
			var on := phys_t >= float(rng[0]) and phys_t < float(rng[1])
			var was: bool = _auto_pressed.get(spec, false)
			if on != was:
				if on:
					Input.action_press(p[0])
				else:
					Input.action_release(p[0])
				var in_menu := state == "menu" or get_tree().paused
				if p[0] in ["confirm", "pause", "quit_menu", "map"] or (in_menu and p[0] in ["up", "down", "left", "right"]):
					var ev := InputEventAction.new()
					ev.action = p[0]
					ev.pressed = on
					Input.parse_input_event(ev)
			_auto_pressed[spec] = on


func _parse_args() -> void:
	for a in OS.get_cmdline_user_args():
		var kv := a.split("=", true, 1)
		if kv.size() == 2:
			auto[kv[0]] = kv[1]
		else:
			auto[a] = "1"


func _auto_process(delta: float) -> void:
	if auto.is_empty():
		return
	auto_t += delta
	if auto.has("calib") and state == "level" and auto_t > 0.5 and not auto.has("_c"):
		auto["_c"] = 1
		open_calibration(level.portal)
	if auto.has("boss") and level != null and level.boss != null and not auto.has("_b") and auto_t > 0.3:
		auto["_b"] = 1
		level.start_boss()
	if auto.has("killboss") and level != null and level.boss != null and level.boss_active and not auto.has("_kb") and auto_t > float(auto["killboss"]):
		auto["_kb"] = 1
		level.boss.take_hit(999, level.boss.global_position)
	if auto.has("victory") and not auto.has("_v") and auto_t > 0.3:
		auto["_v"] = 1
		collect_fragment()
	if auto.has("pause") and not auto.has("_p") and auto_t > 0.3:
		auto["_p"] = 1
		toggle_pause()
	if auto.has("trigger") and level != null and not auto.has("_tr") and auto_t > 0.1:
		auto["_tr"] = 1
		level.trigger(String(auto["trigger"]))
	if auto.has("visitall") and level != null:
		for r in level.data.get("rooms", []):
			visited[level.id + ":" + String(r[0])] = true
	if auto.has("god") and is_instance_valid(player):
		player.inv = 60.0
	if auto.has("trace") and is_instance_valid(player) and int(auto_t * 20) != int((auto_t - delta) * 20):
		print("T ", snappedf(auto_t, 0.01), " pos=", player.global_position.round(), " vel=", player.velocity.round(), " hook=", player.hook != null, " cand=", player.hook_candidate() != null)
	var at := float(auto.get("at", "2.0"))
	if auto_t >= at and not auto.has("_done"):
		auto["_done"] = 1
		if is_instance_valid(player):
			print("STATE pos=", player.global_position, " hp=", player.hp, "/", player.max_hp, " energy=", player.energy,
				" cells=", cells, " terminals=", terminals.keys(), " state=", state, " enemies=",
				get_tree().get_nodes_in_group("enemies").size(), " aim=", player.aim, " mouse=", player.use_mouse,
				" anim=", player.body_spr.animation if player.body_spr != null else "-",
				" armrot=", snappedf(player.arm_pivot.rotation, 0.01) if player.arm_pivot != null else 0.0,
				" sons=", AudioMgr.inst.played, " faltando=", AudioMgr.inst.cache.values().count(null), " musica=", AudioMgr.inst.current_track)
		if auto.has("shot"):
			var img := get_viewport().get_texture().get_image()
			img.save_png(String(auto["shot"]))
		AudioMgr.inst.shutdown()
		get_tree().quit()
