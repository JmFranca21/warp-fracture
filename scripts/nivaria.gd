@tool
class_name Nivaria
extends Node2D
## Nivária (Fase 3, universo de gelo): layout navegável das quatro zonas do esboço do João
## (docs/fases/nivaria/esboco_level_design.png), com a paleta da GL00.
## Ainda NÃO tem perigos, inimigos, Geada nem chefe: só terreno, plataformas, ganchos e checkpoints.
## A arte é provisória, desenhada por código, até as folhas GL50–GL89 serem entregues.
##
## O LAYOUT FICA NA CENA res://fases/nivaria.tscn (este script é a raiz dela). Abra a cena no editor
## e mova os nós: Blocos (rocha sólida), Encosta (polígono), Nevoa, Fundos, Plataformas, Ganchos,
## Mastros, Pontos (início, checkpoints, placas), Itens, Decoracao, Zonas e Notas (recados ao Claude).
## O jogo lê tudo da cena ao carregar a fase; o terreno é desenhado também no editor.
## Física do Daymon: pulo ≈144 px de altura; corrida+pulo ≈240 px; +esquiva ≈360 px; gancho 380 px.

const SCENE_PATH := "res://fases/nivaria.tscn"

# Paleta GL00
const C_ROCHA := [Color("1E2338"), Color("2E3550"), Color("535D78")]
const C_NEVE := [Color("4F6386"), Color("9FB3CF"), Color("E6EEF7")]
const C_GELO := [Color("38536B"), Color("628499"), Color("A4BDCC")]
const C_CRISTAL := [Color("483D65"), Color("7A6FC9"), Color("AA9ACF")]
const C_NEVOA := [Color("422952"), Color("6B2FA8"), Color("B26CEB")]
const C_MADEIRA := [Color("3A3440"), Color("61505A"), Color("89717A")]
const C_METAL := [Color("263447"), Color("526275"), Color("8999A8")]

const GROUND := 800.0
const FUNDO := "res://assets/nivaria/Cenario 1.png"
const FUNDO_CAVERNA := "res://assets/nivaria/Cenario caverna.png"
## Largura (px de câmera) da troca gradual entre o fundo de fora e o da caverna, em cada boca.
const TROCA := 500.0

@export var nome := "NIVÁRIA"
@export var subtitulo := "Universo 3: a Noite Polar"
## Limites da câmera (a fase inteira).
@export var limites := Rect2(-200, -850, 13400, 2100):
	set(v):
		limites = v
		queue_redraw()
## Abaixo desta altura Daymon morre.
@export var kill_y := 1350.0

## Geometria da última cena lida (usada por slope_y e pelos testes).
static var _geo := {}
## true quando a cena foi aberta com F6 no editor: o main.gd entra direto na fase, com o Arpão e sem salvar.
static var direct_play := false

var level: Level
var geo := {}
var clock := 0.0
var platforms: Array = []
var anim: Node2D
var back: NivBack
var cave_bg: VerdBg
var hills: Array = []            # morros do código: somem dentro da caverna
var cave_x := Vector2.ZERO       # trecho [x0, x1] da Caverna (fundo com boca), onde o fundo da caverna aparece
var _sig := 0


# ------------------------------------------------------------------ leitura da cena
## Lê a cena da fase e devolve o dicionário que o Level usa (o mesmo formato das outras fases).
static func layout() -> Dictionary:
	var inst: Nivaria = load(SCENE_PATH).instantiate()
	var g := inst.collect()
	var d := {"theme": "nivaria", "form": "yeti", "name": inst.nome, "sub": inst.subtitulo,
		"bounds": inst.limites, "kill_y": inst.kill_y}
	inst.free()
	var hooks := []
	for h in g["hooks"]:
		hooks.append([h[0], h[1]] if h[1] != null else [h[0]])
	for m: Vector2 in g["masts"]:
		hooks.append([m])
	var pickups := []
	for i in g["cells"].size():
		pickups.append(["cell", g["cells"][i], "niv_c%d" % i])
	for i in g["heals"].size():
		pickups.append(["heal", g["heals"][i], "niv_h%d" % (i + 1)])
	d.merge({"spawn": g["spawn"], "solids": g["solids"], "hazards": [], "hooks": hooks, "enemies": [], "terminals": [],
		"checkpoints": g["checkpoints"], "signs": g["signs"], "pickups": pickups, "rooms": g["rooms"]})
	return d


