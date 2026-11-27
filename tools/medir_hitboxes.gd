extends SceneTree
## Revisão geral: mede, para cada tipo de inimigo de cada fase e para a forma do jogador de cada fase,
## a caixa de dano (Area2D: hurt_area do inimigo, hurtbox do jogador) contra a caixa do desenho opaco
## (alfa > 40) do quadro que está na tela, as duas em px do mundo. Imprime uma linha por entidade em
## formato de tabela Markdown: tamanho e deslocamento da caixa, tamanho do desenho, quanto da caixa cobre
## o desenho e quanto do desenho fica fora da caixa (por lado).
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/medir_hitboxes.gd -- [level=lab]

var game


func _initialize() -> void:
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func _kind(e: Node) -> String:
	if e is DesertEnemy:
		return "deserto_drone" if e.drone else "deserto_robo"
	var sc: Script = e.get_script()
	return sc.resource_path.get_file().get_basename() if sc != null else e.name


## caixa do desenho opaco de todos os sprites de imagem dentro de n (sem brilhos de gradiente)
func art_rect(n: Node) -> Rect2:
	var out := Rect2()
	var first := true
	for s in n.find_children("*", "", true, false) + [n]:
		if not (s is Sprite2D or s is AnimatedSprite2D) or not s.is_visible_in_tree():
			continue
		var tex: Texture2D = null
		if s is Sprite2D:
			tex = s.texture
		elif s.sprite_frames != null and s.sprite_frames.has_animation(s.animation):
			tex = s.sprite_frames.get_frame_texture(s.animation, s.frame)
		if tex == null or tex is GradientTexture2D or s.modulate.a < 0.3 or s.self_modulate.a < 0.3:
			continue
		var img := tex.get_image()
		if img == null:
			continue
		if s is Sprite2D and s.region_enabled:
			img = img.get_region(Rect2i(s.region_rect))
		if img.is_compressed():
			img.decompress()
		var used := img.get_used_rect()     # bbox de alfa > 0; refina para alfa > 40
		var bb := _alpha_bbox(img, used)
		if bb.size.x <= 0:
			continue
		var size := Vector2(img.get_size())
		var top_left: Vector2 = (s.offset - size / 2.0) if s.centered else s.offset
		var xf: Transform2D = s.get_global_transform()
		for c in [bb.position, bb.position + Vector2(bb.size.x, 0), bb.end, bb.position + Vector2(0, bb.size.y)]:
			var p: Vector2 = xf * (top_left + c)
			if first:
				out = Rect2(p, Vector2.ZERO)
				first = false
			else:
				out = out.expand(p)
	return out


func _alpha_bbox(img: Image, used: Rect2i) -> Rect2:
	var x0 := used.end.x
	var y0 := used.end.y
	var x1 := used.position.x
	var y1 := used.position.y
	for y in range(used.position.y, used.end.y, 2):
		for x in range(used.position.x, used.end.x, 2):
			if img.get_pixel(x, y).a > 0.16:
				x0 = mini(x0, x)
				y0 = mini(y0, y)
				x1 = maxi(x1, x + 2)
				y1 = maxi(y1, y + 2)
	return Rect2(x0, y0, x1 - x0, y1 - y0) if x1 > x0 else Rect2()


func box_rect(area: Area2D) -> Rect2:
	for cs in area.find_children("*", "CollisionShape2D", true, false):
		if cs.shape is RectangleShape2D:
			var sz: Vector2 = cs.shape.size * cs.global_transform.get_scale().abs()
			return Rect2(cs.global_position - sz / 2.0, sz)
	return Rect2()


func linha(fase: String, nome: String, origin: Vector2, box: Rect2, art: Rect2) -> void:
	if art.size.x <= 0 or box.size.x <= 0:
		print("| %s | %s | sem medida |" % [fase, nome])
		return
	var inter := box.intersection(art)
	var cobre := inter.get_area() / art.get_area() * 100.0
	var sobra := (box.get_area() - inter.get_area()) / box.get_area() * 100.0
	var fora := "esq %d, dir %d, cima %d, baixo %d" % [maxi(0, roundi(box.position.x - art.position.x)),
		maxi(0, roundi(art.end.x - box.end.x)), maxi(0, roundi(box.position.y - art.position.y)), maxi(0, roundi(art.end.y - box.end.y))]
	print("| %s | %s | %d × %d em (%d, %d) | %d × %d | %d %% | %d %% | %s |" % [fase, nome, box.size.x, box.size.y,
		roundi(box.get_center().x - origin.x), roundi(box.get_center().y - origin.y), art.size.x, art.size.y, roundi(cobre),
		roundi(sobra), fora])


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
	print("| Fase | Entidade | Caixa de dano (centro rel. à origem) | Desenho | Desenho coberto | Caixa vazia | Desenho fora da caixa (px) |")
	print("|---|---|---|---|---|---|---|")
	for id in ["lab", "verdamia", "deserto", "nivaria"]:
		if only != "" and id != only:
			continue
		game.load_level(id, LevelData.get_level(id)["spawn"], false)
		await ticks(40)
		var p: Player = game.player
		p.inv = 9999.0
		linha(id, "jogador (%s)" % p.form, p.global_position, box_rect(p.hurtbox), art_rect(p))
		var seen := {}
		for e in get_nodes_in_group("enemies"):
			if not is_instance_valid(e) or e.dead or not ("hurt_area" in e) or e.hurt_area == null:
				continue
			var k := _kind(e)
			if seen.has(k):
				continue
			seen[k] = true
			linha(id, k, e.global_position, box_rect(e.hurt_area), art_rect(e))
	quit(0)
