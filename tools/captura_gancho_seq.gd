extends SceneTree
## Revisão geral: sequência de quadros (1280 × 720, câmera do jogo) da travessia com o gancho, para o
## antes/depois. Põe o jogador parado na borda de um vão, segura a direção do outro lado e aperta o gancho
## uma vez, sem pular. Grava um quadro a cada `passo` quadros de física por `seg` segundos.
## Padrão: primeiro fosso das Dunas (x 780–1180, argola em (975, 510)), com o Autômato.
## uso: xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 --path . \
##        --script res://tools/captura_gancho_seq.gd -- out=/pasta [level=deserto] [pos=756,697] [seg=2.4] [passo=9]

var game


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	var out := "/tmp/gancho_seq"
	var level := "deserto"
	var pos := Vector2(756, 697)
	var seg := 2.4
	var passo := 9
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
		elif a.begins_with("level="):
			level = a.substr(6)
		elif a.begins_with("pos="):
			var p := a.substr(4).split(",")
			pos = Vector2(float(p[0]), float(p[1]))
		elif a.begins_with("seg="):
			seg = float(a.substr(4))
		elif a.begins_with("passo="):
			passo = int(a.substr(6))
	DirAccess.make_dir_recursive_absolute(out)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	for i in 4:
		await physics_frame
	game._reset_progress()
	game.modules["arpao"] = true
	game.menu.visible = false
	game.hud.visible = false
	game.load_level(level, pos, false)
	for i in 30:
		await physics_frame
	for e in get_nodes_in_group("enemies"):
		e.process_mode = Node.PROCESS_MODE_DISABLED
	var p: Player = game.player
	p.inv = 9999.0
	p.global_position = pos
	p.velocity = Vector2.ZERO
	p.facing = 1
	for i in 20:
		await physics_frame
	game.cam.reset_smoothing()
	Input.action_press("right")
	var n := 0
	var f := 0
	while f < int(seg * 60.0):
		if f == 2:
			Input.action_press("hook")
		if f == 4:
			Input.action_release("hook")
		await physics_frame
		if f % passo == 0:
			await process_frame
			root.get_viewport().get_texture().get_image().save_png(out.path_join("q%02d.png" % n))
			n += 1
		f += 1
	Input.action_release("right")
	print("%d quadros em %s; jogador terminou em %s, no chão %s" % [n, out, p.global_position, p.is_on_floor()])
	quit(0)
