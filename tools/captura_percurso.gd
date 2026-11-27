extends SceneTree
## Revisão geral: fotografa uma fase inteira com a câmera do jogo (1280 × 720, sem HUD), parando nos
## pontos do percurso que a própria fase descreve (início, placas, estações, bancos, coletáveis e
## inimigos), um a cada ~700 px. Serve para a passada visual: objetos sem apoio, emendas, repetição.
## uso: xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 --path . \
##        --script res://tools/captura_percurso.gd -- level=verdamia out=/pasta [passo=700]

var game


func _initialize() -> void:
	_run.call_deferred()


func _pos(v) -> Vector2:
	if v is Vector2:
		return v
	if v is Array and v.size() > 0:
		return _pos(v[0])
	if v is Dictionary:
		for k in ["pos", "position", "at"]:
			if v.has(k):
				return _pos(v[k])
	if v is Rect2:
		return v.get_center()
	return Vector2.INF


func _run() -> void:
	var level := "lab"
	var out := "/tmp/percurso"
	var passo := 700.0
	for a in OS.get_cmdline_user_args():
		if a.begins_with("level="):
			level = a.substr(6)
		elif a.begins_with("out="):
			out = a.substr(4)
		elif a.begins_with("passo="):
			passo = float(a.substr(6))
	DirAccess.make_dir_recursive_absolute(out)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	for i in 4:
		await physics_frame
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	var d: Dictionary = LevelData.get_level(level)
	game.load_level(level, d["spawn"], false)
	for i in 30:
		await physics_frame
	var pts: Array = [d["spawn"]]
	for k in ["signs", "checkpoints", "benches", "pickups", "terminals", "enemies"]:
		for item in d.get(k, []):
			var v := _pos(item)
			if v != Vector2.INF:
				pts.append(v)
	pts.sort_custom(func(a, b): return a.x < b.x)
	var escolhidos: Array = []
	for v in pts:
		if escolhidos.is_empty() or v.x - escolhidos[-1].x >= passo:
			escolhidos.append(v)
	var p: Player = game.player
	var n := 0
	for v in escolhidos:
		p.inv = 9999.0
		p.global_position = v + Vector2(0, -4)
		p.velocity = Vector2.ZERO
		for i in 25:
			await physics_frame
		game.cam.position = game._cam_target()
		game.cam.reset_smoothing()
		for i in 4:
			await process_frame
		var nome := out.path_join("%s_%02d_x%d.png" % [level, n, int(v.x)])
		root.get_viewport().get_texture().get_image().save_png(nome)
		n += 1
	print("%s: %d capturas em %s" % [level, n, out])
	quit(0)
