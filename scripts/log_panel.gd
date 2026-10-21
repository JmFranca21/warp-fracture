class_name LogPanel
extends Control
## Leitor dos Registros do Projeto: mostra um registro ou o arquivo de registros lidos.

signal closed

var main
var active := false
var mode := "read"          # read | archive
var current := ""
var from_archive := false
var list := MenuList.new()
var t := 0.0
var reveal := 0.0


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	list.font_size = 20
	list.spacing = 40.0


func show_log(id: String, archive := false) -> void:
	active = true
	visible = true
	mode = "read"
	current = id
	from_archive = archive
	reveal = 0.0
	AudioMgr.sfx("terminal", Vector2.INF, -4.0, 0.0)


func show_archive() -> void:
	active = true
	visible = true
	mode = "archive"
	var items: Array = []
	for id in Logs.ORDER:
		if main.collected.has(id):
			items.append({"id": id, "label": Logs.LOGS[id][0]})
	items.append({"id": "back", "label": "Voltar"})
	list.set_items(items)
	list.sel = 0


func handle(event: InputEvent) -> void:
	if not active:
		return
	if mode == "read":
		if event.is_action_pressed("confirm") or event.is_action_pressed("pause") or event.is_action_pressed("interact") or (event is InputEventMouseButton and event.pressed):
			if reveal < 1.0:
				reveal = 1.0
				return
			if from_archive:
				show_archive()
			else:
				_close()
		return
	var id := list.handle(event)
	if event.is_action_pressed("pause") or id == "back":
		_close()
	elif id != "":
		show_log(id, true)


func _close() -> void:
	active = false
	visible = false
	closed.emit()


func _process(dt: float) -> void:
	t += dt
	if active:
		reveal = minf(1.0, reveal + dt * 0.9)
		queue_redraw()


func _draw() -> void:
	if not active:
		return
	var sz := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, sz), Color(0.0, 0.01, 0.03, 0.78))
	var w := 760.0
	var h := 460.0
	var r := Rect2((sz.x - w) / 2.0, (sz.y - h) / 2.0, w, h)
	draw_rect(r, Color(0.02, 0.05, 0.08, 0.97))
	draw_rect(r, Color(0.35, 0.92, 1.0, 0.55), false, 2.0)
	for y in range(int(r.position.y) + 4, int(r.end.y), 4):
		draw_line(Vector2(r.position.x + 2, y), Vector2(r.end.x - 2, y), Color(0.3, 0.8, 1.0, 0.03), 1.0)
	if mode == "archive":
		Art.text(self, r.position + Vector2(0, 46), "REGISTROS DO PROJETO  (%d/%d)" % [Logs.read_count(main), Logs.ORDER.size()], 24, Color(0.9, 0.95, 1.0), HORIZONTAL_ALIGNMENT_CENTER, w)
		list.draw(self, sz.x / 2.0, r.position.y + 110, w - 120.0, t)
		return
	var data: Array = Logs.LOGS[current]
	Art.text(self, r.position + Vector2(36, 48), "◆ REGISTRO DO PROJETO HÉLIX", 14, Color(0.45, 0.85, 1.0))
	Art.text(self, r.position + Vector2(36, 82), data[0], 24, Color(0.92, 0.96, 1.0))
	draw_line(r.position + Vector2(36, 96), r.position + Vector2(w - 36, 96), Color(0.35, 0.92, 1.0, 0.4), 1.0)
	var txt: String = data[1]
	var shown := txt.substr(0, int(txt.length() * reveal))
	draw_multiline_string(Art.font(), r.position + Vector2(36, 132), shown, HORIZONTAL_ALIGNMENT_LEFT, w - 72.0, 18, -1, Color(0.82, 0.9, 0.97))
	var hint := "ENTER / E para continuar" if reveal >= 1.0 else "ENTER para mostrar tudo"
	Art.text(self, Vector2(r.position.x, r.end.y - 22), hint, 14, Color(0.6, 0.7, 0.8, 0.6 + 0.4 * sin(t * 3.0)), HORIZONTAL_ALIGNMENT_CENTER, w)
