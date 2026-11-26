@tool
class_name DFCamada
extends Node2D
## Deserto: grupo de peças grandes de fundo (DF204) num plano de parallax próprio, atrás do terreno.
## O Level move o grupo como as outras camadas: position = câmera × (1 − depth). As peças guardam a posição
## "de camada" (x × depth e y − câmera de referência × (1 − depth)), para aparecerem no lugar certo com a câmera
## parada diante delas; a base fica abaixo da crista do chão, escondida pelo terreno, em qualquer altura da câmera.

@export var depth := 0.85
