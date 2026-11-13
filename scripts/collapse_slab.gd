class_name CollapseSlab
extends StaticBody2D
## Trecho de piso da Galeria do Portal que se fende e cai na Fuga do Eco, abrindo um fosso.
## Antes da fuga parece piso normal. Ao disparar: racha e treme por 0,55 s, depois despenca.
## Depois que a fuga foi concluída, a fase nem cria a peça (o fosso fica aberto).

const WARN := 0.55

var rect: Rect2
var shape: CollisionShape2D
var draw_node: TerrainDraw
var t := -1.0
var fell := false
var cracks: Array = []


func _ready() -> void:
	position = rect.position
	shape = CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = rect.size
	shape.shape = r
	shape.position = rect.size / 2.0
	add_child(shape)
	draw_node = TerrainDraw.new()
	draw_node.theme = "lab"
	draw_node.rects = [Rect2(Vector2.ZERO, rect.size)]
	add_child(draw_node)


func collapse() -> void:
	if t >= 0.0:
		return
	t = 0.0
	AudioMgr.sfx("rachadura", global_position + rect.size / 2.0, 0.0, 0.0)
	for i in 5:
		cracks.append(randf_range(10.0, rect.size.x - 10.0))


func _process(dt: float) -> void:
	if t < 0.0 or fell:
		return
	t += dt
	draw_node.position = Vector2(randf_range(-2, 2), randf_range(-1, 1)) * (t / WARN) * 2.0
	queue_redraw()
	if t >= WARN:
		fell = true
		shape.set_deferred("disabled", true)
		# quem estava em cima não pode "voltar" para um piso que não existe mais
		var pl = get_parent().player
		if is_instance_valid(pl) and Rect2(rect.position - Vector2(10, 40), rect.size + Vector2(20, 60)).has_point(pl.last_safe):
			pl.last_safe = Vector2(rect.position.x - 40.0, rect.position.y - 2.0)
		AudioMgr.sfx("desaba", global_position + rect.size / 2.0, 0.0, 0.0)
		FxAnim.spawn(get_parent().fx, SpriteMetaCells.POEIRA_LAB_FRAMES, SpriteMetaCells.POEIRA_LAB_OFFSET,
			global_position + Vector2(rect.size.x / 2.0, 6.0), 0.58 * 1.5)
		var tw := create_tween()
		tw.set_parallel(true)
		tw.tween_property(draw_node, "position:y", 420.0, 0.7).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
		tw.tween_property(draw_node, "rotation", 0.12, 0.7)
		tw.tween_property(self, "modulate:a", 0.0, 0.7)


func _draw() -> void:
	if t < 0.0 or fell:
		return
	var k := clampf(t / WARN, 0.0, 1.0)
	for cx: float in cracks:
		draw_line(Vector2(cx, 0), Vector2(cx + 8.0, 18.0 * k + 6.0), Color(0.35, 0.95, 1.0, 0.9), 2.0)
		draw_line(Vector2(cx + 8.0, 18.0 * k + 6.0), Vector2(cx - 4.0, 34.0 * k + 8.0), Color(0.35, 0.95, 1.0, 0.7), 2.0)
