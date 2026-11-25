extends SceneTree
## Auditoria visual: alinha personagens e inimigos de cada universo na escala real do jogo
## (zoom 1,1), sobre um fundo neutro com régua. Gera um PNG por universo e um dos chefes.
## uso: godot --audio-driver Dummy --path . --script res://tools/lineup.gd -- out=/pasta

var game
var out := "user://"
const ROWS := {
	"lab": {"pos": Vector2(300, 790), "floor": 800.0, "items": ["player", "crawler", "drone", "turret_r"]},
	"verdamia": {"pos": Vector2(300, 790), "floor": 800.0, "items": ["player", "human", "moth", "spore"]},
	"deserto": {"pos": Vector2(300, 690), "floor": 700.0, "items": ["player", "human", "robo", "drone_df"]},
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
	print("captura ", name)


class Ruler extends Node2D:
	var floor_y := 0.0
	var x0 := 0.0
	var x1 := 0.0
	func _draw() -> void:
		draw_rect(Rect2(x0 - 2000, floor_y - 1400, 6000, 2400), Color("6f7480"))
		draw_line(Vector2(x0 - 2000, floor_y), Vector2(x1 + 2000, floor_y), Color(1, 1, 1, 0.7), 2.0)
		for k in range(1, 6):
			var y := floor_y - k * 62.0
			draw_line(Vector2(x0 - 2000, y), Vector2(x1 + 2000, y), Color(1, 1, 1, 0.12 if k > 1 else 0.35), 1.0)


func _human(lv) -> Player:
	var h := Player.new()
	h.form = "human"
	h.level = lv
	return h


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	game.events["fuga_lab"] = true
	for lid in ROWS:
		var cfg: Dictionary = ROWS[lid]
		game.load_level(lid, cfg["pos"], false)
		await ticks(10)
		var lv = game.level
		# some com inimigos da fase, efeitos e objetos (só a fila fica na tela)
		for e in lv.entities.get_children():
			if e != game.player:
				e.queue_free()
		lv.objects.visible = false
		lv.fx.visible = false
		for c in lv.get_children():
			if c is FgLayer:
				c.visible = false
		var ruler := Ruler.new()
		ruler.floor_y = cfg["floor"]
		ruler.x0 = cfg["pos"].x - 200
		ruler.x1 = cfg["pos"].x + 700
		ruler.z_index = 3
		lv.add_child(ruler)
		var x: float = cfg["pos"].x
		for it in cfg["items"]:
			var node: Node2D = null
			var y: float = cfg["floor"]
			match it:
				"player":
					node = game.player
				"human":
					node = _human(lv)
				"robo", "drone_df":
					var d := DesertEnemy.new()
					d.level = lv
					d.drone = it == "drone_df"
					d.patrol = Vector2(x, x)
					node = d
					if d.drone:
						y -= 90.0
				_:
					node = lv.spawn_enemy(it, Vector2(x, y))
					if it in ["drone", "moth"]:
						y -= 90.0
			if node != game.player and node.get_parent() == null:
				lv.entities.add_child(node)
			await ticks(3)
			node.global_position = Vector2(x, y)
			if node != game.player:
				node.process_mode = Node.PROCESS_MODE_DISABLED     # congela onde está
			x += 150.0
		await ticks(40)
		await shot("fila_" + lid)
		# mesma cena sem os personagens (para separar cada figura por diferença)
		var keep_cam: Vector2 = game.cam.get_screen_center_position()
		for e in lv.entities.get_children():
			e.visible = false
		game.player.process_mode = Node.PROCESS_MODE_DISABLED
		await ticks(4)
		await shot("fila_" + lid + "_fundo")
	# chefes na escala de jogo (zoom 1,1), congelados
	game.load_level("verdamia", Vector2(4250, 790), false)
	await ticks(30)
	for e in game.level.entities.get_children():
		e.process_mode = Node.PROCESS_MODE_DISABLED
	await ticks(4)
	await shot("chefe_rainha")
	game.load_level("deserto", Vector2(7560, 760), false)
	await ticks(6)
	game.level.desert.forja.process_mode = Node.PROCESS_MODE_DISABLED
	await ticks(40)
	game.player.process_mode = Node.PROCESS_MODE_DISABLED
	await ticks(4)
	await shot("chefe_forja")
	AudioMgr.inst.shutdown()
	quit(0)
