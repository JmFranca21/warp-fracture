extends SceneTree
## Alcance do layout de Nivária (Fase 3), jogado por input real (ações de teclado).
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_nivaria.gd -- level=nivaria arpao at=999
## Cobre cada passagem obrigatória das quatro zonas: subida do Cume até o bloco flutuante, plataforma
## móvel sobre o precipício, os quatro poços da Caverna na ida e na volta, subida da Encosta a pé,
## argola de cada mastro alcançável dos dois lados, elevador até a Arena e ganchos do teto da Arena.

var game
var fails := 0


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


func _p() -> Player:
	return game.player


## Coloca o jogador parado no chão em pos.
func _place(pos: Vector2) -> void:
	_release_all()
	var p := _p()
	p.global_position = pos
	p.velocity = Vector2.ZERO
	p.hook = null
	await _wait(0.35)


## Corre na direção dir e pula ao passar de jump_x (segurando o pulo até o ápice); continua até pousar.
## Com hook_after, aperta o Arpão no ápice e salta de novo ao passar de release_x.
func _leap(dir: String, jump_x: float, limit := 3.0, hook_after := false, release_x := NAN) -> Vector2:
	var p := _p()
	var sgn := 1.0 if dir == "right" else -1.0
	var t := 0.0
	var stage := 0
	Input.action_press(dir)
	while t < limit:
		await physics_frame
		t += 1.0 / 60.0
		p = _p()
		if not is_instance_valid(p) or p.dead:
			break
		var x := p.global_position.x
		match stage:
			0:
				if (x - jump_x) * sgn >= 0.0 and p.is_on_floor():
					Input.action_press("jump")
					stage = 1
			1:
				if not p.is_on_floor() and p.velocity.y > -60.0:
					Input.action_release("jump")
					if hook_after:
						await _tap("hook")
						stage = 3
					else:
						stage = 2
			2:
				if p.is_on_floor():
					break
			3:
				if p.hook != null and not is_nan(release_x) and (x - release_x) * sgn >= 0.0:
					await _tap("jump")
					stage = 2
				elif p.hook == null and p.is_on_floor():
					break
	_release_all()
	await _wait(0.2)
	p = _p()
	return p.global_position if is_instance_valid(p) else Vector2.ZERO


## Anda na direção dir até cair de uma beirada e pousar de novo.
func _drop(dir: String, limit := 3.0) -> Vector2:
	var t := 0.0
	var left := false
	Input.action_press(dir)
	while t < limit:
		await physics_frame
		t += 1.0 / 60.0
		var p := _p()
		if not p.is_on_floor():
			left = true
		elif left:
			break
	_release_all()
	await _wait(0.2)
	return _p().global_position


