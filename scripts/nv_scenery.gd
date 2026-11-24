class_name NvScenery
extends RefCounted
## Composição de cena de Nivária pela DA-03 (receita de cena): estrutura de fundo (camada 3),
## decoração em três escalas (C4), moldura (C3), primeiro plano (camada 5), luzes e partículas (C6).
## PLACEHOLDER: as peças são desenhadas por código com a paleta da GL00 e serão trocadas pelas folhas
## GL54 (estrutura), GL56 (decoração), GL57 (moldura), GL58 (primeiro plano) e GL59 (efeitos).
## Os dados (tipo, posição, altura) já são os que as peças finais vão ocupar.

const D := 91.0                  # altura do Daymon no jogo
const FAR := Color("1a2640")     # estrutura de fundo: mais escura que o plano do jogo
const MID := Color("24324f")
const SNOW_FAR := Color("40557a")
const SNOW_MID := Color("5a6f95")
const FG := Color("070b16")      # primeiro plano: azul-marinho quase preto


class Shapes extends Node2D:
	## Uma camada de peças desenhadas: [tipo, base (x, y), altura, semente, tom (0 = longe … 1 = perto)].
	var items: Array = []

	func _draw() -> void:
		for it in items:
			var rng := RandomNumberGenerator.new()
			rng.seed = int(it[3])
			var k: float = it[4] if it.size() > 4 else 0.5
			match String(it[0]):
				"pinheiro":
					NvScenery.pine(self, it[1], it[2], rng, k)
				"rocha":
					NvScenery.rock(self, it[1], it[2], rng, k)
				"ruina":
					NvScenery.ruin(self, it[1], it[2], rng, k)
				"pilar":
					NvScenery.pillar(self, it[1], it[2], rng, k)
				"tufo":
					NvScenery.tuft(self, it[1], it[2], rng, k)
				"pedra":
					NvScenery.pebble(self, it[1], it[2], rng, k)
				"monte":
					NvScenery.mound(self, it[1], it[2], rng, k)
				"galho":
					NvScenery.branch(self, it[1], it[2], rng, k)
				"corrente":
					NvScenery.chain(self, it[1], it[2], rng, k)
				"poste":
					NvScenery.post(self, it[1], it[2], rng, k)
				"cabo":
					NvScenery.cable(self, it[1], it[2], rng, k)


static func _tone(base: Color, k: float) -> Color:
	return FAR.lerp(base, k)


