@tool
class_name NivGancho
extends Node2D
## Argola do Arpão de Fase. A posição do nó é o centro da argola; Daymon para 46 px abaixo dela.
## Alcance do Arpão: 380 px a partir do ombro.
##  preso_no_teto – desenha o suporte e a corrente subindo até teto_y (caverna e arena)
##  Os ganchos da Encosta ficam em nós Mastro, não aqui.

@export var preso_no_teto := true:
	set(v):
		preso_no_teto = v
		queue_redraw()
## Altura (y da fase) da face de baixo do teto onde o suporte fica preso.
@export var teto_y := 300.0:
	set(v):
		teto_y = v
		queue_redraw()


func _ready() -> void:
	set_notify_transform(true)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		queue_redraw()


func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	var c := Color(0.35, 0.92, 1.0)
	if preso_no_teto:
		draw_line(Vector2(0, teto_y - position.y), Vector2(0, -14), Color(c, 0.5), 2.0)
	draw_arc(Vector2.ZERO, 12.0, 0, TAU, 24, c, 3.0, true)
	draw_arc(Vector2.ZERO, 380.0, 0, TAU, 64, Color(c, 0.12), 1.0, true)
	draw_circle(Vector2(0, 46), 4.0, Color(c, 0.6))
