extends SceneTree
## Forja-Mãe na Câmara, em quatro estados, com a câmera da luta (1280 × 720, zoom 0,85):
## repouso, aviso (martelo esquerdo, lente e escotilhas), martelo preso (âncora ciano) e peito aberto.
## Para comparar com colaboracao/entregas/DF100/DF100_montagem_v3.png e _aviso_v3.png.
## uso: xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 --path . \
##        --script res://tools/captura_forja.gd -- out=/pasta [hb=1]   (hb=1: desenha as áreas de dano)

var game
var out := "user://"
var hb := false


class HB extends Node2D:
	var root_node: Node

	func _process(_d: float) -> void:
		queue_redraw()

	func _draw() -> void:
		for cs in root_node.find_children("*", "CollisionShape2D", true, false):
			if cs.disabled:
				continue
			var par := cs.get_parent()
			var col := Color(1, 0.2, 0.2, 0.9) if par.is_in_group("enemy_attack") else (Color(0.2, 0.95, 1, 0.9) if par is Area2D else Color(1, 0.9, 0.2, 0.9))
			draw_set_transform_matrix(get_global_transform().affine_inverse() * cs.global_transform)
			if cs.shape is RectangleShape2D:
				draw_rect(Rect2(-cs.shape.size / 2.0, cs.shape.size), col, false, 1.5)
			elif cs.shape is CircleShape2D:
				draw_arc(Vector2.ZERO, cs.shape.radius, 0, TAU, 32, col, 1.5)


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
		elif a == "hb=1":
			hb = true
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func shot(name: String) -> void:
	paused = true
	game.cam.position = Vector2(7770, 420)
	game.cam.zoom = Vector2(0.85, 0.85)
	game.cam.reset_smoothing()
	game.level._process(0.0)
	for i in 4:
		await process_frame
	root.get_viewport().get_texture().get_image().save_png(out.path_join(name + ".png"))
	paused = false


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	await ticks(4)
	game._reset_progress()
	game.events["porta_imantada"] = true
	game.events["forja_intro"] = true
	game.menu.visible = false
	game.hud.visible = false
	game.load_level("deserto", Vector2(7300, 760), false)
	await ticks(30)
	var f: Forja = game.level.desert.forja
	var p: Player = game.player
	p.inv = 9999.0
	if hb:
		var o := HB.new()
		o.root_node = f
		o.z_index = 100
		o.z_as_relative = false
		game.level.add_child(o)
	f.start()
	await ticks(10)
	game.level.boss_cam = Vector2(7770, 420)
	p.global_position = Vector2(7500, 760)
	p.controls_locked = true
	f.next_t = 999.0
	await ticks(30)
	await shot("forja_1_repouso")
	# aviso: martelo esquerdo, lente e escotilhas
	var a0 = f.arms[0]
	a0.state = "warn"
	a0.hammer.frame = 1
	f.lens.texture = DFArt.cell("DF101", 1)
	for h in f.hatches:
		h.texture = DFArt.cell("DF107", 1)
		h.modulate = Color(1.0, 0.45, 0.35)
	await ticks(2)
	await shot("forja_2_aviso")
	for h in f.hatches:
		h.texture = DFArt.cell("DF107", 0)
		h.modulate = Color.WHITE
	# martelo preso no chão, com a âncora acesa
	a0.state = "stuck"
	a0.jy = Forja.SLAM_Y
	a0.hammer.frame = 2
	a0.set_hook(true)
	a0.layout()
	a0.plat_cs.disabled = false
	f.lens.texture = DFArt.cell("DF101", 0)
	await ticks(2)
	await shot("forja_3_martelo_preso")
	# peito aberto (fase 3)
	f.phase = 3
	f.chest_open = 3.0
	f.chest.texture = DFArt.cell("DF102", 1)
	f.chest_core.set_on(true)
	await shot("forja_4_peito_aberto")
	quit(0)
