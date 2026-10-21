class_name BgLayer
extends Node2D
## Camada de fundo com parallax, desenhada proceduralmente (silhuetas em camadas).

var theme := "lab"
var depth := 0.3
var layer_index := 0
var span := Vector2(-1500, 6000)
var items: Array = []
var lights: Array = []
var t := 0.0
var rng := RandomNumberGenerator.new()


func base_y() -> float:
	return 500.0 * depth + 330.0


func col() -> Color:
	if theme == "lab":
		return [Color("1c2c40"), Color("111c2a"), Color("0a121c")][layer_index]
	return [Color("164446"), Color("0c2b2f"), Color("061a1d")][layer_index]


func _ready() -> void:
	rng.seed = 7919 + layer_index * 977 + (0 if theme == "lab" else 50021)
	if theme == "lab":
		_gen_lab()
	else:
		_gen_verd()
	queue_redraw()


func _process(dt: float) -> void:
	t += dt
	for l in lights:
		var s: Sprite2D = l[0]
		var base: Color = l[1]
		var k := 1.0
		if l[2] == "flicker":
			k = 0.55 + 0.45 * sin(t * 3.0 + float(l[3]))
			if fmod(t + float(l[3]), 4.0) < 0.08:
				k = 0.1
		else:
			k = 0.75 + 0.25 * sin(t * 1.3 + float(l[3]))
		s.modulate = Color(base, base.a * k)


func _add_light(pos: Vector2, c: Color, r: float, mode: String) -> void:
	var s := Art.glow(c, r)
	s.position = pos
	add_child(s)
	lights.append([s, c, mode, rng.randf() * 10.0])


# ------------------------------------------------------------ laboratório
func _gen_lab() -> void:
	var by := base_y()
	var top := by - 640.0 + layer_index * 50.0
	var x := span.x
	while x < span.y:
		var k := rng.randi() % 5
		match k:
			0:
				var w := rng.randf_range(16, 38) * (0.6 + depth)
				var bands: Array = []
				var yy := top + 40.0
				while yy < by:
					bands.append(yy)
					yy += rng.randf_range(70, 150)
				items.append({"t": "pipe", "x": x, "w": w, "top": top, "by": by, "bands": bands})
				x += w + rng.randf_range(50, 180)
			1, 2:
				var w2 := rng.randf_range(120, 280)
				var h := rng.randf_range(90, 280)
				items.append({"t": "machine", "x": x, "w": w2, "h": h, "by": by, "win": rng.randi() % 4})
				if layer_index >= 1 and rng.randf() < 0.6:
					_add_light(Vector2(x + w2 * 0.5, by - h - 6), Color(1.0, 0.18, 0.12, 0.55), 40.0 + depth * 30.0, "flicker")
				x += w2 + rng.randf_range(30, 140)
			3:
				var n := 2 + rng.randi() % 3
				for i in n:
					var x0 := x + rng.randf_range(-30, 30)
					var x1 := x0 + rng.randf_range(160, 340)
					items.append({"t": "cable", "a": Vector2(x0, top), "b": Vector2(x1, top + rng.randf_range(-10, 30)), "sag": rng.randf_range(60, 200)})
				x += rng.randf_range(120, 260)
			4:
				items.append({"t": "truss", "x": x, "w": rng.randf_range(260, 420), "y": top + 40})
				x += rng.randf_range(260, 420)
	if layer_index == 0:
		for i in int((span.y - span.x) / 700.0):
			var cx := span.x + rng.randf_range(0, span.y - span.x)
			var pts := PackedVector2Array()
			var p := Vector2(cx, top + rng.randf_range(0, 200))
			for j in 9:
				pts.append(p)
				p += Vector2(rng.randf_range(-40, 40), rng.randf_range(30, 70))
			items.append({"t": "crack", "pts": pts})
			_add_light(pts[4], Color(0.55, 0.35, 1.0, 0.35), 110.0, "pulse")
	if layer_index == 1:
		for i in int((span.y - span.x) / 900.0):
			_add_light(Vector2(span.x + rng.randf_range(0, span.y - span.x), top + rng.randf_range(80, 300)),
				Color(0.3, 0.75, 1.0, 0.18), 160.0, "pulse")
	items.append({"t": "mass", "top": top, "by": by})


