@tool
class_name NivPonto
extends Node2D
## Ponto marcado na fase. A posição do nó é o ponto (para quem fica no chão: os pés, no chão).
##  Início      – onde Daymon aparece ao entrar na fase
##  Checkpoint  – ponto de controle (fica no chão)
##  Célula      – célula de energia (coletável)
##  Cura        – kit de reparo
##  Placa       – placa com fala da IRIS (o texto vai em "texto")
##  Cristal     – cristais roxos de enfeite, apoiados no chão (tamanho em "escala")
##  Estação     – ruína de estação de observação (enfeite do Cume)
##  Nota        – recado para o Claude: escreva o pedido em "texto". Não aparece no jogo.

@export_enum("Início", "Checkpoint", "Célula", "Cura", "Placa", "Cristal", "Estação", "Nota") var tipo := 0:
	set(v):
		tipo = v
		queue_redraw()
@export_multiline var texto := "":
	set(v):
		texto = v
		queue_redraw()
@export var escala := 1.0

const CORES := [Color(0.4, 1.0, 0.5), Color(0.4, 0.95, 1.0), Color(0.35, 0.9, 1.0), Color(1.0, 0.45, 0.45),
	Color(1.0, 0.9, 0.5), Color(0.7, 0.55, 1.0), Color(0.7, 0.75, 0.9), Color(1.0, 0.6, 0.1)]
const NOMES := ["INÍCIO", "CHECKPOINT", "", "", "PLACA", "", "", "NOTA"]


func _ready() -> void:
	set_notify_transform(true)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		queue_redraw()


func _draw() -> void:
	if not Engine.is_editor_hint():
		return
	var c: Color = CORES[tipo]
	var f := ThemeDB.fallback_font
	match tipo:
		0, 1:
			draw_line(Vector2.ZERO, Vector2(0, -70), c, 3.0)
			draw_colored_polygon(PackedVector2Array([Vector2(0, -70), Vector2(30, -60), Vector2(0, -50)]), c)
		2:
			draw_circle(Vector2.ZERO, 9.0, Color(c, 0.5))
			draw_arc(Vector2.ZERO, 9.0, 0, TAU, 20, c, 2.0)
		3:
			draw_rect(Rect2(-9, -9, 18, 18), Color(c, 0.5))
			draw_line(Vector2(-6, 0), Vector2(6, 0), Color.WHITE, 3.0)
			draw_line(Vector2(0, -6), Vector2(0, 6), Color.WHITE, 3.0)
		4:
			draw_rect(Rect2(-18, -60, 36, 26), Color(c, 0.35))
			draw_line(Vector2(0, -34), Vector2.ZERO, c, 3.0)
		7:
			draw_circle(Vector2.ZERO, 14.0, Color(c, 0.85))
			draw_string(f, Vector2(-5, 7), "!", HORIZONTAL_ALIGNMENT_LEFT, -1, 22, Color.BLACK)
		_:
			draw_arc(Vector2.ZERO, 10.0, 0, TAU, 20, c, 2.0)
	var label: String = NOMES[tipo]
	if texto != "" and tipo in [4, 7]:
		label += ": " + texto
	if label != "":
		draw_string(f, Vector2(-10, -78 if tipo in [0, 1] else -24), label, HORIZONTAL_ALIGNMENT_LEFT, 520, 16, c)
