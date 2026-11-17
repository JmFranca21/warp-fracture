extends SceneTree
## Regressão do Deserto de Ferrugem com o Autômato (D03), por input real.
## uso: godot --audio-driver Dummy --path . --script res://tools/test_deserto.gd -- save at=999
## Cobre: forma (tamanho, velocidade, pulo de ~130 px, sem pulo duplo nem salto de parede, animações e
## braço-ímã), os três vãos com o Ímã de Fase, degraus, esteira, válvula, plataformas, Rebitadeira
## (robô em 3 rebites, cadência 20% menor), Pulso Magnético (drone cai, robô para, tiro desviado),
## feixe no drone sem âncora, drone puxado para o jato da válvula, peso (sem recuo), Arranque e o save.

var game
var fails := 0
var backup := ""


func _initialize() -> void:
	_run.call_deferred()


func _check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FAIL ") + what)
	if not ok:
		fails += 1


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func _wait(s: float) -> void:
	await create_timer(s, true).timeout


func place(pos: Vector2, god := true) -> void:
	game.player.global_position = pos
	game.player.velocity = Vector2.ZERO
	game.player.hook = null
	game.player.inv = 8.0 if god else 0.0
	await ticks(4)


func release() -> void:
	for a in ["left", "right", "jump", "hook", "dash", "attack", "special", "up"]:
		Input.action_release(a)


## Travessia física com o ímã (F, e pulo no fim da puxada) ou com pulo.
func cross(start: Vector2, target_x: float, use_hook: bool) -> bool:
	await place(start)
	var p: Player = game.player
	Input.action_press("right")
	if use_hook:
		_check(p.hook_candidate() != null, "âncora ao alcance em x %d" % start.x)
		Input.action_press("hook")
	else:
		Input.action_press("jump")
	await ticks(2)
	Input.action_release("hook")
	var reached := false
	for i in 140:
		if use_hook and i > 12 and p.hook == null and not p.is_on_floor():
			Input.action_press("jump")
		if p.global_position.x >= target_x and p.is_on_floor():
			reached = true
			break
		await physics_frame
	release()
	return reached


func _enemies() -> Array:
	return get_nodes_in_group("enemies").filter(func(e): return e is DesertEnemy and not e.dead)


