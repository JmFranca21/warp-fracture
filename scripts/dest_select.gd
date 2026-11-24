class_name DestSelect
extends Control
## Seletor de destino do Arco de Dobra (D02, passo 8): glifos dos universos com sinal.
## A/D (ou W/S) escolhe, E/ENTER confirma, ESC cancela.

signal done(choice: String)

var main
var active := false
var items: Array = []        # [{id, nome, status}]
var sel := 0
var t := 0.0


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false


func open(list: Array, start := 0) -> void:
	items = list
	sel = clampi(start, 0, maxi(0, items.size() - 1))
	active = true
	visible = true


func _input(event: InputEvent) -> void:
	if not active:
		return
	var handled := true
	if event.is_action_pressed("left") or event.is_action_pressed("up"):
		sel = (sel + items.size() - 1) % items.size()
		AudioMgr.sfx("ui_mover", Vector2.INF, -4.0, 0.0)
	elif event.is_action_pressed("right") or event.is_action_pressed("down"):
		sel = (sel + 1) % items.size()
		AudioMgr.sfx("ui_mover", Vector2.INF, -4.0, 0.0)
	elif event.is_action_pressed("interact") or event.is_action_pressed("confirm"):
		AudioMgr.sfx("ui_ok", Vector2.INF, -2.0, 0.0)
		_close(String(items[sel]["id"]))
	elif event.is_action_pressed("pause"):
		AudioMgr.sfx("ui_volta", Vector2.INF, -2.0, 0.0)
		_close("")
	else:
		handled = false
	if handled:
		get_viewport().set_input_as_handled()


func _close(choice: String) -> void:
	active = false
	visible = false
	done.emit(choice)


func _process(dt: float) -> void:
	t += dt
	if active:
		queue_redraw()


func _draw() -> void:
	if not active:
		return
	var sz := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, sz), Color(0.0, 0.01, 0.03, 0.6))
	var w := 640.0
	var h := 300.0
	var r := Rect2((sz.x - w) / 2.0, (sz.y - h) / 2.0, w, h)
	draw_rect(r, Color(0.03, 0.05, 0.09, 0.95))
	draw_rect(r, Color(0.35, 0.85, 1.0, 0.6), false, 2.0)
	Art.text(self, r.position + Vector2(0, 42), "ARCO DE DOBRA · DESTINO", 26, Color(0.9, 0.95, 1.0), HORIZONTAL_ALIGNMENT_CENTER, w)
	var n := items.size()
	for i in n:
		var it: Dictionary = items[i]
		var cx := r.position.x + w * (i + 1) / (n + 1)
		var c := Vector2(cx, r.position.y + 140)
		var col := Portal.dest_color(it["id"])
		var on := i == sel
		draw_circle(c, 46.0, Color(0.02, 0.03, 0.06))
		draw_arc(c, 46.0, 0, TAU, 40, Color(col, 0.9 if on else 0.35), 3.0 if on else 1.5, true)
		var g := Portal.glyph_tex(it["id"], on)
		var gs := Vector2(110, 110)
		draw_texture_rect(g, Rect2(c - gs / 2.0, gs), false)
		Art.text(self, Vector2(cx - 140, c.y + 76), it["nome"], 18, Color(1, 1, 1, 1.0 if on else 0.6), HORIZONTAL_ALIGNMENT_CENTER, 280)
		Art.text(self, Vector2(cx - 140, c.y + 98), it["status"], 14, Color(col, 0.9 if on else 0.5), HORIZONTAL_ALIGNMENT_CENTER, 280)
	Art.text(self, Vector2(r.position.x, r.end.y - 16), "A / D  escolher      E  confirmar      ESC  cancelar", 15, Color(0.65, 0.72, 0.82), HORIZONTAL_ALIGNMENT_CENTER, w)