static func pine(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var body := _tone(Color("2a3d55"), k)
	var snow := SNOW_FAR.lerp(SNOW_MID, k)
	ci.draw_rect(Rect2(b.x - h * 0.03, b.y - h * 0.2, h * 0.06, h * 0.2), _tone(Color("30293a"), k))
	var tiers := 4
	for i in tiers:
		var y0: float = b.y - h * 0.15 - i * h * 0.21
		var w: float = h * (0.36 - i * 0.07)
		var top: float = y0 - h * 0.3
		var pts := PackedVector2Array([Vector2(b.x - w, y0), Vector2(b.x - w * 0.55, y0 - h * 0.05), Vector2(b.x, top), Vector2(b.x + w * 0.55, y0 - h * 0.04), Vector2(b.x + w, y0)])
		ci.draw_colored_polygon(pts, body)
		# neve acumulada nos galhos
		ci.draw_colored_polygon(PackedVector2Array([Vector2(b.x - w * 0.5, y0 - h * 0.08), Vector2(b.x, top + h * 0.02), Vector2(b.x + w * 0.42, y0 - h * 0.09),
			Vector2(b.x + w * 0.1, y0 - h * 0.13), Vector2(b.x - w * 0.2, y0 - h * 0.11)]), snow)


static func rock(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var w := h * rng.randf_range(1.1, 1.6)
	var pts := PackedVector2Array([Vector2(b.x - w / 2, b.y)])
	var n := 6
	for i in n + 1:
		var u := float(i) / n
		pts.append(Vector2(b.x - w / 2 + u * w, b.y - h * (0.55 + 0.45 * sin(u * PI)) * rng.randf_range(0.8, 1.0)))
	pts.append(Vector2(b.x + w / 2, b.y))
	ci.draw_colored_polygon(pts, _tone(Color("2e3550"), k))
	var cap := PackedVector2Array()
	for i in range(1, n):
		cap.append(pts[i + 1] + Vector2(0, -3))
	for i in range(n - 1, 0, -1):
		cap.append(pts[i + 1] + Vector2(0, h * 0.12))
	ci.draw_colored_polygon(cap, SNOW_FAR.lerp(Color("9fb3cf"), k * 0.8))


static func ruin(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var c := _tone(Color("2c3550"), k)
	var snow := SNOW_FAR.lerp(SNOW_MID, k)
	var w := h * 0.9
	for side in [-1, 1]:
		var x: float = b.x + side * w * 0.4
		var ch := h * (1.0 if side < 0 else rng.randf_range(0.6, 0.85))
		ci.draw_rect(Rect2(x - h * 0.07, b.y - ch, h * 0.14, ch), c)
		ci.draw_rect(Rect2(x - h * 0.09, b.y - ch - h * 0.04, h * 0.18, h * 0.05), snow)
	ci.draw_arc(Vector2(b.x - w * 0.05, b.y - h * 0.82), w * 0.38, PI, TAU * 0.86, 16, c, h * 0.08)
	ci.draw_rect(Rect2(b.x - w * 0.6, b.y - h * 0.08, w * 1.2, h * 0.08), c)


static func pillar(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var c := _tone(Color("2f4766"), k)
	var w := h * 0.16
	var pts := PackedVector2Array([Vector2(b.x - w, b.y), Vector2(b.x - w * 0.7, b.y - h * 0.5), Vector2(b.x - w * 0.9, b.y - h),
		Vector2(b.x + w * 0.9, b.y - h), Vector2(b.x + w * 0.6, b.y - h * 0.45), Vector2(b.x + w, b.y)])
	ci.draw_colored_polygon(pts, c)
	ci.draw_line(Vector2(b.x - w * 0.3, b.y - h * 0.9), Vector2(b.x - w * 0.1, b.y - h * 0.1), _tone(Color("4d6f92"), k), 3.0)


static func tuft(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	for i in 5:
		var x := b.x + rng.randf_range(-h * 0.5, h * 0.5)
		ci.draw_line(Vector2(x, b.y), Vector2(x + rng.randf_range(-h * 0.25, h * 0.25), b.y - h * rng.randf_range(0.6, 1.0)), Color("6d7f99").lerp(Color("3a4a66"), 1.0 - k), 2.0, true)


static func pebble(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var pts := Art.circle(b + Vector2(0, -h * 0.4), h * 0.55, 8)
	for i in pts.size():
		pts[i].y = minf(pts[i].y, b.y)
	ci.draw_colored_polygon(pts, Color("3a4258").lerp(FAR, 1.0 - k))
	ci.draw_colored_polygon(PackedVector2Array([b + Vector2(-h * 0.4, -h * 0.75), b + Vector2(0, -h * 0.95), b + Vector2(h * 0.45, -h * 0.72), b + Vector2(0, -h * 0.62)]), Color("9fb3cf").lerp(SNOW_FAR, 1.0 - k))


static func mound(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var w := h * rng.randf_range(2.5, 4.0)
	var pts := PackedVector2Array()
	for i in 13:
		var u := float(i) / 12.0
		pts.append(Vector2(b.x - w / 2 + u * w, b.y - h * sin(u * PI) * (0.85 + 0.15 * sin(u * 9.0))))
	ci.draw_colored_polygon(pts, Color("8ea3c2").lerp(SNOW_FAR, 1.0 - k))


## Galho de pinheiro que desce do alto (moldura, C3): pendurado a partir do ponto b.
static func branch(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var c := FG.lerp(Color("1c2a40"), k)
	var dir := 1.0 if rng.randf() < 0.5 else -1.0
	ci.draw_line(b, b + Vector2(dir * h * 0.9, h * 0.35), c, h * 0.07, true)
	for i in 6:
		var p := b.lerp(b + Vector2(dir * h * 0.9, h * 0.35), (i + 1) / 7.0)
		ci.draw_colored_polygon(PackedVector2Array([p + Vector2(-h * 0.12, 0), p + Vector2(h * 0.12, 0), p + Vector2(0, h * rng.randf_range(0.25, 0.45))]), c)


static func chain(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var c := Color("535d78").lerp(FAR, 1.0 - k)
	var y := 0.0
	while y < h:
		ci.draw_arc(b + Vector2(0, y + 5), 4.0, 0, TAU, 8, c, 2.0)
		y += 10.0
	ci.draw_colored_polygon(PackedVector2Array([b + Vector2(-6, h), b + Vector2(6, h), b + Vector2(0, h + 18)]), Color("6fa6c4").lerp(FAR, 1.0 - k))


## Poste de metal das estações (segura ganchos e lajes: nada flutua sem motivo, C5).
static func post(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	var c := Color("3a4560").lerp(FAR, 1.0 - k)
	ci.draw_rect(Rect2(b.x - 4, b.y - h, 8, h), c)
	for y in range(int(h * 0.15), int(h), 60):
		ci.draw_line(Vector2(b.x - 4, b.y - y), Vector2(b.x + 4, b.y - y - 18), Color("535d78").lerp(FAR, 1.0 - k), 2.0)
	ci.draw_rect(Rect2(b.x - 9, b.y - 6, 18, 6), c)


## Cabo esticado entre dois postes (trilho da plataforma móvel): b = início, (h, seed) = fim.
static func cable(ci: CanvasItem, b: Vector2, h: float, rng: RandomNumberGenerator, k: float) -> void:
	ci.draw_line(b, b + Vector2(h, 0), Color("535d78").lerp(FAR, 1.0 - k), 3.0, true)


# ------------------------------------------------------------------ montagem
static func build(nv) -> void:
	var lv: Level = nv.level
	var floors: Array = nv.FLOOR
	# camada 3: estrutura de fundo, atrás do plano do jogo (pinheiros, rochas, ruínas; pilares na caverna)
	var back := Shapes.new()
	back.z_index = -12
	var rng := RandomNumberGenerator.new()
	rng.seed = 7
	var x := -60.0
	while x < 2400.0:
		back.items.append(["pinheiro", Vector2(x, 700), rng.randf_range(3.0, 5.5) * D, int(x), 0.35])
		x += rng.randf_range(260, 520)
	back.items.append(["ruina", Vector2(2150, 700), 3.4 * D, 3, 0.4])
	back.items.append(["rocha", Vector2(1250, 700), 2.2 * D, 4, 0.35])
	for px in [2520, 2980, 3300, 3720, 4120, 4450]:
		back.items.append(["pilar", Vector2(px, 700), 320.0, px, 0.45])
	x = 4760.0
	while x < 7000.0:
		back.items.append(["pinheiro", Vector2(x, Nivaria.slope_y(x) + 8), rng.randf_range(3.2, 5.0) * D, int(x), 0.3])
		x += rng.randf_range(300, 560)
	back.items.append(["ruina", Vector2(7230, 300), 3.0 * D, 9, 0.4])
	for px in [7800, 8200, 8600, 8950]:
		back.items.append(["pilar", Vector2(px, -100), 520.0, px, 0.4])
	lv.add_child(back)
	# camada 4: decoração média e pequena no plano do jogo (C4), na frente da estrutura
	var deco := Shapes.new()
	deco.z_index = -3
	rng.seed = 21
	for r: Rect2 in floors:
		if r.position.y < -50.0:
			continue
		var xx := r.position.x + rng.randf_range(30, 90)
		while xx < r.end.x - 30.0:
			var roll := rng.randf()
			if roll < 0.45:
				deco.items.append(["tufo", Vector2(xx, r.position.y + 2), rng.randf_range(0.18, 0.3) * D, int(xx), 0.9])
			elif roll < 0.8:
				deco.items.append(["pedra", Vector2(xx, r.position.y + 3), rng.randf_range(0.15, 0.35) * D, int(xx), 0.9])
			else:
				deco.items.append(["rocha", Vector2(xx, r.position.y + 4), rng.randf_range(0.9, 1.4) * D, int(xx), 0.75])
			xx += rng.randf_range(90, 190)
	x = 5000.0
	while x < 6980.0:
		var roll := rng.randf()
		deco.items.append(["tufo" if roll < 0.6 else "pedra", Vector2(x, Nivaria.slope_y(x) + 3), rng.randf_range(0.18, 0.32) * D, int(x), 0.9])
		x += rng.randf_range(110, 220)
	# postes que seguram os ganchos e as lajes soltas (nada flutua sem motivo)
	for h: Vector2 in nv.HOOKS:
		if nv.HOOK_CEIL.has(h):
			continue
		var ground: float = Nivaria.slope_y(h.x) if h.x < 7000.0 else 300.0
		deco.items.append(["poste", Vector2(h.x, ground + 2), ground - (h.y - 20.0), int(h.x), 0.6])
	deco.items.append(["poste", Vector2(7300, 302), 340.0, 1, 0.6])
	deco.items.append(["poste", Vector2(7400, 302), 340.0, 2, 0.6])
	# trilho da plataforma móvel sobre o poço do Cume
	deco.items.append(["poste", Vector2(880, 702), 260.0, 5, 0.6])
	deco.items.append(["poste", Vector2(1220, 702), 260.0, 6, 0.6])
	deco.items.append(["cabo", Vector2(880, 446), 340.0, 7, 0.6])
	lv.add_child(deco)
	# laje do Cume e nicho: rocha por trás (a laje é a borda de cima de um maciço)
	var mass := ColorRect.new()
	mass.position = Vector2(1410, 545)
	mass.size = Vector2(480, 160)
	mass.color = Color("1c2338")
	mass.z_index = -4
	lv.add_child(mass)
	var pocket := ColorRect.new()
	pocket.position = Vector2(1690, 360)
	pocket.size = Vector2(210, 165)
	pocket.color = Color("161c2e")
	pocket.z_index = -5
	lv.add_child(pocket)
	# moldura (C3): no exterior, os pinheiros altos do fundo sobem até o topo da tela; na caverna e na arena, correntes descem do teto
	var frame := Shapes.new()
	frame.z_index = 20
	rng.seed = 33
	for cx in [2610, 3010, 3640, 4230, 4560]:
		frame.items.append(["corrente", Vector2(cx, 380), rng.randf_range(60, 120), cx, 0.5])
	for cx in [7760, 8300, 8780]:
		frame.items.append(["corrente", Vector2(cx, -620), rng.randf_range(80, 150), cx, 0.5])
	lv.add_child(frame)
	# camada 5: primeiro plano (parallax 1,1) — montes de neve e rochas em silhueta na borda de baixo
	var fgl := FgSnow.new()
	fgl.depth = 1.0
	fgl.z_index = 30
	lv.add_child(fgl)
	lv.fg_layers.append(fgl)
	# luzes (C6): cristais e lanternas das estações
	for p in [Vector2(2560, 680), Vector2(2900, 680), Vector2(3330, 680), Vector2(3700, 690), Vector2(4250, 680), Vector2(4520, 680)]:
		var g := Art.glow(Color(0.55, 0.45, 1.0, 0.28), 70)
		g.position = p
		g.z_index = -2
		lv.add_child(g)
	for p in [Vector2(430, 640), Vector2(7200, 250), Vector2(2150, 620)]:
		var g2 := Art.glow(Color(1.0, 0.66, 0.35, 0.22), 60)
		g2.position = p
		g2.z_index = -2
		lv.add_child(g2)
	# partículas (C6): neve caindo no exterior e brilho de cristal na caverna
	_snow(lv, Rect2(-200, -760, 4600, 1500), 140)
	_snow(lv, Rect2(4700, -760, 2900, 1500), 110)
	var dust := CPUParticles2D.new()
	dust.position = Vector2(3550, 540)
	dust.emission_shape = CPUParticles2D.EMISSION_SHAPE_RECTANGLE
	dust.emission_rect_extents = Vector2(1150, 160)
	dust.amount = 60
	dust.lifetime = 7.0
	dust.preprocess = 7.0
	dust.texture = Art.glow_tex()
	dust.material = Art.add_mat()
	dust.gravity = Vector2(0, -4)
	dust.initial_velocity_min = 3.0
	dust.initial_velocity_max = 12.0
	dust.spread = 180.0
	dust.scale_amount_min = 0.03
	dust.scale_amount_max = 0.08
	var g3 := Gradient.new()
	g3.colors = PackedColorArray([Color(0.7, 0.6, 1.0, 0.0), Color(0.7, 0.6, 1.0, 0.7), Color(0.7, 0.6, 1.0, 0.0)])
	g3.offsets = PackedFloat32Array([0.0, 0.5, 1.0])
	dust.color_ramp = g3
	dust.z_index = 3
	lv.add_child(dust)


static func _snow(lv: Level, r: Rect2, amount: int) -> void:
	var p := CPUParticles2D.new()
	p.position = Vector2(r.get_center().x, r.position.y)
	p.emission_shape = CPUParticles2D.EMISSION_SHAPE_RECTANGLE
	p.emission_rect_extents = Vector2(r.size.x / 2.0, 10)
	p.amount = amount
	p.lifetime = 14.0
	p.preprocess = 14.0
	p.texture = Art.glow_tex()
	p.gravity = Vector2(0, 8)
	p.direction = Vector2(-0.4, 1)
	p.spread = 25.0
	p.initial_velocity_min = 60.0
	p.initial_velocity_max = 110.0
	p.scale_amount_min = 0.04
	p.scale_amount_max = 0.1
	p.color = Color(0.9, 0.95, 1.0, 0.75)
	p.z_index = 25
	lv.add_child(p)


class FgSnow extends Node2D:
	## Primeiro plano: silhuetas de neve, rocha e pinheiro baixo, quase pretas, abaixo do nível do chão
	## (na faixa do subsolo, na borda de baixo da tela), para não esconder perigos nem o personagem.
	var depth := 1.0

	static func base_y(x: float) -> float:
		if x < 4700.0:
			return 880.0
		if x < 7000.0:
			return Nivaria.slope_y(x) + 175.0
		if x < 7620.0:
			return 480.0
		return 80.0

	func _draw() -> void:
		var rng := RandomNumberGenerator.new()
		rng.seed = 404
		var x := -400.0
		while x < 9400.0:
			var w := rng.randf_range(160, 420)
			var h := rng.randf_range(50, 120)
			var gy := base_y(x + w / 2.0)
			var pts := PackedVector2Array([Vector2(x, gy + 600)])
			for i in 9:
				var u := i / 8.0
				pts.append(Vector2(x + u * w, gy - h * sin(u * PI) * rng.randf_range(0.7, 1.0)))
			pts.append(Vector2(x + w, gy + 600))
			draw_colored_polygon(pts, NvScenery.FG)
			if rng.randf() < 0.3:
				NvScenery.pine(self, Vector2(x + w * 0.5, gy - h * 0.5), rng.randf_range(1.0, 1.6) * NvScenery.D, rng, 0.0)
			x += w * rng.randf_range(0.6, 1.2)
