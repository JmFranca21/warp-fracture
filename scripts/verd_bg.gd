class_name VerdBg
extends Node2D
## Camada de parallax de Verdâmia feita com a arte entregue (VD_bg_distante / VD_bg_intermediario).
## A imagem se repete na horizontal espelhando as cópias vizinhas, para as bordas sempre emendarem.

var depth := 0.1
var tex: Texture2D
var img_scale := 1.0
var top := 0.0              # y local do topo da imagem
var span := Vector2(-1000, 3000)   # faixa local em x que precisa estar coberta
var single := false        # place(): uma cópia só, sem repetir (espelhada só fora de 16:9)
var left := 0.0
var tiled := false         # place(..., true): repete sem espelhar


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


## Escala fixa e canto de cima à esquerda em pos (coordenadas da camada). Sem repeat_x: uma cópia só
## (espelhada nos lados só fora de 16:9). Com repeat_x: cópias iguais lado a lado, sem espelhar, cobrindo cover.
func place(sc: float, pos: Vector2, repeat_x := false, cover := Vector2(-2000, 4000)) -> void:
	single = not repeat_x
	tiled = repeat_x
	texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED if repeat_x else CanvasItem.TEXTURE_REPEAT_PARENT_NODE
	img_scale = sc
	left = pos.x
	top = pos.y
	span = cover
	queue_redraw()


func _draw() -> void:
	if tiled:
		# uma chamada só, com a repetição do amostrador: cópias lado a lado deixariam um fio de 1 px na
		# emenda em posições fracionárias da câmera (a camada de trás aparece pela fresta)
		var tw := tex.get_width() * img_scale
		var k0 := floorf((span.x - left) / tw)
		var x0 := left + k0 * tw
		var n := ceilf((span.y - x0) / tw)
		draw_set_transform(Vector2(x0, top), 0.0, Vector2(img_scale, img_scale))
		draw_texture_rect_region(tex, Rect2(0, 0, tex.get_width() * n, tex.get_height()),
			Rect2(0, 0, tex.get_width() * n, tex.get_height()))
		draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
		return
	if single:
		var sw := tex.get_width() * img_scale
		var sh := tex.get_height() * img_scale
		draw_texture_rect(tex, Rect2(left, top, sw, sh), false)
		# cópias espelhadas dos lados: só aparecem em telas mais largas que 16:9 (stretch "expand")
		draw_set_transform(Vector2(left, top), 0.0, Vector2(-1, 1))
		draw_texture_rect(tex, Rect2(0, 0, sw, sh), false)
		draw_set_transform(Vector2(left + 2.0 * sw, top), 0.0, Vector2(-1, 1))
		draw_texture_rect(tex, Rect2(0, 0, sw, sh), false)
		draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
		return
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
