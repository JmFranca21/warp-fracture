@tool
class_name NivArea
extends ReferenceRect
## Retângulo de Nivária que não é chão:
##  Névoa          – Névoa da Fratura no fundo de um poço (1 de dano e volta ao último chão firme)
##  Fundo          – parede de rocha ao fundo (atrás do terreno), com estalactites e blocos escuros
##  Fundo caverna  – como Fundo, mas com as bocas abertas nos dois lados e o beiral de rocha na entrada
##  Zona           – sala do mapa (id e nome aparecem no mapa)

@export_enum("Névoa", "Fundo", "Fundo caverna", "Zona") var tipo := 0:
	set(v):
		tipo = v
		_cor()
## Só para Zona: letra da sala no mapa.
@export var id := ""
## Só para Zona: nome mostrado no mapa.
@export var nome := ""


func _init() -> void:
	editor_only = true
	border_width = 2.0
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	_cor()


func _cor() -> void:
	border_color = [Color(0.75, 0.4, 1.0, 0.9), Color(0.5, 0.55, 0.7, 0.5), Color(0.5, 0.55, 0.7, 0.5), Color(1.0, 0.85, 0.3, 0.6)][tipo]
	queue_redraw()


func _draw() -> void:
	if tipo == 3 and Engine.is_editor_hint():
		draw_string(ThemeDB.fallback_font, Vector2(8, 22), "Zona %s · %s" % [id, nome], HORIZONTAL_ALIGNMENT_LEFT, -1, 18, border_color)
