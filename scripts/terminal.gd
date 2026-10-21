class_name Terminal
extends Interactable
## Terminal que destrava as portas de emergência (arte: terminal.png).

var tid := "A"
var level
var active := false
var screen: Sprite2D
var spr: Sprite2D


func _setup() -> void:
	active = main.terminals.has(tid)
	prompt = "" if active else "[E] Ativar terminal " + tid
	spr = Props.sprite("terminal", 0.62)
	add_child(spr)
	screen = Art.glow(Color(1, 0.3, 0.2, 0.5), 46)
	screen.position = Vector2(-2, -52)
	add_child(screen)


func interact() -> void:
	if active:
		return
	active = true
	AudioMgr.sfx("terminal", Vector2.INF, 0.0, 0.0)
	main.terminals[tid] = true
	prompt = ""
	refresh_prompt()
	var n := 0
	for k in level.data["door"]["needs"]:
		if main.terminals.has(k):
			n += 1
	main.hud.notice("Terminal %s ativado (%d/%d)" % [tid, n, level.data["door"]["needs"].size()])
	Fx.burst(level.fx, global_position + Vector2(0, -52), Color(0.4, 0.95, 1.0), 20, 220, 0.5, 0.06)
	level.check_door()


func _process(dt: float) -> void:
	super._process(dt)
	if active:
		screen.modulate = Color(0.4, 0.95, 1.0, 0.55)
		spr.modulate = Color(1, 1, 1)
	else:
		screen.modulate = Color(1.0, 0.3, 0.2, 0.35 + 0.25 * sin(t * 6.0))
		spr.modulate = Color(1.0, 0.72, 0.72)


func _draw() -> void:
	# ícone de status acima do terminal
	var c := Vector2(0, -92)
	if active:
		draw_polyline(PackedVector2Array([c + Vector2(-7, 0), c + Vector2(-2, 5), c + Vector2(8, -6)]), Color(0.4, 1.0, 0.7), 3.0, true)
	else:
		var a := 0.6 + 0.4 * sin(t * 6.0)
		draw_line(c + Vector2(-6, -6), c + Vector2(6, 6), Color(1, 0.35, 0.3, a), 3.0, true)
		draw_line(c + Vector2(6, -6), c + Vector2(-6, 6), Color(1, 0.35, 0.3, a), 3.0, true)
	Art.text(self, Vector2(-5, -104), tid, 13, Color(0.75, 0.85, 0.95, 0.85))
