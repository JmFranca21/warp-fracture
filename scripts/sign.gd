class_name Sign
extends Interactable
## Placa/holograma com dica. Mostra o texto quando o jogador se aproxima.

var text := ""


func _setup() -> void:
	size = Vector2(150, 120)
	var g := Art.glow(Color(0.4, 0.9, 1.0, 0.35) if theme == "lab" else Color(0.5, 1.0, 0.8, 0.35), 50)
	g.position = Vector2(0, -48)
	add_child(g)


func _on_enter(b: Node) -> void:
	if b is Player:
		player_near = true
		main.hud.show_tip(text)


func _on_exit(b: Node) -> void:
	if b is Player:
		player_near = false
		main.hud.hide_tip()


func _draw() -> void:
	if theme == "lab":
		draw_line(Vector2(0, 0), Vector2(0, -36), Color("2a3442"), 4.0, true)
		var a := 0.55 + 0.15 * sin(t * 3.0) + (0.25 if player_near else 0.0)
		if fmod(t, 3.1) < 0.06:
			a *= 0.3
		var r := Rect2(-20, -66, 40, 30)
		draw_rect(r, Color(0.3, 0.85, 1.0, a * 0.25))
		draw_rect(r, Color(0.4, 0.9, 1.0, a), false, 1.5)
		for i in 3:
			draw_line(Vector2(-14, -58 + i * 8), Vector2(6 - i * 5, -58 + i * 8), Color(0.6, 0.95, 1.0, a), 1.5)
	else:
		var stone := PackedVector2Array([Vector2(-16, 0), Vector2(-14, -40), Vector2(-4, -54), Vector2(10, -48), Vector2(16, 0)])
		Art.poly(self, stone, Color("0b1716"))
		var a2 := 0.5 + 0.3 * sin(t * 2.0) + (0.2 if player_near else 0.0)
		draw_arc(Vector2(0, -28), 7.0, 0.0, TAU, 20, Color(0.5, 1.0, 0.8, a2), 2.0, true)
		draw_line(Vector2(0, -40), Vector2(0, -16), Color(0.5, 1.0, 0.8, a2), 2.0, true)
