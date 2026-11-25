@tool
class_name NivBloco
extends ReferenceRect
## Bloco de rocha sólido de Nivária (chão, parede, teto, pilar, fundo de poço).
## No editor: arraste para mover e puxe as alças para mudar o tamanho. A neve no topo é automática.

## Pendura estalactites na face de baixo (tetos e blocos flutuantes).
@export var estalactites := false
## Estalactites curtas (para blocos pequenos).
@export var estalactites_pequenas := false
## Sem camada de neve no topo (paredes, tetos e blocos cobertos).
@export var sem_neve := false


func _init() -> void:
	editor_only = true
	border_color = Color(0.55, 0.8, 1.0, 0.7)
	border_width = 2.0
	mouse_filter = Control.MOUSE_FILTER_IGNORE
