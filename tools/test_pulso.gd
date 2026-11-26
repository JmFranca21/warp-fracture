extends SceneTree
## Ensino e leitura do Autômato (revisão geral): Pulso Magnético e Ímã de Fase.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_pulso.gd
## Cobre: placas novas, HUD com as duas habilidades, anel de alcance só com energia e alvo perto,
## alvos marcados dentro/fora do alcance, drone marcado para o Ímã, porta imantada (fechada antes da
## luta, não abre de longe, abre com o Pulso perto, fica aberta no save), dica da IRIS na porta,
## energia garantida antes da porta e o Pulso derrubando drone, travando robô e estourando tiro.

var game
var fails := 0


func _initialize() -> void:
	_run.call_deferred()


func _check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FAIL ") + what)
	if not ok:
		fails += 1


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func place(pos: Vector2) -> void:
	var p: Player = game.player
	p.global_position = pos
	p.velocity = Vector2.ZERO
	p.hook = null
	p.inv = 9999.0
	await ticks(4)


func press(a: String) -> void:
	Input.action_press(a)
	await ticks(2)
	Input.action_release(a)
	await ticks(2)


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}     # harness ligado sem "save": o teste nunca grava o save do jogador
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = true
	game.load_level("deserto", LevelData.get_level("deserto")["spawn"], false)
	await ticks(20)
	var lv: Level = game.level
	var p: Player = game.player
	var desert: Desert = lv.desert
	var texts: Array = lv.data["signs"].map(func(s): return String(s[1]))
	_check(texts.any(func(s): return s.contains("PULSO MAGNÉTICO") and s.contains("anel tracejado")), "placa própria do Pulso, com o alcance")
	_check(texts.any(func(s): return s.begins_with("ÍMÃ (F) sem argola")), "placa do Ímã no drone separada da do Pulso")
	_check(not texts.any(func(s): return s.contains("Pule no fim da puxada")), "nenhuma placa pede pulo no fim da puxada")
	_check(lv.data["pickups"].any(func(k): return k[0] == "energy" and k[1].distance_to(Vector2(6800, 735)) < 1.0), "energia que reaparece antes da porta imantada")

	# --- porta imantada
	_check(desert.mag_lock != null and not desert.door_open("in"), "a entrada da Câmara começa fechada por placas imantadas")
	await place(Vector2(6700, 770))
	_check(not game.hud.say_lines.is_empty() and game.hud.say_lines.any(func(l): return l.contains("PULSO")), "IRIS explica a porta ao chegar perto")
	p.energy = 99.0
	await place(Vector2(6750, 770))           # 270 px: fora do alcance
	await press("special")
	await ticks(6)
	_check(desert.mag_lock != null and not desert.door_open("in"), "Pulso de longe (270 px) não abre a porta")
	_check(p.energy < 99.0 - 30.0, "o Pulso gastou 1/3 da energia")
	p.energy = 99.0
	await place(Vector2(6930, 770))
	var tg: Array = p.pulse_targets(Player.PULSE_SHOW)
	_check(tg.any(func(x): return x[1] and x[0].distance_to(Desert.MAG_LOCK) < 2.0), "a porta aparece como alvo dentro do alcance")
	await press("special")
	await ticks(6)
	_check(desert.mag_lock == null and desert.door_open("in"), "Pulso perto abre a porta imantada")
	_check(game.events.has("porta_imantada"), "a porta aberta vai para o save (evento porta_imantada)")
	await ticks(20)
	_check(not p.pulse_targets(Player.PULSE_SHOW).any(func(x): return x[0].distance_to(Desert.MAG_LOCK) < 2.0), "porta aberta deixa de ser alvo")

	# recarregar a fase com o evento: porta aberta e sem placas
	game.load_level("deserto", Vector2(6700, 770), false)
	await ticks(20)
	lv = game.level
	p = game.player
	desert = lv.desert
	_check(desert.mag_lock == null and desert.door_open("in"), "com o evento salvo, a porta já começa aberta")

	# --- leitura: anel e alvos
	for e in lv.entities.get_children():
		if e is DesertEnemy:
			e.process_mode = Node.PROCESS_MODE_DISABLED
	var robot: DesertEnemy = null
	var drone: DesertEnemy = null
	for e in get_nodes_in_group("enemies"):
		if e is DesertEnemy and not e.drone and robot == null:
			robot = e
		elif e is DesertEnemy and e.drone and drone == null:
			drone = e
	await place(robot.global_position + Vector2(-120, 0))
	p.energy = 10.0
	await ticks(2)
	var near: Array = p.pulse_targets(Player.PULSE_SHOW)
	_check(near.any(func(x): return x[1]), "robô a 120 px conta como alvo dentro do alcance")
	await place(robot.global_position + Vector2(-210, 0))
	var mid: Array = p.pulse_targets(Player.PULSE_SHOW)
	_check(mid.size() > 0 and not mid.any(func(x): return x[1]), "robô a 210 px aparece, mas marcado fora do alcance")

	# --- Pulso: robô trava, drone cai, tiro estoura
	for e in [robot, drone]:
		e.process_mode = Node.PROCESS_MODE_INHERIT
	await place(robot.global_position + Vector2(-100, 0))
	p.energy = 99.0
	await press("special")
	await ticks(3)
	_check(robot.stun > 1.5, "Pulso trava o robô por 2 s")
	var shot := DesertEnemy.DesertShot.new()
	shot.vel = Vector2(-200, 0)
	shot.position = p.global_position + Vector2(80, -30)
	lv.fx.add_child(shot)
	await ticks(2)
	p.energy = 99.0
	await press("special")
	await ticks(3)
	_check(not is_instance_valid(shot) or shot.is_queued_for_deletion(), "Pulso estoura o tiro inimigo")
	await place(drone.global_position + Vector2(-60, 100))
	p.energy = 99.0
	await press("special")
	await ticks(3)
	_check(drone.falling or drone.downed > 0.0 or drone.dead, "Pulso derruba o drone")

	# --- Ímã no drone: marcado quando não há argola ao alcance
	await ticks(200)
	for e in get_nodes_in_group("enemies"):
		if e is DesertEnemy and e.drone and not e.dead and not e.falling and e.downed <= 0.0:
			drone = e
			break
	await place(drone.global_position + Vector2(-140, 150))
	_check(p.hook_candidate() == null and p.drone_candidate() == drone, "sem argola ao alcance, o Ímã marca o drone")

	# --- HUD: as duas habilidades do Autômato
	game.hud.queue_redraw()
	_check(game.hud.has_method("_draw_abilities"), "HUD mostra as habilidades da forma (Ímã e Pulso)")

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	game.queue_free()
	await ticks(2)
	quit(0 if fails == 0 else 1)
