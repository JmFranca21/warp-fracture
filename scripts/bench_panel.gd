class_name BenchPanel
extends Control
## Painel da Bancada de Upgrades (pausa o jogo enquanto aberto).

signal closed

var main
var list := MenuList.new()
var active := false
var t := 0.0
var flash_t := 0.0
var msg := ""


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	list.font_size = 22
	list.spacing = 50.0


func open() -> void:
	active = true
	visible = true
	msg = ""
	_refresh()
	list.sel = 0


func _refresh() -> void:
	var items: Array = []
	for id in Upgrades.LIST:
		var lv := Upgrades.level(main, id)
		var mx := Upgrades.max_level(id)
		var c := Upgrades.cost(main, id)
		var tag := "COMPLETO" if c < 0 else "%d ◆" % c
		var pips := ""
		for i in mx:
			pips += "●" if i < lv else "○"
		items.append({"id": id, "label": "%s   %s   %s" % [Upgrades.LIST[id][0], pips, tag]})
	items.append({"id": "back", "label": "Sair da bancada"})
	list.set_items(items)


func handle(event: InputEvent) -> void:
	if not active:
		return
	if event.is_action_pressed("pause") or event.is_action_pressed("interact"):
		_close()
		return
	var id := list.handle(event)
	if id == "":
		return
	if id == "back":
		_close()
		return
	var c := Upgrades.cost(main, id)
	if c < 0:
		msg = "Esta melhoria já está no nível máximo."
		AudioMgr.sfx("negado", Vector2.INF, -4.0, 0.0)
	elif main.cells < c:
		msg = "Células de Fase insuficientes (faltam %d)." % (c - main.cells)
		AudioMgr.sfx("negado", Vector2.INF, -4.0, 0.0)
	else:
		main.cells -= c
		main.upgrades[id] = Upgrades.level(main, id) + 1
		main.apply_upgrades()
		msg = "%s instalado!" % Upgrades.LIST[id][0]
		flash_t = 0.5
		AudioMgr.sfx("modulo", Vector2.INF, -3.0, 0.0)
		main.save_now()
	_refresh()


func _close() -> void:
	active = false
	visible = false
	closed.emit()


func _process(dt: float) -> void:
	t += dt
	flash_t = maxf(0.0, flash_t - dt)
	if active:
		queue_redraw()


func _draw() -> void:
	if not active:
		return
	var sz := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, sz), Color(0.0, 0.01, 0.03, 0.75))
	var w := 760.0
	var h := 470.0
	var r := Rect2((sz.x - w) / 2.0, (sz.y - h) / 2.0, w, h)
	draw_rect(r, Color(0.03, 0.05, 0.09, 0.96))
	draw_rect(r, Color(0.35, 0.92, 1.0, 0.6 + flash_t), false, 2.0)
	Art.text(self, r.position + Vector2(0, 44), "BANCADA DE UPGRADES", 28, Color(0.9, 0.95, 1.0), HORIZONTAL_ALIGNMENT_CENTER, w)
	Art.text(self, r.position + Vector2(0, 74), "Células de Fase: %d ◆" % main.cells, 18, Color(0.55, 0.95, 1.0), HORIZONTAL_ALIGNMENT_CENTER, w)
	list.draw(self, sz.x / 2.0, r.position.y + 130, w - 80.0, t)
	var it: Dictionary = list.items[list.sel]
	var desc := "" if it["id"] == "back" else String(Upgrades.LIST[it["id"]][1])
	Art.text(self, Vector2(r.position.x, r.end.y - 62), desc, 17, Color(0.75, 0.85, 0.95), HORIZONTAL_ALIGNMENT_CENTER, w)
	if msg != "":
		Art.text(self, Vector2(r.position.x, r.end.y - 30), msg, 16, Color(1.0, 0.85, 0.5), HORIZONTAL_ALIGNMENT_CENTER, w)
