extends SceneTree
## Regressão da Fuga do Eco (Etapa 7), jogada por input real (ações de teclado).
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_fuga.gd -- level=lab terminals arpao pos=4250,790 save at=999
## Cobre: início (ponto de retorno, trilha, Eco pela fenda), agarrão com aviso, esquiva atravessando
## o golpe, entulho com aviso, piso que desaba, Dobra espectral (nunca perto do jogador), zona do
## portal, morte e recomeço, corrida completa até o portal e Verdâmia, e o save ("fuga_lab").

var game
var fails := 0
var backup := ""
# observados durante a corrida (membros: lambdas do GDScript copiam variáveis locais)
var hits := 0
var min_d := INF
var dobra_ok := true
var slab_fell := false
var debris_seen := 0
var watching := false
var usou_gancho := false


func _initialize() -> void:
	_run.call_deferred()


func _check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FAIL ") + what)
	if not ok:
		fails += 1


func _wait(s: float) -> void:
	await create_timer(s, false).timeout


func _tap(a: String, hold := 0.08) -> void:
	Input.action_press(a)
	await _wait(hold)
	Input.action_release(a)


func _release_all() -> void:
	for a in ["left", "right", "jump", "dash", "hook", "down", "interact"]:
		Input.action_release(a)


func _key(code: Key) -> void:
	for pressed in [true, false]:
		var ev := InputEventKey.new()
		ev.keycode = code
		ev.physical_keycode = code
		ev.pressed = pressed
		Input.parse_input_event(ev)
		await physics_frame
		await process_frame


func _fuga():
	return game.level.fuga


func _eco():
	var f = _fuga()
	return f.eco if f != null and is_instance_valid(f.eco) else null


## Corre da Sala G até o portal: pula o degrau, o fosso 1 (depois do piso cair) e usa o gancho no fosso 2.
## Devolve o tempo gasto ou -1 se não chegou.
func _run_to_portal(limit := 30.0) -> float:
	var p: Player = game.player
	var t := 0.0
	var jumped := {}
	Input.action_press("right")
	while t < limit:
		await physics_frame
		t += 1.0 / 60.0
		p = game.player
		if not is_instance_valid(p) or p.dead:
			break
		var x := p.global_position.x
		if x > 4445.0 and not jumped.has("degrau"):
			jumped["degrau"] = true
			Input.action_press("jump")
		if x > 4560.0 and jumped.has("degrau") and not jumped.has("solta1"):
			jumped["solta1"] = true
			Input.action_release("jump")
		if x > 5420.0 and not jumped.has("fosso1"):
			jumped["fosso1"] = true
			Input.action_press("jump")
		if x > 5560.0 and not jumped.has("solta2"):
			jumped["solta2"] = true
			Input.action_release("jump")
		# Galeria: plataforma suspensa → topo da barricada → gancho sobre o fosso 2
		if x > 5650.0 and p.is_on_floor() and p.global_position.y > 680.0 and not jumped.has("plat"):
			jumped["plat"] = true
			Input.action_press("jump")
		if jumped.has("plat") and not jumped.has("solta3") and p.velocity.y > 0.0:
			jumped["solta3"] = true
			Input.action_release("jump")
		if x > 5790.0 and p.is_on_floor() and p.global_position.y < 600.0 and not jumped.has("barric"):
			jumped["barric"] = true
			Input.action_press("jump")
		if jumped.has("barric") and not jumped.has("solta4") and p.velocity.y > 0.0:
			jumped["solta4"] = true
			Input.action_release("jump")
		if x > 5975.0 and p.is_on_floor() and p.global_position.y < 480.0 and not jumped.has("gancho"):
			jumped["gancho"] = true
			Input.action_press("jump")
		if jumped.has("gancho") and not jumped.has("f") and p.velocity.y > -150.0:
			jumped["f"] = true
			Input.action_release("jump")
			await _tap("hook")
			usou_gancho = p.hook != null
		if jumped.has("f") and not jumped.has("salta") and p.hook != null and p.global_position.x > 6110.0:
			jumped["salta"] = true
			await _tap("jump")
		if x > 6440.0:
			_release_all()
			return t
	_release_all()
	return -1.0