## Altura da neve da Encosta em x (fora dela, o chão em y 800 não conta: só a Encosta).
static func slope_y(x: float) -> float:
	return surface_y(_geo.get("surface", []), x)


## Posições das argolas dos mastros da Encosta.
static func slope_hooks() -> Array:
	return _geo.get("masts", [])


static func geometry() -> Dictionary:
	return _geo


static func surface_y(surf: Array, x: float) -> float:
	if surf.is_empty():
		return GROUND
	if x <= surf[0].x:
		return surf[0].y
	for i in range(1, surf.size()):
		var a: Vector2 = surf[i - 1]
		var b: Vector2 = surf[i]
		if x <= b.x:
			return lerpf(a.y, b.y, (x - a.x) / maxf(b.x - a.x, 0.001))
	return surf[surf.size() - 1].y


## Junta os nós da cena (em qualquer pasta) num dicionário de geometria, em coordenadas da fase.
func collect() -> Dictionary:
	var g := {"blocks": [], "solids": [], "mist": [], "backs": [], "rooms": [], "hooks": [], "masts": [],
		"checkpoints": [], "cells": [], "heals": [], "signs": [], "crystals": [], "stations": [], "notes": [],
		"spawn": Vector2(80, 790), "slope": PackedVector2Array(), "surface": [], "elevator": null,
		"descents": [], "frozen": []}
	for n in _all(self):
		var o := _off(n)
		if n is NivBloco:
			var r := Rect2(o, n.size)
			g["blocks"].append({"r": r, "ice": n.estalactites, "small": n.estalactites_pequenas, "snow": not n.sem_neve})
			g["solids"].append(r)
		elif n is NivArea:
			var r := Rect2(o, n.size)
			match n.tipo:
				0: g["mist"].append(r)
				1, 2: g["backs"].append({"r": r, "mouth": n.tipo == 2})
				3: g["rooms"].append([n.id, r, n.nome])
		elif n is NivGancho:
			g["hooks"].append([o, n.teto_y if n.preso_no_teto else null])
		elif n is NivMastro:
			g["masts"].append(o)
		elif n is NivPonto:
			match n.tipo:
				0: g["spawn"] = o
				1: g["checkpoints"].append(o)
				2: g["cells"].append(o)
				3: g["heals"].append(o)
				4: g["signs"].append([o, n.texto])
				5: g["crystals"].append([o, n.escala])
				6: g["stations"].append(o)
				7: g["notes"].append([o, n.texto])
		elif n is NivPlatform:
			if n.kind == "elevador" and g["elevator"] == null:
				g["elevator"] = {"top": o, "w": n.largura}
		elif n is NivPreso:
			g["frozen"].append(o)
		elif n is Polygon2D and (n.name == "Encosta" or String(n.name).begins_with("Descida")):
			var poly := PackedVector2Array()
			for p in n.polygon:
				poly.append(p + o)
			if n.name == "Encosta":
				g["slope"] = poly
				g["surface"] = surface_of(poly)
			else:
				g["descents"].append({"poly": poly, "surf": surface_of(poly)})
	_geo = g
	return g


## Superfície de um polígono de terreno: os vértices de cima (todos menos os da base), da esquerda para a direita.
static func surface_of(poly: PackedVector2Array) -> Array:
	if poly.size() < 3:
		return []
	var maxy := -INF
	for p in poly:
		maxy = maxf(maxy, p.y)
	var surf := []
	for p in poly:
		if p.y < maxy - 1.0:
			surf.append(p)
	surf.sort_custom(func(a: Vector2, b: Vector2) -> bool: return a.x < b.x)
	return surf


