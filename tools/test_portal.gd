extends SceneTree

var game

func _initialize() -> void:
	_run.call_deferred()

func _key(code: Key) -> void:
	var event := InputEventKey.new()
	event.keycode = code
	event.physical_keycode = code
	event.pressed = true
	Input.parse_input_event(event)
	await physics_frame
	await process_frame
	event = InputEventKey.new()
	event.keycode = code
	event.physical_keycode = code
	event.pressed = false
	Input.parse_input_event(event)
	await physics_frame
	await process_frame

func _require(ok: bool, message: String) -> bool:
	if not ok:
		printerr("FAIL: ", message)
		quit(1)
	return ok

func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await create_timer(0.3).timeout
	if not _require(game.interact_target == game.level.portal, "portal selecionado pela proximidade"):
		return
	await _key(KEY_E)
	if not _require(game.calib.active and game.state == "calib" and paused, "E abre calibração e pausa o mundo"):
		return
	await _key(KEY_ESCAPE)
	if not _require(not game.calib.active and game.state == "level" and not paused, "ESC cancela e retoma o mundo"):
		return
	await _key(KEY_E)
	if not _require(game.calib.active, "E reabre após cancelar"):
		return
	for i in 3:
		var steps := roundi((game.calib.target[i] - game.calib.cur[i]) / game.calib.STEP)
		for j in absi(steps):
			await _key(KEY_D if steps > 0 else KEY_A)
		if i < 2:
			await _key(KEY_S)
	if not _require(game.calib.success_t >= 0.0, "ondas resolvidas com entradas de teclado"):
		return
	await create_timer(5.0).timeout
	if not _require(game.level.id == "verdamia" and game.player.form == "lince" and not paused, "calibração leva a Verdâmia na forma Lince"):
		return
	print("PASS: proximidade -> E -> calibração -> ESC -> E -> resolver ondas -> Verdâmia")
	AudioMgr.inst.shutdown()
	quit(0)
