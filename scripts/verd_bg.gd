class_name VerdBg
extends Node2D
## Camada de parallax de Verdâmia feita com a arte entregue (VD_bg_distante / VD_bg_intermediario).
## A imagem se repete na horizontal espelhando as cópias vizinhas, para as bordas sempre emendarem.

var depth := 0.1
var tex: Texture2D
var img_scale := 1.0
var top := 0.0              # y local do topo da imagem
var span := Vector2(-1000, 3000)   # faixa local em x que precisa estar coberta


func _ready() -> void:
	queue_redraw()


## Calcula escala e posição para cobrir a tela em qualquer ponto da fase.
## view = tamanho visível do mundo; cam_x / cam_y = faixa do centro da câmera.
func fit(view: Vector2, cam_x: Vector2, cam_y: Vector2, min_scale: float) -> void:
	var need_h := view.y + (cam_y.y - cam_y.x) * depth + 40.0
	img_scale = maxf(min_scale, need_h / tex.get_height())
	var h := tex.get_height() * img_scale
	top = cam_y.x * depth - view.y / 2.0 - (h - need_h) / 2.0 - 20.0
	span = Vector2(cam_x.x * depth - view.x / 2.0 - 60.0, cam_x.y * depth + view.x / 2.0 + 60.0)


func _draw() -> void:
	var w := tex.get_width() * img_scale
	var h := tex.get_height() * img_scale
	var k := int(floor(span.x / w))
	while k * w < span.y:
		if k % 2 == 0:
			draw_set_transform(Vector2(k * w, top), 0.0, Vector2.ONE)
		else:
			draw_set_transform(Vector2((k + 1) * w, top), 0.0, Vector2(-1, 1))
		draw_texture_rect(tex, Rect2(0, 0, w + 1.0, h), false)
		k += 1
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
