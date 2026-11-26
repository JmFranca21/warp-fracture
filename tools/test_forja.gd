extends SceneTree
## Regressão da luta contra a Forja-Mãe (D04), por input real (ímã, pulos, rebites e pulso).
## uso: godot --audio-driver Dummy --path . --script res://tools/test_forja.gd -- save at=999
## Cobre: estação antes da porta, porta que fecha, câmera da sala inteira, martelo com aviso e marca,
## dano sem recuo, ímã até o martelo preso, rebites no núcleo do pistão (fases 1 e 2), esteira, drones,
## fase 3 (Pulso abre o peito, feixe, sobrecarga), morte e nova tentativa, vitória, fragmento 2/4,
## portas abertas, fenda de retorno e a volta ao Hélix com o segundo fragmento.

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


func release() -> void:
	for a in ["left", "right", "jump", "hook", "dash", "attack", "special", "up", "down"]:
		Input.action_release(a)


func tap(a: String, n := 2) -> void:
	Input.action_press(a)
	await ticks(n)
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


func forja() -> Forja:
	return game.level.desert.forja


## Fases 1 e 2: espera o martelo prender, sobe nele com o ímã e acerta o núcleo do pistão por cima.
func ride_and_shoot(arm_i: int, limit := 70.0) -> bool:
	var f := forja()
	var a: Forja.Arm = f.arms[arm_i]
	var p: Player = game.player
	var start_phase := f.phase
	var t := 0.0
	var rode := false
	while t < limit and f.phase == start_phase and not f.dead:
		p.inv = 99.0
		if a.state == "stuck" and a.st > 0.5 and p.hook == null:
			var h = p.hook_candidate()
			if OS.has_environment("DBG"):
				print("  stuck: cand=", h, " hook=", a.hook.global_position, " p=", p.global_position.round(), " hp=", f.hp, " dist=", a.hook.global_position.distance_to(p.shoulder_global()))
			if h == a.hook:
				await tap("hook")
				for i in 40:
					await physics_frame
					if p.hook == null:
						break
				await ticks(4)
				if p.is_on_floor() and absf(p.global_position.y - (a.jy + Forja.HAMMER_TOP)) < 8.0:
					rode = true
				if OS.has_environment("DBG"):
					print("  after pull: p=", p.global_position.round(), " floor=", p.is_on_floor(), " top=", a.jy + Forja.HAMMER_TOP)
				# de pé na chapa do martelo: rebites à queima-roupa na junta (núcleo do pistão)
				for k in 5:
					if a.state != "stuck":
						break
					while p.atk_cd > 0.0 and a.state == "stuck":
						await physics_frame
					await tap("attack")
					if p.is_on_floor() and absf(p.global_position.y - (a.jy + Forja.HAMMER_TOP)) < 8.0:
						rode = true
					if OS.has_environment("DBG"):
						print("  shot: p=", p.global_position.round(), " aim=", p.aim, " hp=", f.hp)
		elif a.state in ["idle", "track", "warn", "recover"] and p.is_on_floor():
			# fica perto do braço: o martelo vem até o jogador
			var dx := a.x - p.global_position.x
			if absf(dx) > 140.0:
				Input.action_press("right" if dx > 0.0 else "left")
			else:
				release()
		await physics_frame
		t += 1.0 / 60.0
	release()
	return rode and f.phase != start_phase


