class_name Bench
extends Interactable
## Bancada de Upgrades: mesa de trabalho do laboratório (desenhada por código).

var level


func _setup() -> void:
	size = Vector2(110, 110)
	prompt = "[E] Usar a Bancada de Upgrades"
	var g := Art.glow(Color(0.35, 0.92, 1.0, 0.35), 60)
	g.position = Vector2(-18, -78)
	add_child(g)


func interact() -> void:
	main.set_checkpoint(global_position)
	main.open_bench()


func _draw() -> void:
	var dark := Color("141d2a")
	var mid := Color("1d2a3c")
	var hi := Color("2c3e58")
	# pernas e tampo
	draw_rect(Rect2(-52, -46, 6, 46), dark)
	draw_rect(Rect2(46, -46, 6, 46), dark)
	draw_rect(Rect2(-58, -52, 116, 10), mid)
	draw_line(Vector2(-58, -52), Vector2(58, -52), hi, 2.0)
	draw_rect(Rect2(-46, -24, 92, 6), dark)
	# caixa de ferramentas e peças
	draw_rect(Rect2(14, -66, 30, 14), Color("2a3346"))
	draw_rect(Rect2(20, -70, 18, 4), Color("3a4560"))
	draw_circle(Vector2(-6, -56), 4.0, Color("3a4a62"))
	draw_line(Vector2(-14, -55), Vector2(4, -60), Color("4a5a74"), 2.0)
	# monitor holográfico
	draw_rect(Rect2(-42, -104, 4, 52), dark)
	var a := 0.55 + 0.2 * sin(t * 3.0)
	draw_rect(Rect2(-50, -110, 46, 30), Color(0.3, 0.85, 1.0, 0.18 * a + 0.05))
	draw_rect(Rect2(-50, -110, 46, 30), Color(0.4, 0.92, 1.0, a), false, 1.5)
	for i in 3:
		draw_line(Vector2(-45, -103 + i * 7), Vector2(-20 - i * 6, -103 + i * 7), Color(0.6, 0.95, 1.0, a), 1.5)
	# ícone de célula na tela
	var c := Vector2(-14, -95)
	draw_colored_polygon(PackedVector2Array([c + Vector2(0, -6), c + Vector2(4, 0), c + Vector2(0, 6), c + Vector2(-4, 0)]), Color(0.55, 0.95, 1.0, a))