## Altura do chão (blocos, Encosta e Descidas) em x, procurando de cima para baixo a partir de from_y.
static func ground_y(x: float, from_y := -INF) -> float:
	var best := INF
	for r: Rect2 in _geo.get("solids", []):
		if x >= r.position.x and x <= r.end.x and r.position.y >= from_y:
			best = minf(best, r.position.y)
	var polys: Array = _geo.get("descents", []).duplicate()
	if _geo.get("surface", []).size() > 1:
		polys.append({"surf": _geo["surface"]})
	for d in polys:
		var s: Array = d["surf"]
		if s.size() > 1 and x >= s[0].x and x <= s[s.size() - 1].x:
			var y := surface_y(s, x)
			if y >= from_y:
				best = minf(best, y)
	return best


func _all(n: Node) -> Array:
	var out := []
	for c in n.get_children():
		if c.owner != self:       # só os nós salvos na cena (ignora os criados por código)
			continue
		out.append(c)
		out.append_array(_all(c))
	return out


## Posição do nó em coordenadas da fase (soma as posições das pastas até a raiz).
func _off(n: Node) -> Vector2:
	var p := Vector2.ZERO
	while n != null and n != self:
		if n is Node2D:
			p += n.position
		elif n is Control:
			p += n.position
		n = n.get_parent()
	return p


# ------------------------------------------------------------------ montagem
func _ready() -> void:
	if not Engine.is_editor_hint() and level == null:
		# F6 com a cena aberta: sem Level não há jogador; abre o jogo completo direto nesta fase
		direct_play = true
		get_tree().change_scene_to_file.call_deferred("res://main.tscn")
		return
	z_index = 0
	geo = collect()
	back = NivBack.new()
	back.niv = self
	back.z_index = -14
	add_child(back)
	if Engine.is_editor_hint():
		queue_redraw()
		return
	# fundo distante: arte do Cenário 1 (aurora e cordilheira), cobrindo a tela em qualquer altura da fase
	var far := VerdBg.new()
	far.tex = load(FUNDO)
	far.depth = 0.04
	var view := Vector2(1280, 720) / 1.1 + Vector2(240, 40)
	far.fit(view, Vector2(limites.position.x + 580.0, limites.end.x - 580.0),
		Vector2(limites.position.y + 327.0, limites.end.y - 327.0), 0.9)
	far.z_index = -60
	level.add_child(far)
	level.bg_layers.append(far)
	# fundo da caverna: mesma camada, por cima, aparece aos poucos conforme a câmera entra pela boca
	for bk in geo["backs"]:
		if bk["mouth"]:
			cave_x = Vector2(bk["r"].position.x, bk["r"].end.x)
	if cave_x != Vector2.ZERO:
		back.see_through = true
		cave_bg = VerdBg.new()
		cave_bg.tex = load(FUNDO_CAVERNA)
		cave_bg.depth = far.depth
		cave_bg.fit(view, Vector2(limites.position.x + 580.0, limites.end.x - 580.0),
			Vector2(limites.position.y + 327.0, limites.end.y - 327.0), 0.9)
		cave_bg.z_index = -59
		cave_bg.modulate.a = 0.0
		level.add_child(cave_bg)
		level.bg_layers.append(cave_bg)
	# só os morros escuros do código ficam na frente da arte (as cordilheiras desenhadas cobriam o Cenário 1)
	var depths := [0.45]
	for k in depths.size():
		var i: int = k + 3
		var bg := NivBg.new()
		bg.layer = i
		bg.depth = depths[k]
		bg.span_x = limites.end.x
		bg.span_x0 = limites.position.x
		bg.z_index = -60 + i * 10
		level.add_child(bg)
		level.bg_layers.append(bg)
		hills.append(bg)
	_slope_body()
	for r: Rect2 in geo["mist"]:
		_mist_area(r)
	for n in _all(self):
		if n is NivPlatform:
			platforms.append(n)
			n.level = level
		elif n is NivPreso:
			n.level = level
	anim = Node2D.new()
	anim.z_index = 1
	anim.draw.connect(_draw_anim)
	add_child(anim)
	_snow()
	queue_redraw()


