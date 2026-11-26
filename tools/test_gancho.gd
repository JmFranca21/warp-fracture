extends SceneTree
## Travessia dos vãos com o gancho (Arpão de Fase / Ímã de Fase), sem timing exato.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_gancho.gd -- [fps=30,60,144] [level=lab] [csv=/caminho.csv]
##
## Para cada gancho que atravessa um vão (achado por tools/mapa_ganchos.gd) em cada fase com gancho
## (Laboratório/Fuga do Eco, Deserto, Nivária), simula o jogador vindo da borda SEGURANDO a direção do
## outro lado e apertando o gancho UMA vez por gancho, em instantes diferentes:
##   parado     — parado a 24 px da borda, aperta logo;
##   correndo   — vem correndo de 140 px atrás e aperta ao passar da borda;
##   no_ar      — sai da borda andando e aperta 0,1 s depois, já caindo;
##   pulo_meio  — como "parado", com um pulo apertado sem querer no meio do puxão;
##   pulo_cedo  — como "parado", com um pulo apertado 0,03 s depois do gancho (corda ainda esticando).
## Confere que ele chega ao outro lado, no chão, sem cair no vão, a 30, 60 e 144 FPS.
## Vãos com as duas bordas na mesma altura são testados nos dois sentidos; os outros, no sentido do
## level design (para a direita, rumo ao fim da fase). O caminho contrário é só informativo.

const Mapa := preload("res://tools/mapa_ganchos.gd")
const VARIANTES := ["parado", "correndo", "no_ar", "pulo_meio", "pulo_cedo"]

var game
var fails := 0
var info_fails := 0
var backup := ""
var rows: Array = []
var trace := false


func _initialize() -> void:
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func release() -> void:
	for a in ["left", "right", "jump", "hook", "dash", "attack", "special", "up", "down"]:
		Input.action_release(a)


## Uma tentativa. Devolve [chegou, motivo].
func attempt(gap: Dictionary, dir: int, variant: String) -> Array:
	var p: Player = game.player
	var edge: float = gap["left_x"] if dir > 0 else gap["right_x"]
	var edge_y: float = gap["left_y"] if dir > 0 else gap["right_y"]
	var far_x: float = gap["right_x"] if dir > 0 else gap["left_x"]
	var far_y: float = gap["right_y"] if dir > 0 else gap["left_y"]
	var back := 24.0
	if variant == "correndo":
		back = 140.0
	elif variant == "no_ar":
		back = 40.0
	var space: PhysicsDirectSpaceState2D = game.level.get_world_2d().direct_space_state
	# a borda pode ser curta: recua só enquanto houver chão na mesma altura
	while back > 20.0 and absf(Mapa.floor_at(space, edge - dir * back, edge_y - 40.0) - edge_y) > 6.0:
		back -= 8.0
	release()
	# espera o retorno ao ponto seguro da tentativa anterior terminar (ele trava os controles e teleporta)
	while game.transitioning or p.controls_locked:
		await physics_frame
	p.hook = null
	p.hook_carry = 0.0
	p.dead = false
	p.hp = p.max_hp
	p.inv = 9999.0
	p.dash_t = 0.0
	p.knock_t = 0.0
	p.last_hook = null
	p.global_position = Vector2(edge - dir * back, edge_y - 1.0)
	p.velocity = Vector2.ZERO
	p.facing = dir
	p.last_safe = p.global_position
	await ticks(6)
	var start_safe := p.last_safe
	Input.action_press("right" if dir > 0 else "left")
	var dt := 1.0 / Engine.physics_ticks_per_second
	var used := {}
	var pressed_at := -1.0
	var hook_release_at := -1.0
	var jump_release_at := -1.0
	var left_floor_at := -1.0
	var tt := 0.0
	var jumped := false
	var max_y := -INF
	while tt < 5.0:
		var press := false
		if pressed_at < 0.0:
			match variant:
				"parado", "pulo_meio", "pulo_cedo":
					press = tt >= 2.0 * dt
				"correndo":
					press = (p.global_position.x - edge) * dir >= 0.0
				"no_ar":
					if left_floor_at < 0.0 and not p.is_on_floor():
						left_floor_at = tt
					press = left_floor_at >= 0.0 and tt - left_floor_at >= 0.1
		elif p.hook == null and not p.is_on_floor() and hook_release_at < 0.0:
			# um aperto por gancho: só se aparecer um gancho novo à frente
			var c: Node2D = p.hook_candidate()
			# só ganchos do próprio vão: à frente do jogador e antes da borda de chegada
			if c != null and not used.has(c) and (c.global_position.x - p.global_position.x) * dir > 0.0 \
					and (c.global_position.x - far_x) * dir < 0.0:
				press = true
		if press:
			var c2: Node2D = p.hook_candidate()
			if c2 != null:
				used[c2] = true
			Input.action_press("hook")
			hook_release_at = tt + 2.0 * dt
			if pressed_at < 0.0:
				pressed_at = tt
		if hook_release_at >= 0.0 and tt >= hook_release_at:
			Input.action_release("hook")
			hook_release_at = -1.0
		if not jumped and pressed_at >= 0.0:
			if (variant == "pulo_meio" and p.hook != null and p.hook_pull_t > 0.08) or (variant == "pulo_cedo" and tt - pressed_at >= 0.03):
				Input.action_press("jump")
				jump_release_at = tt + 0.05
				jumped = true
		if jump_release_at >= 0.0 and tt >= jump_release_at:
			Input.action_release("jump")
			jump_release_at = -1.0
		await physics_frame
		tt += dt
		if trace and int(round(tt / dt)) % 4 == 0:
			print("   t %.2f pos (%.0f, %.0f) v (%.0f, %.0f) gancho %s chão %s carry %.2f" % [tt, p.global_position.x, p.global_position.y,
				p.velocity.x, p.velocity.y, p.hook.global_position if p.hook != null else "-", p.is_on_floor(), p.hook_carry])
		max_y = maxf(max_y, p.global_position.y)
		if p.global_position.distance_to(start_safe) < 2.0 and tt > 0.5 and pressed_at >= 0.0:
			release()
			return [false, "voltou ao ponto seguro (caiu no vão)"]
		if max_y > maxf(edge_y, far_y) + 160.0:
			release()
			return [false, "caiu no vão (y %.0f)" % max_y]
		if p.is_on_floor() and (p.global_position.x - far_x) * dir >= 0.0 and p.global_position.y <= far_y + 6.0 and p.hook == null:
			release()
			return [true, "%.2f s" % tt]
	release()
	return [false, "não chegou em 5 s (x %.0f, y %.0f, gancho %s)" % [p.global_position.x, p.global_position.y, p.hook != null]]


