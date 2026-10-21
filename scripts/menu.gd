class_name MainMenu
extends Control
## Tela inicial: Continuar / Novo jogo / Opções / Sair (teclado, controle e mouse).

signal chosen(action: String)

var main
var t := 0.0
var stars: Array = []
var screen := "main"        # main | options | confirm
var list := MenuList.new()
var summary := ""


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	var rng := RandomNumberGenerator.new()
	rng.seed = 33
	for i in 160:
		stars.append([Vector2(rng.randf(), rng.randf()), rng.randf_range(0.6, 2.2), rng.randf() * 6.0])
	refresh()


func refresh() -> void:
	screen = "main"
	summary = SaveGame.summary()
	var items: Array = []
	if SaveGame.exists():
		items.append({"id": "continue", "label": "Continuar"})
	items.append({"id": "new", "label": "Novo jogo"})
	items.append({"id": "options", "label": "Opções"})
	items.append({"id": "quit", "label": "Sair"})
	list.set_items(items)
	list.sel = 0
	list.font_size = 26
	list.spacing = 46.0


func handle(event: InputEvent) -> void:
	var id := list.handle(event)
	if id == "" and screen != "main" and (event.is_action_pressed("pause")):
		id = "back"
	match screen:
		"main":
			match id:
				"continue":
					chosen.emit("continue")
				"new":
					if SaveGame.exists():
						screen = "confirm"
						list.set_items([{"id": "yes", "label": "Sim, apagar e começar"}, {"id": "back", "label": "Não, voltar"}])
						list.sel = 1
					else:
						chosen.emit("new")
				"options":
					screen = "options"
					list.set_items(MenuList.options_items())
					list.sel = 0
					list.font_size = 24
				"quit":
					chosen.emit("quit")
		"options":
			if id == "back":
				Settings.save_cfg()
				refresh()
		"confirm":
			if id == "yes":
				chosen.emit("new")
			elif id == "back":
				refresh()


func _process(dt: float) -> void:
	t += dt
	if visible:
		queue_redraw()


func _draw() -> void:
	var sz := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, sz), Color("04060c"))
	for i in 6:
		draw_rect(Rect2(0, sz.y * (0.5 + i * 0.1), sz.x, sz.y * 0.1), Color(0.05, 0.08, 0.14, 0.12 * i))
	for s in stars:
		var p: Vector2 = s[0] * sz
		var a := 0.35 + 0.35 * sin(t * 1.5 + float(s[2]))
		draw_circle(p, float(s[1]), Color(0.8, 0.9, 1.0, a))
	var c := Vector2(sz.x / 2.0, sz.y * 0.22)
	for i in 10:
		var r := 30.0 + i * 10.0
		var sp := (0.5 + i * 0.12) * (1.0 if i % 2 == 0 else -1.0)
		var a0 := t * sp + i * 0.7
		var col := Color(0.55, 0.4, 1.0).lerp(Color(0.35, 0.92, 1.0), float(i) / 9.0)
		col.a = 0.75 - i * 0.05
		draw_arc(c, r, a0, a0 + 2.2, 40, col, 3.0, true)
		draw_arc(c, r, a0 + PI, a0 + PI + 1.1, 24, Color(col, col.a * 0.5), 2.0, true)
	Art.poly(self, Art.circle(c, 24.0 + 2.0 * sin(t * 2.0), 32), Color(0.35, 0.92, 1.0, 0.9))
	var crack := PackedVector2Array([c + Vector2(-11, -27), c + Vector2(-2, -10), c + Vector2(-8, -2), c + Vector2(5, 11), c + Vector2(-2, 18), c + Vector2(8, 32)])
	draw_polyline(crack, Color("04060c"), 4.0, true)
	var ty := sz.y * 0.46
	Art.text(self, Vector2(0, ty), "WARP", 88, Color(0.35, 0.92, 1.0), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 10, Color(0.02, 0.05, 0.1, 1))
	Art.text(self, Vector2(0, ty + 52), "F R A C T U R E", 38, Color(0.8, 0.72, 1.0), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 8, Color(0.02, 0.05, 0.1, 1))
	var ly := sz.y * 0.66
	if screen == "options":
		Art.text(self, Vector2(0, ly - 30), "OPÇÕES", 22, Color(0.8, 0.88, 0.95), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
		list.draw(self, sz.x / 2.0, ly + 10, 520.0, t)
	elif screen == "confirm":
		Art.text(self, Vector2(0, ly - 20), "Começar um novo jogo apaga o progresso salvo.", 20, Color(1.0, 0.8, 0.7), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
		list.draw(self, sz.x / 2.0, ly + 30, 420.0, t)
	else:
		list.draw(self, sz.x / 2.0, ly, 360.0, t)
		if summary != "" and list.items.size() > 0 and list.items[list.sel]["id"] == "continue":
			Art.text(self, Vector2(0, sz.y - 58), summary, 16, Color(0.6, 0.75, 0.85), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
	Art.text(self, Vector2(0, sz.y - 26), "W/S ou mouse para escolher · ENTER confirma · ESC volta", 14, Color(0.55, 0.62, 0.72), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
	Art.text(self, Vector2(sz.x - 200, 30), "Protótipo v0.4", 14, Color(0.5, 0.58, 0.68), HORIZONTAL_ALIGNMENT_RIGHT, 180)
