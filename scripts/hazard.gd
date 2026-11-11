class_name Hazard
extends Area2D
## Perigo sem inteligência (piso eletrificado no lab, espinhos em Verdâmia).

var theme := "lab"
var rect := Rect2()
var t := 0.0
var bolts: Array = []
var bolt_t := 0.0


func _ready() -> void:
	collision_layer = 32
	collision_mask = 0
	monitoring = false
	add_to_group("hazard")
	z_index = 1
	var cs := CollisionShape2D.new()
	var rs := RectangleShape2D.new()
	rs.size = rect.size - Vector2(4, 4)
	cs.shape = rs
	cs.position = rect.get_center() + Vector2(0, 2)
	add_child(cs)
	if theme == "lab":
		for i in int(rect.size.x / 120.0) + 1:
			var g := Art.glow(Color(0.55, 0.4, 1.0, 0.45), 70)
			g.position = Vector2(rect.position.x + 60 + i * 120, rect.position.y)
			add_child(g)
	else:
		for i in int(rect.size.x / 150.0) + 1:
			var g2 := Art.glow(Color(0.7, 0.25, 0.9, 0.25), 60)
			g2.position = Vector2(rect.position.x + 75 + i * 150, rect.position.y + 10)
			add_child(g2)


func _process(dt: float) -> void:
	t += dt
	bolt_t -= dt
	if theme == "lab" and bolt_t <= 0.0:
		bolt_t = 0.07
		bolts.clear()
		for i in 3:
			var pts := PackedVector2Array()
			var x := rect.position.x
			while x <= rect.end.x:
				pts.append(Vector2(x, rect.position.y + randf_range(-10, 6)))
				x += randf_range(10, 24)
			bolts.append(pts)
	if theme == "lab":
		queue_redraw()


func _draw() -> void:
	if theme == "lab":
		draw_rect(Rect2(rect.position + Vector2(0, 6), rect.size - Vector2(0, 6)), Color("120c22"))
		for b in bolts:
			draw_polyline(b, Color(0.55, 0.4, 1.0, 0.35), 5, true)
			draw_polyline(b, Color(0.9, 0.85, 1.0, 0.9), 1.5, true)
	else:
		# faixa de espinhos (VD_espinhos) repetida; a linha do musgo fica na base do perigo
		var tex: Texture2D = Props.tex(SpriteMetaVerd.TERRENO_DIR + "espinhos.png")
		var h := tex.get_height() / 2.0
		var top := rect.end.y - SpriteMetaVerd.ESPINHOS_BASE
		TerrainDraw.tile(self, tex, Rect2(rect.position.x, top, rect.size.x, h), Vector2(rect.position.x, top))