## No editor: redesenha o terreno quando algum nó da cena muda.
func _process(_dt: float) -> void:
	if not Engine.is_editor_hint():
		return
	var parts := [limites]
	for n in _all(self):
		if n is Control:
			parts.append([n.position, n.size, n.get("tipo"), n.get("estalactites"), n.get("estalactites_pequenas")])
		elif n is Node2D:
			parts.append([n.position, n.get("tipo"), n.get("escala"), n.get("kind"), n.get("largura"), n.get("teto_y")])
			if n is Polygon2D:
				parts.append(n.polygon)
	var s := hash(parts)
	if s != _sig:
		_sig = s
		geo = collect()
		queue_redraw()
		if is_instance_valid(back):
			back.queue_redraw()


func _slope_body() -> void:
	var list: Array = [geo["slope"]]
	for d in geo["descents"]:
		list.append(d["poly"])
	for pts: PackedVector2Array in list:
		if pts.size() < 3:
			continue
		var body := StaticBody2D.new()
		body.collision_layer = 1
		body.collision_mask = 0
		var poly := CollisionPolygon2D.new()
		poly.polygon = pts
		body.add_child(poly)
		add_child(body)


## Névoa da Fratura: 1 de dano e volta ao último chão firme (grupo "hazard", como os fossos do laboratório).
func _mist_area(r: Rect2) -> void:
	var area := Area2D.new()
	area.collision_layer = 32
	area.collision_mask = 0
	area.monitoring = false
	area.add_to_group("hazard")
	var cs := CollisionShape2D.new()
	var box := RectangleShape2D.new()
	box.size = r.size
	cs.shape = box
	area.position = r.get_center()
	area.add_child(cs)
	add_child(area)


func _snow() -> void:
	var b := limites
	var p := CPUParticles2D.new()
	p.position = Vector2(b.get_center().x, b.position.y - 40)
	p.emission_shape = CPUParticles2D.EMISSION_SHAPE_RECTANGLE
	p.emission_rect_extents = Vector2(b.size.x / 2.0, 20)
	p.amount = int(b.size.x / 18.0)      # mesma densidade de neve em qualquer comprimento de fase
	p.lifetime = 16.0
	p.preprocess = 16.0
	p.texture = Art.glow_tex()
	p.direction = Vector2(0.25, 1)
	p.spread = 12.0
	p.gravity = Vector2(6, 18)
	p.initial_velocity_min = 55.0
	p.initial_velocity_max = 95.0
	p.scale_amount_min = 0.03
	p.scale_amount_max = 0.07
	p.color = Color(C_NEVE[2], 0.75)
	p.z_index = 3
	add_child(p)


func _physics_process(dt: float) -> void:
	if Engine.is_editor_hint() or anim == null:
		return   # no F6 a cena só troca para main.tscn e não monta nada
	clock += dt
	anim.queue_redraw()
	_cave_fade()


## Troca gradual do fundo: 0 fora da caverna, 1 dentro; a transição ocupa TROCA px em volta de cada boca.
func _cave_fade() -> void:
	if cave_bg == null:
		return
	var cam := get_viewport().get_camera_2d()
	if cam == null:
		return
	var cx := cam.get_screen_center_position().x
	var w := clampf((cx - cave_x.x + TROCA * 0.5) / TROCA, 0.0, 1.0) * clampf((cave_x.y - cx + TROCA * 0.5) / TROCA, 0.0, 1.0)
	cave_bg.modulate.a = smoothstep(0.0, 1.0, w)
	for h in hills:
		h.modulate.a = 1.0 - cave_bg.modulate.a


