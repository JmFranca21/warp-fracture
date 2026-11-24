extends SceneTree
## Medição da "receita de cena" (DA-03): para cada fase, conta camadas, decoração, luzes e partículas
## e salva capturas em quatro pontos fixos (com tudo, sem primeiro plano e sem o jogador), as três no
## mesmo quadro (árvore pausada), para tools/scene_metrics.py calcular valores, estrutura e contraste.
## Parâmetros fixos: janela 1.280 × 720, zoom 1,1, câmera no alvo normal do jogador, HUD escondido.
## uso: godot --path . --script res://tools/scene_metrics.gd -- out=/pasta [level=deserto] [spots=x,y;x,y] [hide_bg=1,2] [float=1]
##   level: mede só essa fase; spots: troca os pontos dela; hide_bg: esconde essas camadas de fundo (índices)

var game
var out := "user://"
var only := ""
var custom := []
var hide_bg := []
var float_player := false   # float=1: o jogador fica parado no ponto (câmera no fundo de um fosso ou no alto)
const SPOTS := {
	"lab": [Vector2(700, 790), Vector2(2600, 790), Vector2(4250, 790), Vector2(6400, 680)],
	"verdamia": [Vector2(600, 790), Vector2(1700, 790), Vector2(2800, 790), Vector2(3700, 790)],
	"deserto": [Vector2(500, 700), Vector2(2300, 700), Vector2(5200, 770), Vector2(6500, 770)],
	"nivaria": [Vector2(500, 699), Vector2(1500, 519), Vector2(3290, 699), Vector2(6500, 391)],
}


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
		elif a.begins_with("level="):
			only = a.substr(6)
		elif a.begins_with("spots="):
			for xy in a.substr(6).split(";"):
				var v := xy.split(",")
				custom.append(Vector2(float(v[0]), float(v[1])))
		elif a == "float=1":
			float_player = true
		elif a.begins_with("hide_bg="):
			for i in a.substr(8).split(","):
				hide_bg.append(int(i))
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func shot(name: String) -> void:
	await process_frame
	await process_frame
	await process_frame
	root.get_viewport().get_texture().get_image().save_png(out.path_join(name + ".png"))


func _walk(n: Node, acc: Dictionary, lv: Level) -> void:
	for c in n.get_children():
		if c == lv.entities or c == lv.objects or c == lv.fx:
			continue
		if c is CPUParticles2D or c is GPUParticles2D:
			acc["particulas"] += 1
		elif c is Sprite2D or c is AnimatedSprite2D:
			var tex: Texture2D = c.texture if c is Sprite2D else null
			if tex != null and tex.get_width() == 128 and tex.get_height() == 128 and c.material != null:
				acc["luzes"] += 1          # Art.glow
			else:
				acc["sprites"] += 1
		elif c is ColorRect:
			acc["retangulos"] += 1
		if c is FgLayer:
			acc["primeiro_plano"] += 1
		if c is BackWall:
			acc["parede_fundo"] += 1
		_walk(c, acc, lv)


## Esconde tudo o que não é o jogador nem um ancestral dele (camadas de fundo em CanvasLayer inclusive).
func _hide_all_but(n: Node, p: Node, acc: Array) -> void:
	for c in n.get_children():
		if c == p:
			continue
		if c.is_ancestor_of(p):
			_hide_all_but(c, p, acc)
		elif (c is CanvasItem or c is CanvasLayer) and c.visible:
			c.visible = false
			acc.append(c)


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	game.events["fuga_lab"] = true
	game.modules = {"arpao": true}
	for id in Logs.ORDER:
		game.collected[id] = true        # Registros abrem um painel e pausam: fora das capturas
	var report := []
	for lid in SPOTS:
		if only != "" and lid != only:
			continue
		var spots: Array = custom if not custom.is_empty() else SPOTS[lid]
		game.load_level(lid, spots[0], false)
		await ticks(20)
		var lv: Level = game.level
		for i in hide_bg:
			lv.bg_layers[i].visible = false
		var acc := {"sprites": 0, "luzes": 0, "particulas": 0, "retangulos": 0, "camadas_fundo": 0, "primeiro_plano": 0, "parede_fundo": 0}
		_walk(lv, acc, lv)
		var b: Rect2 = lv.data["bounds"]
		acc["largura"] = b.size.x
		acc["camadas_fundo"] = lv.bg_layers.size()
		acc["inimigos"] = get_nodes_in_group("enemies").size()
		acc["interativos"] = lv.objects.get_child_count()
		report.append([lid, acc])
		for e in lv.entities.get_children():
			if e != game.player:
				e.process_mode = Node.PROCESS_MODE_DISABLED
		for i in spots.size():
			var p: Player = game.player
			p.global_position = spots[i]
			p.velocity = Vector2.ZERO
			if float_player:
				p.process_mode = Node.PROCESS_MODE_DISABLED
			p.inv = 99.0
			await ticks(12)
			game.cam.position = game._cam_target()
			game.cam.reset_smoothing()
			await ticks(3)
			var tag := "%s_%d" % [lid, i]
			paused = true          # as três variantes no mesmo estado (partículas e animações paradas)
			await shot(tag + "_a_tudo")
			for f in lv.fg_layers:
				f.visible = false
			await shot(tag + "_b_sem_fg")
			p.visible = false
			await shot(tag + "_c_sem_jogador")
			p.visible = true
			# d: só o jogador sobre preto (máscara exata do personagem para o contraste)
			var hidden := []
			_hide_all_but(game.world, p, hidden)
			RenderingServer.set_default_clear_color(Color.BLACK)
			await shot(tag + "_d_so_jogador")
			for c in hidden:
				c.visible = true
			for f in lv.fg_layers:
				f.visible = true
			paused = false
	var f := FileAccess.open(out.path_join("contagem.json"), FileAccess.WRITE)
	f.store_string(JSON.stringify(report, "  "))
	print(JSON.stringify(report))
	AudioMgr.inst.shutdown()
	quit(0)
