class_name Portal
extends Interactable
## Portal dimensional. Precisa de Calibração (mini-game) para estabilizar.

var target := "verdamia"
var active := false
var core: Sprite2D
var halo: Sprite2D
var power := 0.0


func _setup() -> void:
	size = Vector2(140, 170)
	prompt = "[E] Calibrar o portal"
	halo = Art.glow(Color(0.55, 0.4, 1.0, 0.5), 220)
	halo.position = Vector2(0, -80)
	add_child(halo)
	core = Art.glow(Color(0.5, 0.9, 1.0, 0.6), 70)
	core.position = Vector2(0, -80)
	add_child(core)


func activate() -> void:
	active = true
	prompt = ""
	refresh_prompt()
	Fx.ring(main.level.fx, global_position + Vector2(0, -80), Color(0.6, 0.9, 1.0), 260, 0.6, 8)
	Fx.burst(main.level.fx, global_position + Vector2(0, -80), Color(0.7, 0.6, 1.0), 40, 400, 0.8, 0.09, 0)


func _process(dt: float) -> void:
	super._process(dt)
	power = move_toward(power, 1.0 if active else 0.35, dt * 1.5)
	halo.modulate.a = 0.25 + 0.35 * power + 0.08 * sin(t * 3.0)
	core.modulate.a = 0.3 + 0.6 * power
	halo.scale = Vector2.ONE * (220.0 + power * 80.0) * 2.0 / 128.0


func _draw() -> void:
	var c := Vector2(0, -80)
	var jitter := 0.0 if active else 3.0
	for i in 9:
		var r := 22.0 + i * 7.0
		var sp := (1.2 + i * 0.25) * (1.0 if i % 2 == 0 else -1.0) * (0.4 + power)
		var a0 := t * sp + i
		var col := Color(0.55, 0.4, 1.0).lerp(Color(0.4, 0.95, 1.0), float(i) / 8.0)
		col.a = (0.35 + 0.5 * power) * (1.0 - i / 12.0)
		var jr := r + randf_range(-jitter, jitter)
		draw_arc(c, jr, a0, a0 + 1.6 + power * 2.0, 24, col, 3.0, true)
	Art.poly(self, Art.ellipse(c, 14.0 + power * 10.0, 18.0 + power * 14.0, 20), Color(0.9, 0.97, 1.0, 0.25 + power * 0.6))
	# base (máquina do portal)
	Art.poly(self, PackedVector2Array([Vector2(-60, 0), Vector2(-50, -14), Vector2(50, -14), Vector2(60, 0)]), Color("141b26"))
	draw_line(Vector2(-46, -12), Vector2(46, -12), Color(0.55, 0.4, 1.0, 0.6), 2.0)
