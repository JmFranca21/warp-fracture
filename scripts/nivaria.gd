class_name Nivaria
extends Node2D
## Nivária (Fase 3, universo de gelo — proposta_fase3.md; D07 e D08 aprovadas pelo João).
## Daymon continua humano com a camada polar (forma "inverno"). Zonas (esboço do João):
##   A Cume Congelado (0–2400)   · B Caverna de Cristal (2400–4700)
##   C Encosta Nevada (4700–7700) · D Arena do Guardião (7620–9020, chão em y -100)
## Arte: recortes das fichas GL01–GL04 v2 (NvArt) como placeholder até o lote 2; terreno e fundo
## desenhados por código com a paleta aprovada da GL00.

const FLOOR := [
	Rect2(-120, 700, 1020, 360), Rect2(1180, 700, 1220, 360),          # A
	Rect2(2400, 700, 400, 360), Rect2(3200, 700, 180, 360), Rect2(3870, 700, 830, 360),   # B
	Rect2(4700, 700, 250, 360), Rect2(7000, 300, 750, 760),            # C (o platô vai até o fundo do poço do elevador)
	Rect2(7750, -100, 1270, 1160)]                                      # D: chão da arena
const LEDGES := [Rect2(1400, 520, 500, 30), Rect2(3850, 400, 120, 22), Rect2(7280, -60, 140, 22), Rect2(900, 900, 280, 160)]
const WALLS := [
	Rect2(-60, -760, 60, 1820),
	Rect2(1690, 360, 210, 40), Rect2(1870, 400, 30, 120),              # nicho do Núcleo 1 (teto e fundo)
	Rect2(1950, 330, 350, 50),                                          # beiral de rocha com estalactites
	Rect2(2400, -760, 1420, 1140), Rect2(3820, -760, 170, 1010), Rect2(3990, -760, 710, 1140),   # teto da caverna (recesso do Núcleo 2)
	Rect2(7560, -760, 60, 900),                                         # parede esquerda da arena / poço do elevador
	Rect2(7560, -760, 1520, 140),                                       # teto da arena (base em y -620)
	Rect2(9020, -760, 60, 1820)]
const SLOPE_A := Vector2(4950, 700)
const SLOPE_B := Vector2(7000, 300)
const PITS := [Rect2(900, 860, 280, 40), Rect2(2800, 760, 400, 300), Rect2(3380, 760, 490, 300)]
const HOOKS := [Vector2(3120, 470), Vector2(3500, 470), Vector2(3780, 470), Vector2(3920, 300),
	Vector2(5250, 391), Vector2(5570, 329), Vector2(5890, 267), Vector2(6210, 204), Vector2(6530, 142), Vector2(6850, 79),
	Vector2(7150, 60), Vector2(7350, -120)]
const ARENA := Rect2(7620, -620, 1400, 520)
const ARENA_HOOKS := [Vector2(8090, -420), Vector2(8550, -420)]
## Teto acima de cada gancho preso na rocha (o suporte desce até ele); os da Encosta ficam em
## rochas soltas, como no esboço do João.
const HOOK_CEIL := {Vector2(3120, 470): 380.0, Vector2(3500, 470): 380.0, Vector2(3780, 470): 380.0,
	Vector2(3920, 300): 250.0, Vector2(8090, -420): -620.0, Vector2(8550, -420): -620.0}
const FIRES := [Vector2(2330, 700), Vector2(4620, 700), Vector2(7480, 300)]
const ARENA_FIRE := Vector2(7860, -100)

var level: Level
var clock := 0.0
var thin_ice: Array = []
var stalactites: Array = []
var gates: Array = []
var walls_ice: Array = []
var patches: Array = []
var movers: Array = []          # [corpo, início, deslocamento, período, fase]
var elevator: AnimatableBody2D
var elev_y := 300.0
var elev_wait := 0.0
var balls_t := 1.0
var ball_big := false
var guardiao: Guardiao = null
var fires: Array = []