func _run() -> void:
	if SaveGame.exists():
		backup = FileAccess.get_file_as_string(SaveGame.PATH)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = true
	game.checkpoint_level = "deserto"
	game.checkpoint_pos = LevelData.get_level("deserto")["spawn"]
	game.load_level("deserto", game.checkpoint_pos, true)
	await ticks(20)
	var lv: Level = game.level
	var p: Player = game.player

	# --- forma
	_check(lv.id == "deserto" and p.form == "automato", "o Deserto inteiro é jogado como Autômato")
	var shape: RectangleShape2D = (p.get_child(0) as CollisionShape2D).shape
	_check(shape.size == Vector2(30, 62), "colisão de 30 × 62 px")
	_check(is_equal_approx(p.run_speed, 272.0) and p.max_air_jumps == 0, "andar 272 px/s (0,85×), sem pulo duplo")
	var anims := ["idle", "walk", "jump", "fall", "dash", "hurt", "death"]
	_check(anims.all(func(a): return p.body_spr.sprite_frames.has_animation(a)), "as 7 animações do corpo (DF90–DF96)")
	_check(p.arm_spr != null and p.arm_spr.sprite_frames.has_animation("beam"), "braço-ímã DF97 com repouso, disparo e feixe")
	_check(_enemies().size() == 6, "seis máquinas")
	_check(get_nodes_in_group("hooks").size() == 5, "cinco âncoras (três vãos e duas na Câmara)")
	_check(lv.data["pickups"].filter(func(k): return k[0] == "cell").size() == 12, "12 células")
	var desert: Desert = lv.desert

	# --- pulo de ~130 px, sem pulo duplo
	await place(Vector2(400, 690))
	await ticks(10)
	var y0: float = p.global_position.y
	Input.action_press("jump")
	var top := y0
	for i in 50:
		await physics_frame
		top = minf(top, p.global_position.y)
		if i == 20:
			Input.action_release("jump")
			Input.action_press("jump")
	release()
	var h := y0 - top
	_check(h > 115.0 and h < 145.0, "altura do pulo %.0f px (~130, 90%% do humano)" % h)
	await ticks(40)

	# --- vãos e degraus
	_check(await cross(Vector2(760, 699), 1190, true), "vão 1 (Dunas): ímã no mastro e salto até a margem")
	_check(await cross(Vector2(2760, 699), 2875, false), "degrau de 75 px no fim da esteira")
	_check(await cross(Vector2(3000, 624), 3110, false), "degrau de 80 px até a plataforma grande")
	_check(await cross(Vector2(3325, 544), 3590, true), "vão 2 (Fábrica): âncora da abertura da parede")
	_check(await cross(Vector2(3990, 414), 4420, true), "vão 3 (Salão): âncora do teto do corredor")

	# --- esteira, válvula e plataformas
	await place(Vector2(1780, 700))
	var bx: float = p.global_position.x
	await ticks(28)
	_check(p.global_position.x > bx + 20.0, "a esteira empurra o Autômato")
	var warned := false
	var hot := false
	for i in 220:
		var v: Array = desert.vents[0]
		warned = warned or v[0].visible
		hot = hot or (v[1].visible and v[2].collision_layer == 16)
		await physics_frame
	_check(warned and hot, "válvula: aviso e jato que fere")
	for cart in desert.carts:
		var body: AnimatableBody2D = cart[0]
		await place(body.position + Vector2(60, -1))
		var before: Vector2 = p.global_position
		await ticks(44)
		_check(p.is_on_floor() and p.global_position.distance_to(before) > 12.0, "plataforma móvel leva o Autômato")

	# --- peso: sem recuo ao levar dano
	await place(Vector2(1300, 690), false)
	await ticks(6)
	var hp0: int = p.hp
	p.hurt(p.global_position + Vector2(40, 0), 1)
	await ticks(3)
	_check(p.hp == hp0 - 1 and absf(p.velocity.x) < 1.0 and p.velocity.y >= 0.0, "dano sem recuo (pesado)")
	await _wait(1.3)

	# --- Rebitadeira: robô em 3 rebites, cadência 20% menor
	var robot: DesertEnemy = null
	for e in _enemies():
		if not e.drone and e.patrol.x == 1205:
			robot = e
	await place(Vector2(1240, 690))
	robot.position = Vector2(1460, 700)
	robot.patrol = Vector2(1459, 1461)
	robot.cooldown = 99.0
	p.facing = 1
	var shots := 0
	var first_cd := -1.0
	for i in 200:
		if not is_instance_valid(robot) or robot.dead:
			break
		if p.atk_cd <= 0.0:
			Input.action_press("attack")
			await physics_frame
			Input.action_release("attack")
			shots += 1
			await physics_frame
			first_cd = maxf(first_cd, p.atk_cd + 2.0 / 60.0)
		await physics_frame
	_check(shots == 3 and (not is_instance_valid(robot) or robot.dead), "robô derrubado com 3 rebites (%d disparos)" % shots)
	_check(absf(first_cd - Upgrades.fire_cd(game) * 1.25) < 0.04, "cadência 20%% menor que o Estabilizador (%.2f s)" % first_cd)
	_check(game.collected.has("df_enemy1"), "robô derrotado fica registrado")

	# --- Pulso Magnético: drone cai, robô para, tiro inimigo desviado
	var drone: DesertEnemy = null
	for e in _enemies():
		if e.drone and e.patrol.x == 780:
			drone = e
	await place(Vector2(1300, 690))
	drone.position = Vector2(1320, 600)
	drone.altitude = 600
	var shot := DesertEnemy.DesertShot.new()
	shot.vel = Vector2(-200, 0)
	shot.position = p.global_position + Vector2(90, -30)
	lv.fx.add_child(shot)
	await ticks(2)
	p.energy = 40.0
	Input.action_press("special")
	await physics_frame
	Input.action_release("special")
	await ticks(2)
	_check(drone.falling or drone.downed > 0.0, "o Pulso derruba o drone")
	_check(not is_instance_valid(shot) or shot.is_queued_for_deletion(), "o Pulso desvia o projétil inimigo")
	_check(p.energy < 10.0, "o Pulso gasta 1/3 da energia")
	await ticks(60)
	_check(drone.downed > 0.0 and absf(drone.position.y - 686.0) < 20.0, "drone no chão, atordoado")
	await ticks(150)
	_check(not drone.falling and drone.downed <= 0.0, "depois de atordoado, o drone volta a voar")

	# --- feixe do ímã no drone (sem âncora ao alcance) e drone no jato da válvula
	var d2: DesertEnemy = null
	for e in _enemies():
		if e.drone and e.patrol.x == 6220:
			d2 = e
	await place(Vector2(6200, 769))
	d2.position = Vector2(6330, 600)
	d2.altitude = 600
	d2.cooldown = 99.0
	p.facing = 1
	_check(p.hook_candidate() == null, "sem âncora ao alcance no Salão das válvulas")
	desert.clock = 0.0
	Input.action_press("hook")
	await physics_frame
	Input.action_release("hook")
	await ticks(2)
	_check(d2.pull_to != Vector2.INF or d2.falling, "F sem âncora: o feixe puxa o drone até o chão")
	_check(p.beam_t > 0.0, "o feixe aparece entre o braço e o drone")
	await ticks(90)
	_check(d2.downed > 0.0 or d2.dead, "o drone puxado cai à frente do Autômato")
	d2.position.x = 6290
	d2.downed = 4.0
	var died := false
	for i in 260:
		if d2.dead or not is_instance_valid(d2):
			died = true
			break
		await physics_frame
	_check(died, "drone no chão diante da válvula: o jato o destrói")

	# --- Arranque: invulnerável
	await place(Vector2(6700, 769), false)
	await ticks(4)
	Input.action_press("dash")
	await physics_frame
	Input.action_release("dash")
	await ticks(2)
	await process_frame
	await process_frame
	_check(p.dash_t > 0.0 and p.body_spr.animation == "dash", "Arranque: avanço sobre as rodas (DF94) [%s %.2f cd %.2f chão %s]" % [p.body_spr.animation, p.dash_t, p.dash_cd, p.is_on_floor()])
	await ticks(20)

	# --- save: checkpoint e máquina derrotada persistem
	game.auto["save"] = "1"
	game.set_checkpoint(Vector2(4730, 415))
	game.show_menu()
	await _wait(0.4)
	game._on_menu("continue")
	await _wait(2.6)
	p = game.player
	_check(game.level.id == "deserto" and absf(p.global_position.x - 4730) < 10.0 and p.form == "automato", "Continuar: estação do Salão, forma Autômato")
	_check(not _enemies().any(func(e): return e.pid == "df_enemy1"), "a máquina derrotada continua derrotada")

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	SaveGame.erase()
	if backup != "":
		var fw := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
		fw.store_string(backup)
		fw.close()
	AudioMgr.inst.shutdown()
	quit(0 if fails == 0 else 1)