# ------------------------------------------------------------ verdâmia
func _gen_verd() -> void:
	var by := base_y()
	var x := span.x
	while x < span.y:
		var k := rng.randi() % 6
		match k:
			0, 1:
				var h := rng.randf_range(260, 620) * (0.7 + depth * 0.6)
				var rx := rng.randf_range(80, 190) * (0.7 + depth * 0.5)
				var lean := rng.randf_range(-60, 60)
				var spots: Array = []
				for i in 4 + rng.randi() % 4:
					spots.append(Vector2(rng.randf_range(-0.7, 0.7), rng.randf_range(0.15, 0.75)))
				var it := {"t": "shroom", "x": x, "h": h, "rx": rx, "ry": rx * rng.randf_range(0.45, 0.7), "lean": lean, "by": by, "spots": spots, "sw": rng.randf_range(14, 30) * (0.6 + depth)}
				items.append(it)
				var capc := Vector2(x + lean, by - h)
				var sc := Color(0.45, 1.0, 0.85, 0.22 + 0.15 * layer_index) if rng.randf() < 0.5 else Color(0.8, 1.0, 0.4, 0.22 + 0.15 * layer_index)
				for s in spots:
					_add_light(capc + Vector2(s.x * rx, -s.y * it["ry"]), sc, 10.0 + depth * 16.0, "pulse")
				_add_light(capc + Vector2(0, 10), Color(0.4, 1.0, 0.8, 0.12), rx * 1.2, "pulse")
				x += rx * 1.6 + rng.randf_range(40, 200)
			2:
				items.append({"t": "trunk", "x": x, "w": rng.randf_range(40, 90) * (0.6 + depth), "by": by, "bend": rng.randf_range(-80, 80)})
				x += rng.randf_range(120, 260)
			3:
				items.append({"t": "fern", "x": x, "by": by, "n": 5 + rng.randi() % 5, "h": rng.randf_range(60, 150) * (0.6 + depth)})
				x += rng.randf_range(60, 160)
			4:
				var vx := x
				for i in 2 + rng.randi() % 3:
					var vlen := rng.randf_range(200, 600)
					var top := by - 1000.0
					items.append({"t": "vine", "x": vx, "top": top, "len": vlen, "ph": rng.randf() * 6.0})
					if rng.randf() < 0.6:
						_add_light(Vector2(vx, top + vlen), Color(0.85, 1.0, 0.45, 0.45), 14.0 + depth * 10.0, "pulse")
					vx += rng.randf_range(20, 60)
				x += rng.randf_range(80, 180)
			5:
				x += rng.randf_range(80, 200)
	if layer_index == 1:
		var sx := span.x
		while sx < span.y:
			items.append({"t": "shaft", "x": sx, "w": rng.randf_range(60, 160), "by": by})
			sx += rng.randf_range(500, 1100)
	items.append({"t": "hills", "by": by})