static func layout() -> Dictionary:
	var pickups := []
	var cells := [Vector2(700, 640), Vector2(1040, 560), Vector2(1550, 470), Vector2(2120, 640),
		Vector2(2600, 640), Vector2(3000, 600), Vector2(3290, 640), Vector2(4300, 640),
		Vector2(5400, 560), Vector2(6000, 450), Vector2(6600, 360), Vector2(7200, 250)]
	for i in cells.size():
		pickups.append(["cell", cells[i], "nv_c%d" % i])
	pickups.append(["nucleo", Vector2(1830, 495), "nv_nucleo1"])
	pickups.append(["nucleo", Vector2(3910, 380), "nv_nucleo2"])
	pickups.append(["nucleo", Vector2(7350, -80), "nv_nucleo3"])
	pickups.append(["registro", Vector2(560, 680), "log_11"])
	pickups.append(["registro", Vector2(4120, 680), "log_12"])
	pickups.append(["registro", Vector2(7090, 280), "log_13"])
	pickups.append(["heal", Vector2(4560, 680), "nv_h1"])
	pickups.append(["energy", Vector2(7700, -125), "", 10.0])
	var hooks := []
	for h in HOOKS:
		hooks.append([h])
	for h in ARENA_HOOKS:
		hooks.append([h])
	return {"theme": "nivaria", "form": "inverno", "name": "NIVÁRIA", "sub": "Cume Congelado — noite polar",
		"bounds": Rect2(0, -760, 9080, 1820), "spawn": Vector2(190, 690), "kill_y": 1040.0,
		"solids": FLOOR + LEDGES + WALLS, "hazards": [], "hooks": hooks, "enemies": [],
		"checkpoints": [], "terminals": [], "pickups": pickups,
		"signs": [
			[Vector2(300, 700), "NIVÁRIA: golpes de frio cobrem o traje de GEADA. Cada camada deixa você mais lento; na terceira, você CONGELA."],
			[Vector2(1250, 700), "Clique direito (ou K) com 1/3 de energia: PULSO TÉRMICO. Tira a geada, liberta do gelo e derrete placas de gelo."],
			[Vector2(2500, 700), "Os cristais ressonantes descarregam em ciclo. Espere o arco apagar para passar."],
			[Vector2(4800, 700), "IRIS: \"Avalanche no alto da encosta. Use o Arpão para ficar acima das bolas de neve.\""]],
		"arrival_rift": Vector2(105, 700), "return_rift": Vector2(8920, -100),
		"rooms": [["A", Rect2(0, -760, 2400, 1820), "Cume Congelado"], ["B", Rect2(2400, -760, 2300, 1820), "Caverna de Cristal"],
			["C", Rect2(4700, -760, 2860, 1820), "Encosta Nevada"], ["D", Rect2(7560, -760, 1520, 1100), "Arena do Guardião"]]}


static func slope_y(x: float) -> float:
	if x >= SLOPE_B.x:
		return SLOPE_B.y
	if x <= SLOPE_A.x:
		return SLOPE_A.y
	return lerpf(SLOPE_A.y, SLOPE_B.y, (x - SLOPE_A.x) / (SLOPE_B.x - SLOPE_A.x))


# ================================================================== peças
## Área de dano (grupo "enemy_attack"), de queda (grupo "hazard") ou de frio (grupo "frost").
static func make_area(rect: Rect2, parent: Node, kind := "attack") -> Area2D:
	var area := Area2D.new()
	area.collision_layer = 32 if kind == "pit" else 16
	area.collision_mask = 0
	area.monitoring = false
	area.add_to_group({"pit": "hazard", "attack": "enemy_attack", "frost": "frost"}[kind])
	var shape := CollisionShape2D.new()
	var box := RectangleShape2D.new()
	box.size = rect.size
	shape.shape = box
	area.position = rect.get_center()
	area.add_child(shape)
	parent.add_child(area)
	return area


class Backdrop extends Node2D:
	## Céu (noite polar, aurora rosa, lua) e cordilheiras em parallax, com a paleta da GL00.
	var depth := 0.1
	var kind := "ceu"
	var seed_v := 1

	func _draw() -> void:
		var rng := RandomNumberGenerator.new()
		rng.seed = seed_v
		match kind:
			"ceu":
				for i in 12:
					var c := NvArt.CEU_A.lerp(NvArt.CEU_B, i / 11.0)
					draw_rect(Rect2(-3000, -1400 + i * 160, 16000, 162), c)
				for i in 160:
					var p := Vector2(rng.randf_range(-1500, 9500), rng.randf_range(-1300, 300))
					draw_circle(p, rng.randf_range(0.8, 1.8), Color(0.85, 0.9, 1.0, rng.randf_range(0.25, 0.7)))
				for band in 3:
					var pts := PackedVector2Array()
					var y0 := -900.0 + band * 120.0
					for k in 40:
						var x := -1500.0 + k * 300.0
						pts.append(Vector2(x, y0 + sin(k * 0.55 + band) * 70.0))
					for k in range(39, -1, -1):
						var x := -1500.0 + k * 300.0
						pts.append(Vector2(x, y0 + 50.0 + sin(k * 0.55 + band) * 70.0 + sin(k * 1.3) * 20.0))
					draw_colored_polygon(pts, Color(NvArt.AURORA, 0.10 - band * 0.025))
				draw_circle(Vector2(1300, -560), 46.0, Color(0.92, 0.95, 1.0, 0.95))
				draw_circle(Vector2(1300, -560), 70.0, Color(0.85, 0.9, 1.0, 0.08))
			"picos", "colinas":
				var far := kind == "picos"
				var base := 820.0 if far else 900.0
				var x := -1500.0
				var pts := PackedVector2Array([Vector2(x, base + 600)])
				var caps := []
				while x < 10500.0:
					var w := rng.randf_range(260, 520) if far else rng.randf_range(380, 700)
					var h := rng.randf_range(420, 760) if far else rng.randf_range(160, 320)
					pts.append(Vector2(x, base))
					pts.append(Vector2(x + w * 0.5, base - h))
					caps.append([Vector2(x + w * 0.5, base - h), w, h])
					x += w
				pts.append(Vector2(x, base))
				pts.append(Vector2(x, base + 600))
				draw_colored_polygon(pts, Color("1b2943") if far else Color("222b45"))
				for c in caps:
					var top: Vector2 = c[0]
					var cw := float(c[1]) * 0.16
					draw_colored_polygon(PackedVector2Array([top, top + Vector2(cw, float(c[2]) * 0.2), top + Vector2(cw * 0.2, float(c[2]) * 0.16),
						top + Vector2(-cw * 0.4, float(c[2]) * 0.22), top + Vector2(-cw, float(c[2]) * 0.2)]),
						Color("38536b") if far else Color("3d4c6c"))


