extends SceneTree
## Hitboxes sobre a arte e origem real dos tiros, para cada tipo de inimigo de cada fase.
## Para cada tipo (o primeiro de cada script), põe o jogador na frente (dos dois lados), espera o
## inimigo atirar, guarda onde o projétil NASCEU em relação à origem do inimigo e fotografa o inimigo
## em 1280 × 720 com zoom 2,5: corpo/colisão em amarelo, área que fere o jogador (hurtbox do inimigo) em
## ciano, origem do tiro em magenta (cruz cheia: virado para a direita; vazada: para a esquerda).
## uso: xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 --path . \
##        --script res://tools/captura_hitboxes.gd -- out=/pasta [level=lab|verdamia|deserto]
## Também imprime a tabela de origens (px do jogo, relativas à origem do inimigo, olhando para a direita).

var game
var out := "user://"
var only := ""
var origins := {}      # tipo → {1: Vector2, -1: Vector2}


class Overlay extends Node2D:
	var target: Node2D
	var marks: Array = []     # [Vector2 global, filled]

	func _process(_d: float) -> void:
		queue_redraw()

	func _draw() -> void:
		if not is_instance_valid(target):
			return
		for cs in target.find_children("*", "CollisionShape2D", true, false):
			var col := Color(0.2, 0.95, 1.0, 0.95) if cs.get_parent() is Area2D else Color(1.0, 0.9, 0.2, 0.95)
			if cs.disabled:
				col.a = 0.35
			draw_set_transform_matrix(get_global_transform().affine_inverse() * cs.global_transform)
			var sh: Shape2D = cs.shape
			if sh is RectangleShape2D:
				draw_rect(Rect2(-sh.size / 2.0, sh.size), col, false, 1.0)
			elif sh is CircleShape2D:
				draw_arc(Vector2.ZERO, sh.radius, 0, TAU, 32, col, 1.0)
			elif sh is CapsuleShape2D:
				draw_rect(Rect2(-sh.radius, -sh.height / 2.0, sh.radius * 2.0, sh.height), col, false, 1.0)
		draw_set_transform_matrix(get_global_transform().affine_inverse())
		var o := target.global_position
		draw_line(o + Vector2(-4, 0), o + Vector2(4, 0), Color(1, 1, 1), 1.0)
		draw_line(o + Vector2(0, -4), o + Vector2(0, 4), Color(1, 1, 1), 1.0)
		for m in marks:
			var c := Color(1.0, 0.2, 1.0)
			draw_line(m[0] + Vector2(-5, -5), m[0] + Vector2(5, 5), c, 1.5)
			draw_line(m[0] + Vector2(-5, 5), m[0] + Vector2(5, -5), c, 1.5)
			if m[1]:
				draw_circle(m[0], 2.0, c)
			else:
				draw_arc(m[0], 4.0, 0, TAU, 12, c, 1.0)


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
		elif a.begins_with("level="):
			only = a.substr(6)
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func _kind(e: Node) -> String:
	if e is DesertEnemy:
		return "deserto_drone" if e.drone else "deserto_robo"
	var sc: Script = e.get_script()
	return sc.resource_path.get_file().get_basename() if sc != null else e.name


## Espera o primeiro projétil novo em level.fx e devolve a posição em que nasceu (ou INF).
func wait_shot(e: Node2D, secs: float) -> Vector2:
	var fx: Node = game.level.fx
	var before := {}
	for c in fx.get_children():
		before[c] = true
	var t := 0.0
	while t < secs:
		await physics_frame
		t += 1.0 / 60.0
		var best := Vector2.INF
		for c in fx.get_children():
			if not before.has(c) and c is EnemyBullet:
				var born: Vector2 = c.get_meta("nasceu", c.global_position)
				# só o tiro deste inimigo: o que nasceu mais perto dele (outros inimigos podem atirar junto)
				if born.distance_to(e.global_position) < 130.0 and born.distance_to(e.global_position) < best.distance_to(e.global_position):
					best = born
		if best != Vector2.INF:
			return best
		game.player.inv = 9999.0
		game.player.hp = game.player.max_hp
	return Vector2.INF


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	# o projétil marca onde nasceu (antes do primeiro passo de física)
	for id in ["lab", "verdamia", "deserto"]:
		if only != "" and id != only:
			continue
		game.load_level(id, LevelData.get_level(id)["spawn"], false)
		await ticks(20)
		game.level.fx.child_entered_tree.connect(func(n): if n is Node2D: n.set_meta("nasceu", n.global_position))
		var seen := {}
		var list: Array = get_nodes_in_group("enemies").duplicate()
		for e in list:
			if not is_instance_valid(e) or e.dead:
				continue
			var k := _kind(e)
			if seen.has(k):
				continue
			seen[k] = true
			var res := {}
			# Rainha (espinhos do chão), Mariposa (só investe) e Turreta (feixe, olho medido à parte): só a foto
			var so_foto: bool = k in ["queen", "moth", "turret"]
			for side in ([] if so_foto else [1, -1]):
				var p: Player = game.player
				var ep: Vector2 = e.global_position
				var feet_y: float = ep.y
				if k == "deserto_drone" or k == "drone" or k == "moth":
					feet_y = ep.y + 150.0
				var dx := 40.0 if k == "deserto_drone" else 150.0
				p.global_position = Vector2(ep.x + side * dx, feet_y)
				p.velocity = Vector2.ZERO
				p.inv = 9999.0
				if "direction" in e:
					e.direction = side
				var born := await wait_shot(e, 7.0)
				if born != Vector2.INF:
					var rel: Vector2 = born - e.global_position
					res[side] = rel
			origins[k] = res
			# foto: jogador escondido; a câmera do jogo segue o jogador, então ele fica onde a câmera deve olhar
			var ov := Overlay.new()
			ov.target = e
			ov.z_index = 100
			ov.z_as_relative = false
			for side in res:
				ov.marks.append([e.global_position + Vector2(absf(res[side].x) * side * (1 if res[side].x * side >= 0 else -1), res[side].y), side > 0])
			game.level.add_child(ov)
			game.cam.position = e.global_position + Vector2(0, -30)
			game.cam.zoom = Vector2(1.2, 1.2) if k == "queen" else Vector2(2.5, 2.5)
			game.cam.reset_smoothing()
			for c in game.level.fx.get_children():
				if c is EnemyBullet:
					c.queue_free()
			paused = true
			game.player.visible = false
			game.player.facing = 1
			game.player.global_position = e.global_position + Vector2(-70, -30 + 165)
			game.cam.position = game._cam_target()
			game.cam.reset_smoothing()
			game.level._process(0.0)
			for i in 4:
				await process_frame
			root.get_viewport().get_texture().get_image().save_png(out.path_join("hitbox_%s_%s.png" % [id, k]))
			paused = false
			game.player.visible = true
			ov.queue_free()
			game.cam.zoom = Vector2.ONE
		print("== ", id)
		for k in origins:
			print("  %s: direita %s · esquerda %s" % [k, origins[k].get(1, "sem tiro"), origins[k].get(-1, "sem tiro")])
		origins.clear()
	quit(0)