func _run() -> void:
	if SaveGame.exists():
		backup = FileAccess.get_file_as_string(SaveGame.PATH)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await ticks(4)
	game.auto["save"] = "1"
	game._reset_progress()
	game.frags = {"verdamia": true}
	game.fragments = 1
	game.installed = {"verdamia": true}
	game.portal_cal = {"verdamia": true, "deserto": true}
	game.menu.visible = false
	game.hud.visible = true
	game.checkpoint_level = "deserto"
	game.checkpoint_pos = Vector2(6650, 760)
	game.load_level("deserto", game.checkpoint_pos, false)
	await ticks(20)
	var p: Player = game.player
	var desert: Desert = game.level.desert

	# --- estação e entrada
	_check(game.level.objects.get_children().any(func(n): return n is Checkpoint and absf(n.position.x - 6650) < 1.0), "estação antes da porta da Câmara")
	# revisão geral: a entrada fica presa por placas imantadas até o Pulso Magnético (antes: já aberta)
	_check(not desert.door_open("in") and desert.mag_lock != null and not desert.door_open("out"), "porta de entrada imantada; saída trancada")
	p.global_position = Vector2(6930, 760)
	p.energy = 40.0
	await ticks(4)
	await tap("special")
	await ticks(6)
	_check(desert.door_open("in") and game.events.has("porta_imantada"), "o Pulso perto das placas abre a entrada da Câmara")
	p.global_position = Vector2(6650, 760)
	await ticks(4)
	Input.action_press("right")
	var started := false
	for i in 300:
		await physics_frame
		if forja().active:
			started = true
			break
	release()
	_check(started and game.level.boss_active and game.level.boss == forja(), "entrar na Câmara acorda a Forja-Mãe")
	await ticks(6)
	_check(not desert.door_open("in"), "a porta se fecha atrás do jogador")
	_check(game.level.boss_cam != Vector2.INF, "a câmera se abre para a sala inteira")
	_check(game.hud.title == "FORJA-MÃE", "título \"FORJA-MÃE\"")
	await _wait(1.0)
	_check(game.cam.zoom.x < 0.9, "zoom da câmera para mostrar a Câmara")

	# --- martelo: aviso, marca e dano sem recuo
	var f := forja()
	var a0: Forja.Arm = f.arms[0]
	p.inv = 0.0
	var t_warn := -1.0
	var t_slam := -1.0
	var t := 0.0
	var hp0: int = p.hp
	var vx_hit := 999.0
	while t < 6.0:
		await physics_frame
		t += 1.0 / 60.0
		if a0.state == "warn" and t_warn < 0.0:
			t_warn = t
			_check(absf(a0.x - p.global_position.x) < 80.0, "o carrinho corre no trilho até ficar sobre o jogador")
		if a0.state == "stuck" and t_slam < 0.0:
			t_slam = t
		if p.hp < hp0 and vx_hit == 999.0:
			vx_hit = p.velocity.x
		if t_slam > 0.0 and t > t_slam + 0.2:
			break
	_check(t_warn > 0.0 and t_slam - t_warn >= 0.68, "aviso do martelo de %.2f s (marca vermelha, faixas acesas)" % (t_slam - t_warn))
	_check(p.hp < hp0 and absf(vx_hit) < 1.0, "parado na marca: leva dano, sem recuo")
	_check(a0.hammer.frame == 2 and a0.hook.is_in_group("hooks"), "martelo preso: placa de âncora acesa e ímã disponível")

	# --- morte durante a luta: volta à estação, a Forja volta inteira, sem repetir a abertura longa
	p.inv = 0.0
	p.hurt(p.global_position + Vector2(10, 0), 99)
	await _wait(3.6)
	p = game.player
	_check(not p.dead and absf(p.global_position.x - 6650) < 30.0 and not forja().active and forja().phase == 0, "morrer: volta à estação com a Forja-Mãe inteira")
	Input.action_press("right")
	for i in 300:
		await physics_frame
		if forja().active:
			break
	release()
	_check(forja().active and forja().next_t < 1.0, "na nova tentativa a abertura é curta (%.1f s)" % forja().next_t)
	f = forja()
	desert = game.level.desert

	# --- fase 1: ímã até o martelo e rebites no pistão esquerdo
	_check(await ride_and_shoot(0), "fase 1: ímã até o martelo preso, de pé no braço, rebites no núcleo do pistão (6)")
	_check(f.phase == 2 and f.arms[0].state == "broken" and f.arms[0].hammer.frame == 3, "o braço esquerdo cede (martelo destruído)")

	# --- fase 2: braço direito mais rápido, esteira e drones
	var belt_seen := false
	var drones_seen := false
	var warn2 := -1.0
	var tt := 0.0
	var a1: Forja.Arm = f.arms[1]
	var st_warn := -1.0
	while tt < 14.0 and (not belt_seen or not drones_seen or warn2 < 0.0):
		game.player.inv = 99.0
		await physics_frame
		tt += 1.0 / 60.0
		belt_seen = belt_seen or f.belt_on > 0.0
		drones_seen = drones_seen or f.drones.size() > 0
		if a1.state == "warn" and st_warn < 0.0:
			st_warn = tt
		if a1.state == "slam" and st_warn > 0.0 and warn2 < 0.0:
			warn2 = tt - st_warn
	_check(warn2 > 0.0 and warn2 < 0.62, "fase 2: o braço direito avisa mais rápido (%.2f s)" % warn2)
	_check(belt_seen, "fase 2: a esteira liga, com setas acesas antes")
	_check(drones_seen, "fase 2: as escotilhas soltam drones")
	for d in f.drones:
		if is_instance_valid(d) and not d.dead:
			d.die()
	_check(await ride_and_shoot(1), "fase 2: núcleo do pistão direito destruído (6)")
	_check(f.phase == 3 and f.arms[1].state == "broken", "fase 3: os dois braços caem")

	# --- fase 3: Pulso perto do peito abre as placas; rebites no núcleo central; feixe e sobrecarga
	p = game.player
	var beam_seen := false
	var vents_seen := false
	var opened := 0
	var t3 := 0.0
	while t3 < 90.0 and not f.dead:
		p.inv = 99.0
		beam_seen = beam_seen or f.beam_x > 0.0
		vents_seen = vents_seen or f.vents[0][1].visible
		var dx := Forja.CHEST.x - p.global_position.x
		if absf(dx) > 20.0:
			Input.action_press("right" if dx > 0.0 else "left")
		else:
			release()
		if f.chest_open <= 0.0 and absf(dx) < 60.0:
			if p.energy < 33.0:
				p.energy = 40.0           # (a Câmara também tem energia que reaparece)
			await tap("special")
			await ticks(3)
			if f.chest_open > 0.0:
				opened += 1
		elif f.chest_open > 0.0:
			Input.action_press("up")
			if p.atk_cd <= 0.0:
				await tap("attack")
		await physics_frame
		t3 += 1.0 / 60.0
	release()
	_check(opened > 0, "o Pulso Magnético perto do peito arranca as placas (%d vezes)" % opened)
	_check(beam_seen, "fase 3: o feixe da lente varre o chão")
	_check(vents_seen, "fase 3: sobrecarga nas válvulas laterais")
	_check(f.dead and game.boss_done.has("deserto"), "núcleo central destruído (8): Forja-Mãe derrotada")
	_check(f.lens.texture.region == DFArt.cell("DF101", 3).region and f.grate.animation == "fria", "a lente apaga e a fornalha esfria")
	await _wait(1.8)
	var frag: Fragment = null
	for n in game.level.objects.get_children():
		if n is Fragment:
			frag = n
	_check(frag != null, "o fragmento 2/4 sobe da câmara do peito")

	# --- pegar o fragmento
	p.inv = 0.0
	p.global_position = Vector2(frag.global_position.x, 760)
	await ticks(4)
	await tap("jump", 12)
	await ticks(30)
	_check(game.frags.has("deserto") and game.fragments == 2, "fragmento do Deserto recuperado: 2/4")
	_check(game.hud.banner_a == "FRAGMENTO RECUPERADO · 2/4", "letreiro 2/4")
	await _wait(3.4)
	_check(desert.door_open("out") and desert.door_open("in"), "as portas da Câmara se abrem")
	_check(game.level.return_rift != null, "a fenda de retorno aparece atrás da porta direita")
	await _wait(3.0)
	# desde a Fase 3 (Nivária), o Deserto não encerra mais a versão: IRIS manda instalar o fragmento
	_check(game.state == "level" and not game.hud.victory and not game.player.controls_locked, "sem tela de fim: o jogo segue para o Receptáculo")

	# --- volta ao Hélix com o segundo fragmento
	p = game.player
	p.global_position = game.level.return_rift.global_position + Vector2(-20, -10)
	await _wait(0.4)
	await _key(KEY_E)
	await _wait(3.6)
	_check(game.level.id == "lab" and game.player.form == "human" and game.fragments == 2, "a fenda leva de volta ao Hélix com 2/4")
	_check(game.level.receptacle.prompt == "[E] Instalar o fragmento", "o Receptáculo pede o segundo fragmento")
	game.player.global_position = game.level.receptacle.global_position + Vector2(-10, -10)
	await _wait(0.4)
	await _key(KEY_E)
	await _wait(0.3)
	_check(game.installed.has("deserto") and game.level.receptacle.gems[1].visible, "segundo fragmento instalado no Receptáculo")
	game.show_menu()
	await _wait(0.4)
	game._on_menu("continue")
	await _wait(2.6)
	game.load_level("deserto", Vector2(7300, 760), false)
	await ticks(10)
	_check(game.level.desert.forja.dead and game.level.desert.door_open("out") and game.level.desert.door_open("in"),
		"depois da vitória, a Câmara fica aberta e a Forja-Mãe apagada para sempre")
	_check(not game.level.objects.get_children().any(func(n): return n is Fragment), "o fragmento não reaparece")

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	SaveGame.erase()
	if backup != "":
		var fw := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
		fw.store_string(backup)
		fw.close()
	AudioMgr.inst.shutdown()
	quit(0 if fails == 0 else 1)
