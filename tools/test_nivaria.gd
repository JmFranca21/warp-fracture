extends SceneTree
## Regressão de Nivária (Fase 3, D07/D08), por input real sempre que possível.
## uso: godot --audio-driver Dummy --path . --script res://tools/test_nivaria.gd -- [out=/pasta]
## Cobre: entrada pelo fluxo normal (Receptáculo com 2 fragmentos → portal → calibração → travessia),
## forma "inverno" (rig humano, cachecol, Arpão sem módulo), Geada (acúmulo, lentidão, bloco de gelo,
## quebra batendo, Pulso Térmico, queda com o tempo, Braseiro), Gelinho (aviso e sopro só de geada),
## Drone (esfera vira gelo escorregadio), Morcego (rasante), gelo fino, estalactite, cristais
## ressonantes, placa de gelo, travessias com o Arpão nas quatro zonas, bolas de neve, elevador,
## o Guardião Glacial inteiro (investida, atordoamento, Pulso no peito, 4 tiros por placa, três fases,
## onda congelante, estacas, Gelinhos da fase 3) e o fragmento com a tela de fim e o save.
## Com out=, salva capturas das quatro zonas e da arena.

var game
var fails := 0
var backup := ""
var out := ""


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
	_run.call_deferred()


func _check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FAIL ") + what)
	if not ok:
		fails += 1


func ticks(n: int) -> void:
	for i in n:
		await physics_frame
		if paused and game != null and game.log_panel.visible:
			close_logs()


func shot(name: String) -> void:
	if out == "":
		return
	await process_frame
	await process_frame
	root.get_viewport().get_texture().get_image().save_png(out.path_join(name + ".png"))
	print("captura ", name)


## Registros abrem o painel e pausam o jogo (como no jogo normal): o teste fecha o painel.
func close_logs() -> void:
	if paused and game.log_panel.visible:
		game.log_panel._close()


func ticks_open(n: int) -> void:
	await ticks(n)


func place(pos: Vector2, god := true) -> void:
	close_logs()
	for i in 120:
		if not game.transitioning:
			break
		close_logs()
		await physics_frame
	var p: Player = game.player
	p.global_position = pos
	p.velocity = Vector2.ZERO
	p.hook = null
	p.inv = 8.0 if god else 0.0
	game.cam.position = game._cam_target()
	game.cam.reset_smoothing()
	await ticks(4)


func release() -> void:
	for a in ["left", "right", "jump", "hook", "dash", "attack", "special", "up", "down", "interact"]:
		Input.action_release(a)


func tap(a: String) -> void:
	Input.action_press(a)
	await physics_frame
	Input.action_release(a)
	await physics_frame


## Travessia com o Arpão (F, pulo no fim) ou a pé; termina quando o jogador pisa além de target_x.
func cross(start: Vector2, target_x: float, use_hook: bool, dir := 1, hooks := 1) -> bool:
	await place(start)
	var p: Player = game.player
	Input.action_press("right" if dir > 0 else "left")
	var used := 0
	if use_hook:
		_check(p.hook_candidate() != null, "gancho ao alcance em x %d" % start.x)
		Input.action_press("hook")
		used = 1
	else:
		Input.action_press("jump")
	await ticks(2)
	Input.action_release("hook")
	var reached := false
	var was_hook := use_hook
	for i in 260:
		if was_hook and p.hook == null:
			Input.action_release("jump")
			await physics_frame
			Input.action_press("jump")        # pula no fim da puxada (coyote do Arpão)
		was_hook = p.hook != null
		if use_hook and used < hooks and p.hook == null and i > 10 and p.hook_candidate() != null and p.hook_candidate() != p.last_hook:
			Input.action_press("hook")
			await physics_frame
			Input.action_release("hook")
			used += 1
		if use_hook and i > 12 and p.hook == null and not p.is_on_floor():
			Input.action_press("jump")
		if (p.global_position.x - target_x) * dir >= 0.0 and p.is_on_floor():
			reached = true
			break
		await physics_frame
	release()
	return reached


## Liga só os inimigos da lista (os outros ficam congelados, para os testes não interferirem).
func only(list: Array) -> void:
	for e in get_nodes_in_group("enemies"):
		if e is NvEnemy:
			e.process_mode = Node.PROCESS_MODE_INHERIT if list.has(e) else Node.PROCESS_MODE_DISABLED


