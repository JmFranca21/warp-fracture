class_name GrappleHook
extends Node2D
## Gancho do Arpão de Fase: anel de energia preso ao teto por um suporte.
## O jogador com o módulo "arpao" se puxa até ele (tecla F / botão do meio / RB).

var level
var ceil_y := NAN       # altura do teto onde o suporte está preso
var t := 0.0
var lit := 0.0          # brilho quando está ao alcance
var glow: Sprite2D


func _ready() -> void:
	add_to_group("hooks")
	z_index = 2
	glow = Art.glow(Color(0.35, 0.92, 1.0, 0.35), 34)
	add_child(glow)
	t = randf() * 3.0


func _process(dt: float) -> void:
	t += dt
	var p = level.player if level != null else null
	var target := 0.0
	if is_instance_valid(p) and p.has_module("arpao") and p.hook_candidate() == self:
		target = 1.0
	lit = move_toward(lit, target, dt * 6.0)
	glow.modulate.a = 0.25 + 0.15 * sin(t * 3.0) + lit * 0.5
	queue_redraw()


func _draw() -> void:
	if not is_nan(ceil_y):
		var top := ceil_y - global_position.y
		draw_rect(Rect2(-12, top, 24, 9), Color("1c2a3e"))
		var y := top + 9.0
		while y < -14.0:
			draw_line(Vector2(0, y), Vector2(0, minf(y + 8.0, -14.0)), Color("2a3a50"), 3.0)
			y += 10.0
	var c := Color(0.35, 0.92, 1.0).lerp(Color(1, 1, 1), lit * 0.5)
	draw_arc(Vector2.ZERO, 12.0, 0, TAU, 28, Color("1a2636"), 7.0, true)
	draw_arc(Vector2.ZERO, 12.0, 0, TAU, 28, Color(c, 0.85), 3.0, true)
	draw_circle(Vector2.ZERO, 3.0 + lit * 2.0, Color(c, 0.9))
	if lit > 0.05:
		draw_arc(Vector2.ZERO, 20.0 + 3.0 * sin(t * 8.0), 0, TAU, 32, Color(c, 0.4 * lit), 2.0, true)
