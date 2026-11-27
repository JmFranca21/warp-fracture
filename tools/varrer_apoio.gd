extends SceneTree
## Revisão geral: acha decoração "sem apoio". Para cada sprite de imagem do mundo (fora do fundo em
## parallax e das entidades), mede a base do desenho opaco (alfa > 40) em px do mundo e lança três raios
## para baixo (a 25 %, 50 % e 75 % da largura) até o terreno (camadas 1 e 256). Se o chão mais perto está
## entre 3 e 60 px abaixo da base, o objeto parece flutuar: lista com o nó, a textura e a folga.
## Objetos pendurados (corrente, fio, gancho) e brilhos ficam de fora pelo nome.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/varrer_apoio.gd -- [level=lab]

var game
const IGNORA := ["corrente", "chain", "fio", "cabo", "gancho", "hook", "lamp", "lampada", "DF37", "DF39", "DF28",
	"janela", "window", "banner", "bandeira", "glow", "nevoa", "fog", "luz", "teto", "cipo", "vinha", "estalact"]


func _initialize() -> void:
	_run.call_deferred()


func _alpha_bottom(img: Image) -> Vector3:
	# devolve (x0, x1, y) da última linha com desenho opaco e a faixa de x dela (passo de 2 px)
	var used := img.get_used_rect()
	for y in range(used.end.y - 1, used.position.y - 1, -1):
		var x0 := -1
		var x1 := -1
		for x in range(used.position.x, used.end.x, 2):
			if img.get_pixel(x, y).a > 0.16:
				if x0 < 0:
					x0 = x
				x1 = x
		if x0 >= 0 and (x1 - x0) > 6:
			return Vector3(x0, x1, y)
	return Vector3(-1, -1, -1)


func _run() -> void:
	var only := ""
	for a in OS.get_cmdline_user_args():
		if a.begins_with("level="):
			only = a.substr(6)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	for i in 4:
		await physics_frame
	game._reset_progress()
	game.menu.visible = false
	var total := 0
	for id in ["lab", "verdamia", "deserto", "nivaria"]:
		if only != "" and id != only:
			continue
		game.load_level(id, LevelData.get_level(id)["spawn"], false)
		for i in 30:
			await physics_frame
		var space: PhysicsDirectSpaceState2D = game.level.get_world_2d().direct_space_state
		var n := 0
		for s in game.level.find_children("*", "Sprite2D", true, false):
			if not s.is_visible_in_tree() or s.texture == null or s.texture is GradientTexture2D:
				continue
			if s.get_viewport() != root or s.z_index <= -5 or absf(wrapf(s.global_rotation, -PI, PI)) > 0.1:
				continue      # fundo, ou sprite girado (a base da imagem não é o pé)
			var anc: Node = s.get_parent()
			var entidade := false
			while anc != null and anc != game.level:
				if anc is CharacterBody2D or anc is CanvasLayer or anc is ParallaxLayer or anc is Parallax2D \
						or anc is Area2D or anc.is_in_group("enemies"):
					entidade = true
				anc = anc.get_parent()
			if entidade:
				continue
			var nome: String = (str(s.name) + " " + s.texture.resource_path.get_file()).to_lower()
			var pula := false
			for k in IGNORA:
				if k.to_lower() in nome:
					pula = true
			if pula:
				continue
			var img: Image = s.texture.get_image()
			if img == null:
				continue
			if img.is_compressed():
				img.decompress()
			if s.region_enabled:
				img = img.get_region(Rect2i(s.region_rect))
			var b := _alpha_bottom(img)
			if b.z < 0:
				continue
			var size := Vector2(img.get_size())
			var tl: Vector2 = (s.offset - size / 2.0) if s.centered else s.offset
			var xf: Transform2D = s.get_global_transform()
			var folga := 1e9
			var base_y := 0.0
			var base_x := 0.0
			for f in [0.25, 0.5, 0.75]:
				var pl: Vector2 = xf * (tl + Vector2(lerpf(b.x, b.y, f), b.z))
				var q := PhysicsRayQueryParameters2D.create(pl + Vector2(0, -2), pl + Vector2(0, 80), 1 | 256)
				var hit := space.intersect_ray(q)
				if not hit.is_empty():
					folga = minf(folga, hit.position.y - pl.y)
				base_y = pl.y
				base_x = pl.x if f == 0.5 else base_x
			if folga >= 3.0 and folga <= 60.0:
				print("%-9s %-40s %-28s base (%d, %d)  folga %d px  (pai %s, z %d, %s)" % [id, str(game.level.get_path_to(s)).right(40),
					s.texture.resource_path.get_file(), base_x, base_y, folga, s.get_parent().name, s.z_index, s.texture.get_size()])
				n += 1
		print("== %s: %d sem apoio" % [id, n])
		total += n
	quit(1 if total else 0)
