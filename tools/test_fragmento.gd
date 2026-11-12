extends SceneTree
## Regressão do fragmento de Verdâmia (v0.6.1, defeito registrado na D02).
## Um fragmento já coletado não pode reaparecer no altar depois de "Continuar".
## Casos:
##  1. jogo real: portal → Rainha derrotada → fragmento coletado (salva) → menu → Continuar;
##  2. save antigo (version 1, sem "frags") que pegou o fragmento duas vezes (fragments = 2);
##  3. save antigo com a Rainha derrotada e fragments = 0 (saiu antes da coleta): o fragmento continua no altar.
## O save do usuário é guardado antes e restaurado no fim.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_fragmento.gd -- save at=999

var game
var fails := 0
var backup = null


func _initialize() -> void:
	_run.call_deferred()


func _check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FAIL ") + what)
	if not ok:
		fails += 1


func _wait(s: float) -> void:
	await create_timer(s, false).timeout


func _fragments_in_level() -> int:
	var n := 0
	for o in game.level.objects.get_children():
		if o is Fragment and not o.is_queued_for_deletion():
			n += 1
	return n


func _write_save(d: Dictionary) -> void:
	var f := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
	f.store_string(JSON.stringify(d, "\t"))
	f.close()


func _continue() -> void:
	game.show_menu()
	await _wait(0.4)
	game._on_menu("continue")
	await _wait(2.4)


func _old_save(fragments: int) -> Dictionary:
	return {
		"version": 1, "level": "verdamia", "pos": [2570, 790],
		"terminals": ["A", "B"], "collected": [], "boss_done": ["verdamia"],
		"visited": [], "fragments": fragments, "cells": 3, "deaths": 0,
		"play_time": 120.0, "modules": ["arpao"], "upgrades": {},
	}


func _run() -> void:
	if SaveGame.exists():
		backup = FileAccess.get_file_as_string(SaveGame.PATH)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await _wait(0.3)

	# --- 1. jogo real até a coleta, depois Continuar
	game._on_menu("new")
	await _wait(2.0)
	game.enter_portal("verdamia", game.player.global_position)
	await _wait(3.5)
	var lv = game.level
	game.player.inv = 60.0
	game.player.global_position = Vector2(4000, 790)
	await _wait(0.5)
	_check(lv.boss_active, "a Rainha acorda")
	lv.boss.take_hit(999, game.player.global_position)
	await _wait(3.2)
	_check(_fragments_in_level() == 1, "o fragmento aparece no altar depois da vitória")
	game.player.global_position = Vector2(4200, 790)
	Input.action_press("right")
	await _wait(0.8)
	Input.action_release("right")
	_check(game.state == "victory" and game.fragments == 1, "coletar leva à vitória com 1/4")
	var d := SaveGame.read()
	_check(int(d.get("fragments", -1)) == 1, "o save gravado na coleta tem fragments = 1")
	await _continue()
	_check(game.level.id == "verdamia", "Continuar volta a Verdâmia")
	_check(_fragments_in_level() == 0, "o fragmento coletado NÃO reaparece no altar")
	_check(game.fragments == 1, "o contador continua 1/4 (obtido %d)" % game.fragments)
	_check(game.level.boss == null and game.level.gate == null, "a Rainha não volta e a barreira continua aberta")
	game.player.inv = 60.0
	game.player.global_position = Vector2(4300, 790)
	await _wait(0.6)
	_check(game.fragments == 1 and game.state == "level", "passar pelo altar não conta o fragmento de novo")

	# --- 2. save antigo que já tinha contado o fragmento duas vezes
	_write_save(_old_save(2))
	await _continue()
	_check(_fragments_in_level() == 0, "save antigo com fragments = 2: o fragmento não reaparece")
	_check(game.fragments == 1, "save antigo com fragments = 2: o contador é corrigido para 1 (obtido %d)" % game.fragments)
	game.save_now()
	_check(Array(SaveGame.read().get("frags", [])) == ["verdamia"] and int(SaveGame.read().get("fragments", -1)) == 1, "o save regravado guarda frags = [verdamia] e fragments = 1")

	# --- 3. save antigo gravado entre a vitória e a coleta
	_write_save(_old_save(0))
	await _continue()
	_check(_fragments_in_level() == 1, "save antigo com fragments = 0: o fragmento continua no altar")
	_check(game.level.boss == null, "save antigo com fragments = 0: a Rainha continua derrotada")
	game.player.inv = 60.0
	game.player.global_position = Vector2(4200, 790)
	Input.action_press("right")
	await _wait(0.8)
	Input.action_release("right")
	_check(game.fragments == 1 and game.state == "victory", "coletar depois desse save leva a 1/4")

	print("RESULTADO: ", "PASS" if fails == 0 else "FAIL (%d)" % fails)
	SaveGame.erase()
	if backup != null:
		var f := FileAccess.open(SaveGame.PATH, FileAccess.WRITE)
		f.store_string(backup)
		f.close()
	AudioMgr.inst.shutdown()
	quit(0 if fails == 0 else 1)