# ------------------------------------------------------------------ desenho do terreno
func _draw() -> void:
	if geo.is_empty():
		return
	var rng := RandomNumberGenerator.new()
	rng.seed = 3031
	for b in geo["blocks"]:
		_rock(b["r"], rng)
	_slope_draw(rng, geo["slope"], geo["surface"])
	for d in geo["descents"]:
		_slope_draw(rng, d["poly"], d["surf"], true)
	for b in geo["blocks"]:
		var r: Rect2 = b["r"]
		if not b["snow"]:
			continue
		for seg: Vector2 in _top_open(r):
			_snow_cap(Vector2(seg.x, r.position.y), Vector2(seg.y, r.position.y), rng)
		if b["ice"]:
			_icicles(r.position.x, r.end.x, r.end.y, rng, b["small"])
	_cave_lips(rng)
	_masts()
	_elevator_frame()
	if Engine.is_editor_hint():
		# no editor a névoa fica parada e os limites da câmera aparecem tracejados
		for r: Rect2 in geo["mist"]:
			_mist(self, r)
		var L := limites
		for seg in [[L.position, Vector2(L.end.x, L.position.y)], [Vector2(L.end.x, L.position.y), L.end],
				[L.end, Vector2(L.position.x, L.end.y)], [Vector2(L.position.x, L.end.y), L.position]]:
			draw_dashed_line(seg[0], seg[1], Color(1, 1, 1, 0.35), 3.0, 24.0)
		_elevator_cables(self, 0.0)


## Beiral de rocha nas duas bocas da caverna, emendado no teto, para a entrada não terminar num corte reto.
func _cave_lips(rng: RandomNumberGenerator) -> void:
	for bk in geo["backs"]:
		if not bk["mouth"]:
			continue
		var cave: Rect2 = bk["r"]
		for side: float in [-1.0, 1.0]:
			var x := cave.position.x if side < 0 else cave.end.x
			var y := cave.position.y
			var lip := PackedVector2Array([Vector2(x - side * 4, y - 40), Vector2(x - side * 40, y - 40), Vector2(x - side * 46, y + 20),
				Vector2(x - side * 20, y + 70), Vector2(x + side * 30, y + 48), Vector2(x + side * 70, y + 10), Vector2(x + side * 70, y - 2)])
			draw_colored_polygon(lip, C_ROCHA[1])
			draw_polyline(PackedVector2Array([lip[1], lip[2], lip[3], lip[4], lip[5]]), C_ROCHA[2], 2.0, true)
			_snow_cap(Vector2(x - side * 46, y - 40) if side < 0 else Vector2(x - 4, y - 40), Vector2(x - 4, y - 40) if side < 0 else Vector2(x + 46, y - 40), rng)
			for k in 3:
				var ix := x - side * 20 + side * k * 28.0
				var iy := y + 60 - k * 18.0
				draw_colored_polygon(PackedVector2Array([Vector2(ix - 7, iy), Vector2(ix + 7, iy), Vector2(ix, iy + 30 - k * 4)]), C_GELO[1])


## Partes que se mexem (névoa e cabos do elevador), redesenhadas a cada quadro num nó próprio,
## para não redesenhar o terreno inteiro.
func _draw_anim() -> void:
	for r: Rect2 in geo["mist"]:
		_mist(anim, r)
	for pl in platforms:
		if pl.kind == "elevador":
			_elevator_cables(anim, 0.0, _off(pl))


func _elevator_cables(ci: CanvasItem, _t: float, at := Vector2.INF) -> void:
	var e = geo["elevator"]
	if e == null:
		return
	var top: Vector2 = e["top"]
	var pos: Vector2 = top if at == Vector2.INF else at
	for cx in [-60.0, 60.0]:
		ci.draw_line(Vector2(top.x + cx * 0.15, top.y - 50), Vector2(pos.x + cx, pos.y - 2), C_METAL[1], 2.0)


