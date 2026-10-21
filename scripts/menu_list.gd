class_name MenuList
extends RefCounted
## Lista navegável (teclado, controle e mouse) usada no menu principal, na pausa e nas opções.
## Itens: {"id", "label", "kind": "button"|"slider"|"toggle", "get": Callable, "set": Callable}

var items: Array = []
var sel := 0
var rects: Array = []
var font_size := 24
var spacing := 44.0


func set_items(list: Array) -> void:
	items = list
	sel = clampi(sel, 0, maxi(0, items.size() - 1))


## Devolve o id do item ativado (ou "" se nada foi ativado).
func handle(event: InputEvent) -> String:
	if items.is_empty():
		return ""
	if event is InputEventMouseMotion:
		for i in rects.size():
			if (rects[i] as Rect2).has_point(event.position) and sel != i:
				sel = i
				AudioMgr.sfx("ui_mover", Vector2.INF, -6.0, 0.0)
		return ""
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		for i in rects.size():
			if (rects[i] as Rect2).has_point(event.position):
				sel = i
				return _activate(0)
		return ""
	if event.is_action_pressed("up"):
		sel = (sel - 1 + items.size()) % items.size()
		AudioMgr.sfx("ui_mover", Vector2.INF, -4.0, 0.0)
	elif event.is_action_pressed("down"):
		sel = (sel + 1) % items.size()
		AudioMgr.sfx("ui_mover", Vector2.INF, -4.0, 0.0)
	elif event.is_action_pressed("left"):
		return _activate(-1)
	elif event.is_action_pressed("right"):
		return _activate(1)
	elif event.is_action_pressed("confirm") or (event is InputEventKey and event.pressed and event.physical_keycode == KEY_E):
		return _activate(0)
	return ""


func _activate(dir: int) -> String:
	var it: Dictionary = items[sel]
	var kind: String = it.get("kind", "button")
	if kind == "slider":
		var step := 0.1 if dir != 0 else 0.0
		if dir == 0:
			return ""
		var v: float = clampf(it["get"].call() + step * dir, 0.0, 1.0)
		it["set"].call(snappedf(v, 0.1))
		AudioMgr.sfx("ui_mover", Vector2.INF, -2.0, 0.0)
		return it["id"]
	if kind == "toggle":
		it["set"].call(not it["get"].call())
		AudioMgr.sfx("ui_ok", Vector2.INF, -3.0, 0.0)
		return it["id"]
	if dir != 0:
		return ""
	AudioMgr.sfx("ui_ok", Vector2.INF, -2.0, 0.0)
	return it["id"]


func draw(ci: CanvasItem, center_x: float, top_y: float, width := 420.0, t := 0.0) -> void:
	rects.clear()
	for i in items.size():
		var it: Dictionary = items[i]
		var y := top_y + i * spacing
		var r := Rect2(center_x - width / 2.0, y - font_size - 8, width, font_size + 18)
		rects.append(r)
		var on := i == sel
		if on:
			ci.draw_rect(r, Color(0.35, 0.92, 1.0, 0.10))
			ci.draw_rect(Rect2(r.position.x, r.position.y, 3, r.size.y), Color(0.35, 0.92, 1.0, 0.9))
		var col := Color(1, 1, 1) if on else Color(0.72, 0.8, 0.9)
		var kind: String = it.get("kind", "button")
		if kind == "button":
			Art.text(ci, Vector2(r.position.x, y), it["label"], font_size, col, HORIZONTAL_ALIGNMENT_CENTER, width, 4)
		else:
			Art.text(ci, Vector2(r.position.x + 18, y), it["label"], font_size - 4, col, HORIZONTAL_ALIGNMENT_LEFT, -1, 4)
			var vx := r.end.x - 170.0
			if kind == "slider":
				var v: float = it["get"].call()
				var bar := Rect2(vx, y - 13, 130, 8)
				ci.draw_rect(bar, Color(0.1, 0.14, 0.2))
				ci.draw_rect(Rect2(bar.position, Vector2(bar.size.x * v, bar.size.y)), Color(0.35, 0.92, 1.0) if on else Color(0.3, 0.6, 0.75))
				Art.text(ci, Vector2(bar.end.x + 8, y), "%d%%" % int(round(v * 100)), font_size - 8, col)
			else:
				var b: bool = it["get"].call()
				Art.text(ci, Vector2(vx, y), "LIGADO" if b else "DESLIGADO", font_size - 6, Color(0.5, 1.0, 0.7) if b else Color(0.9, 0.5, 0.5))
		if on and kind != "button":
			Art.text(ci, Vector2(r.position.x, y + 22), "◀  ▶ para ajustar", 13, Color(0.6, 0.7, 0.8, 0.7), HORIZONTAL_ALIGNMENT_RIGHT, width - 10)


static func options_items() -> Array:
	return [
		{"id": "master", "label": "Volume geral", "kind": "slider",
			"get": func(): return Settings.master, "set": func(v): Settings.master = v; Settings.apply()},
		{"id": "musica", "label": "Música", "kind": "slider",
			"get": func(): return Settings.musica, "set": func(v): Settings.musica = v; Settings.apply()},
		{"id": "efeitos", "label": "Efeitos sonoros", "kind": "slider",
			"get": func(): return Settings.efeitos, "set": func(v): Settings.efeitos = v; Settings.apply()},
		{"id": "fullscreen", "label": "Tela cheia", "kind": "toggle",
			"get": func(): return Settings.fullscreen, "set": func(v): Settings.fullscreen = v; Settings.apply()},
		{"id": "shake", "label": "Tremor de tela", "kind": "toggle",
			"get": func(): return Settings.shake, "set": func(v): Settings.shake = v},
		{"id": "back", "label": "Voltar", "kind": "button"},
	]