# ------------------------------------------------------------ desenho
func _draw() -> void:
	var c := col()
	for it in items:
		match it["t"]:
			"mass":
				draw_rect(Rect2(span.x, it["by"], span.y - span.x, 3000), c)
				draw_rect(Rect2(span.x, it["top"] - 3000, span.y - span.x, 3000), c)
				draw_rect(Rect2(span.x, it["top"], span.y - span.x, 16), c.lightened(0.04))
			"pipe":
				draw_rect(Rect2(it["x"], it["top"], it["w"], it["by"] - it["top"]), c)
				draw_rect(Rect2(it["x"] + it["w"] * 0.2, it["top"], it["w"] * 0.12, it["by"] - it["top"]), c.lightened(0.05))
				for yy in it["bands"]:
					draw_rect(Rect2(it["x"] - 4, yy, it["w"] + 8, 10), c.lightened(0.07))
			"machine":
				var x: float = it["x"]
				var w: float = it["w"]
				var h: float = it["h"]
				var by: float = it["by"]
				draw_rect(Rect2(x, by - h, w, h), c)
				Art.poly(self, Art.ellipse(Vector2(x + w * 0.5, by - h), w * 0.3, 34), c)
				draw_rect(Rect2(x + w * 0.1, by - h + 14, w * 0.8, 3), c.lightened(0.06))
				for i in it["win"]:
					draw_rect(Rect2(x + 14 + i * 22, by - h + 30, 12, 5), Color(0.35, 0.8, 1.0, 0.18 + 0.1 * layer_index))
			"cable":
				var pts := PackedVector2Array()
				var a: Vector2 = it["a"]
				var b: Vector2 = it["b"]
				for i in 17:
					var s := float(i) / 16.0
					pts.append(a.lerp(b, s) + Vector2(0, sin(s * PI) * it["sag"]))
				draw_polyline(pts, c.lightened(0.05), 2.0 + depth * 4.0, true)
			"truss":
				var x2: float = it["x"]
				var y: float = it["y"]
				var w2: float = it["w"]
				draw_rect(Rect2(x2, y, w2, 10), c.lightened(0.04))
				draw_rect(Rect2(x2, y + 50, w2, 10), c.lightened(0.04))
				var xx := x2
				var up := true
				while xx < x2 + w2 - 30:
					draw_line(Vector2(xx, y + (5 if up else 55)), Vector2(xx + 30, y + (55 if up else 5)), c.lightened(0.04), 4, true)
					xx += 30
					up = not up
			"crack":
				draw_polyline(it["pts"], Color(0.55, 0.35, 1.0, 0.12), 12, true)
				draw_polyline(it["pts"], Color(0.7, 0.5, 1.0, 0.35), 5, true)
				draw_polyline(it["pts"], Color(0.92, 0.85, 1.0, 0.8), 1.6, true)
			"hills":
				var by2: float = it["by"]
				var pts2 := PackedVector2Array()
				var xs := span.x
				while xs <= span.y:
					pts2.append(Vector2(xs, by2 - 20 - 25 * sin(xs * 0.004 + layer_index) - 15 * sin(xs * 0.011)))
					xs += 40.0
				pts2.append(Vector2(span.y, by2 + 3000))
				pts2.append(Vector2(span.x, by2 + 3000))
				draw_colored_polygon(pts2, c)
			"shroom":
				_draw_shroom(it, c)
			"trunk":
				var x3: float = it["x"]
				var w3: float = it["w"]
				var by3: float = it["by"]
				var bend: float = it["bend"]
				var pts3 := PackedVector2Array([Vector2(x3 - w3 * 0.9, by3 + 10), Vector2(x3 - w3 * 0.5, by3 - 40),
					Vector2(x3 - w3 * 0.4 + bend, by3 - 1600), Vector2(x3 + w3 * 0.4 + bend, by3 - 1600),
					Vector2(x3 + w3 * 0.5, by3 - 40), Vector2(x3 + w3 * 0.9, by3 + 10)])
				Art.poly(self, pts3, c)
			"fern":
				for i in it["n"]:
					var bx: float = it["x"] + i * 9.0
					var hh: float = it["h"] * (0.6 + 0.4 * sin(i * 1.7))
					var lean2: float = (i - it["n"] / 2.0) * 9.0
					var fp := PackedVector2Array()
					for j in 9:
						var s2 := float(j) / 8.0
						fp.append(Vector2(bx + lean2 * s2 * s2 * 2.0, it["by"] - hh * s2))
					draw_polyline(fp, c.lightened(0.05), 3.0 * (0.5 + depth), true)
			"vine":
				var vp := PackedVector2Array()
				for j in 13:
					var s3 := float(j) / 12.0
					vp.append(Vector2(it["x"] + sin(s3 * 3.0 + it["ph"]) * 10.0 * s3, it["top"] + it["len"] * s3))
				draw_polyline(vp, c.lightened(0.06), 2.0 + depth * 2.0, true)
				draw_circle(vp[vp.size() - 1], 3.0 + depth * 3.0, Color(0.85, 1.0, 0.5, 0.5 + 0.2 * layer_index))
			"shaft":
				var x4: float = it["x"]
				var w4: float = it["w"]
				var by4: float = it["by"]
				draw_colored_polygon(PackedVector2Array([Vector2(x4, by4 - 1100), Vector2(x4 + w4, by4 - 1100),
					Vector2(x4 + w4 + 260, by4), Vector2(x4 + 260, by4)]), Color(0.6, 1.0, 0.9, 0.035))


func _draw_shroom(it: Dictionary, c: Color) -> void:
	var x: float = it["x"]
	var by: float = it["by"]
	var h: float = it["h"]
	var rx: float = it["rx"]
	var ry: float = it["ry"]
	var lean: float = it["lean"]
	var sw: float = it["sw"]
	var left := PackedVector2Array()
	var right := PackedVector2Array()
	for i in 11:
		var s := float(i) / 10.0
		var cx := x + lean * s * s
		var ww := sw * (1.6 - 0.7 * s)
		left.append(Vector2(cx - ww, by + 10 - h * s))
		right.append(Vector2(cx + ww, by + 10 - h * s))
	right.reverse()
	var stalk := left + right
	Art.poly(self, stalk, c)
	var capc := Vector2(x + lean, by - h)
	var cap := PackedVector2Array()
	for i in 21:
		var a := PI + PI * float(i) / 20.0
		cap.append(capc + Vector2(cos(a) * rx, sin(a) * ry))
	cap.append(capc + Vector2(rx * 0.85, 14))
	cap.append(capc + Vector2(-rx * 0.85, 14))
	Art.poly(self, cap, c.lightened(0.03))
	draw_line(capc + Vector2(-rx * 0.85, 14), capc + Vector2(rx * 0.85, 14), Color(0.5, 1.0, 0.85, 0.12 + 0.08 * layer_index), 3, true)
	for s in it["spots"]:
		var p := capc + Vector2(s.x * rx, -s.y * ry)
		Art.poly(self, Art.circle(p, 3.0 + depth * 6.0, 12), Color(0.6, 1.0, 0.85, 0.25 + 0.2 * layer_index))