class Terrain extends Node2D:
	## Rocha, neve e gelo do terreno jogável (paleta GL00: topo de neve só nas superfícies jogáveis).
	var rects: Array = []
	var ceilings: Array = []
	var slope := PackedVector2Array()

	func _draw() -> void:
		for r: Rect2 in ceilings:
			draw_rect(r, NvArt.ROCHA_A)
			draw_rect(Rect2(r.position.x, r.end.y - 10, r.size.x, 10), NvArt.ROCHA_B)
			var x := r.position.x + 18.0
			while x < r.end.x - 10.0:
				var h := 14.0 + fmod(x * 7.31, 22.0)
				draw_colored_polygon(PackedVector2Array([Vector2(x - 7, r.end.y), Vector2(x + 7, r.end.y), Vector2(x, r.end.y + h)]), Color(NvArt.GELO, 0.85))
				x += 38.0 + fmod(x * 3.7, 30.0)
		for r: Rect2 in rects:
			_block(r)
		if slope.size() > 2:
			draw_colored_polygon(slope, NvArt.ROCHA_B)
			var a := slope[0]
			var b := slope[1]
			var n := (b - a).orthogonal().normalized() * -1.0
			# subsolo: faixas mais escuras para baixo e pedras
			for i in 4:
				var off := 40.0 + i * 70.0
				draw_line(a + n * off, b + n * off, NvArt.ROCHA_A.lerp(NvArt.ROCHA_B, 0.4 - i * 0.1), 50.0)
			_snow_line(a, b)

	## Bloco de terreno (DA-03, C5): topo de neve irregular, borda escura, subsolo com pedras e cantos.
	func _block(r: Rect2) -> void:
		draw_rect(r, NvArt.ROCHA_B)
		var y := r.position.y + 22.0
		var i := 0
		while y < r.end.y:
			draw_rect(Rect2(r.position.x, y, r.size.x, minf(60.0, r.end.y - y)), NvArt.ROCHA_B.lerp(NvArt.ROCHA_A, minf(1.0, 0.25 + i * 0.22)))
			y += 60.0
			i += 1
		var rng := RandomNumberGenerator.new()
		rng.seed = int(r.position.x * 13.0 + r.position.y)
		var nst := int(r.size.x * minf(r.size.y, 260.0) / 5200.0)
		for k in nst:
			var p := Vector2(rng.randf_range(r.position.x + 8, r.end.x - 8), rng.randf_range(r.position.y + 34, minf(r.end.y - 6, r.position.y + 260)))
			var rr := rng.randf_range(4, 11)
			draw_colored_polygon(Art.circle(p, rr, 6), NvArt.ROCHA_C.lerp(NvArt.ROCHA_A, 0.55))
		draw_line(Vector2(r.position.x + 1, r.position.y + 6), Vector2(r.position.x + 1, r.end.y), NvArt.ROCHA_A, 3.0)
		draw_line(Vector2(r.end.x - 1, r.position.y + 6), Vector2(r.end.x - 1, r.end.y), NvArt.ROCHA_A, 3.0)
		_snow_line(r.position, Vector2(r.end.x, r.position.y), true)

	## Neve acumulada: montes irregulares e beiral que passa um pouco das pontas (cantos).
	func _snow_line(a: Vector2, b: Vector2, caps := false) -> void:
		var rng := RandomNumberGenerator.new()
		rng.seed = int(a.x * 7.0 + a.y * 3.0)
		var seg_len := a.distance_to(b)
		var dir := (b - a) / seg_len
		var up := Vector2(dir.y, -dir.x)
		var ext := 8.0 if caps else 0.0
		var top := PackedVector2Array()
		var low := PackedVector2Array()
		var steps := maxi(2, int(seg_len / 22.0))
		for i in steps + 1:
			var u := float(i) / steps
			var p := a.lerp(b, u) + dir * lerpf(-ext, ext, u)
			var bump := rng.randf_range(2.0, 7.0) + (5.0 if rng.randf() < 0.12 else 0.0)
			top.append(p + up * bump)
			low.append(p - up * rng.randf_range(14.0, 20.0))
		var band := top.duplicate()
		for i in range(low.size() - 1, -1, -1):
			band.append(low[i])
		draw_colored_polygon(band, NvArt.NEVE)
		var hi := top.duplicate()
		for i in range(top.size() - 1, -1, -1):
			hi.append(top[i] - up * 6.0)
		draw_colored_polygon(hi, NvArt.NEVE_TOPO)
		draw_polyline(low, NvArt.NEVE_SOMBRA, 3.0)
		if caps:
			for end in [0, steps]:
				draw_circle(low[end] + up * 6.0, 9.0, NvArt.NEVE)