## Atravessa um poço pelos ganchos do teto: pula em jump_x, puxa o gancho no ápice, encadeia os ganchos
## seguintes na mesma direção e solta com um pulo ao passar de release_x; continua até pousar.
func _swing(dir: String, jump_x: float, release_x: float, hooks := 1, limit := 5.0) -> Vector2:
	var p := _p()
	var sgn := 1.0 if dir == "right" else -1.0
	var t := 0.0
	var stage := 0
	var used := {}
	Input.action_press(dir)
	while t < limit:
		await physics_frame
		t += 1.0 / 60.0
		p = _p()
		if not is_instance_valid(p) or p.dead:
			break
		var x := p.global_position.x
		match stage:
			0:
				if (x - jump_x) * sgn >= 0.0 and p.is_on_floor():
					Input.action_press("jump")
					stage = 1
			1:
				if not p.is_on_floor() and p.velocity.y > -60.0:
					Input.action_release("jump")
					await _tap("hook")
					stage = 3
			3:
				if p.hook != null:
					used[p.hook.get_instance_id()] = true
					var near: bool = p.global_position.distance_to(p.hook.global_position + Vector2(0, 46)) < 60.0
					var nxt := p.hook_candidate()
					if near and used.size() < hooks and nxt != null and not used.has(nxt.get_instance_id()) and (nxt.global_position.x - p.hook.global_position.x) * sgn > 0.0:
						await _tap("hook")
					elif (x - release_x) * sgn >= 0.0:
						await _tap("jump")
						stage = 2
				elif p.is_on_floor():
					break
			2:
				if p.is_on_floor():
					break
	_release_all()
	await _wait(0.2)
	p = _p()
	return p.global_position if is_instance_valid(p) else Vector2.ZERO


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await _wait(0.5)
	_check(game.level != null and game.level.id == "nivaria", "a fase Nivária carrega com o Yeti")
	_check(_p().form == "yeti" and game.modules.has("arpao"), "Yeti com o Arpão de Fase")
	var hp0 := _p().hp

	# --- A · Cume: desce o pico a pé até o patamar sobre o primeiro abismo
	await _place(Vector2(-2450, -910))
	Input.action_press("right")
	var t := 0.0
	while t < 8.0 and _p().global_position.x < -1150.0:
		await physics_frame
		t += 1.0 / 60.0
	_release_all()
	await _wait(0.4)
	_check(absf(_p().global_position.y + 430.0) < 6.0, "Cume: desce a encosta do pico a pé em %.1f s (%s)" % [t, _p().global_position.round()])
	# abismo 1: placa de gelo, placa quebradiça e o outro lado
	var at := await _leap("right", -1080.0, 2.0)
	_check(absf(at.y + 370.0) < 6.0, "Cume: pula na placa de gelo (%s)" % at.round())
	at = await _leap("right", -790.0, 2.0)
	_check(absf(at.y + 330.0) < 6.0, "Cume: pula na placa quebradiça (%s)" % at.round())
	at = await _leap("right", -490.0, 2.0)
	_check(at.x > -350.0 and absf(at.y + 250.0) < 6.0, "Cume: atravessa o primeiro abismo antes da placa cair (%s)" % at.round())
	# a placa quebradiça cai depois de pisada e volta sozinha
	var crack: NivPlatform = null
	var preso: NivPreso = null
	for n in game.level.get_children():
		if n is Nivaria:
			for pl in n.platforms:
				if pl.kind == "quebradica" and crack == null:
					crack = pl
			for c in n._all(n):
				if c is NivPreso:
					preso = c
	_check(crack.state >= 2, "Cume: a placa quebradiça caiu depois de pisada")
	await _wait(3.2)
	_check(crack.state == 0, "Cume: a placa quebradiça voltou")
	# alpinista preso no gelo fecha a passagem até ser quebrado
	await _place(Vector2(-100, -260))
	Input.action_press("right")
	await _wait(0.8)
	_release_all()
	_check(_p().global_position.x < preso.global_position.x - 20.0, "Cume: o bloco de gelo fecha a passagem (%s)" % _p().global_position.round())
	for k in 3:
		if preso.broken:
			break
		await _tap("special")
		await _wait(0.85)
	_check(preso.broken, "Cume: o chute giratório quebra o gelo do alpinista")
	await _wait(1.2)
	_check(is_instance_valid(preso) and preso.runner != null and preso.runner.global_position.x > preso.global_position.x + 60.0,
		"Cume: o alpinista foge para longe do Yeti")
	# desce a segunda encosta até a beira do segundo abismo
	Input.action_press("right")
	t = 0.0
	while t < 8.0 and _p().global_position.x < 1100.0:
		await physics_frame
		t += 1.0 / 60.0
	_release_all()
	await _wait(0.4)
	_check(absf(_p().global_position.y - 190.0) < 6.0, "Cume: passa pelo arco e desce a segunda encosta (%s)" % _p().global_position.round())
	# segundo abismo: desce andando pelas beiradas (placa quebradiça → placa de gelo → vale)
	at = await _drop("right")
	_check(absf(at.y - 320.0) < 6.0, "Cume: desce na segunda placa quebradiça (%s)" % at.round())
	at = await _drop("right")
	_check(absf(at.y - 480.0) < 6.0, "Cume: desce na placa de gelo de baixo (%s)" % at.round())
	at = await _drop("right")
	_check(at.x > 1750.0 and absf(at.y - 800.0) < 4.0, "Cume: chega ao vale da caverna (%s)" % at.round())
	_check(_p().hp == hp0, "Cume: nenhum dano na descida")
	# argola do Cume: alcançável da placa quebradiça, com a célula
	await _place(Vector2(1330, 310))
	await _tap("hook")
	t = 0.0
	var hooked := false
	while t < 1.2:
		await physics_frame
		t += 1.0 / 60.0
		if _p().hook != null and _p().global_position.distance_to(Vector2(1480, 196)) < 40.0:
			hooked = true
			break
	_check(hooked, "Cume: a argola sobre o segundo abismo é alcançável da placa")
	_p().hp = hp0

	# --- B · Caverna, ida: quatro poços
	await _place(Vector2(2700, 790))
	at = await _swing("right", 2860.0, 3050.0)
	_check(at.x > 3220.0 and at.x < 3520.0 and absf(at.y - 800.0) < 4.0, "Caverna ida: o gancho atravessa o poço 1 até o pilar (%s)" % at.round())
	await _place(Vector2(3300, 790))
	at = await _swing("right", 3480.0, 3725.0)
	_check(at.x > 3975.0 and at.x < 4330.0 and absf(at.y - 800.0) < 9.0, "Caverna ida: o gancho atravessa o poço 2 até o patamar (%s)" % at.round())
	await _place(Vector2(4200, 790))
	at = await _swing("right", 4340.0, 4530.0)
	_check(at.x > 4700.0 and at.x < 5000.0 and absf(at.y - 800.0) < 4.0, "Caverna ida: o gancho atravessa o poço 3 até o pilar (%s)" % at.round())
	await _place(Vector2(4760, 790))
	at = await _swing("right", 4960.0, 5430.0, 2)
	_check(at.x > 5620.0 and absf(at.y - 800.0) < 4.0, "Caverna ida: dois ganchos atravessam o poço 4 (%s)" % at.round())
	_check(_p().hp == hp0, "nenhum dano da névoa na ida")

	# --- B · Caverna, volta: os mesmos poços da direita para a esquerda
	_p().hp = hp0
	await _place(Vector2(5800, 790))
	at = await _swing("left", 5660.0, 5190.0, 2)
	_check(at.x > 4700.0 and at.x < 5000.0 and absf(at.y - 800.0) < 4.0, "Caverna volta: dois ganchos atravessam o poço 4 até o pilar (%s)" % at.round())
	await _place(Vector2(4970, 790))
	at = await _swing("left", 4740.0, 4550.0)
	_check(at.x > 4020.0 and at.x < 4380.0 and absf(at.y - 800.0) < 9.0, "Caverna volta: o gancho atravessa o poço 3 até o patamar (%s)" % at.round())
	await _place(Vector2(4150, 790))
	at = await _swing("left", 4060.0, 3795.0)
	_check(at.x > 3220.0 and at.x < 3520.0 and absf(at.y - 800.0) < 4.0, "Caverna volta: o gancho atravessa o poço 2 até o pilar (%s)" % at.round())
	await _place(Vector2(3480, 790))
	at = await _swing("left", 3260.0, 3070.0)
	_check(at.x < 2900.0 and absf(at.y - 800.0) < 4.0, "Caverna volta: o gancho atravessa o poço 1 de volta à entrada (%s)" % at.round())
	_check(_p().hp == hp0, "nenhum dano da névoa na volta")

	# --- C · Encosta a pé até o platô
	_p().hp = hp0
	await _place(Vector2(6700, 790))
	Input.action_press("right")
	t = 0.0
	while t < 25.0 and _p().global_position.x < 11000.0:
		await physics_frame
		t += 1.0 / 60.0
	_release_all()
	_check(_p().global_position.x >= 11000.0 and absf(_p().global_position.y - Nivaria.slope_y(INF)) < 4.0,
		"Encosta: sobe a pé até o platô em %.1f s (%s)" % [t, _p().global_position.round()])

	# --- C · argola de cada mastro, alcançável de baixo e de cima da encosta
	var reached := 0
	var tries := 0
	for h: Vector2 in Nivaria.slope_hooks():
		for side in [-150.0, 150.0]:
			tries += 1
			var sx: float = h.x + side
			await _place(Vector2(sx, Nivaria.slope_y(sx) - 10))
			await _tap("hook")
			t = 0.0
			var ok := false
			while t < 1.5:
				await physics_frame
				t += 1.0 / 60.0
				if _p().hook != null and _p().global_position.distance_to(h + Vector2(0, 46)) < 40.0:
					ok = true
					break
			reached += 1 if ok else 0
			if not ok:
				print("     mastro em x=%d não alcançado do lado %s" % [h.x, "de baixo" if side < 0 else "de cima"])
	_check(reached == tries, "Encosta: %d de %d argolas dos mastros alcançadas do chão" % [reached, tries])

	# --- D · elevador até a Arena
	var elev: NivPlatform = null
	for n in game.level.get_children():
		if n is Nivaria:
			for pl in n.platforms:
				if pl.kind == "elevador":
					elev = pl
	await _place(Vector2(elev.start.x - 150.0, Nivaria.slope_y(INF) - 10))
	t = 0.0
	while t < 14.0 and elev.position.y > Nivaria.slope_y(INF) + 4.0:
		await physics_frame
		t += 1.0 / 60.0
	Input.action_press("right")
	await _wait(0.4)
	_release_all()
	t = 0.0
	while t < 14.0 and _p().global_position.y < 780.0:
		await physics_frame
		t += 1.0 / 60.0
	_check(absf(_p().global_position.y - 800.0) < 20.0, "Arena: o elevador desce até o chão em %.1f s (%s)" % [t, _p().global_position.round()])
	Input.action_press("right")
	await _wait(1.4)
	_release_all()
	_check(_p().global_position.x > elev.start.x + 210.0, "Arena: passa por baixo da parede e entra na arena (%s)" % _p().global_position.round())
	# ganchos do teto da arena
	await _place(Vector2(12000, 790))
	at = await _leap("right", 12020.0, 4.0, true, 12180.0)
	_check(_p().hp == hp0 and at.x > 12150.0, "Arena: o gancho do teto funciona (%s)" % at.round())
	print("     comprimento da fase: %d px" % game.level.data["bounds"].size.x)

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	AudioMgr.inst.shutdown()
	quit(0 if fails == 0 else 1)
