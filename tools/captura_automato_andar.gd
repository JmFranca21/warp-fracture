extends SceneTree
## Os 8 quadros do Autômato andando (DF91), parados um a um sobre o chão das Dunas, com a câmera do
## jogo e zoom 3, para conferir se os pés tocam a linha de apoio em todos os quadros.
## uso: xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 --path . \
##        --script res://tools/captura_automato_andar.gd -- out=/pasta

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


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	game.load_level("deserto", Vector2(400, 690), false)
	await ticks(40)
	var p: Player = game.player
	p.inv = 0.0
	game.set_process(false)          # a câmera do main seguiria o jogador com o deslocamento normal
	for i in 8:
		paused = true
		p.body_spr.play("walk")
		p.body_spr.pause()
		p.body_spr.frame = i
		p.arm_pivot.position = p.shoulder_aut("walk", i)
		game.cam.zoom = Vector2(3, 3)
		game.cam.position = p.global_position + Vector2(0, -35)
		game.cam.reset_smoothing()
		game.level._process(0.0)
		for k in 4:
			await process_frame
		root.get_viewport().get_texture().get_image().save_png(out.path_join("andar_q%d.png" % (i + 1)))
		paused = false
	quit(0)
