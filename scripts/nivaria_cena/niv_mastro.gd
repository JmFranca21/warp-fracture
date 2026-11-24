@tool
class_name NivMastro
extends Node2D
## Mastro de madeira das estações antigas, cravado na Encosta, com uma argola para o Arpão.
## A posição do nó é a argola; o mastro desce sozinho até a neve (46 px à direita da argola).
## Serve de refúgio: sobe-se nele com o Arpão para sair do caminho das bolas de neve.


func _ready() -> void:
	set_notify_transform(true)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		queue_redraw()


func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	var c := Color(0.35, 0.92, 1.0)
	draw_arc(Vector2.ZERO, 16.0, 0, TAU, 24, c, 2.0, true)
	draw_arc(Vector2.ZERO, 380.0, 0, TAU, 64, Color(c, 0.12), 1.0, true)