func _rock(r: Rect2, rng: RandomNumberGenerator) -> void:
	draw_rect(r, C_ROCHA[1])
	# faixa escura funda: o corpo do bloco escurece longe da superfície
	if r.size.y > 160.0:
		draw_rect(Rect2(r.position.x, r.position.y + 90, r.size.x, r.size.y - 90), Color(C_ROCHA[0], 0.75))
	# facetas de rocha
	var n := int(r.size.x * minf(r.size.y, 260.0) / 9000.0)
	for i in n:
		var c := Vector2(rng.randf_range(r.position.x + 12, r.end.x - 12), rng.randf_range(r.position.y + 22, minf(r.end.y, r.position.y + 260) - 10))
		var s := rng.randf_range(10, 26)
		var pts := PackedVector2Array([c + Vector2(-s, 0), c + Vector2(-s * 0.3, -s * 0.6), c + Vector2(s * 0.8, -s * 0.3), c + Vector2(s * 0.5, s * 0.4)])
		draw_colored_polygon(pts, Color(C_ROCHA[2], 0.22))
	# laterais iluminadas (o chão que emenda no pé da encosta não tem borda)
	var surf: Array = geo["surface"]
	if r.size.y > 60.0 and (surf.is_empty() or r.end.x != surf[0].x):
		draw_line(Vector2(r.position.x + 1, r.position.y), Vector2(r.position.x + 1, r.end.y), Color(C_ROCHA[2], 0.55), 2.0)
		draw_line(Vector2(r.end.x - 1, r.position.y), Vector2(r.end.x - 1, r.end.y), Color(C_ROCHA[0], 0.9), 2.0)


func _slope_draw(rng: RandomNumberGenerator, poly: PackedVector2Array, surf: Array, cliffs := false) -> void:
	if poly.size() < 3 or surf.size() < 2:
		return
	draw_colored_polygon(poly, C_ROCHA[1])
	var maxy := -INF
	for p in poly:
		maxy = maxf(maxy, p.y)
	var deep := PackedVector2Array()
	for p in poly:
		deep.append(p + Vector2(0, 90) if p.y < maxy - 1.0 else p)
	draw_colored_polygon(deep, Color(C_ROCHA[0], 0.75))
	var x0: float = surf[0].x
	var x1: float = surf[surf.size() - 1].x
	for i in int((x1 - x0) / 37.0):
		var x := rng.randf_range(x0 + 20, x1 - 20)
		var c := Vector2(x, surface_y(surf, x) + rng.randf_range(28, 200))
		var s := rng.randf_range(10, 24)
		draw_colored_polygon(PackedVector2Array([c + Vector2(-s, 0), c + Vector2(0, -s * 0.5), c + Vector2(s, -s * 0.2), c + Vector2(s * 0.3, s * 0.4)]), Color(C_ROCHA[2], 0.2))
	# paredes laterais do polígono (penhascos): borda clara à esquerda e escura à direita
	var first: Vector2 = surf[0]
	var last: Vector2 = surf[surf.size() - 1]
	if cliffs:
		draw_line(Vector2(first.x + 1, first.y), Vector2(first.x + 1, maxy), Color(C_ROCHA[2], 0.55), 2.0)
		draw_line(Vector2(last.x - 1, last.y), Vector2(last.x - 1, maxy), Color(C_ROCHA[0], 0.9), 2.0)
	elif last.y < GROUND:
		draw_line(Vector2(last.x - 1, last.y), Vector2(last.x - 1, GROUND), Color(C_ROCHA[0], 0.9), 2.0)
	for i in range(1, surf.size()):
		_snow_cap(surf[i - 1], surf[i], rng)