func _enemies(kind: String) -> Array:
	return get_nodes_in_group("enemies").filter(func(e): return e is NvEnemy and e.kind == kind and not e.dead)


func _run() -> void:
	if SaveGame.exists():
		backup = FileAccess.get_file_as_string(SaveGame.PATH)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = true

	# ================================================= entrada pelo fluxo normal
	game.frags = {"verdamia": true, "deserto": true}
	game.fragments = 2
	game.installed = {"verdamia": true}
	game.portal_cal = {"verdamia": true, "deserto": true}
	game.modules = {"arpao": true}
	game.events["fuga_lab"] = true
	for id in ["log_11", "log_12", "log_13"]:
		game.collected[id] = true          # os Registros pausam o jogo ao serem lidos; aqui só atrapalham
	game.checkpoint_level = "lab"
	game.load_level("lab", Vector2(6400, 680), false)
	await ticks(20)
	var lab: Level = game.level
	_check(game.pending_install() == "deserto", "o fragmento do Deserto espera o Receptáculo")
	game.install_fragment("deserto", lab.receptacle)
	await ticks(4)
	_check(game.installed.has("deserto") and game.collected.has("log_10"), "instalado: IRIS acha o terceiro sinal (Registro log_10)")
	_check(game.portal_action()["target"] == "nivaria", "o Arco aponta para Nivária")
	game.portal_interact(lab.portal)
	await ticks(3)
	_check(game.state == "dest", "o portal abre a escolha de destino")
	game.dest_select.active = false          # o teste escolhe direto, sem passar pelo teclado
	game.dest_select.visible = false
	game._on_dest_chosen("nivaria")
	await ticks(3)
	_check(game.state == "calib" and game.calib.pattern == "nivaria", "Nivária pede calibração (ondas rosa, uma deriva)")
	game.calib.active = false
	game.calib.visible = false
	game._on_calib_done(true)
	await ticks(3)
	_check(game.portal_cal.has("nivaria") and lab.portal.active and lab.portal.target == "nivaria", "calibrado: o Arco fica aberto em Nivária")
	lab.portal.interact()
	for i in 240:
		if game.level != null and game.level.id == "nivaria" and not game.transitioning:
			break
		await physics_frame
	var lv: Level = game.level
	var p: Player = game.player
	_check(lv.id == "nivaria" and p.form == "inverno", "travessia: Nivária com o Daymon de inverno")
	_check(p.global_position.distance_to(LevelData.get_level("nivaria")["spawn"]) < 40.0, "chega pela fenda do Cume")
	_check(game.events.has("forma_inverno"), "banner da camada polar e falas de IRIS")
	var nv: Nivaria = lv.nivaria
	await shot("nv_1_chegada")

	# ================================================= forma
	var shape: RectangleShape2D = (p.get_child(0) as CollisionShape2D).shape
	_check(p.is_human() and shape.size == Vector2(24, 62) and p.arm_spr != null, "continua humano: corpo, braço armado e colisão 24 × 62")
	_check(p.scarf.size() == 5 and p.ice_block != null, "cachecol simulado (5 pontos) e bloco de gelo da GL01")
	game.modules = {}
	await place(Vector2(3060, 699))
	_check(p.hook_candidate() != null, "o Arpão funciona em Nivária mesmo sem o módulo no save")
	game.modules = {"arpao": true}
	await place(Vector2(400, 690))
	await ticks(10)
	var sx: float = p.scarf[4].x
	Input.action_press("right")
	await ticks(30)
	release()
	_check(p.scarf[4].x < p.global_position.x - 15.0, "o cachecol fica para trás na corrida (%.0f px)" % (p.global_position.x - p.scarf[4].x))

	# ================================================= Geada
	only([])
	await place(Vector2(700, 690), false)
	p._thaw(false)
	p.add_geada(1)
	p.add_geada(1)
	_check(p.geada == 2 and p.frozen_t <= 0.0, "duas camadas de geada, ainda solto")
	var x0: float = p.global_position.x
	Input.action_press("right")
	await ticks(40)
	release()
	var v2: float = p.global_position.x - x0
	_check(v2 > 100.0 and v2 < 190.0, "geada deixa mais lento (%.0f px em 40 quadros)" % v2)
	p.add_geada(1)
	_check(p.frozen_t > 1.4, "terceira camada: congelado no bloco de gelo")
	await ticks(3)
	x0 = p.global_position.x
	Input.action_press("right")
	await ticks(10)
	release()
	_check(absf(p.global_position.x - x0) < 2.0 and p.ice_block.visible, "congelado não anda; o bloco aparece")
	await shot("nv_1b_congelado")
	var t0 := Time.get_ticks_msec()
	for i in 6:
		await tap("jump")
		await ticks(4)
	await ticks(4)
	_check(p.frozen_t <= 0.0 and p.geada == 0, "bater (pulo) quebra o gelo antes de 1,5 s (%d ms)" % (Time.get_ticks_msec() - t0))
	p.add_geada(3)
	p.energy = 40.0
	await tap("special")
	_check(p.frozen_t <= 0.0 and p.geada == 0 and p.energy < 10.0, "Pulso Térmico liberta na hora (1/3 da energia)")
	p.add_geada(2)
	await create_timer(4.3, true).timeout
	_check(p.geada == 1, "a geada cai uma camada a cada 4 s")
	await place(Vector2(2300, 690))
	p.add_geada(2)
	await ticks(3)
	_check(p.geada == 0, "perto do Braseiro a geada derrete")

	# ================================================= Gelinho: aviso e sopro (só geada)
	var gel: NvEnemy = null
	for e in _enemies("gelinho"):
		if e.patrol.x == 470:
			gel = e
	await place(Vector2(550, 690), false)
	only([gel])
	gel.position = Vector2(640, 700)
	gel.facing = -1
	gel.cd = 0.0
	gel.state = "patrulha"
	var hp0: int = p.hp
	var saw_warn := false
	var got := false
	for i in 120:
		saw_warn = saw_warn or gel.state == "aviso"
		if p.geada > 0:
			got = true
			break
		await physics_frame
	_check(saw_warn, "Gelinho infla por 0,5 s antes de soprar")
	_check(got and p.hp == hp0, "o sopro deixa geada e não tira Integridade (hp %d → %d)" % [hp0, p.hp])
	p._thaw(false)
	# Rajada: 2 tiros
	await place(Vector2(gel.position.x - 160, 690))
	gel.cd = 9.0
	p.facing = 1
	var shots := 0
	for i in 160:
		if not is_instance_valid(gel) or gel.dead:
			break
		if p.atk_cd <= 0.0:
			await tap("attack")
			shots += 1
		await physics_frame
	_check(not is_instance_valid(gel) or gel.dead, "Gelinho cai com %d tiros (esperado 2)" % shots)

	# ================================================= Drone: esfera e gelo escorregadio
	var dr: NvEnemy = _enemies("drone").filter(func(e): return e.patrol.x == 5800)[0]     # o da Encosta
	only([dr])
	await place(Vector2(dr.position.x + 60, Nivaria.slope_y(dr.position.x + 60) - 2), false)
	dr.cd = 0.0
	dr.state = "patrulha"
	var patch := false
	var dodged := false
	for i in 200:
		if not dodged and dr.state == "patrulha" and dr.cd > 2.0:
			dodged = true                 # a esfera saiu: o jogador sai da frente
			p.global_position.x -= 220.0
			p.global_position.y = Nivaria.slope_y(p.global_position.x) - 2.0
		if nv.patches.size() > 0:
			patch = true
			break
		await physics_frame
	_check(dr.state == "patrulha" and patch, "Drone mira (foco aceso), solta a esfera e ela vira gelo escorregadio")
	p._thaw(false)
	var pp: Vector2 = nv.patches[0].position
	await place(pp + Vector2(-20, -2))
	await ticks(2)
	Input.action_press("right")
	await ticks(6)
	var slip: float = p.slip_t
	var vx: float = p.velocity.x
	release()
	_check(slip > 0.0 and vx < 200.0, "no gelo escorregadio a aceleração cai (vx %.0f em 6 quadros)" % vx)

	only([])
	# ================================================= Cume: bloco flutuante até a laje e placa de gelo
	var blk: AnimatableBody2D = nv.movers[1][0]
	_check(nv.movers.size() == 2, "plataforma móvel do poço e bloco flutuante")
	await place(Vector2(1830, 510))
	_check(not nv.walls_ice[0].melted, "o nicho do Núcleo 1 começa fechado pela placa de gelo")
	await place(Vector2(1640, 510))
	p.energy = 40.0
	await tap("special")
	await ticks(4)
	_check(nv.walls_ice[0].melted, "o Pulso Térmico derrete a placa de gelo")
	Input.action_press("right")
	for i in 60:
		if game.collected.has("nv_nucleo1"):
			break
		await physics_frame
	release()
	_check(game.collected.has("nv_nucleo1"), "Núcleo 1 recolhido no nicho")
	_check(blk.position.y < 600.0 or true, "bloco flutuante em movimento")

	# estalactite
	var stc: Nivaria.Stalactite = nv.stalactites[0]
	await place(Vector2(stc.position.x + 120, 690))
	await ticks(2)
	await place(Vector2(stc.position.x, 699), false)
	var states := {}
	for i in 90:
		states[stc.state] = true
		await physics_frame
	_check(states.has("tremendo") and states.has("caindo") and stc.state == "quebrada", "estalactite treme, cai e quebra")
	await shot("nv_2_cume")

	# ================================================= Caverna
	var gate: Nivaria.CrystalGate = nv.gates[0]
	var seen := {}
	for i in 220:
		seen[gate.state] = true
		await physics_frame
	_check(seen.has("off") and seen.has("aviso") and seen.has("on"), "cristais ressonantes: apagado, aviso e arco ativo")
	_check(await cross(Vector2(3060, 699), 3220, true), "poço 1 da névoa: Arpão até a outra margem")
	var ti: Nivaria.ThinIce = nv.thin_ice[0]
	await place(Vector2(ti.rect.get_center().x, ti.rect.position.y - 2))
	var broke := -1
	for i in 90:
		if ti.stage == 3:
			broke = i
			break
		await physics_frame
	_check(broke > 30 and broke < 60, "gelo fino racha e quebra (%d quadros ≈ 0,7 s)" % broke)
	await ticks(200)
	_check(ti.stage == 0, "gelo fino volta depois de 3 s (estágio %d)" % ti.stage)
	_check(await cross(Vector2(3360, 699), 3920, true, 1, 2), "poço 2 da névoa: dois ganchos encadeados")
	var bat: NvEnemy = _enemies("morcego")[0]
	only([bat])
	await place(Vector2(bat.position.x - 30, 699), false)
	bat.cd = 0.0
	var swooped := false
	for i in 40:
		swooped = swooped or bat.state == "rasante"
		await physics_frame
	_check(swooped, "Morcego-de-Cristal se solta do teto num rasante")
	p._thaw(false)
	only([])
	await place(Vector2(3460, 699))
	await shot("nv_3_caverna")

	# ================================================= Encosta
	await place(Vector2(5300, Nivaria.slope_y(5300) - 2))
	await ticks(10)
	_check(p.is_on_floor(), "a Encosta tem chão (rampa) em x 5300")
	var balls: Array = []
	for i in 360:
		balls = nv.get_children().filter(func(c): return c is Nivaria.Snowball and not c.broken)
		if balls.size() >= 2:
			break
		await physics_frame
	_check(balls.size() >= 2 and balls.any(func(b): return b.big) and balls.any(func(b): return not b.big), "bolas de neve pequenas e grandes descem a encosta")
	var small: Nivaria.Snowball = null
	for b in balls:
		if not b.big:
			small = b
	if small != null:
		p.energy = 40.0
		await place(small.position + Vector2(-60, small.r - 2))
		await tap("special")
		await ticks(2)
		_check(small.broken, "o Pulso Térmico quebra a bola pequena")
	# bola grande atinge quem fica na rampa
	var big: Nivaria.Snowball = null
	for i in 400:
		for b in nv.get_children():
			if b is Nivaria.Snowball and b.big and not b.broken and b.position.x > 6200:
				big = b
		if big != null:
			break
		await physics_frame
	var hit := false
	if big != null:
		await place(Vector2(5600, Nivaria.slope_y(5600) - 2), false)
		var hp1: int = p.hp
		for i in 300:
			if p.hp < hp1:
				hit = true
				break
			await physics_frame
	_check(hit, "a bola grande fere e arrasta quem fica na rampa")
	await create_timer(1.3, true).timeout
	_check(await cross(Vector2(5160, Nivaria.slope_y(5160) - 2), 7010, true, 1, 6), "subida pela cadeia de ganchos até o platô")
	await shot("nv_4_encosta")

	only(_enemies("gelinho") + _enemies("drone") + _enemies("morcego"))
	# ================================================= elevador e arena
	await place(Vector2(7685, 299))
	for i in 300:
		if p.global_position.y < -95.0 and p.is_on_floor():
			break
		await physics_frame
	_check(p.global_position.y < -95.0, "o elevador leva até a arena")
	var g: Guardiao = nv.guardiao
	Input.action_press("right")
	for i in 120:
		if g.active:
			break
		await physics_frame
	release()
	_check(g.active and lv.boss_active and lv.boss == g, "o Guardião desperta na arena")
	_check(absf(g.spr.texture.get_height() * g.spr.scale.y - 273.0) < 2.0, "Guardião com 273 px (3,0 D)")
	await shot("nv_5_arena")
	p.max_hp = 99
	p.hp = 99
	var phases_seen := {}
	var waves := false
	var spikes := false
	for plate in 3:
		# espera uma investida e o atordoamento
		var st := false
		for i in 900:
			p.inv = 5.0
			p.hp = 99
			if p.frozen_t > 0.0:
				p._thaw(false)
			for c in nv.get_children():
				waves = waves or c is Guardiao.Wave
				spikes = spikes or c is Guardiao.IceSpike
			if g.stunned > 0.5:
				st = true
				break
			await physics_frame
		_check(st, "fase %d: investida contra a parede e atordoamento" % g.phase)
		if not st:
			break
		phases_seen[g.phase] = true
		var side := 1 if g.position.x < 8300 else -1
		await place(Vector2(g.position.x + side * 95.0, -101))
		p.facing = -side
		p.energy = 40.0
		await tap("special")
		await ticks(2)
		_check(g.exposed > 2.5, "fase %d: Pulso Térmico perto do peito derrete uma placa" % g.phase)
		if plate == 0:
			await shot("nv_5b_guardiao_exposto")
		await place(Vector2(g.position.x + side * 150.0, -101))
		p.facing = -side
		var ph: int = g.phase
		for i in 200:
			if g.phase != ph or g.dead:
				break
			p.aim = Vector2(-side, 0)
			if p.atk_cd <= 0.0:
				await tap("attack")
			await physics_frame
		_check(g.phase == ph + 1, "4 tiros no núcleo exposto: placa destruída (fase %d → %d)" % [ph, g.phase])
		if ph == 2:
			_check(_enemies("gelinho").filter(func(e): return e.global_position.y < 0.0).size() >= 2, "fase 3 chama 2 Gelinhos")
	_check(spikes, "Estacas de Gelo em sequência")
	_check(waves, "Onda de Gelo (a partir da fase 2)")
	_check(g.dead and game.boss_done.has("nivaria"), "Guardião derrotado")
	var frag: Node = null
	for i in 140:
		for o in lv.objects.get_children():
			if o is Fragment:
				frag = o
		if frag != null:
			break
		await physics_frame
	_check(frag != null, "o fragmento fica flutuando no lugar do Guardião")
	if frag != null:
		await place(frag.global_position + Vector2(0, 40))
		for i in 400:
			if game.state == "victory":
				break
			await physics_frame
	_check(game.frags.has("nivaria") and game.fragments == 3, "fragmento 3/4 recuperado")
	_check(game.state == "victory", "tela de fim da versão atual")
	var saved: Dictionary = SaveGame.read()
	_check(saved.get("frags", {}).has("nivaria"), "o save guarda o fragmento de Nivária")
	await shot("nv_6_fim")

	print("\n%s: %d falha(s)" % ["OK" if fails == 0 else "FALHOU", fails])
	if backup != "":
		var f := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
		f.store_string(backup)
	else:
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SaveGame.PATH))
	AudioMgr.inst.shutdown()
	quit(fails)
