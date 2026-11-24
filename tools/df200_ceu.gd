extends SceneTree
## DF200: captura o céu no jogo, com a câmera normal (zoom 1,1) em pontos das Dunas, do vão do Salão e nos
## extremos da câmera. Três variantes por ponto: tudo; sem as camadas antigas à frente (DF11 e DF12); só o céu.
## uso: godot --path . --script res://tools/df200_ceu.gd -- out=/pasta

var game
var out := "user://"
# posição do jogador (a câmera segue o alvo dele: 70 à frente, 165 acima, presa aos limites da fase)
const SPOTS := {
	"dunas_inicio": Vector2(185, 690), "dunas_meio": Vector2(500, 700), "dunas_fim": Vector2(1600, 700),
	"dunas_fosso_baixo": Vector2(980, 1000), "salao_passarela_1": Vector2(3795, 415),
	"salao_passarela_2": Vector2(4635, 415), "salao_alto": Vector2(4205, 250),
}


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func shot(name: String) -> void:
	await process_frame
	await process_frame
	await process_frame
	root.get_viewport().get_texture().get_image().save_png(out.path_join(name + ".png"))


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	for id in Logs.ORDER:
		game.collected[id] = true
	game.load_level("deserto", Vector2(185, 690), false)
	await ticks(20)
	var lv: Level = game.level
	for e in lv.entities.get_children():
		if e != game.player:
			e.visible = false
			e.process_mode = Node.PROCESS_MODE_DISABLED
	var p: Player = game.player
	p.inv = 9999.0
	var sky: VerdBg = lv.bg_layers[0]
	var lines := []
	for k in SPOTS:
		p.global_position = SPOTS[k]
		p.velocity = Vector2.ZERO
		p.facing = 1
		await ticks(2)
		paused = true
		game.cam.position = game._cam_target()
		game.cam.reset_smoothing()
		for i in 40:
			await process_frame
		lv._process(0.0)            # árvore pausada: reposiciona as camadas de parallax para esta câmera
		await shot(k + "_a_tudo")
		for b in lv.bg_layers.slice(1):
			b.visible = false
		await shot(k + "_b_sem_camadas_antigas")
		var hidden := []
		for c in game.world.get_children():
			if c != lv and c is CanvasItem and c.visible:
				c.visible = false
				hidden.append(c)
		for c in lv.get_children():
			if c != sky and c is CanvasItem and c.visible:
				c.visible = false
				hidden.append(c)
		await shot(k + "_c_so_ceu")
		for c in hidden:
			c.visible = true
		for b in lv.bg_layers:
			b.visible = true
		# onde a imagem do céu cai na tela (para ver se alguma borda aparece)
		var cs: Vector2 = game.cam.get_screen_center_position()
		var half: Vector2 = Vector2(640, 360) / game.cam.zoom
		var rect := Rect2(sky.global_position + Vector2(sky.left, sky.top), sky.tex.get_size() * sky.img_scale)
		var view := Rect2(cs - half, half * 2.0)
		var fx := (view.position.x - rect.position.x) / sky.img_scale
		var fy := (view.position.y - rect.position.y) / sky.img_scale
		lines.append("%s: câmera (%d, %d); a tela mostra o céu de x %d a %d e linhas %d a %d do arquivo; borda visível: %s" % [
			k, cs.x, cs.y, fx, fx + view.size.x / sky.img_scale, fy, fy + view.size.y / sky.img_scale, str(not rect.encloses(view))])
		paused = false
	for l in lines:
		print(l)
	AudioMgr.inst.shutdown()
	quit(0)