## Camada de neve sobre uma superfície (reta ou inclinada): borda ondulada, sombra azulada e beiral nas pontas.
func _snow_cap(a: Vector2, b: Vector2, rng: RandomNumberGenerator) -> void:
	var len := a.distance_to(b)
	if len < 1.0:
		return
	var dir := (b - a) / len
	var nrm := Vector2(-dir.y, dir.x)          # aponta para dentro do terreno (para baixo)
	var top := PackedVector2Array()
	var bottom := PackedVector2Array()
	var steps := maxi(2, int(len / 26.0))
	for i in steps + 1:
		var t := float(i) / steps
		var p := a.lerp(b, t)
		var edge := 1.0 - smoothstep(0.0, 14.0, minf(t * len, (1.0 - t) * len))   # afina nas pontas
		top.append(p - nrm * (2.0 + rng.randf_range(0, 3)))
		bottom.append(p + nrm * ((14.0 + rng.randf_range(-3, 6)) * (1.0 - edge * 0.5)))
	var shade := PackedVector2Array()
	for i in range(bottom.size() - 1, -1, -1):
		shade.append(bottom[i] + nrm * 4.0)
	var under := top.duplicate()
	under.append_array(shade)
	draw_colored_polygon(under, C_NEVE[1])
	var body := top.duplicate()
	for i in range(bottom.size() - 1, -1, -1):
		body.append(bottom[i])
	draw_colored_polygon(body, C_NEVE[2])
	draw_polyline(top, Color(1, 1, 1, 0.9), 1.5, true)
	# beiral arredondado nas pontas
	for end in [a, b]:
		draw_circle(end + nrm * 6.0 + (dir if end == a else -dir) * 2.0, 7.0, C_NEVE[2])


func _icicles(x0: float, x1: float, y: float, rng: RandomNumberGenerator, small: bool) -> void:
	draw_rect(Rect2(x0, y - 8, x1 - x0, 8), Color(C_GELO[0], 0.9))
	var x := x0 + rng.randf_range(8, 30)
	while x < x1 - 10:
		var w := rng.randf_range(10, 22)
		var h := rng.randf_range(18, 34) if small else rng.randf_range(20, 70)
		if rng.randf() < 0.18:
			h *= 1.6
		var tri := PackedVector2Array([Vector2(x - w / 2, y - 2), Vector2(x + w / 2, y - 2), Vector2(x + rng.randf_range(-2, 2), y + h)])
		draw_colored_polygon(tri, C_GELO[1])
		draw_line(Vector2(x - w / 4, y), Vector2(x, y + h * 0.75), Color(C_GELO[2], 0.8), 2.0)
		x += rng.randf_range(26, 60)


## Mastros de madeira das estações de observação, com braço e argola para o Arpão.
func _masts() -> void:
	var surf: Array = geo["surface"]
	for h: Vector2 in geo["masts"]:
		var px := h.x + 46.0
		var base := surface_y(surf, px) + 6.0
		var top := h.y - 34.0
		draw_rect(Rect2(px - 6, top, 12, base - top), C_MADEIRA[1])
		draw_line(Vector2(px - 5, top), Vector2(px - 5, base), Color(C_MADEIRA[2], 0.7), 2.0)
		draw_line(Vector2(px + 5, top), Vector2(px + 5, base), C_MADEIRA[0], 2.0)
		# estacas de apoio cravadas na neve
		draw_line(Vector2(px, base - 70), Vector2(px - 30, surface_y(surf, px - 30) + 4), C_MADEIRA[0], 4.0)
		draw_line(Vector2(px, base - 70), Vector2(px + 30, surface_y(surf, px + 30) + 4), C_MADEIRA[0], 4.0)
		# braço com a corrente da argola
		draw_rect(Rect2(h.x - 8, top - 2, px - h.x + 16, 9), C_MADEIRA[1])
		draw_rect(Rect2(h.x - 8, top - 6, px - h.x + 22, 5), C_NEVE[2])
		var y := top + 7.0
		while y < h.y - 14.0:
			draw_line(Vector2(h.x, y), Vector2(h.x, minf(y + 7.0, h.y - 14.0)), C_METAL[1], 3.0)
			y += 9.0
		# bandeira roxa das estações (GL00)
		draw_colored_polygon(PackedVector2Array([Vector2(px + 6, top + 12), Vector2(px + 34, top + 18), Vector2(px + 6, top + 30)]), Color("6B3A78"))


