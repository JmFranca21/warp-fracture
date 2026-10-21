class_name Calibration
extends Control
## Mini-game "Calibração de Portal": alinhar 3 ondas de frequência.

signal done(ok: bool)

var main
var active := false
var target: Array = []
var cur: Array = []
var sel := 0
var t := 0.0
var success_t := -1.0
const STEP := 0.25


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false


func open() -> void:
	target.clear()
	cur.clear()
	for i in 3:
		var tg := 1.0 + float(randi() % 9) * 0.5
		target.append(tg)
		var c := tg
		while absf(c - tg) < 0.6:
			c = 0.5 + float(randi() % 19) * STEP
		cur.append(c)
	sel = 0
	success_t = -1.0
	active = true
	visible = true


func _input(event: InputEvent) -> void:
	if not active or success_t >= 0.0:
		return
	var handled := true
	if event.is_action_pressed("up"):
		sel = (sel + 2) % 3
	elif event.is_action_pressed("down"):
		sel = (sel + 1) % 3
	elif event.is_action_pressed("left"):
		cur[sel] = maxf(0.5, cur[sel] - STEP)
	elif event.is_action_pressed("right"):
		cur[sel] = minf(5.0, cur[sel] + STEP)
	elif event.is_action_pressed("pause"):
		_close(false)
	else:
		handled = false
	if handled:
		AudioMgr.sfx("ui_mover", Vector2.INF, -4.0, 0.0)
		get_viewport().set_input_as_handled()
		_check()


func _check() -> void:
	for i in 3:
		if absf(cur[i] - target[i]) > 0.01:
			return
	success_t = 0.0


func _close(ok: bool) -> void:
	active = false
	visible = false
	done.emit(ok)


func _process(dt: float) -> void:
	t += dt
	if not active:
		return
	if success_t >= 0.0:
		success_t += dt
		if success_t > 1.0:
			_close(true)
	if main != null and main.auto.has("calib") and success_t < 0.0 and t > 0.0:
		# modo de teste: resolve sozinho
		for i in 3:
			cur[i] = move_toward(cur[i], target[i], dt * 4.0)
		_check()
	queue_redraw()


func _draw() -> void:
	if not active:
		return
	var sz := get_viewport_rect().size
	draw_rect(Rect2(Vector2.ZERO, sz), Color(0.0, 0.01, 0.03, 0.7))
	var w := 760.0
	var h := 430.0
	var r := Rect2((sz.x - w) / 2.0, (sz.y - h) / 2.0, w, h)
	draw_rect(r, Color(0.03, 0.05, 0.09, 0.95))
	draw_rect(r, Color(0.5, 0.4, 1.0, 0.7), false, 2.0)
	Art.text(self, r.position + Vector2(0, 44), "CALIBRAÇÃO DO PORTAL", 28, Color(0.9, 0.95, 1.0), HORIZONTAL_ALIGNMENT_CENTER, w)
	Art.text(self, r.position + Vector2(0, 72), "Alinhe cada onda (ciano) com a onda-alvo (lilás).", 16, Color(0.7, 0.78, 0.88), HORIZONTAL_ALIGNMENT_CENTER, w)
	for i in 3:
		var row := Rect2(r.position.x + 40, r.position.y + 100 + i * 92, w - 80, 76)
		var matched := absf(cur[i] - target[i]) < 0.01
		var border := Color(0.4, 0.95, 1.0, 0.9) if i == sel else Color(0.3, 0.35, 0.45, 0.7)
		if matched:
			border = Color(0.5, 1.0, 0.6, 0.9)
		draw_rect(row, Color(0.02, 0.03, 0.06, 0.9))
		draw_rect(row, border, false, 2.0 if i == sel else 1.0)
		_wave(row, target[i], Color(0.7, 0.55, 1.0, 0.55), 2.0, 0.0)
		var wc := Color(0.5, 1.0, 0.6) if matched else Color(0.35, 0.92, 1.0)
		_wave(row, cur[i], wc, 2.5, 0.0 if matched else t * 2.0)
		Art.text(self, row.position + Vector2(row.size.x - 120, 20), "%.2f Hz" % cur[i], 14, Color(0.8, 0.88, 0.95), HORIZONTAL_ALIGNMENT_RIGHT, 110)
		if i == sel:
			Art.text(self, row.position + Vector2(-30, 46), "▶", 20, Color(0.4, 0.95, 1.0))
	Art.text(self, Vector2(r.position.x, r.end.y - 20), "W / S  selecionar      A / D  ajustar frequência      ESC  cancelar", 15, Color(0.65, 0.72, 0.82), HORIZONTAL_ALIGNMENT_CENTER, w)
	if success_t >= 0.0:
		var a := clampf(success_t * 3.0, 0.0, 1.0)
		draw_rect(r, Color(0.6, 1.0, 0.9, 0.15 * a))
		Art.text(self, Vector2(r.position.x, r.position.y + h / 2.0 + 10), "PORTAL ESTABILIZADO", 36, Color(0.7, 1.0, 0.85, a), HORIZONTAL_ALIGNMENT_CENTER, w, 8)


func _wave(row: Rect2, freq: float, col: Color, width: float, phase: float) -> void:
	var pts := PackedVector2Array()
	var n := 80
	for j in n + 1:
		var s := float(j) / float(n)
		var x := row.position.x + 12 + s * (row.size.x - 140)
		var y := row.position.y + row.size.y / 2.0 + sin(s * TAU * freq + phase) * (row.size.y * 0.32)
		pts.append(Vector2(x, y))
	draw_polyline(pts, col, width, true)