func _run() -> void:
	if FileAccess.file_exists(SaveGame.PATH):
		backup = FileAccess.get_file_as_string(SaveGame.PATH)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await _wait(0.4)
	var p: Player = game.player
	_check(game.level.id == "lab" and _fuga() != null and not _fuga().active, "Sala G aberta pelos terminais; a fuga ainda não começou")

	# --- início
	Input.action_press("right")
	await _wait(0.25)
	Input.action_release("right")
	await _wait(0.1)
	var f = _fuga()
	_check(f.active, "entrar na Sala G começa a fuga")
	_check(game.checkpoint_level == "lab" and game.checkpoint_pos.distance_to(Vector2(4300, 790)) < 5.0, "ponto de retorno salvo no início da fuga")
	_check(AudioMgr.inst.current_track == "fuga", "trilha de fuga tocando")
	await _wait(0.6)
	var e = _eco()
	_check(e != null and e.global_position.distance_to(p.global_position) >= 250.0, "o Eco surge por uma fenda atrás da porta, longe do jogador")

	# --- agarrão: parado, o Eco alcança e agarra; o golpe vem depois de um aviso
	var t_grab := -1.0
	var t_hit := -1.0
	var t := 0.0
	var hp0 := p.hp
	while t < 6.0 and t_hit < 0.0:
		await physics_frame
		t += 1.0 / 60.0
		if t_grab < 0.0 and e.state == "grab":
			t_grab = t
		if p.hp < hp0:
			t_hit = t
	_check(t_grab >= 0.0 and t_hit > 0.0, "parado, o Eco alcança e agarra (dano 1)")
	_check(t_hit - t_grab >= 0.28, "o agarrão tem aviso de %.2f s antes do golpe" % (t_hit - t_grab))

	# --- esquiva atravessa o golpe
	await _wait(1.4)
	p.inv = 0.0
	var hp1 := p.hp
	var dodged := false
	t = 0.0
	while t < 5.0:
		await physics_frame
		t += 1.0 / 60.0
		if e.state == "grab" and e.spr.frame == 2 and not dodged:
			dodged = true
			Input.action_press("left" if e.face > 0 else "right")
			await _tap("dash", 0.05)
			await _wait(0.4)
			_release_all()
			break
	_check(dodged and p.hp == hp1, "esquivar no aviso atravessa o golpe sem dano")

	# --- morte durante a fuga: volta ao início e o Eco volta a surgir
	p.inv = 0.0
	p.hurt(p.global_position + Vector2(10, 0), 99)
	await _wait(3.6)
	p = game.player
	_check(not p.dead and p.global_position.distance_to(Vector2(4300, 790)) < 30.0 and _fuga() != null and not _fuga().active,
		"morrer na fuga volta ao início, com a fuga pronta para recomeçar")

	# --- corrida completa, sem ser pego
	watching = true
	var watcher := func():
		var lasthp: int = game.player.hp
		while watching and is_instance_valid(game.player) and game.level.id == "lab":
			await physics_frame
			var pl: Player = game.player
			if pl.hp < lasthp:
				hits += 1
			lasthp = pl.hp
			var ec = _eco()
			if ec != null and ec.spr.visible:
				min_d = minf(min_d, ec.global_position.distance_to(pl.global_position))
				if ec.state == "dobra_wait" and ec.global_position.distance_to(pl.global_position + Eco.TORSO) < Eco.DOBRA_MIN_DIST:
					dobra_ok = false
			if _fuga() != null and _fuga().slab.fell:
				slab_fell = true
			for n in game.level.fx.get_children():
				if n is Debris and n.falling:
					debris_seen = maxi(debris_seen, 1)
	watcher.call()
	var tr := await _run_to_portal()
	watching = false
	_check(tr > 0.0, "corrida da Sala G até o portal em %.1f s (degrau, piso que desaba, plataforma, barricada)" % tr)
	_check(usou_gancho, "o Arpão prende no gancho sobre o fosso 2")
	_check(slab_fell, "o piso sobre o fosso 1 desaba durante a fuga")
	_check(debris_seen > 0, "o teto cai com aviso pelo caminho")
	_check(hits == 0, "corrida limpa: nenhum dano do Eco nem do entulho (%d)" % hits)
	_check(dobra_ok, "a Dobra nunca reabre a menos de 250 px do jogador")

	# --- zona do portal: o Eco não entra
	await _wait(2.5)
	e = _eco()
	p = game.player
	_check(e == null or e.global_position.x <= game.level.portal.global_position.x - 300.0, "perto do portal, o Eco fica para trás")
	var hp2 := p.hp
	Input.action_press("right")
	await _wait(0.3)
	Input.action_release("right")
	await _wait(1.0)
	_check(game.player.hp == hp2, "na luz do portal o Eco não ataca")

	# --- Dobra: o jogador some de repente para longe (rastro longo)
	e = _eco()
	if e != null:
		e.dobra_cd = 0.0
		e.hold_x = INF
		e.state = "advance"
		var far := 0
		for i in 60:
			e.trail.append(e.global_position + Vector2(-(i + 1) * 20.0, 0))
		e.trail.reverse()
		t = 0.0
		var saw := ""
		while t < 3.0:
			await physics_frame
			t += 1.0 / 60.0
			if e.state.begins_with("dobra"):
				saw = e.state
			if e.state == "dobra_wait":
				far = int(e.global_position.distance_to(game.player.global_position + Eco.TORSO))
				break
		_check(saw != "" and far >= 250, "Dobra: some, abre a fenda a %d px e sai por ela" % far)

	# --- calibrar e atravessar: o Eco se desfaz e a fuga fica salva
	await _wait(1.0)
	p = game.player
	p.global_position = game.level.portal.global_position + Vector2(-30, -10)
	await _wait(0.3)
	await _key(KEY_E)
	_check(game.calib.active, "E no portal abre a calibração")
	for i in 3:
		var steps := roundi((game.calib.target[i] - game.calib.cur[i]) / game.calib.STEP)
		for j in absi(steps):
			await _key(KEY_D if steps > 0 else KEY_A)
		if i < 2:
			await _key(KEY_S)
	await _wait(5.0)
	_check(game.level.id == "verdamia" and game.events.has("fuga_lab"), "o portal leva a Verdâmia e a fuga fica registrada")
	var d := SaveGame.read()
	_check(Array(d.get("events", [])).has("fuga_lab"), "o save guarda a fuga concluída")

	# --- continuar depois: o laboratório não repete a fuga
	game._reset_progress()
	game.events = SaveGame.to_set(d.get("events", []))
	game.terminals = {"A": true, "B": true}
	game.load_level("lab", Vector2(4300, 790), false)
	await _wait(0.5)
	_check(game.level.fuga == null, "com a fuga concluída, o laboratório fica sem Eco")

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	SaveGame.erase()
	if backup != "":
		var fw := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
		fw.store_string(backup)
		fw.close()
	AudioMgr.inst.shutdown()
	quit(0 if fails == 0 else 1)