## Viga com roldana no alto do poço do elevador; os cabos descem até a plataforma.
func _elevator_frame() -> void:
	var e = geo["elevator"]
	if e == null:
		return
	# coordenadas relativas à borda esquerda do poço, na altura de partida do elevador
	var o: Vector2 = e["top"] - Vector2(e["w"] / 2.0 + 15.0, 0)
	var beam := Rect2(o + Vector2(-30, -64), Vector2(220, 14))
	# pé da viga cravado no platô (a outra ponta entra na parede da arena)
	draw_rect(Rect2(o + Vector2(-28, -50), Vector2(12, 52)), C_METAL[0])
	draw_line(o + Vector2(-27, -50), o + Vector2(-27, 2), C_METAL[2], 2.0)
	draw_line(o + Vector2(-22, 0), o + Vector2(-60, 2), C_METAL[0], 4.0)
	draw_rect(beam, C_METAL[0])
	draw_line(beam.position, Vector2(beam.end.x, beam.position.y), C_METAL[2], 2.0)
	draw_rect(Rect2(beam.position.x, beam.position.y - 6, beam.size.x, 6), C_NEVE[2])
	draw_circle(e["top"] + Vector2(0, -57), 10.0, C_METAL[1])
	draw_circle(e["top"] + Vector2(0, -57), 4.0, C_METAL[0])


func _mist(ci: CanvasItem, r: Rect2) -> void:
	var x0 := r.position.x
	var x1 := r.end.x
	var y := r.position.y
	var y1 := r.end.y
	ci.draw_rect(Rect2(x0, y + 10, x1 - x0, y1 - y - 10), C_NEVOA[0])
	for k in 3:
		var pts := PackedVector2Array()
		var amp := 8.0 - k * 2.0
		var off := float(k) * 9.0
		pts.append(Vector2(x0, y1))
		var x := x0
		while x <= x1:
			pts.append(Vector2(x, y + off + sin(x * 0.03 + clock * (1.2 + k * 0.4)) * amp - 10.0 + k * 6.0))
			x += 12.0
		pts.append(Vector2(x1, y + off))
		pts.append(Vector2(x1, y1))
		ci.draw_colored_polygon(pts, Color(C_NEVOA[1 if k < 2 else 2], 0.45 - k * 0.1))
	# brilho subindo das bordas do poço
	for i in int((x1 - x0) / 40.0):
		var px := x0 + 20.0 + i * 40.0
		var ph := fmod(clock * 0.6 + i * 0.37, 1.0)
		ci.draw_circle(Vector2(px + sin(i + clock) * 6.0, y - ph * 90.0), 3.0 * (1.0 - ph), Color(C_NEVOA[2], 0.6 * (1.0 - ph)))


## Trechos [x0, x1] do topo de r sem outro bloco apoiado em cima (fundos de poço ficam sob a névoa, sem neve).
func _top_open(r: Rect2) -> Array:
	if r.position.y >= 1000.0:      # fundos de poço, sob a névoa
		return []
	var segs: Array = [Vector2(r.position.x, r.end.x)]
	for o: Rect2 in geo["solids"]:
		if o == r or not (o.end.y >= r.position.y - 1 and o.position.y < r.position.y):
			continue
		var next: Array = []
		for s: Vector2 in segs:
			if o.end.x <= s.x or o.position.x >= s.y:
				next.append(s)
				continue
			if o.position.x > s.x:
				next.append(Vector2(s.x, o.position.x))
			if o.end.x < s.y:
				next.append(Vector2(o.end.x, s.y))
		segs = next
	return segs.filter(func(s: Vector2) -> bool: return s.y - s.x > 20.0)
