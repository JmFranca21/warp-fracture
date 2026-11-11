extends SceneTree
## Regressão de Verdâmia (v0.6): percorre os sistemas da fase com a arte integrada.
## menu → novo jogo → portal → Lince (11 animações) → garras em inimigo → checkpoint (E) → morte e
## retorno → salvar e continuar → Rainha (4 ataques com arte) → barreira abre → fragmento → vitória.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_verdamia.gd -- save at=999

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


func _tap(action: String, hold := 0.1) -> void:
	Input.action_press(action)
	await _wait(hold)
	Input.action_release(action)
	await _wait(0.05)


func _key_e() -> void:
	for pressed in [true, false]:
		var ev := InputEventKey.new()
		ev.keycode = KEY_E
		ev.physical_keycode = KEY_E
		ev.pressed = pressed
		Input.parse_input_event(ev)
		await physics_frame
		await process_frame


func _put(pos: Vector2) -> void:
	game.player.global_position = pos
	game.player.velocity = Vector2.ZERO
	await _wait(0.25)


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await _wait(0.3)
	_check(game.state == "menu", "o jogo abre no menu")
	game._on_menu("new")
	await _wait(2.0)
	_check(game.level.id == "lab" and game.player.form == "human", "Novo jogo começa no Laboratório Hélix como Daymon")
	game.enter_portal("verdamia", game.player.global_position)
	await _wait(3.5)
	var p = game.player
	_check(game.level.id == "verdamia" and p.form == "lince", "o portal leva a Verdâmia na forma Lince")

	# --- Lince: animações ligadas aos estados
	var names: PackedStringArray = p.body_spr.sprite_frames.get_animation_names()
	var need := ["idle", "run", "jump", "fall", "doublejump", "wall", "claw", "pogo", "flash", "hurt", "death"]
	var all := true
	for n in need:
		all = all and names.has(n)
	_check(all, "as 11 animações do Lince estão no SpriteFrames")
	await _put(Vector2(1130, 790))
	p.inv = 60.0     # sem dano durante os testes de locomoção
	_check(p.body_spr.animation == "idle", "parado → idle")
	Input.action_press("right")
	await _wait(0.3)
	_check(p.body_spr.animation == "run", "andando → run")
	Input.action_press("jump")
	await _wait(0.12)
	_check(p.body_spr.animation == "jump", "subindo → jump")
	Input.action_release("jump")
	await _wait(0.1)
	await _tap("jump", 0.05)
	_check(p.body_spr.animation == "doublejump", "segundo pulo no ar → doublejump")
	var fell := false
	for i in 40:
		await _wait(0.03)
		if not p.is_on_floor() and p.velocity.y > 80.0 and p.act == "":
			await process_frame
			fell = p.body_spr.animation == "fall"
			break
	_check(fell, "descendo → fall")
	Input.action_release("right")
	await _wait(0.6)
	await _put(Vector2(1130, 790))
	await _tap("attack", 0.05)
	_check(p.body_spr.animation == "claw", "ataque no chão → claw")
	await _wait(0.4)
	Input.action_press("jump")
	await _wait(0.2)
	Input.action_press("down")
	await _tap("attack", 0.05)
	_check(p.body_spr.animation == "pogo", "ataque para baixo no ar → pogo")
	Input.action_release("down")
	Input.action_release("jump")
	await _wait(0.8)
	p.energy = 99.0
	await _tap("special", 0.05)
	_check(p.body_spr.animation == "flash", "especial → flash")
	await _wait(0.6)
	await _put(Vector2(1700, 560))
	Input.action_press("right")
	await _wait(0.35)
	_check(p.body_spr.animation == "wall", "deslizando na parede → wall")
	Input.action_release("right")

	# --- inimigos com arte e combate
	var spore = null
	var moth = null
	for e in root.get_tree().get_nodes_in_group("enemies"):
		if e is SporePlant and spore == null:
			spore = e
		if e is Moth and moth == null:
			moth = e
	_check(spore != null and spore.spr.sprite_frames.has_animation("attack"), "Esporângio usa idle/attack/death")
	_check(moth != null and moth.spr.animation == "fly", "Mariposa usa fly/death")
	await _put(spore.global_position + Vector2(-58, -10))
	p.facing = 1
	var hp0: int = spore.hp
	await _tap("attack", 0.05)
	await _wait(0.2)
	_check(spore.hp < hp0, "as garras acertam o Esporângio")
	p.inv = 0.0
	p.hurt(spore.global_position)
	await _wait(0.05)
	_check(p.body_spr.animation == "hurt", "dano → hurt")
	await _wait(0.6)

	# --- checkpoint, morte e retorno
	await _put(Vector2(2570, 790))
	await _key_e()
	_check(game.checkpoint_level == "verdamia" and game.checkpoint_pos.distance_to(Vector2(2570, 790)) < 5.0, "E no santuário salva o ponto de retorno")
	await _put(Vector2(3000, 600))
	p.inv = 0.0
	p.hurt(p.global_position + Vector2(10, 0), 99)
	await _wait(0.3)
	_check(p.dead and p.body_spr.animation == "death", "morte → death")
	var old_p = p
	for i in 80:
		await _wait(0.05)
		if game.player != old_p and is_instance_valid(game.player):
			break
	p = game.player
	_check(not p.dead and p.hp == p.max_hp and p.global_position.distance_to(Vector2(2570, 790)) < 40.0, "depois da morte, volta ao santuário com a Integridade cheia")

	await _wait(1.2)

	# --- salvar e continuar
	game.save_now()
	game.show_menu()
	await _wait(0.5)
	game._on_menu("continue")
	await _wait(2.2)
	p = game.player
	_check(game.level.id == "verdamia" and p.form == "lince" and p.global_position.distance_to(Vector2(2570, 790)) < 40.0, "Continuar retoma em Verdâmia no santuário")

	# --- Rainha Micélia
	await _put(Vector2(4000, 790))
	await _wait(0.4)
	var lv = game.level
	_check(lv.boss_active and lv.gate != null, "entrar na arena acorda a Rainha e fecha a barreira")
	_check(lv.boss.spr.animation == "rugido", "a Rainha ruge ao acordar")
	var seen := {}
	var anims := {}
	var t := 0.0
	while t < 40.0 and seen.size() < 4:
		p.inv = 60.0
		anims[String(lv.boss.spr.animation)] = true
		for n in lv.fx.get_children():
			if n is Spike:
				seen["raízes"] = true
			elif n is EnemyBullet and n.sprite == "esporo_violeta":
				seen["chuva de esporos"] = true
			elif n is EnemyBullet and n.sprite == "esporo_verde":
				seen["rajada"] = true
		var moths := 0
		for e in root.get_tree().get_nodes_in_group("enemies"):
			if e is Moth and e.global_position.x > 3900.0:
				moths += 1
		if moths > 0:
			seen["invocação"] = true
		await _wait(0.1)
		t += 0.1
	_check(seen.size() == 4, "os quatro ataques acontecem: " + ", ".join(seen.keys()))
	_check(anims.has("raizes") and anims.has("esporos") and anims.has("rugido"), "a Rainha toca raizes / esporos / rugido nos ataques")
	lv.boss.take_hit(11, p.global_position)
	await _wait(0.3)
	_check(lv.boss.phase2, "com metade da vida ela se enfurece")
	lv.boss.take_hit(999, p.global_position)
	await _wait(0.2)
	_check(lv.boss.spr.animation == "death", "derrota → death")
	await _wait(3.0)
	_check(not is_instance_valid(lv.gate) or lv.gate.is_queued_for_deletion(), "a barreira abre")
	var frag = null
	for n in lv.objects.get_children():
		if n is Fragment:
			frag = n
	_check(frag != null, "o fragmento aparece no altar")
	p.inv = 0.0
	await _put(Vector2(4200, 790))
	Input.action_press("right")
	await _wait(0.8)
	Input.action_release("right")
	_check(game.state == "victory" and game.fragments == 1, "coletar o fragmento leva à tela de vitória")

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	SaveGame.erase()
	AudioMgr.inst.shutdown()
	quit(0 if fails == 0 else 1)
