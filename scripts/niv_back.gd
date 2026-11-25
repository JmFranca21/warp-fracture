@tool
class_name NivBack
extends Node2D
## Fundo próximo de Nivária, atrás do terreno: paredes de rocha da Caverna de Cristal e da Arena
## (com cristais roxos apoiados no chão) e as ruínas da estação de observação no Cume (GL00).
## Tudo vem dos nós da cena (Fundos e Decoracao), lidos pelo Nivaria.

var niv: Nivaria
## No jogo, com a arte de fundo da caverna atrás: a parede desenhada da caverna fica quase transparente.
var see_through := false


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	if niv == null or niv.geo.is_empty():
		return
	var g: Dictionary = niv.geo
	if Engine.is_editor_hint():
		# no editor não há céu nem parallax: um fundo escuro ajuda a ler a fase
		draw_rect(niv.limites, Color("0B0F1E"))
	var rng := RandomNumberGenerator.new()
	rng.seed = 1777
	for st: Vector2 in g["stations"]:
		_station(st)
	for bk in g["backs"]:
		_cave_wall(bk["r"], bk["mouth"], rng)
	# cristais no chão da caverna e da arena, sempre apoiados no piso
	for c in g["crystals"]:
		_crystal(c[0], c[1], rng)


func _cave_wall(r: Rect2, mouth: bool, rng: RandomNumberGenerator) -> void:
	if mouth:
		# bocas da caverna: a parede do fundo abre para fora, irregular, até o chão
		var wall := PackedVector2Array([Vector2(r.position.x, r.position.y), Vector2(r.end.x, r.position.y),
			Vector2(r.end.x + 30, r.position.y + 120), Vector2(r.end.x + 5, r.position.y + 260), Vector2(r.end.x + 60, r.position.y + 400), Vector2(r.end.x + 90, r.position.y + 500),
			Vector2(r.end.x + 90, r.end.y), Vector2(r.position.x - 90, r.end.y), Vector2(r.position.x - 90, r.position.y + 500),
			Vector2(r.position.x - 55, r.position.y + 390), Vector2(r.position.x - 10, r.position.y + 260), Vector2(r.position.x - 35, r.position.y + 120)])
		if see_through:
			return      # no jogo, a arte da caverna (que entra aos poucos) faz a parede do fundo
		draw_colored_polygon(wall, Color("161B2E"))
		draw_polyline(PackedVector2Array([wall[0], wall[11], wall[10], wall[9], wall[8]]), Color(Nivaria.C_ROCHA[2], 0.5), 3.0)
		draw_polyline(PackedVector2Array([wall[1], wall[2], wall[3], wall[4], wall[5]]), Color(Nivaria.C_ROCHA[2], 0.5), 3.0)
	else:
		draw_rect(r, Color("161B2E"))
	# blocos de rocha ao fundo, mais claros no meio da sala
	var x := r.position.x
	while x < r.end.x:
		var w := rng.randf_range(90, 200)
		var top := rng.randf_range(r.position.y + 120, maxf(r.position.y + 121, r.end.y - 160))
		var pts := PackedVector2Array([Vector2(x, r.end.y), Vector2(x + w * 0.1, top + 30), Vector2(x + w * 0.45, top),
			Vector2(x + w * 0.85, top + 40), Vector2(x + w, r.end.y)])
		draw_colored_polygon(pts, Color(Nivaria.C_ROCHA[1], 0.45))
		draw_line(pts[1], pts[2], Color(Nivaria.C_ROCHA[2], 0.3), 2.0)
		x += w * rng.randf_range(0.6, 0.9)
	# estalactites ao fundo, presas ao teto
	x = r.position.x + 20
	while x < r.end.x - 20:
		var h := rng.randf_range(30, 110)
		var w2 := rng.randf_range(14, 30)
		draw_colored_polygon(PackedVector2Array([Vector2(x - w2 / 2, r.position.y), Vector2(x + w2 / 2, r.position.y), Vector2(x, r.position.y + h)]), Color(Nivaria.C_GELO[0], 0.55))
		x += rng.randf_range(50, 120)


func _crystal(base: Vector2, s: float, rng: RandomNumberGenerator) -> void:
	if not Engine.is_editor_hint():
		var g := Art.glow(Color(0.55, 0.45, 0.95, 0.25), 70 * s)
		g.position = base + Vector2(0, -40 * s)
		add_child(g)
	for i in 4:
		var ox := (i - 1.5) * 12.0 * s
		var h := rng.randf_range(40, 85) * s * (1.0 - absf(i - 1.5) * 0.2)
		var lean := (i - 1.5) * 0.18
		var tip := base + Vector2(ox + h * lean, -h)
		var pts := PackedVector2Array([base + Vector2(ox - 7 * s, 0), tip + Vector2(-5 * s, 8 * s), tip, tip + Vector2(5 * s, 8 * s), base + Vector2(ox + 7 * s, 0)])
		draw_colored_polygon(pts, Nivaria.C_CRISTAL[1])
		draw_line(base + Vector2(ox, 0), tip, Nivaria.C_CRISTAL[2], 2.0)


## Ruína de estação de observação: cúpula partida sobre colunas, apoiada no degrau de rocha.
func _station(base: Vector2) -> void:
	var stone := Color("2A3350")
	var lit := Color("3E4A6A")
	draw_rect(Rect2(base.x - 90, base.y - 16, 180, 16), stone)
	for cx in [-70.0, -24.0, 24.0, 70.0]:
		draw_rect(Rect2(base.x + cx - 9, base.y - 150, 18, 134), stone)
		draw_line(Vector2(base.x + cx - 8, base.y - 150), Vector2(base.x + cx - 8, base.y - 16), lit, 2.0)
	draw_rect(Rect2(base.x - 96, base.y - 168, 192, 20), stone)
	# cúpula com uma fenda aberta
	var dome := PackedVector2Array()
	for i in 17:
		var a := PI + PI * float(i) / 16.0
		dome.append(base + Vector2(cos(a) * 84.0, -168.0 + sin(a) * 70.0))
	draw_colored_polygon(dome, stone)
	draw_colored_polygon(PackedVector2Array([base + Vector2(10, -238), base + Vector2(40, -226), base + Vector2(22, -170), base + Vector2(4, -170)]), Color("161B2E"))
	draw_polyline(dome, lit, 2.0, true)
	# neve na cornija e na cúpula
	draw_rect(Rect2(base.x - 100, base.y - 174, 200, 7), Nivaria.C_NEVE[2])
	var cap := PackedVector2Array()
	for i in range(3, 14):
		var a := PI + PI * float(i) / 16.0
		cap.append(base + Vector2(cos(a) * 86.0, -170.0 + sin(a) * 73.0))
	draw_polyline(cap, Nivaria.C_NEVE[2], 6.0, true)
	# estandarte roxo pendurado na cornija
	draw_colored_polygon(PackedVector2Array([base + Vector2(-50, -148), base + Vector2(-30, -148), base + Vector2(-30, -92), base + Vector2(-40, -104), base + Vector2(-50, -92)]), Color("6B3A78"))
	draw_rect(Rect2(base.x - 44, base.y - 132, 8, 8), Color("C9A2D8"))
