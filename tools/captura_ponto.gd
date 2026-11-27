extends SceneTree
## Revisão geral: uma captura 1280 × 720 com a câmera do jogo, com o jogador num ponto da fase (a câmera
## segue como no jogo), sem HUD. Serve para os "antes e depois" de correções visuais pontuais.
## uso: xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 --path . \
##        --script res://tools/captura_ponto.gd -- level=lab pos=3600,790 out=/pasta/arquivo.png [zoom=1.0] [esconde=1]

var game


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	var level := "lab"
	var pos := Vector2.ZERO
	var out := "user://ponto.png"
	var zoom := 0.0
	var esconde := false
	for a in OS.get_cmdline_user_args():
		if a.begins_with("level="):
			level = a.substr(6)
		elif a.begins_with("pos="):
			var p := a.substr(4).split(",")
			pos = Vector2(float(p[0]), float(p[1]))
		elif a.begins_with("out="):
			out = a.substr(4)
		elif a.begins_with("zoom="):
			zoom = float(a.substr(5))
		elif a.begins_with("esconde="):
			esconde = a.substr(8) == "1"
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	for i in 4:
		await physics_frame
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	game.load_level(level, pos, false)
	for i in 30:
		await physics_frame
	var p: Player = game.player
	p.inv = 9999.0
	p.global_position = pos
	p.velocity = Vector2.ZERO
	for i in 20:
		await physics_frame
	p.visible = not esconde
	if zoom > 0.0:
		game.cam.zoom = Vector2(zoom, zoom)
	game.cam.position = game._cam_target()
	game.cam.reset_smoothing()
	for i in 6:
		await process_frame
	root.get_viewport().get_texture().get_image().save_png(out)
	print("captura: ", out)
	quit(0)
