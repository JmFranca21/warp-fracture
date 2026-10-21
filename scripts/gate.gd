class_name Gate
extends StaticBody2D
## Muralha de raízes que fecha a arena do chefe.

var rect := Rect2()
var amt := 0.0
var cs: CollisionShape2D


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
	var tw := create_tween()
	tw.tween_property(self, "amt", 1.0, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func open() -> void:
	cs.set_deferred("disabled", true)
	var tw := create_tween()
	tw.tween_property(self, "amt", 0.0, 1.0)
	tw.tween_callback(queue_free)


func _process(_dt: float) -> void:
	queue_redraw()


func _draw() -> void:
	var h := rect.size.y * amt
	var base := rect.end.y
	var dark := Color("170f26")
	for i in 5:
		var x := rect.position.x + i * rect.size.x / 4.0
		var hh := h * (0.8 + 0.2 * sin(i * 1.7))
		draw_colored_polygon(PackedVector2Array([Vector2(x - 14, base), Vector2(x + sin(i) * 8.0, base - hh), Vector2(x + 14, base)]), dark)
		draw_line(Vector2(x + sin(i) * 8.0, base - hh), Vector2(x, base - hh * 0.5), Color(0.7, 0.5, 1.0, 0.6), 2.0, true)
