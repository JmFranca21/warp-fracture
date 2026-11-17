extends SceneTree
## Regressão da passagem Verdâmia → Hélix → Deserto (D02) e do save versão 2, por input real.
## uso: godot --audio-driver Dummy --path . --script res://tools/test_passagem.gd -- save at=999
## Cobre: fragmento sem tela de vitória → fenda de retorno → Sala G → portal sem energia → Receptáculo
## (instalar, log_09, estação) → seletor de destino → calibração do Deserto (com deriva) → último E →
## Deserto na forma Autômato; os cinco estados de "Continuar" e a migração de saves da versão 1.

var game
var fails := 0
var backup := ""


func _initialize() -> void:
	_run.call_deferred()


func _check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FAIL ") + what)
	if not ok:
		fails += 1


func _wait(s: float) -> void:
	await create_timer(s, true).timeout


func _key(code: Key) -> void:
	for pressed in [true, false]:
		var ev := InputEventKey.new()
		ev.keycode = code
		ev.physical_keycode = code
		ev.pressed = pressed
		Input.parse_input_event(ev)
		await physics_frame
		await process_frame


func _put(pos: Vector2) -> void:
	game.player.global_position = pos
	game.player.velocity = Vector2.ZERO
	await _wait(0.35)


func _continue() -> void:
	game.show_menu()
	await _wait(0.4)
	game._on_menu("continue")
	await _wait(2.6)


func _write_save(d: Dictionary) -> void:
	var f := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
	f.store_string(JSON.stringify(d, "\t"))
	f.close()