class ThinIce extends AnimatableBody2D:
	## Gelo fino (GL04): racha em três estágios (0,35 s cada) e quebra; volta depois de 3 s.
	var rect: Rect2
	var stage := 0
	var st := 0.0
	var spr: Sprite2D
	var cs: CollisionShape2D
	var lvl

	func _ready() -> void:
		collision_layer = 1
		collision_mask = 0
		sync_to_physics = false
		position = rect.position
		cs = CollisionShape2D.new()
		var b := RectangleShape2D.new()
		b.size = Vector2(rect.size.x, 14)
		cs.shape = b
		cs.position = Vector2(rect.size.x / 2.0, 7)
		add_child(cs)
		spr = Sprite2D.new()
		spr.position = Vector2(rect.size.x / 2.0, 8)
		add_child(spr)
		_show()

	func _show() -> void:
		spr.texture = NvArt.tex("gl04_gelo_fino%d" % stage)
		var k := (rect.size.x + 20.0) / NvArt.tex("gl04_gelo_fino0").get_width()
		spr.scale = Vector2(k, k)
		spr.visible = stage < 3 or st < 0.5

	func tick(dt: float, p: Player) -> void:
		if stage == 0:
			if p != null and p.is_on_floor() and absf(p.global_position.y - rect.position.y) < 6.0 \
					and p.global_position.x > rect.position.x - 10.0 and p.global_position.x < rect.end.x + 10.0:
				stage = 1
				st = 0.0
				AudioMgr.sfx("rachadura", rect.get_center(), -4.0, 0.1)
				_show()
			return
		st += dt
		if stage < 3 and st >= 0.35:
			stage += 1
			st = 0.0
			if stage == 3:
				cs.set_deferred("disabled", true)
				AudioMgr.sfx("plataforma_quebra", rect.get_center(), -2.0, 0.1)
				Fx.burst(lvl.fx, rect.get_center(), Color(0.8, 0.9, 1.0), 14, 220, 0.5, 0.06, 400)
			_show()
		elif stage == 3:
			spr.modulate.a = maxf(0.0, 1.0 - st * 2.0)
			if st >= 3.0:
				stage = 0
				st = 0.0
				spr.modulate.a = 1.0
				cs.set_deferred("disabled", false)
				_show()


class Stalactite extends Node2D:
	## Estalactite (GL04): treme por 0,5 s quando o jogador passa embaixo, cai e quebra no chão.
	var floor_y := 700.0
	var state := "parada"          # parada, tremendo, caindo, quebrada
	var st := 0.0
	var vy := 0.0
	var spr: Sprite2D
	var hit: Area2D
	var lvl
	var auto := true                # falsa na arena: só cai com o impacto do Guardião
	var home := Vector2.ZERO

	func _ready() -> void:
		home = position
		spr = NvArt.sprite("gl04_estalactite", 64.0, "h", "topo")
		add_child(spr)
		hit = Nivaria.make_area(Rect2(-9, 18, 18, 40), self)
		hit.collision_layer = 0

	func trigger() -> void:
		if state == "parada":
			state = "tremendo"
			st = 0.0

	func tick(dt: float, p: Player) -> void:
		st += dt
		match state:
			"parada":
				if auto and p != null and absf(p.global_position.x - position.x) < 48.0 and p.global_position.y > position.y:
					trigger()
			"tremendo":
				spr.position.x = sin(st * 70.0) * 2.0
				if st >= 0.5:
					state = "caindo"
					st = 0.0
					spr.position.x = 0.0
					hit.collision_layer = 16
			"caindo":
				vy = minf(vy + 2200.0 * dt, 1100.0)
				position.y += vy * dt
				if position.y + 60.0 >= floor_y:
					position.y = floor_y - 60.0
					state = "quebrada"
					st = 0.0
					hit.collision_layer = 0
					spr.texture = NvArt.tex("gl04_estalactite_quebrada")
					AudioMgr.sfx("plataforma_quebra", position, -3.0, 0.12)
					Fx.burst(lvl.fx, position + Vector2(0, 55), Color(0.8, 0.9, 1.0), 12, 220, 0.45, 0.05, 500)
			"quebrada":
				spr.modulate.a = maxf(0.0, 1.0 - st * 1.5)
				if not auto and st > 6.0:          # na arena, voltam a crescer no teto
					position = home
					vy = 0.0
					state = "parada"
					spr.texture = NvArt.tex("gl04_estalactite")
					spr.modulate.a = 1.0


