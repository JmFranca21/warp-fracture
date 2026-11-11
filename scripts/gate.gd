class_name Gate
extends StaticBody2D
## Muralha de raízes que fecha a arena do chefe.

var rect := Rect2()
var amt := 0.0
var cs: CollisionShape2D
var art: Node2D


func _ready() -> void:
	collision_layer = 1
	collision_mask = 0
	z_index = 2
	cs = CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = rect.size
	cs.shape = r
	cs.position = rect.get_center()
	add_child(cs)
	# barreira de raízes (VD_barreira_arena): três trechos empilhados cobrem a altura da colisão
	art = Node2D.new()
	art.position = Vector2(rect.get_center().x, rect.end.y + 4.0)
	add_child(art)
	var tex := Props.tex(SpriteMetaVerd.OBJ_DIR + "barreira_arena.png")
	var piece_h := tex.get_height() * SpriteMetaVerd.OBJ_SCALE
	# os trechos de cima usam a peça sem a base de musgo (14% de baixo), para o musgo só aparecer no chão
	var cut := 0.14
	var step := piece_h * (1.0 - cut) - 14.0
	var n := int(ceil((rect.size.y - piece_h) / step)) + 1
	for i in n:
		var s := Props.sprite(SpriteMetaVerd.OBJ_DIR + "barreira_arena.png", SpriteMetaVerd.OBJ_SCALE, i % 2 == 1)
		if i > 0:
			s.region_enabled = true
			s.region_rect = Rect2(0, 0, tex.get_width(), tex.get_height() * (1.0 - cut))
			s.offset = Vector2(0, -s.region_rect.size.y / 2.0)
			s.position = Vector2(0, -(piece_h - 14.0) - (i - 1) * step)
		art.add_child(s)
	art.scale = Vector2(1, 0.02)
	var tw := create_tween()
	tw.tween_property(self, "amt", 1.0, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func open() -> void:
	cs.set_deferred("disabled", true)
	var tw := create_tween()
	tw.tween_property(self, "amt", 0.0, 1.0)
	tw.tween_callback(queue_free)


func _process(_dt: float) -> void:
	art.scale = Vector2(0.75 + 0.25 * amt, maxf(0.02, amt))
	art.modulate.a = clampf(amt * 3.0, 0.0, 1.0)
