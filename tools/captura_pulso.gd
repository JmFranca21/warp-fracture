extends SceneTree
## Revisão geral: capturas do Pulso Magnético do Autômato (1280 × 720, câmera do jogo, sem HUD).
## 1) com energia e um robô a menos de 240 px, o anel tracejado de 150 px e as cantoneiras nos alvos;
## 2) e 3) logo depois de apertar o especial: onda, faíscas nos alvos e o robô paralisado.
## uso: xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 --path . \
##        --script res://tools/captura_pulso.gd -- out=/pasta

var game


func _initialize() -> void:
	_run.call_deferred()


func shot(nome: String) -> void:
	await process_frame
	root.get_viewport().get_texture().get_image().save_png(nome)


func _run() -> void:
	var out := "/tmp/pulso"
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
	DirAccess.make_dir_recursive_absolute(out)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	for i in 4:
		await physics_frame
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	game.load_level("deserto", LevelData.get_level("deserto")["spawn"], false)
	for i in 30:
		await physics_frame
	var p: Player = game.player
	# o primeiro robô (não drone) do Deserto
	var alvo: Node2D = null
	for e in get_nodes_in_group("enemies"):
		if e is DesertEnemy and not e.drone and (alvo == null or e.global_position.x < alvo.global_position.x):
			alvo = e
	alvo.process_mode = Node.PROCESS_MODE_DISABLED
	p.inv = 9999.0
	p.global_position = alvo.global_position + Vector2(120, -2)
	p.velocity = Vector2.ZERO
	p.facing = -1
	p.energy = 100.0
	for i in 30:
		await physics_frame
	game.cam.zoom = Vector2(1.6, 1.6)
	game.cam.position = game._cam_target()
	game.cam.reset_smoothing()
	await shot(out.path_join("pulso_1_alcance.png"))
	alvo.process_mode = Node.PROCESS_MODE_INHERIT
	Input.action_press("special")
	await physics_frame
	await physics_frame
	Input.action_release("special")
	for i in 3:
		await physics_frame
	await shot(out.path_join("pulso_2_onda.png"))
	for i in 12:
		await physics_frame
	await shot(out.path_join("pulso_3_paralisado.png"))
	print("pulso: alvo em %s, energia %d" % [alvo.global_position, p.energy])
	quit(0)