func _run() -> void:
	var fps_list := [30, 60, 144]
	var only := ""
	var csv := ""
	var so_var := ""
	for a in OS.get_cmdline_user_args():
		if a.begins_with("fps="):
			fps_list = Array(a.substr(4).split(",")).map(func(s): return int(s))
		elif a.begins_with("level="):
			only = a.substr(6)
		elif a == "trace":
			trace = true
		elif a.begins_with("so="):
			so_var = a.substr(3)
		elif a.begins_with("csv="):
			csv = a.substr(4)
	if SaveGame.exists():
		backup = FileAccess.get_file_as_string(SaveGame.PATH)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}     # harness ligado sem "save": o teste nunca grava o save do jogador
	await ticks(4)
	game._reset_progress()
	game.modules["arpao"] = true
	game.menu.visible = false
	game.hud.visible = true
	for id in ["lab", "deserto", "nivaria"]:
		if only != "" and id != only:
			continue
		Engine.physics_ticks_per_second = 60
		game.checkpoint_level = id
		game.load_level(id, LevelData.get_level(id)["spawn"], false)
		await ticks(20)
		for e in game.level.entities.get_children():
			if e != game.player and e.is_in_group("enemies"):
				e.process_mode = Node.PROCESS_MODE_DISABLED
		var space: PhysicsDirectSpaceState2D = game.level.get_world_2d().direct_space_state
		var gaps := []
		var seen := {}
		var hooks := get_nodes_in_group("hooks")
		hooks.sort_custom(func(a, b): return a.global_position.x < b.global_position.x)
		for h in hooks:
			var g: Dictionary = Mapa.gap_of(space, h.global_position)
			if g.is_empty():
				continue
			var key := "%d_%d" % [roundi(g["left_x"]), roundi(g["right_x"])]
			if seen.has(key):
				continue          # dois ganchos no mesmo vão: um teste só (aperta uma vez por gancho)
			seen[key] = true
			gaps.append(g)
		print("== %s: %d vãos com gancho" % [id, gaps.size()])
		for g in gaps:
			var dirs := [1]
			if absf(g["left_y"] - g["right_y"]) < 40.0:
				dirs.append(-1)
			for dir in [1, -1]:
				var required: bool = dirs.has(dir)
				for fps in fps_list:
					Engine.physics_ticks_per_second = fps
					Engine.max_physics_steps_per_frame = 32
					await ticks(3)
					for v in VARIANTES:
						if so_var != "" and v != so_var:
							continue
						var r: Array = await attempt(g, dir, v)
						var what := "%s vão x %.0f–%.0f (gancho %s) %s %d FPS %s: %s" % [id, g["left_x"], g["right_x"],
							g["hook"], "→" if dir > 0 else "←", fps, v, r[1]]
						if r[0]:
							print("ok   " + what)
						elif required:
							print("FAIL " + what)
							fails += 1
						else:
							print("info " + what)
							info_fails += 1
						rows.append([id, g["left_x"], g["right_x"], g["hook"].x, g["hook"].y, dir, fps, v, r[0], required, r[1]])
		Engine.physics_ticks_per_second = 60
	if csv != "":
		var f := FileAccess.open(csv, FileAccess.WRITE)
		f.store_line("fase,borda_esq,borda_dir,gancho_x,gancho_y,sentido,fps,variante,chegou,obrigatorio,detalhe")
		for r in rows:
			f.store_line(",".join(r.map(func(x): return str(x))))
	print("informativo (sentido contrário em vão com degrau): %d sem chegar" % info_fails)
	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	game.queue_free()
	await ticks(2)
	if backup != "":
		var f2 := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
		f2.store_string(backup)
	quit(0 if fails == 0 else 1)
