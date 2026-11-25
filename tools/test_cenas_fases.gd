extends SceneTree
## Confere que scenes/fases/lab.tscn e verdamia.tscn descrevem as mesmas fases que o código da v0.9
## (tools/referencia_fases_v09.gd): o dicionário que o jogo lê (LevelData.get_level) bate campo por campo, e a cena
## tem um nó para cada item da descrição antiga (decoração, sólidos, objetos, inimigos).
## Enquanto ninguém editar as cenas, todos passam; depois de editar no Godot, as diferenças mostram o que mudou.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_cenas_fases.gd

const REF := preload("res://tools/referencia_fases_v09.gd")
var fails := 0


func check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FALHA ") + what)
	if not ok:
		fails += 1


func _initialize() -> void:
	for id in ["lab", "verdamia"]:
		var old: Dictionary = REF.get_level(id)
		var new: Dictionary = LevelData.get_level(id)
		print("== ", id)
		for k in ["name", "sub", "theme", "form", "spawn", "bounds", "kill_y", "rooms", "solids", "hazards", "hooks",
				"lasers", "cameras", "levers", "fields", "locks", "enemies", "crates", "pickups", "signs",
				"checkpoints", "benches", "terminals", "door", "portal", "receptacle", "arrival_rift",
				"return_rift", "boss", "fuga", "thin_art"]:
			if not old.has(k) and not new.has(k):
				continue
			var a = old.get(k)
			var b = new.get(k)
			if k in ["hazards", "hooks", "lasers", "cameras", "levers", "fields", "locks", "crates", "benches", "terminals"] \
					and a == null and b is Array and b.is_empty():
				continue
			check(a == b, "%s: %s" % [k, "igual" if a == b else "código %s | cena %s" % [str(a).left(200), str(b).left(200)]])
		# plataformas: tipo, retângulo, deslocamento e opções (o código omitia as opções no valor padrão)
		var po: Array = old.get("platforms", [])
		var pn: Array = new.get("platforms", [])
		var same := po.size() == pn.size()
		for i in mini(po.size(), pn.size()):
			same = same and _plat(po[i]) == _plat(pn[i])
		check(same, "platforms: %d, iguais" % pn.size() if same else "platforms diferentes")
		# nós da cena: um para cada item da descrição antiga
		var lv: Level = load(LevelData.CENAS[id]).instantiate()
		var deco := 0
		for c in lv.get_node("Decoracao").get_children():
			if c is Sprite2D and not (c.texture is GradientTexture2D):
				deco += 1
		check(deco == old.get("decor", []).size(), "decoração: %d sprites (código: %d)" % [deco, old.get("decor", []).size()])
		var bw := lv.get_node_or_null("ParedeDeFundo")
		if old.has("backwall"):
			check(bw != null and bw.spans == old["backwall"]["spans"] and bw.columns == old["backwall"]["columns"],
				"parede de fundo: mesmos vãos e colunas")
		check(lv.get_node("Marcadores/Inicio").position == old["spawn"], "marcador Inicio no spawn")
		lv.free()
	print("cenas das fases: %d falha(s)" % fails)
	quit(1 if fails else 0)


func _plat(p: Array) -> Array:
	var travel: Vector2 = p[2] if p.size() > 2 and p[2] is Vector2 else Vector2.ZERO
	var o: Dictionary = p[p.size() - 1] if p[p.size() - 1] is Dictionary else {}
	return [p[0], p[1], travel, o.get("hang", -99999.0), o.get("sid", ""), o.get("period", 4.0)]   # NAN != NAN: sem gancho vira -99999
