extends SceneTree
## Revisão geral: carrega cada fase como o jogo carrega e mede a escala GLOBAL de todo sprite visível
## (Sprite2D, AnimatedSprite2D, TextureRect com textura de imagem). Lista os que têm |sx| ≠ |sy| (mais de
## 1 % de diferença), isto é, arte esticada num eixo só. O jogador fica de fora (o squash-and-stretch do
## pouso é animação de propósito e volta a 1 × 1 em ~0,2 s).
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/varrer_escalas.gd -- [level=deserto]
## Sai com 1 quando acha algum sprite esticado.

var game
var achados := 0


func _initialize() -> void:
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func _run() -> void:
	var only := ""
	for a in OS.get_cmdline_user_args():
		if a.begins_with("level="):
			only = a.substr(6)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	for id in ["lab", "verdamia", "deserto", "nivaria"]:
		if only != "" and id != only:
			continue
		game.load_level(id, LevelData.get_level(id)["spawn"], false)
		await ticks(30)
		var n := 0
		var total := 0
		var vistos := {}
		for node in root.find_children("*", "", true, false):
			if not (node is Sprite2D or node is AnimatedSprite2D or node is TextureRect):
				continue
			if not node.is_visible_in_tree() or game.player.is_ancestor_of(node):
				continue
			var tex_name := ""
			if node is Sprite2D:
				if node.texture == null or node.texture is GradientTexture2D or node.texture is GradientTexture1D:
					continue
				tex_name = node.texture.resource_path.get_file()
			elif node is AnimatedSprite2D:
				if node.sprite_frames == null:
					continue
				tex_name = node.sprite_frames.resource_path.get_file()
			else:
				if node.texture == null or not (node.texture is Texture2D) or node.texture is GradientTexture2D:
					continue
				tex_name = node.texture.resource_path.get_file()
			total += 1
			var s: Vector2 = node.get_global_transform().get_scale().abs() if not (node is TextureRect) \
					else node.size / node.texture.get_size()
			if s.x < 1e-4 or s.y < 1e-4:
				continue
			var r := maxf(s.x, s.y) / minf(s.x, s.y)
			if r <= 1.01:
				continue
			# a mesma textura com a mesma escala aparece uma vez só, com a contagem
			var chave := "%s|%.3f|%.3f" % [tex_name, s.x, s.y]
			if vistos.has(chave):
				vistos[chave][1] += 1
				continue
			vistos[chave] = [node, 1]
		for chave in vistos:
			var node: Node = vistos[chave][0]
			var s: Vector2 = node.get_global_transform().get_scale().abs() if not (node is TextureRect) \
					else node.size / node.texture.get_size()
			print("%-9s %-58s %-34s esc %.3f × %.3f (×%d)" % [id, str(root.get_path_to(node)).right(58),
				chave.get_slice("|", 0), s.x, s.y, vistos[chave][1]])
			n += 1
		print("== %s: %d sprite(s) olhados, %d esticado(s)" % [id, total, n])
		achados += n
	quit(1 if achados else 0)
