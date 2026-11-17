extends SceneTree
## Capturas de conferência da Fase 2 (posicionamento e estados). Não é teste: só gera PNGs.
## uso: godot --audio-driver Dummy --path . --script res://tools/shots_fase2.gd -- out=/pasta

var game
var out := "user://"


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func _wait(s: float) -> void:
	await create_timer(s, true).timeout


func shot(name: String) -> void:
	await process_frame
	await process_frame
	var img := root.get_viewport().get_texture().get_image()
	img.save_png(out.path_join(name + ".png"))
	print("captura ", name)


func load_at(lid: String, pos: Vector2) -> void:
	game.checkpoint_level = lid
	game.checkpoint_pos = pos
	game.load_level(lid, pos, false)
	game.hud.title_t = -1.0
	await ticks(12)
	game.player.inv = 99.0


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()          # o argumento out= não é comando do harness
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = true
	game.events["fuga_lab"] = true
	game.terminals = {"A": true, "B": true}
	# 1. Galeria: portal sem energia e Receptáculo pedindo o fragmento
	game.frags = {"verdamia": true}
	game.fragments = 1
	await load_at("lab", Vector2(6300, 680))
	await _wait(0.6)
	await shot("01_galeria_sem_energia")
	# 2. instalado, Deserto armado (membrana âmbar) e o jogador dentro do arco
	game.installed = {"verdamia": true}
	game.portal_cal = {"verdamia": true, "deserto": true}
	await load_at("lab", Vector2(6400, 680))
	game.level.receptacle.refresh()
	game.level.portal.arm("deserto")
	await _wait(1.6)
	game.player.global_position = Vector2(6560, 680)
	await _wait(0.4)
	await shot("02_arco_aberto_deserto")
	game.level.portal.arm("verdamia")
	await _wait(1.0)
	await shot("03_arco_aberto_verdamia")
	# 4. Verdâmia: fenda de retorno atrás do altar
	await load_at("verdamia", Vector2(4380, 790))
	game.boss_done["verdamia"] = true
	await load_at("verdamia", Vector2(4380, 790))
	await _wait(0.8)
	await shot("04_verdamia_fenda_retorno")
	# 5. Deserto: chegada (fenda fechando) e Autômato
	await load_at("deserto", Vector2(185, 690))
	game.level.arrival_rift.open_now()
	game.level.arrival_rift.close_anim()
	await _wait(0.35)
	await shot("05_deserto_chegada")
	# 6. ímã puxando para a âncora do mastro
	await load_at("deserto", Vector2(800, 690))
	Input.action_press("right")
	Input.action_press("hook")
	await ticks(14)
	Input.action_release("hook")
	await shot("06_ima_ancora")
	Input.action_release("right")
	# 7. Pulso Magnético
	await load_at("deserto", Vector2(1300, 690))
	game.player.energy = 60.0
	Input.action_press("special")
	await ticks(2)
	Input.action_release("special")
	await ticks(9)
	await shot("07_pulso")
	# 8. Rebitadeira mirando para cima
	await load_at("deserto", Vector2(2000, 690))
	Input.action_press("up")
	for i in 4:
		Input.action_press("attack")
		await ticks(2)
		Input.action_release("attack")
		await ticks(16)
	await shot("08_rebitadeira")
	Input.action_release("up")
	# 9. Câmara: martelo preso com o Autômato em cima
	await load_at("deserto", Vector2(7300, 760))
	var f: Forja = game.level.desert.forja
	for i in 600:
		await physics_frame
		if f.arms[0].state == "warn":
			break
	await shot("09_martelo_aviso")
	for i in 120:
		await physics_frame
		if f.arms[0].state == "stuck":
			break
	Input.action_press("hook")
	await ticks(3)
	Input.action_release("hook")
	await ticks(34)
	await shot("10_em_cima_do_martelo")
	# 11. fase 2: esteira e drones
	f.take_hit(1, Vector2.ZERO)
	f.belt_warn = 0.6
	f.drones_t = 0.05
	await _wait(1.6)
	await shot("11_fase2_esteira_drones")
	# 12. fase 3: feixe
	f.take_hit(1, Vector2.ZERO)
	game.player.global_position = Vector2(7500, 760)
	f.act = ""
	f._start_beam()
	await _wait(1.25)
	await shot("12_fase3_feixe")
	# 13. peito aberto
	f.act = ""
	f.beam_x = -1.0
	f.on_pulse(Forja.CHEST)
	await _wait(0.3)
	await shot("13_peito_aberto")
	# 14. derrotada, fragmento
	f.take_hit(1, Vector2.ZERO)
	await _wait(2.2)
	await shot("14_derrotada_fragmento")
	# 15. saída: porta aberta e fenda de retorno
	game.frags["deserto"] = true
	await load_at("deserto", Vector2(8600, 760))
	await _wait(0.8)
	await shot("15_saida_fenda")
	AudioMgr.inst.shutdown()
	quit(0)