class CrystalGate extends Node2D:
	## Cristais Ressonantes (GL04): par chão/teto com arco rosa. 1,4 s apagado, 0,4 s de aviso, 1,6 s ativo.
	var top_y := 380.0
	var bottom_y := 700.0
	var phase := 0.0
	var state := "off"
	var low: Sprite2D
	var high: Sprite2D
	var hit: Area2D
	var t := 0.0

	func _ready() -> void:
		low = NvArt.sprite("gl04_cristal_off", 70.0, "h", "base")
		low.position = Vector2(0, bottom_y - position.y)
		add_child(low)
		high = NvArt.sprite("gl04_cristal_off", 70.0, "h", "base")
		high.position = Vector2(0, top_y - position.y)
		high.flip_v = true
		high.offset.y = -high.offset.y
		add_child(high)
		hit = Nivaria.make_area(Rect2(-26, top_y - position.y + 30, 52, bottom_y - top_y - 60), self)

	func tick(dt: float) -> void:
		t += dt
		var c := fmod(t + phase, 3.4)
		state = "off" if c < 1.4 else ("aviso" if c < 1.8 else "on")
		var id: String = {"off": "gl04_cristal_off", "aviso": "gl04_cristal_aviso", "on": "gl04_cristal_on"}[state]
		low.texture = NvArt.tex(id)
		high.texture = NvArt.tex(id)
		hit.collision_layer = 16 if state == "on" else 0
		queue_redraw()

	func _draw() -> void:
		if state == "off":
			return
		var a := Vector2(0, top_y - position.y + 50)
		var b := Vector2(0, bottom_y - position.y - 50)
		if state == "aviso":
			draw_line(a, b, Color(NvArt.AURORA, 0.18 + 0.15 * sin(t * 30.0)), 2.0)
			return
		var pts := PackedVector2Array()
		var n := 14
		for i in n + 1:
			var p := a.lerp(b, float(i) / n)
			if i > 0 and i < n:
				p.x += randf_range(-14, 14)
			pts.append(p)
		draw_polyline(pts, Color(NvArt.AURORA, 0.35), 9.0, true)
		draw_polyline(pts, Color(1.0, 0.8, 0.95), 2.5, true)


class IceWall extends StaticBody2D:
	## Placa de gelo (GL04) que bloqueia passagens; derrete com o Pulso Térmico.
	var rect: Rect2
	var spr: Sprite2D
	var cs: CollisionShape2D
	var melted := false

	func _ready() -> void:
		collision_layer = 1
		collision_mask = 0
		cs = CollisionShape2D.new()
		var b := RectangleShape2D.new()
		b.size = rect.size
		cs.shape = b
		cs.position = rect.get_center()
		add_child(cs)
		# a peça da GL04 é larga: dois blocos empilhados na largura da passagem (escala uniforme)
		spr = NvArt.sprite("gl04_parede", rect.size.x + 16.0, "w", "base")
		spr.position = Vector2(rect.get_center().x, rect.end.y + 2.0)
		spr.z_index = 2
		add_child(spr)
		var top_spr := NvArt.sprite("gl04_parede", rect.size.x + 10.0, "w", "base")
		top_spr.position = Vector2(rect.get_center().x, rect.end.y - spr.texture.get_height() * spr.scale.y * 0.78)
		top_spr.flip_h = true
		top_spr.z_index = 1
		spr.add_child(top_spr)
		top_spr.position = (top_spr.position - spr.position) / spr.scale.x
		top_spr.scale = top_spr.scale / spr.scale.x

	func melt(lvl) -> void:
		if melted:
			return
		melted = true
		cs.set_deferred("disabled", true)
		spr.texture = NvArt.tex("gl04_parede_meio")
		AudioMgr.sfx("plataforma_quebra", rect.get_center(), -2.0, 0.05)
		Fx.burst(lvl.fx, rect.get_center(), Color(0.8, 0.92, 1.0), 20, 200, 0.6, 0.06, 200)
		var tw := spr.create_tween()
		tw.tween_property(spr, "modulate:a", 0.0, 0.9)


class SlipPatch extends Node2D:
	## Mancha de gelo escorregadio deixada pela esfera do Drone Gélido (3 s).
	var life := 3.0
	var w := 90.0
	var spr: Sprite2D

	func _ready() -> void:
		spr = NvArt.sprite("gl02_gelo_chao", w, "w", "base")
		spr.position.y = 2.0
		add_child(spr)
		z_index = 1

	func tick(dt: float, p: Player) -> bool:
		life -= dt
		spr.modulate.a = clampf(life / 0.6, 0.0, 1.0)
		if p != null and p.is_on_floor() and absf(p.global_position.x - position.x) < w / 2.0 and absf(p.global_position.y - position.y) < 10.0:
			p.slip_t = 0.1
		return life <= 0.0


class Snowball extends Node2D:
	## Bola de neve (GL04) que desce a Encosta: pequena (0,5 D, dá para pular; o Pulso quebra) ou
	## grande (1,2 D, só o Arpão salva). Esmaga Gelinhos no caminho; no pé do morro, se desfaz.
	var big := false
	var r := 22.0
	var vx := -60.0
	var spr: Sprite2D
	var hit: Area2D
	var nv
	var broken := false

	func _ready() -> void:
		r = 54.5 if big else 22.5
		spr = NvArt.sprite("gl04_bola_g" if big else "gl04_bola_p", r * 2.0, "h", "centro")
		add_child(spr)
		hit = Nivaria.make_area(Rect2(-r * 0.8, -r * 0.8, r * 1.6, r * 1.6), self)
		hit.set_meta("snowball", self)
		z_index = 4

	func tick(dt: float) -> void:
		if broken:
			return
		var on_slope := position.x > Nivaria.SLOPE_A.x and position.x < Nivaria.SLOPE_B.x
		vx = maxf(vx - (330.0 if on_slope else -120.0) * dt, -560.0 if big else -470.0)
		position.x += vx * dt
		position.y = Nivaria.slope_y(position.x) - r
		spr.rotation += vx * dt / r
		for e in nv.level.get_tree().get_nodes_in_group("enemies"):
			if e is NvEnemy and e.kind == "gelinho" and not e.dead and e.global_position.distance_to(position) < r + 20.0:
				e.take_hit(9, position)
		if position.x < 4820.0 or (vx > -20.0 and not on_slope):
			shatter()

	func shatter() -> void:
		if broken:
			return
		broken = true
		hit.collision_layer = 0
		spr.texture = NvArt.tex("gl04_bola_g_explode")
		spr.rotation = 0.0
		AudioMgr.sfx("plataforma_quebra", position, -4.0, 0.1)
		Fx.burst(nv.level.fx, position, Color(0.9, 0.95, 1.0), 16, 260, 0.5, 0.07, 300)
		var tw := create_tween()
		tw.tween_property(self, "modulate:a", 0.0, 0.4)
		tw.tween_callback(queue_free)

	func on_hit_player() -> void:
		var p: Player = nv.level.player
		if is_instance_valid(p):
			p.velocity.x = vx * 0.9      # arrastado morro abaixo


