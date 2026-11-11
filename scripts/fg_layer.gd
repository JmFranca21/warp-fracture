class_name FgLayer
extends Node2D
## Primeiro plano escuro (tufos, entulho) na frente dos personagens, para dar profundidade.

var theme := "lab"
var depth := 1.0
var span := Vector2(-600, 6000)
var ground_rects: Array = []
var base_y := 1190.0        # Verdâmia: y da base da faixa de vegetação


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	if theme == "verd":
		_draw_verd()
		return
	var rng := RandomNumberGenerator.new()
	rng.seed = 991
	for rv in ground_rects:
		var r: Rect2 = rv
		if r.size.x < 300.0 or r.size.y < 300.0:
			continue
		var x := r.position.x + rng.randf_range(20, 120)
		while x < r.end.x - 40.0:
			_rubble(Vector2(x, r.position.y + 4), rng)
			x += rng.randf_range(180, 420)


## Verdâmia: faixa de vegetação de primeiro plano (VD_fg_vegetacao) na borda de baixo da tela.
## Fica abaixo do nível dos fossos para não esconder perigos; as cópias vizinhas são espelhadas.
func _draw_verd() -> void:
	var tex: Texture2D = Props.tex(SpriteMetaVerd.FUNDO_DIR + "fg_vegetacao.png")
	var s := 0.62
	var w := tex.get_width() * s
	var h := tex.get_height() * s
	var top := base_y - h
	var k := int(floor(span.x / w))
	while k * w < span.y:
		if k % 2 == 0:
			draw_set_transform(Vector2(k * w, top), 0.0, Vector2.ONE)
		else:
			draw_set_transform(Vector2((k + 1) * w, top), 0.0, Vector2(-1, 1))
		draw_texture_rect(tex, Rect2(0, 0, w + 1.0, h), false, Color(0.42, 0.5, 0.5))
		k += 1
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)


func _rubble(p: Vector2, rng: RandomNumberGenerator) -> void:
	var c := Color("020406")
	var pts := PackedVector2Array()
	var w := rng.randf_range(30, 70)
	pts.append(p + Vector2(-w, 2))
	for i in 5:
		pts.append(p + Vector2(-w + (i + 0.5) * w * 2.0 / 5.0, -rng.randf_range(6, 22)))
	pts.append(p + Vector2(w, 2))
	draw_colored_polygon(pts, c)
	if rng.randf() < 0.5:
		draw_line(p + Vector2(-w * 0.3, -10), p + Vector2(-w * 0.3 + 14, -40), c, 3, true)
