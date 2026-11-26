extends SceneTree
## Lista os ganchos de cada fase e classifica os que servem para atravessar um vão:
## para cada gancho, mede o chão logo abaixo dele e procura a borda de apoio mais próxima de cada lado.
## Um gancho é "de travessia" quando o chão embaixo dele está pelo menos 120 px abaixo das duas bordas
## (ou não existe) e as duas bordas estão a até 520 px do gancho.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/mapa_ganchos.gd -- [level=lab]

var game


func _initialize() -> void:
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


## y do chão (camadas 1 e 256) abaixo de (x, y0), ou INF.
static func floor_at(space: PhysicsDirectSpaceState2D, x: float, y0: float, depth := 900.0) -> float:
	var q := PhysicsRayQueryParameters2D.create(Vector2(x, y0), Vector2(x, y0 + depth), 1 | 256)
	var hit := space.intersect_ray(q)
	return INF if hit.is_empty() else float(hit["position"].y)


## Gancho de travessia: {hook, left_x, left_y, right_x, right_y, pit_y} ou {} se não for.
static func gap_of(space: PhysicsDirectSpaceState2D, hp: Vector2) -> Dictionary:
	var y0 := hp.y + 30.0
	var under := floor_at(space, hp.x, y0)
	var res := {"hook": hp, "pit_y": under}
	for side in [-1, 1]:
		var found := false
		var x := hp.x
		while absf(x - hp.x) < 520.0:
			x += side * 8.0
			var fy := floor_at(space, x, y0)
			if fy != INF and fy < under - 120.0 and fy - hp.y < 420.0:
				# borda: o primeiro ponto com apoio; recua até onde o apoio continua por 40 px
				res["left_x" if side < 0 else "right_x"] = x
				res["left_y" if side < 0 else "right_y"] = fy
				found = true
				break
		if not found:
			return {}
	return res


func _run() -> void:
	var only := ""
	for a in OS.get_cmdline_user_args():
		if a.begins_with("level="):
			only = a.substr(6)
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.modules["arpao"] = true
	game.menu.visible = false
	for id in ["lab", "deserto", "nivaria"]:
		if only != "" and id != only:
			continue
		game.load_level(id, LevelData.get_level(id)["spawn"], false)
		await ticks(20)
		var space: PhysicsDirectSpaceState2D = game.level.get_world_2d().direct_space_state
		print("== ", id)
		var hooks := get_nodes_in_group("hooks")
		hooks.sort_custom(func(a, b): return a.global_position.x < b.global_position.x)
		for h in hooks:
			var g := gap_of(space, h.global_position)
			if g.is_empty():
				print("  gancho %s  (subida ou apoio, sem vão embaixo)" % [h.global_position])
			else:
				print("  gancho %s  VÃO: borda esq x %.0f y %.0f · borda dir x %.0f y %.0f · fundo y %s" % [
					h.global_position, g["left_x"], g["left_y"], g["right_x"], g["right_y"], str(g["pit_y"])])
	quit(0)