# ================================================================== construção
func _ready() -> void:
	for i in 3:
		var bd := Backdrop.new()
		bd.kind = ["ceu", "picos", "colinas"][i]
		bd.depth = [0.02, 0.12, 0.3][i]
		bd.seed_v = 11 + i * 7
		bd.z_index = -60 + i * 5
		level.add_child(bd)
		level.bg_layers.append(bd)
	# fundos fixos: caverna e arena escuras (luma ≤ 0,2), com cristais lavanda
	_back(Rect2(2400, 380, 2300, 330), NvArt.ROCHA_A.lerp(NvArt.CEU_A, 0.3))
	_back(Rect2(ARENA.position.x, ARENA.position.y, ARENA.size.x, ARENA.size.y + 5), NvArt.ROCHA_A.lerp(NvArt.CEU_A, 0.2))
	_back(Rect2(7620, -100, 130, 400), NvArt.ROCHA_A)     # poço do elevador
	for x in [2560, 2900, 3330, 3700, 4250, 4520]:
		_decor("gl04_cristal_off", Vector2(x, 700), 54.0, -8, Color(0.7, 0.7, 0.85))
	for x in [7900, 8380, 8800]:
		_decor("gl04_cristal_off", Vector2(x, -100), 80.0, -8, Color(0.7, 0.7, 0.85))
	_decor("gl04_observatorio", Vector2(430, 700), 150.0, -6)
	_decor("gl04_painel", Vector2(4170, 700), 46.0, -4)
	_decor("gl04_observatorio", Vector2(7200, 300), 120.0, -6, Color(0.85, 0.88, 0.95))
	var terr := Terrain.new()
	terr.rects = FLOOR + LEDGES.slice(0, 3)
	terr.ceilings = WALLS.slice(1)
	terr.slope = PackedVector2Array([SLOPE_A, SLOPE_B, Vector2(SLOPE_B.x, 1060), Vector2(SLOPE_A.x, 1060)])
	terr.z_index = -2
	add_child(terr)
	var slope_body := StaticBody2D.new()
	slope_body.collision_layer = 1
	var poly := CollisionPolygon2D.new()
	poly.polygon = terr.slope
	slope_body.add_child(poly)
	add_child(slope_body)
	# poços: espinhos de gelo (Cume) e Névoa da Fratura (Caverna)
	for i in 2:
		_decor("gl04_espinhos", Vector2(970 + i * 140, 900), 70.0, 1)
	make_area(Rect2(900, 850, 280, 50), self, "pit")
	for pit in PITS.slice(1):
		var mist := ColorRect.new()
		mist.position = Vector2(pit.position.x, 735)
		mist.size = Vector2(pit.size.x, 330)
		mist.color = Color("2a1446")
		mist.z_index = -3
		add_child(mist)
		var n := ceili((pit.size.x - 10.0) / 130.0)
		for i in n:
			# a última faixa encosta na borda direita do poço (não invade o chão)
			var cx: float = minf(pit.position.x + 70.0 + i * 130.0, pit.end.x - 70.0)
			var s := _decor("gl04_nevoa", Vector2(cx, 760), 140.0, 2, Color(1, 1, 1, 0.95), "w")
			s.set_meta("nevoa", true)
		make_area(Rect2(pit.position.x, 745, pit.size.x, 300), self, "pit")
	# ganchos (GL04: aro ciano preso na rocha)
	for h in HOOKS + ARENA_HOOKS:
		var g := NvArt.sprite("gl04_gancho", 64.0, "w", "base")
		g.position = h + Vector2(0, 16)
		g.z_index = 1
		add_child(g)
		if HOOK_CEIL.has(h):
			var top: float = h.y + 16.0 - NvArt.tex("gl04_gancho").get_height() * g.scale.y
			var chain := Line2D.new()
			chain.points = PackedVector2Array([Vector2(h.x, HOOK_CEIL[h]), Vector2(h.x, top + 4.0)])
			chain.width = 4.0
			chain.default_color = NvArt.ROCHA_C
			chain.z_index = 0
			add_child(chain)
	# gelo fino
	for r in [Rect2(2930, 640, 110, 14), Rect2(3600, 640, 100, 14)]:
		var ti := ThinIce.new()
		ti.rect = r
		ti.lvl = level
		add_child(ti)
		thin_ice.append(ti)
	# estalactites que caem (Cume e Caverna) e as da arena (caem com o impacto do Guardião)
	for p in [Vector2(2030, 380), Vector2(2130, 380), Vector2(2230, 380), Vector2(4080, 380), Vector2(4160, 380)]:
		_stalactite(p, 700.0, true)
	var x2 := ARENA.position.x + 180.0
	while x2 < ARENA.end.x - 60.0:
		_stalactite(Vector2(x2, ARENA.position.y), -100.0, false)
		x2 += 110.0
	# cristais ressonantes (portão por tempo)
	var gate := CrystalGate.new()
	gate.position = Vector2(2700, 380)
	gate.top_y = 380.0
	gate.bottom_y = 700.0
	add_child(gate)
	gates.append(gate)
	# placa de gelo do nicho do Núcleo 1
	var w := IceWall.new()
	w.rect = Rect2(1690, 400, 70, 120)
	add_child(w)
	walls_ice.append(w)
	# plataformas: móvel sobre o poço do Cume e bloco flutuante que sobe até a laje
	_mover("gl04_plataforma", Rect2(920, 610, 110, 16), Vector2(140, 0), 4.0)
	_mover("gl04_bloco", Rect2(1260, 600, 90, 70), Vector2(0, -130), 5.0)
	var lev := Art.glow(Color(0.45, 0.85, 1.0, 0.35), 70)     # flutua por energia: o brilho diz isso (DA-03, C5)
	lev.position = Vector2(45, 60)
	movers[-1][0].add_child(lev)
	# elevador até a arena
	elevator = AnimatableBody2D.new()
	elevator.collision_layer = 1
	elevator.position = Vector2(7620, 300)
	var ecs := CollisionShape2D.new()
	var eb := RectangleShape2D.new()
	eb.size = Vector2(130, 16)
	ecs.shape = eb
	ecs.position = Vector2(65, 8)
	elevator.add_child(ecs)
	var es := NvArt.sprite("gl04_elevador", 140.0, "w", "base")
	es.position = Vector2(65, 18)
	elevator.add_child(es)
	add_child(elevator)
	# Braseiros (checkpoints de Nivária) e o braseiro da arena
	for f in FIRES:
		var cp := Checkpoint.new()
		cp.main = level.main
		cp.theme = "nivaria"
		cp.position = f
		level.objects.add_child(cp)
		fires.append(f)
	var af := NvArt.sprite("gl04_braseiro_on", 52.0, "h", "base")
	af.position = ARENA_FIRE
	af.z_index = -1
	add_child(af)
	fires.append(ARENA_FIRE)
	# inimigos (12: densidade ~1,3 por 1.000 px, como Verdâmia)
	var list := [
		["gelinho", Vector2(640, 700), Vector2(470, 860)], ["gelinho", Vector2(1520, 520), Vector2(1420, 1680)],
		["gelinho", Vector2(2150, 700), Vector2(1960, 2280)], ["drone", Vector2(1080, 470), Vector2(960, 1240)],
		["drone", Vector2(1950, 260), Vector2(1760, 2240)],
		["morcego", Vector2(2560, 380), Vector2.ZERO], ["morcego", Vector2(4300, 380), Vector2.ZERO],
		["gelinho", Vector2(4420, 700), Vector2(4060, 4560)], ["drone", Vector2(3640, 560), Vector2(3440, 3860)],
		["gelinho", Vector2(5250, 640), Vector2(5060, 5450)], ["drone", Vector2(6100, 300), Vector2(5800, 6400)],
		["gelinho", Vector2(7300, 300), Vector2(7120, 7420)]]
	for i in list.size():
		var pid := "nv_enemy%d" % i
		if level.main.collected.has(pid):
			continue
		var e := NvEnemy.new()
		e.level = level
		e.kind = list[i][0]
		e.pid = pid
		e.position = list[i][1]
		e.patrol = list[i][2]
		level.entities.add_child.call_deferred(e)
	guardiao = Guardiao.new()
	guardiao.level = level
	guardiao.nv = self
	add_child(guardiao)
	NvScenery.build(self)      # DA-03: estrutura, decoração, moldura, primeiro plano, luzes e partículas


