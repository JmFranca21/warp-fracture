extends SceneTree
## Retrato da fase carregada: cada nó do nível (ordem, classe, posição, camadas, configuração), para comparar o
## nível montado pelo código com o carregado da cena. Não inclui contadores de tempo nem nós criados depois.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/dump_fase.gd -- level=lab estado=zero out=arq.txt
##   codigo=1: Deserto montado pelo código (para comparar com scenes/fases/deserto.tscn)
##   estado: zero (jogo novo) | avancado (itens, terminais e eventos feitos) | chefe (Rainha vencida, fragmento pego)

var game
const PROPS := ["theme", "text", "tid", "rect", "target", "kind", "pid", "respawn", "travel", "hang_y", "sid", "period",
	"phase", "hint", "ceil_y", "side", "spawns", "dir", "drop", "depth", "span", "layer_index", "rects", "thin_art",
	"spans", "columns", "breaches", "pipes", "drops", "rails", "ground_rects", "clear", "base_y", "img_scale", "top",
	"left", "single", "tiled", "portal_x", "color", "size", "prompt", "label", "state", "opened", "active", "pulled",
	"open", "dropped", "home", "hp", "max_hp", "collision_layer", "collision_mask", "monitoring", "monitorable",
	"amount", "lifetime", "emission_rect_extents", "offset", "centered", "flip_h", "flip_v", "region_enabled",
	"region_rect", "hframes", "vframes", "stretch_mode", "layer", "blend_mode"]


func _initialize() -> void:
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await process_frame


func fmt(v) -> String:
	if v is float:
		return "nan" if is_nan(v) else "%.3f" % v
	if v is Vector2:
		return "(%s, %s)" % [fmt(v.x), fmt(v.y)]
	if v is Rect2:
		return "[%s %s]" % [fmt(v.position), fmt(v.size)]
	if v is Color:
		return "c(%s %s %s %s)" % [fmt(v.r), fmt(v.g), fmt(v.b), fmt(v.a)]
	if v is Array or v is PackedVector2Array:
		return "[" + ", ".join(Array(v).map(func(x): return fmt(x))) + "]"
	if v is Dictionary:
		var ks: Array = v.keys()
		ks.sort()
		return "{" + ", ".join(ks.map(func(k): return "%s: %s" % [k, fmt(v[k])])) + "}"
	if v is Resource:
		return res(v)
	if v is Object:
		return "obj(%s)" % (v.get_class() if v != null else "null")
	if v is Callable:
		return "callable"
	return str(v)


func res(r) -> String:
	if r == null:
		return "-"
	if not (r is Resource):
		return fmt(r)
	if r.resource_path != "" and not r.resource_path.contains("::"):
		return r.resource_path.get_file()
	if r is AtlasTexture:
		return "atlas(%s %s)" % [res(r.atlas), fmt(r.region)]
	if r is GradientTexture2D:
		return "grad(%dx%d %s)" % [r.width, r.height, fmt(r.gradient.colors)]
	if r is CanvasItemMaterial:
		return "mat(%d)" % r.blend_mode
	if r is RectangleShape2D:
		return "rect(%s)" % fmt(r.size)
	if r is SpriteFrames:
		return "frames(%s)" % ",".join(r.get_animation_names())
	if r is Texture2D:
		return "%s(%dx%d)" % [r.get_class(), r.get_width(), r.get_height()]
	return r.get_class()


func line(n: Node, path: String) -> String:
	var cls: String = n.get_class()
	var sc: Script = n.get_script()
	if sc != null:
		cls = sc.get_global_name() if sc.get_global_name() != "" else sc.resource_path.get_file()
	var parts := [path, cls]
	if n is CanvasItem:
		parts.append("vis=%s z=%d rel=%s mod=%s smod=%s mat=%s" % [n.visible, n.z_index, n.z_as_relative, fmt(n.modulate), fmt(n.self_modulate), res(n.material)])
	if n is Node2D:
		parts.append("pos=%s rot=%s esc=%s" % [fmt(n.position), fmt(n.rotation), fmt(n.scale)])
	if n is Control:
		parts.append("anc=%s %s %s %s" % [n.anchor_left, n.anchor_top, n.anchor_right, n.anchor_bottom])
	for k in ["texture", "shape", "sprite_frames", "color_ramp"]:
		if k in n:
			parts.append("%s=%s" % [k, res(n.get(k))])
	for k in PROPS:
		if k in n:
			parts.append("%s=%s" % [k, fmt(n.get(k))])
	var gs := n.get_groups().filter(func(g): return not String(g).begins_with("_"))
	if not gs.is_empty():
		parts.append("grupos=%s" % str(gs))
	return " | ".join(parts)


func walk(n: Node, path: String, out: PackedStringArray, skip: Node) -> void:
	out.append(line(n, path))
	var i := 0
	for c in n.get_children():
		if c == skip:
			i += 1
			continue
		walk(c, "%s/%d" % [path, i], out, skip)
		i += 1


func _run() -> void:
	var lid := "lab"
	var estado := "zero"
	var out_path := "user://dump.txt"
	for a in OS.get_cmdline_user_args():
		if a.begins_with("level="):
			lid = a.substr(6)
		elif a.begins_with("estado="):
			estado = a.substr(7)
		elif a.begins_with("out="):
			out_path = a.substr(4)
		elif a == "codigo=1":
			LevelData.sem_cena = true      # Deserto: a montagem antiga pelo código, para comparar com a cena
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(2)
	game._reset_progress()
	game.menu.visible = false
	if estado == "avancado":
		for id in ["lab_c1", "lab_e1", "lab_arpao", "log_01", "log_03", "lab_nucleo1", "v_c1", "v_h1", "log_06"]:
			game.collected[id] = true
		game.terminals["A"] = true
		game.terminals["B"] = true
		game.events["fuga_lab"] = true
		game.modules["arpao"] = true
		for id in ["df_c0", "df_c5", "df_h1", "df_enemy0", "df_enemy3"]:
			game.collected[id] = true
	elif estado == "chefe":
		game.boss_done["verdamia"] = true
		game.frags["verdamia"] = true
		game.boss_done["deserto"] = true
		game.frags["deserto"] = true
	var spawn: Vector2 = LevelData.get_level(lid)["spawn"]
	game.load_level(lid, spawn, false)
	paused = true            # nada se move: o retrato é do nível recém-montado
	await ticks(3)
	var lv: Node = game.level
	var out := PackedStringArray()
	walk(lv, "nivel", out, game.player)
	var f := FileAccess.open(out_path, FileAccess.WRITE)
	f.store_string("\n".join(out) + "\n")
	f.close()
	print("dump: %d nós -> %s" % [out.size(), out_path])
	AudioMgr.inst.shutdown()
	quit(0)