func _run() -> void:
	if SaveGame.exists():
		backup = FileAccess.get_file_as_string(SaveGame.PATH)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await _wait(0.3)

	# --- 1. Verdâmia: Rainha vencida, pegar o fragmento
	game._on_menu("new")
	await _wait(2.0)
	game.terminals = {"A": true, "B": true}
	game.events["fuga_lab"] = true
	game.enter_portal("verdamia", game.player.global_position)
	await _wait(3.5)
	_check(game.level.id == "verdamia" and game.level.return_rift == null, "Verdâmia ainda sem fenda de retorno")
	game.player.inv = 60.0
	await _put(Vector2(4000, 790))
	game.level.boss.take_hit(999, game.player.global_position)
	await _wait(3.2)
	await _put(Vector2(4200, 790))
	Input.action_press("right")
	await _wait(0.6)
	Input.action_release("right")
	_check(game.state == "level" and game.fragments == 1, "fragmento: sem tela de vitória, contador 1/4")
	_check(game.hud.banner_a == "FRAGMENTO RECUPERADO · 1/4", "letreiro \"FRAGMENTO RECUPERADO · 1/4\"")
	_check(game.player.controls_locked, "controles travados durante a absorção")
	var d := SaveGame.read()
	_check(int(d.get("version", 0)) == 2 and Array(d.get("frags", [])) == ["verdamia"], "o jogo salva na coleta (versão 2, frags = [verdamia])")
	await _wait(3.4)
	var rift: Rift = game.level.return_rift
	_check(rift != null and not game.player.controls_locked, "depois de ~3 s a fenda de retorno abre e o controle volta")
	_check(game.hud.say_lines.size() > 0 and String(game.hud.say_lines[0]).begins_with("IRIS"), "IRIS fala pelo rádio")
	await _wait(1.2)
	_check(rift.state == "aberta" and rift.prompt == "[E] Voltar ao Laboratório Hélix", "a fenda mostra \"[E] Voltar ao Laboratório Hélix\"")

	# --- 2. Continuar entre a coleta e a fenda: volta a Verdâmia com a fenda aberta
	await _continue()
	_check(game.level.id == "verdamia" and game.level.return_rift != null and game.level.return_rift.state == "aberta",
		"Continuar depois da coleta: Verdâmia, fenda aberta, sem fragmento no altar")

	# --- 3. atravessar a fenda: Sala G, forma humana
	await _put(game.level.return_rift.global_position + Vector2(-20, -10))
	await _key(KEY_E)
	await _wait(3.6)
	_check(game.level.id == "lab" and game.player.form == "human", "a fenda leva ao Hélix na forma humana")
	_check(game.player.global_position.distance_to(Vector2(6470, 690)) < 40.0, "chegada na Galeria, ao lado do portal")
	_check(game.hud.banner_a == "FORMA HUMANA", "banner \"FORMA HUMANA\"")
	_check(game.level.fuga == null, "a Fuga do Eco não se repete")
	var portal: Portal = game.level.portal
	var rec: Receptacle = game.level.receptacle
	_check(portal.prompt == "[E] Portal sem energia" and portal.state == "bloqueado", "portal escuro e sem energia antes de instalar")
	_check(rec != null and rec.prompt == "[E] Instalar o fragmento", "o Receptáculo pede o fragmento")
	await _continue()
	_check(game.level.id == "lab" and game.player.global_position.distance_to(Vector2(6470, 690)) < 40.0, "Continuar sem instalar: volta à Galeria, ao lado do portal")

	# --- 4. instalar o fragmento
	await _put(game.level.receptacle.global_position + Vector2(-10, -10))
	await _key(KEY_E)
	await _wait(0.4)
	_check(game.installed.has("verdamia") and game.collected.has("log_09"), "instalar: fragmento no soquete e registro log_09")
	_check(game.checkpoint_level == "lab" and game.checkpoint_pos.distance_to(game.level.receptacle.global_position + Vector2(-60, -10)) < 2.0, "o Receptáculo vira estação e salva")
	_check(game.level.portal.prompt == "[E] Escolher destino", "o portal oferece \"[E] Escolher destino\"")
	_check(game.level.receptacle.prompt == "[E] Descansar no Receptáculo", "depois de instalar, o Receptáculo funciona como estação")
	await _continue()
	_check(game.installed.has("verdamia") and game.level.portal.prompt == "[E] Escolher destino", "Continuar depois de instalar: seletor com o Deserto pendente")

	# --- 5. seletor → Deserto → calibração com deriva → último E
	await _put(game.level.portal.global_position + Vector2(-20, -10))
	await _key(KEY_E)
	await _wait(0.2)
	_check(game.dest_select.active and game.dest_select.items.size() == 2, "o seletor mostra Verdâmia e Deserto")
	_check(String(game.dest_select.items[game.dest_select.sel]["id"]) == "deserto", "o Deserto vem selecionado")
	await _key(KEY_ESCAPE)
	await _wait(0.2)
	_check(not game.dest_select.active and game.state == "level", "ESC fecha o seletor")
	await _key(KEY_E)
	await _wait(0.2)
	await _key(KEY_E)
	await _wait(0.3)
	_check(game.calib.active and game.calib.pattern == "deserto" and game.calib.drift_row == 1, "Deserto: calibração âmbar com uma onda à deriva")
	var c = game.calib
	var tries := 0
	while c.active and c.success_t < 0.0 and tries < 60:
		tries += 1
		var moved := false
		for i in 3:
			var steps := roundi((c.target[i] - c.cur[i]) / c.STEP)
			if steps != 0:
				while c.sel != i:
					await _key(KEY_S)
				for j in absi(steps):
					await _key(KEY_D if steps > 0 else KEY_A)
				moved = true
		if not moved:
			await _wait(0.1)
	await _wait(1.4)
	_check(not c.active and game.portal_cal.has("deserto"), "alinhar as três ondas estabiliza o sinal do Deserto")
	_check(game.level.id == "lab" and game.level.portal.active and game.level.portal.prompt == "[E] Atravessar", "a viagem não começa sozinha: aparece \"[E] Atravessar\"")
	d = SaveGame.read()
	_check(Array(d.get("portal_cal", [])).has("deserto") and Array(d.get("installed", [])) == ["verdamia"], "o save guarda installed e portal_cal")
	await _continue()
	await _put(game.level.portal.global_position + Vector2(-20, -10))
	await _key(KEY_E)
	await _wait(0.2)
	_check(String(game.dest_select.items[1]["status"]) == "calibrado", "Continuar com o Deserto calibrado: não pede nova calibração")
	await _key(KEY_E)
	await _wait(0.4)
	_check(game.level.portal.active and not game.calib.active, "Deserto calibrado: o portal abre direto")
	await _key(KEY_E)
	await _wait(3.6)
	_check(game.level.id == "deserto" and game.player.form == "automato", "o último E leva ao Deserto na forma Autômato")
	_check(game.hud.banner_a == "NOVA FORMA: AUTÔMATO", "banner \"NOVA FORMA: AUTÔMATO\"")
	_check(game.level.arrival_rift != null and game.level.arrival_rift.state in ["fechando", "dormente"], "a fenda de chegada se fecha atrás do jogador")
	await _continue()
	_check(game.level.id == "deserto" and game.player.form == "automato", "Continuar no Deserto: mesmo arquivo de save, forma Autômato")

	# --- 6. saves da versão 1
	_write_save({"version": 1, "level": "verdamia", "pos": [2570, 790], "terminals": ["A", "B"], "collected": [],
		"boss_done": ["verdamia"], "visited": [], "fragments": 2, "cells": 3, "deaths": 0, "play_time": 120.0,
		"modules": ["arpao"], "upgrades": {}})
	await _continue()
	_check(game.fragments == 1 and game.portal_cal.has("verdamia") and game.installed.is_empty(), "save v1 (fragments = 2): 1/4, Verdâmia calibrada, nada instalado")
	_check(game.level.return_rift != null and game.level.return_rift.state == "aberta", "save v1 com o fragmento: a fenda de retorno abre")
	_write_save({"version": 1, "level": "lab", "pos": [4300, 790], "terminals": ["A", "B"], "collected": [],
		"boss_done": [], "visited": [], "fragments": 0, "cells": 0, "deaths": 0, "play_time": 10.0,
		"modules": ["arpao"], "upgrades": {}})
	await _continue()
	_check(game.level.id == "lab" and game.portal_cal.is_empty() and game.level.portal.prompt == "[E] Calibrar o portal", "save v1 no Laboratório: nada muda (portal pede calibração)")

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	SaveGame.erase()
	if backup != "":
		var fw := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
		fw.store_string(backup)
		fw.close()
	AudioMgr.inst.shutdown()
	quit(0 if fails == 0 else 1)