func _back(r: Rect2, c: Color) -> void:
	var cr := ColorRect.new()
	cr.position = r.position
	cr.size = r.size
	cr.color = c
	cr.z_index = -20
	add_child(cr)


func _decor(id: String, pos: Vector2, size: float, z: int, mod := Color(1, 1, 1), by := "h") -> Sprite2D:
	var s := NvArt.sprite(id, size, by, "base")
	s.position = pos
	s.z_index = z
	s.modulate = mod
	add_child(s)
	return s


func _stalactite(p: Vector2, floor_y: float, auto: bool) -> void:
	var s := Stalactite.new()
	s.position = p
	s.floor_y = floor_y
	s.lvl = level
	s.auto = auto
	add_child(s)
	stalactites.append(s)


func _mover(id: String, r: Rect2, travel: Vector2, period: float) -> void:
	var body := AnimatableBody2D.new()
	body.collision_layer = 1
	body.position = r.position
	var cs := CollisionShape2D.new()
	var b := RectangleShape2D.new()
	b.size = Vector2(r.size.x, 16)
	cs.shape = b
	cs.position = Vector2(r.size.x / 2.0, 8)
	body.add_child(cs)
	var s := NvArt.sprite(id, r.size.x + 8.0, "w", "topo")
	s.position = Vector2(r.size.x / 2.0, -4)
	body.add_child(s)
	add_child(body)
	movers.append([body, r.position, travel, period])


