extends SceneTree
## Revisão geral: exporta cada quadro de cada SpriteFrames (.tres) de assets/ como PNG, mais um índice
## JSON (recurso, animação, quadro, região na folha, duração), para tools/auditar_animacoes.py medir
## quadros repetidos, pixels soltos e cortes na borda da célula com o mesmo critério da auditoria do Deserto.
## uso: godot --headless --path . --script res://tools/exportar_quadros.gd -- out=/pasta

var out := "/tmp/quadros"


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
	DirAccess.make_dir_recursive_absolute(out)
	var index := []
	for path in _tres("res://assets"):
		var res = load(path)
		if not (res is SpriteFrames):
			continue
		var sf: SpriteFrames = res
		for anim in sf.get_animation_names():
			for i in sf.get_frame_count(anim):
				var tex: Texture2D = sf.get_frame_texture(anim, i)
				if tex == null:
					continue
				var img := tex.get_image()
				if img == null:
					continue
				var region := Rect2()
				var atlas := ""
				if tex is AtlasTexture:
					region = tex.region
					atlas = tex.atlas.resource_path if tex.atlas else ""
				var nome := "%s__%s__%02d.png" % [path.trim_prefix("res://assets/").replace("/", "_").get_basename(), anim, i]
				img.save_png(out.path_join(nome))
				index.append({"tres": path, "anim": anim, "quadro": i, "arquivo": nome, "atlas": atlas,
					"regiao": [region.position.x, region.position.y, region.size.x, region.size.y],
					"duracao": sf.get_frame_duration(anim, i), "fps": sf.get_animation_speed(anim),
					"loop": sf.get_animation_loop(anim)})
	var f := FileAccess.open(out.path_join("indice.json"), FileAccess.WRITE)
	f.store_string(JSON.stringify(index, "  "))
	f.close()
	print("%d quadros exportados para %s" % [index.size(), out])
	quit(0)


func _tres(dir: String) -> Array:
	var lst := []
	var d := DirAccess.open(dir)
	if d == null:
		return lst
	for f in d.get_files():
		if f.ends_with(".tres"):
			lst.append(dir.path_join(f))
	for sub in d.get_directories():
		lst.append_array(_tres(dir.path_join(sub)))
	return lst
