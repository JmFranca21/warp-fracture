class_name Checkpoint
extends Interactable
## Estação de Recarga: restaura a Integridade e salva o ponto de retorno.

var glow: Sprite2D
var used_t := 0.0


func _setup() -> void:
	prompt = "[E] Descansar na Estação de Recarga"
	glow = Art.glow(Color(0.4, 0.95, 1.0, 0.4) if theme == "lab" else Color(0.6, 1.0, 0.7, 0.4), 110)
	glow.position = Vector2(0, -50)
	add_child(glow)
	if theme == "lab":
		var spr := Props.sprite("celula_suporte", 0.55)
		add_child(spr)
		glow.position = Vector2(0, -42)


func interact() -> void:
	main.set_checkpoint(global_position)
	used_t = 1.0
	Fx.burst(main.level.fx, global_position + Vector2(0, -40), Color(0.5, 1.0, 0.9), 30, 260, 0.8, 0.08, -100)
	Fx.ring(main.level.fx, global_position + Vector2(0, -40), Color(0.5, 1.0, 0.9), 120, 0.5, 5)


func _process(dt: float) -> void:
	super._process(dt)
	used_t = maxf(0.0, used_t - dt)
	glow.modulate.a = 0.35 + 0.1 * sin(t * 2.0) + used_t * 0.5


func _draw() -> void:
	if theme == "lab":
		var k := 0.35 + 0.15 * sin(t * 2.0) + used_t * 0.5
		draw_arc(Vector2(0, -2), 46.0, 0.0, TAU, 40, Color(0.35, 0.9, 1.0, k * 0.6), 2.0, true)
		for i in 3:
			var y := -20.0 - fmod(t * 25.0 + i * 20.0, 70.0)
			var x := -26.0 + i * 26.0
			draw_line(Vector2(x - 4, y), Vector2(x + 4, y), Color(0.5, 1.0, 1.0, 0.6), 2.0)
			draw_line(Vector2(x, y - 4), Vector2(x, y + 4), Color(0.5, 1.0, 1.0, 0.6), 2.0)
		return
	var dark := Color("10161f") if theme == "lab" else Color("0a1716")
	var lite := Color(0.4, 0.95, 1.0) if theme == "lab" else Color(0.6, 1.0, 0.75)
	Art.poly(self, PackedVector2Array([Vector2(-40, 0), Vector2(-34, -10), Vector2(34, -10), Vector2(40, 0)]), dark)
	draw_arc(Vector2(0, -10), 34.0, PI, TAU, 32, dark, 6.0, true)
	draw_arc(Vector2(0, -10), 30.0, PI, TAU, 32, Color(lite, 0.35 + 0.2 * sin(t * 2.0)), 1.5, true)
	draw_rect(Rect2(-22, -18, 44, 6), dark)
	draw_line(Vector2(-18, -15), Vector2(18, -15), Color(lite, 0.7), 2.0)
	for i in 3:
		var y := -20.0 - fmod(t * 20.0 + i * 12.0, 36.0)
		draw_circle(Vector2(-10 + i * 10, y), 1.8, Color(lite, 0.6 * (1.0 + y / 56.0)))