# ================================================================== interação
## Pulso Térmico (player._heat_pulse): derrete placas de gelo, quebra bolas pequenas e as placas do Guardião.
func on_heat(c: Vector2, radius: float) -> void:
	for w: IceWall in walls_ice:
		var near := Vector2(clampf(c.x, w.rect.position.x, w.rect.end.x), clampf(c.y, w.rect.position.y, w.rect.end.y))
		if near.distance_to(c) <= radius:
			w.melt(level)
	for b in get_children():
		if b is Snowball and not b.big and b.position.distance_to(c) <= radius + b.r:
			b.shatter()
	if guardiao != null:
		guardiao.on_heat(c, radius)


func on_fragile(pos: Vector2) -> bool:
	for ti: ThinIce in thin_ice:
		if absf(pos.y - ti.rect.position.y) < 8.0 and pos.x > ti.rect.position.x - 14.0 and pos.x < ti.rect.end.x + 14.0:
			return true
	return false


func near_fire(pos: Vector2) -> bool:
	for f: Vector2 in fires:
		if absf(pos.x - f.x) < 80.0 and absf(pos.y - f.y) < 60.0:
			return true
	return false


func add_patch(pos: Vector2) -> void:
	var sp := SlipPatch.new()
	sp.position = pos
	add_child(sp)
	patches.append(sp)


func arena_impact(x: float) -> void:
	## Impacto da Investida na parede: derruba as estalactites mais próximas do jogador.
	var p := level.player
	var px: float = p.global_position.x if is_instance_valid(p) else x
	for s: Stalactite in stalactites:
		if not s.auto and s.state == "parada" and absf(s.position.x - px) < 200.0:
			s.trigger()


func _physics_process(dt: float) -> void:
	clock += dt
	var p: Player = level.player if is_instance_valid(level.player) and not level.player.dead else null
	for ti: ThinIce in thin_ice:
		ti.tick(dt, p)
	for s: Stalactite in stalactites:
		s.tick(dt, p)
	for g: CrystalGate in gates:
		g.tick(dt)
	for i in range(patches.size() - 1, -1, -1):
		if patches[i].tick(dt, p):
			patches[i].queue_free()
			patches.remove_at(i)
	for m in movers:
		var k := 0.5 - 0.5 * cos(clock * TAU / float(m[3]))
		m[0].position = m[1] + m[2] * k
	for c in get_children():
		if c is Snowball:
			c.tick(dt)
		elif c is Sprite2D and c.has_meta("nevoa"):
			c.position.y = 760.0 + sin(clock * 1.3 + c.position.x * 0.01) * 4.0
	_elevator(dt, p)
	# bolas de neve: só quando o jogador está na Encosta
	if p != null and p.global_position.x > 4700.0 and p.global_position.x < 7000.0 and p.global_position.y > 150.0:
		balls_t -= dt
		if balls_t <= 0.0:
			balls_t = 2.4
			ball_big = not ball_big
			var b := Snowball.new()
			b.big = ball_big
			b.nv = self
			b.position = Vector2(6995, 300 - (54.5 if ball_big else 22.5))
			add_child(b)
	# fase 3 do Guardião: o chão da arena fica escorregadio
	if guardiao != null and guardiao.phase == 3 and guardiao.active and p != null and p.global_position.y < -90.0:
		p.slip_t = 0.1


func _elevator(dt: float, p: Player) -> void:
	## Sobe quando o jogador pisa nele; desce sozinho 1,5 s depois de ele sair lá em cima. Nunca
	## esmaga: se o jogador estiver no poço, embaixo, para acima da cabeça dele.
	var in_shaft := p != null and p.global_position.x > 7600.0 and p.global_position.x < 7770.0
	var on_it := in_shaft and p.is_on_floor() and absf(p.global_position.y - elev_y) < 8.0
	var goal := 300.0
	if (guardiao != null and guardiao.active) or on_it:
		goal = -100.0
		elev_wait = 0.0
	elif elev_y <= -99.0:
		elev_wait += dt
		goal = 300.0 if elev_wait > 1.5 else -100.0
	var ny := move_toward(elev_y, goal, 130.0 * dt)
	if in_shaft and not on_it and p.global_position.y > elev_y + 4.0:
		ny = minf(ny, maxf(elev_y, p.global_position.y - 62.0 - 40.0))
	if absf(ny - elev_y) > 0.01 and absf(elev_y - goal) > 0.01 and absf(ny - goal) < 0.01:
		AudioMgr.sfx("elevador", Vector2(7685, ny), -6.0, 0.0)
	elev_y = ny
	elevator.position.y = elev_y
