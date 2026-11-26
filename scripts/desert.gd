class_name Desert
extends Node2D
## Deserto de Ferrugem (Fase 2, primeira área de Ferrumgrado): cenário, máquinas e percurso.
## Layout e máquinas vêm do protótipo (branch prototipo/deserto-de-ferrugem), reescritos na estrutura
## da main (D02–D05): o jogador é o Autômato, as argolas são âncoras do Ímã de Fase, a porta do Salão
## leva à Câmara da Forja (chefe, D04) e, atrás da porta direita da Câmara, fica a fenda de retorno.
## Zonas: A Dunas de sucata (0–1700) · B Fábrica autônoma (1700–3580) · C Salão do Núcleo (3580–6990)
##        D Câmara da Forja (6990–8550) · E Saída (8550–8900).

const FLOOR := [Rect2(-120,700,900,360), Rect2(1180,700,520,360), Rect2(1700,700,1080,360),
	Rect2(2870,625,145,26), Rect2(3100,545,240,28), Rect2(3580,415,430,40),
	Rect2(4410,415,450,40), Rect2(4980,770,510,320), Rect2(6030,770,2870,320)]
const SKY := "res://assets/deserto/fundo/DF200_ceu_diurno.png"   # Dunas diurnas (DA-04 aprovada em 25/11/2026)
const SKY_SCALE := 0.645
const MID := ["res://assets/deserto/fundo/DF201_distante_v2.png", "res://assets/deserto/fundo/DF201_proximo_v2.png"]
const MID_BASE := [230.0, 325.0]   # y da base na camada: a base cai em y ≈ 496 da tela com a câmera normal das Dunas
const SKY_ORIGIN := Vector2(1020, 720)   # px do arquivo que ficam no ponto (0, 30) da camada
const DF53_SLAB := [385.0, 226.0]     # linha (px da textura) onde começa a laje em DF53a e DF53b
const V2 := "res://assets/deserto/v2/"
const FUNDO := "res://assets/deserto/fundo/"
# DF204 (atlas 5 × 2, células 1024 × 1536, âncora na base (512, 1536), 2,5 px por px do jogo), num plano de
# parallax 0,85 (DFCamada), com a base 30 px abaixo do apoio, escondida pelo terreno, e fora dos vãos dos fossos.
# [coluna, linha, x onde aparece com a câmera diante dele, y do piso, câmera de referência (x, y), névoa]
const ESTRUTURAS := [
	[1, 1, 110, 700, Vector2(640, 535), 0.22], [2, 2, 470, 700, Vector2(640, 535), 0.22],   # Dunas: guindaste, Autômato tombado
	[2, 1, 1835, 700, Vector2(1835, 535), 0.0], [5, 1, 2380, 700, Vector2(2380, 535), 0.0],  # Fábrica: pórtico, tanque
	[3, 2, 2735, 700, Vector2(2735, 535), 0.0],                                              # Fábrica: coluna treliçada
	[4, 2, 5255, 770, Vector2(5255, 605), 0.0], [3, 1, 6200, 770, Vector2(6200, 605), 0.0]]  # Salão: galpão, chaminé alta
const ESTRUTURA_DEPTH := 0.85
const NEVOA := Color(0.93, 0.71, 0.53)   # cor do céu diurno na altura do horizonte
# DF206 (2×; médias: células 512 × 512, base em (256, 512); pequenas: 256 × 256, base em (128, 256)):
# [folha, coluna, linha, x da base, y da base]
const DECORACAO := [
	["media", 3, 2, 640, 700], ["media", 4, 2, 1430, 700],                         # Dunas: roda de trem, poste quebrado
	["pequena", 7, 2, 240, 700], ["pequena", 6, 2, 450, 700], ["pequena", 5, 2, 515, 700],
	["pequena", 4, 2, 752, 700], ["pequena", 6, 1, 1228, 700], ["pequena", 7, 2, 1475, 700],
	["media", 3, 1, 5060, 770], ["media", 5, 1, 5405, 770],                         # Salão (nada sobre a esteira)
	["media", 5, 2, 6110, 770], ["media", 1, 2, 6800, 770], ["media", 4, 2, 6935, 770],
	["pequena", 3, 1, 5130, 770], ["pequena", 3, 2, 5205, 770], ["pequena", 7, 1, 5300, 770],
	["pequena", 4, 1, 6185, 770], ["pequena", 2, 2, 6410, 770],
	["pequena", 4, 1, 8595, 770], ["pequena", 2, 1, 8850, 770]]                     # Saída (livre na fenda de retorno)
# DF207 (2×; células 512 × 768, fixação no topo (256, 0)): [coluna, linha, x, y da fixação]. A corrente (1, 1) é
# repetida acima da peça até o topo da fase, para nada ficar solto no ar.
const SUSPENSAS := [
	[3, 2, 2050, 150], [4, 1, 2700, 150], [2, 2, 3230, 90],                         # Fábrica: polia, mangueira, caçamba
	[1, 1, 3990, 30], [2, 1, 4540, -10], [3, 1, 5310, 220], [4, 2, 5700, 230], [1, 2, 6230, 290]]   # Salão
const TOPO := -80.0
const WALLS := [Rect2(-60,-200,60,1350), Rect2(6990,-200,60,780), Rect2(7050,-200,1440,350),
	Rect2(8490,-200,60,780), Rect2(8550,-200,350,600), Rect2(8900,-200,60,1350)]
const PITS := [Rect2(780,850,400,60), Rect2(2780,900,2200,60), Rect2(5490,900,540,60)]
const HOOKS := [Vector2(975,510), Vector2(3510,345), Vector2(4205,230)]
const ARENA_HOOKS := [Vector2(7400,470), Vector2(8080,470)]   # âncoras fixas do teto da Câmara (D04)
const MACHINES := [
	[true,780,1180,563], [false,1205,1620,700], [false,3125,3315,545],
	[false,3605,3980,415], [false,5010,5450,770], [true,6220,6540,635]]
# Câmara da Forja
const ROOM := Rect2(7050, 150, 1440, 620)      # interior: x 7050–8490, teto em y 150, chão em y 770
const DOOR_IN := Rect2(6990, 580, 60, 190)
const DOOR_OUT := Rect2(8490, 580, 60, 190)

## Desde 25/11/2026 o Deserto também é cena (scenes/fases/deserto.tscn, gerada por tools/gerar_cena_deserto.gd):
## com montada = true os nós já estão lá e _ligar() refaz as listas de máquinas pelos metadados de cada nó.
@export var montada := false
var level: Level
var clock := 0.0
var presses: Array = []
var carts: Array = []
var vents: Array = []
var wheel: Sprite2D
var saw: Sprite2D
var belt: Sprite2D
var flickering_lamp: Sprite2D
var lamps: Array = []        # [acesa, apagada, halo]
var ambient: Array = []      # [AnimatedSprite2D, período, fase] (faíscas DF209)
var dust_clock := 0.0
var doors := {}          # "in"/"out" → [corpo, fechada, aberta]
var forja: Forja = null


static func layout() -> Dictionary:
	var pickups := []
	var points := [Vector2(855,598),Vector2(975,510),Vector2(1100,589),Vector2(1775,658),
		Vector2(2250,563),Vector2(2940,572),Vector2(3220,490),Vector2(4100,326),
		Vector2(4290,316),Vector2(4790,365),Vector2(5760,708),Vector2(6410,718)]
	for i in points.size():
		pickups.append(["cell",points[i],"df_c%d" % i])
	pickups.append(["heal", Vector2(6560, 740), "df_h1"])
	pickups.append(["energy", Vector2(7120, 735), "", 9.0])     # Câmara: energia que reaparece (Pulso da fase 3)
	pickups.append(["energy", Vector2(8420, 735), "", 9.0])
	var hooks := [[HOOKS[0]],[HOOKS[1]],[HOOKS[2],125.0]]
	for h in ARENA_HOOKS:
		hooks.append([h, ROOM.position.y])
	return {"theme":"deserto","form":"automato","name":"DESERTO DE FERRUGEM","sub":"Ferrumgrado — Dunas de sucata",
		"bounds":Rect2(0,-80,8900,1140),"spawn":Vector2(185,690),"kill_y":1060.0,
		"solids":FLOOR + WALLS,     # paredes: Salão|Câmara (porta embaixo), teto da Câmara (y 150), Câmara|Saída, teto da saída, fim
		"hazards":[],"hooks":hooks,"enemies":[],
		"checkpoints":[Vector2(1650,700),Vector2(4730,415),Vector2(6650,770)],"terminals":[],"signs":[
			[Vector2(330,700), "AUTÔMATO: lento e pesado, não recua ao levar dano. Clique esquerdo (ou J) dispara a REBITADEIRA."],
			[Vector2(700,700), "F perto de uma argola ciano: o ÍMÃ DE FASE puxa você até ela. Pule no fim da puxada para ganhar impulso."],
			[Vector2(1320,700), "Sem âncora ao alcance, F puxa um drone até o chão. Clique direito (ou K) com 1/3 de energia: PULSO MAGNÉTICO."],
			[Vector2(6560,770), "IRIS: \"A energia do fragmento vem de trás desta porta. É o núcleo da fábrica.\""]],
		"pickups":pickups,
		"return_rift":Vector2(8720,770), "arrival_rift":Vector2(105,700),
		"rooms":[["A",Rect2(0,-80,1700,1140),"Dunas de sucata"],["B",Rect2(1700,-80,1880,1140),"Fábrica autônoma"],
		["C",Rect2(3580,-80,3410,1140),"Salão do Núcleo"],["D",Rect2(6990,150,1560,620),"Câmara da Forja"],
		["E",Rect2(8550,400,350,370),"Saída"]]}


static func texture(id: String) -> Texture2D:
	return load("res://assets/deserto/" + id + ".webp")


## Âncora de cada efeito v2 (pixels da célula 384 × 512 do original, como no ENTREGA_v2).
const FX_ANCORA := {"DF80": Vector2(192, 500), "DF81": Vector2(192, 500), "DF82": Vector2(192, 472),
	"DF83": Vector2(192, 472), "DF84": Vector2(192, 256), "DF85": Vector2(192, 256),
	"DF70": Vector2(192, 256), "DF71": Vector2(192, 256)}


## Folhas v2 do Deserto (DF60–DF85; grade 4 × 2 de 384 × 512, importadas em meia resolução por
## tools/import_deserto_v2_folhas.py): escala uniforme DFArt.NODE × sc, âncora do ENTREGA na origem do nó.
static func animation(id: String, count: int, fps: float, looped: bool, sc := 1.0) -> AnimatedSprite2D:
	var frames := SpriteFrames.new()
	DFArt.add_anim(frames, "default", id, range(count), fps, looped)
	var sprite := AnimatedSprite2D.new()
	sprite.sprite_frames = frames
	sprite.offset = DFArt.offset(Vector2(384, 512), FX_ANCORA.get(id, Vector2(192, 256)))
	sprite.scale = Vector2.ONE * DFArt.NODE * sc
	sprite.autoplay = "default"     # a cena guarda o autoplay; play() não é salvo
	sprite.play()
	return sprite


## Efeito com a âncora (FX_ANCORA) em pos; sc multiplica a escala do jogo por igual nos dois eixos.
static func effect(parent: Node, id: String, count: int, pos: Vector2, sc := 1.0, looped := false) -> AnimatedSprite2D:
	var sprite := animation(id,count,12.0,looped,sc)
	sprite.position = pos
	parent.add_child(sprite)
	if not looped:
		sprite.animation_finished.connect(sprite.queue_free)
	return sprite


func prop(id: String, rect: Rect2, depth := 0, parent: Node = self) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.texture = texture(id)
	sprite.position = rect.get_center()
	sprite.scale = rect.size / sprite.texture.get_size()
	sprite.z_index = depth
	parent.add_child(sprite)
	return sprite


func tile(id: String, rect: Rect2, factor: Vector2, depth := 0) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.centered = false
	sprite.texture = texture(id)
	sprite.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	sprite.region_enabled = true
	sprite.region_rect = Rect2(Vector2.ZERO,rect.size / factor)
	sprite.position = rect.position
	sprite.scale = factor
	sprite.z_index = depth
	add_child(sprite)
	return sprite


## --- Arte v2 (pacotes 3–10, aprovados em 25/11/2026). Tudo em escala uniforme: 2× → 0,5; DF204 → 0,4. ---

## Parede de fundo repetível (DF202, DF203) guardada em 2×: cobre rect, com a grade da textura presa a origin.
func wall_tile(path: String, rect: Rect2, origin: Vector2, depth := -14) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.centered = false
	sprite.texture = load(path)
	sprite.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	sprite.region_enabled = true
	sprite.region_rect = Rect2((rect.position - origin) * 2.0, rect.size * 2.0)
	sprite.position = rect.position
	sprite.scale = Vector2(0.5, 0.5)
	sprite.z_index = depth
	add_child(sprite)
	return sprite


## Peça v2 de um quadro, guardada em 2×, no retângulo de jogo da v0.8 (o PNG mede exatamente 2× o retângulo).
func prop_v2(id: String, rect: Rect2, depth := 0, parent: Node = self) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.texture = load(V2 + id + ".png")
	sprite.position = rect.get_center()
	sprite.scale = Vector2(0.5, 0.5)
	sprite.z_index = depth
	parent.add_child(sprite)
	return sprite


## Módulo v2 repetível (2×) cobrindo rect a 0,5: a trama começa no canto de cima à esquerda.
func tile_v2(id: String, rect: Rect2, depth := 0, parent: Node = self) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.centered = false
	sprite.texture = load(V2 + id + ".png")
	sprite.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	sprite.region_enabled = true
	sprite.region_rect = Rect2(Vector2.ZERO, rect.size * 2.0)
	sprite.position = rect.position
	sprite.scale = Vector2(0.5, 0.5)
	sprite.z_index = depth
	parent.add_child(sprite)
	return sprite


## Peça v2 (2×) com o ponto anchor (pixels do PNG) em pos, escala 0,5.
func peca_v2(id: String, anchor: Vector2, pos: Vector2, depth := 0, parent: Node = self) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.texture = load(V2 + id + ".png")
	sprite.centered = false
	sprite.offset = -anchor
	sprite.position = pos
	sprite.scale = Vector2(0.5, 0.5)
	sprite.z_index = depth
	parent.add_child(sprite)
	return sprite


## Uma célula de atlas (grade fixa, sem cortar rente ao desenho) com o ponto anchor da célula em pos.
func atlas(path: String, grid: Vector2i, i: int, anchor: Vector2, pos: Vector2, depth := 0, sc := 0.5, parent: Node = self) -> Sprite2D:
	var t: Texture2D = load(path)
	var cell := t.get_size() / Vector2(grid)
	var a := AtlasTexture.new()
	a.atlas = t
	a.region = Rect2(Vector2(i % grid.x, i / grid.x) * cell, cell)
	var sprite := Sprite2D.new()
	sprite.texture = a
	sprite.centered = false
	sprite.offset = -anchor
	sprite.position = pos
	sprite.scale = Vector2(sc, sc)
	sprite.z_index = depth
	parent.add_child(sprite)
	return sprite


## Cabo DF28 v2 entre dois pontos: a trama (512 × 32, 2×) se repete ao longo do eixo, com a espessura da escala.
func cable_v2(a: Vector2, b: Vector2, sc: float, depth := -4) -> Sprite2D:
	var t: Texture2D = load(V2 + "DF28_cabo_v2.png")
	var sprite := Sprite2D.new()
	sprite.texture = t
	sprite.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	sprite.region_enabled = true
	sprite.region_rect = Rect2(0, 0, a.distance_to(b) / sc, t.get_height())
	sprite.centered = false
	sprite.offset = Vector2(0, -t.get_height() / 2.0)     # eixo do cabo na linha entre os pontos
	sprite.position = a
	sprite.rotation = (b - a).angle()
	sprite.scale = Vector2(sc, sc)
	sprite.z_index = depth
	add_child(sprite)
	return sprite


## Halo DF209 (um quadro, centro na célula, aditivo) no bulbo de uma lâmpada.
func halo_v2(pos: Vector2) -> Sprite2D:
	var h := atlas(V2 + "DF209_brilho_lampada.png", Vector2i(4, 1), 0, Vector2(128, 128), pos, -2)
	var m := CanvasItemMaterial.new()
	m.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	h.material = m
	return h


## Animação de uma folha DF209 (células 256 × 256 em 4 colunas, âncora no centro), escala 0,5.
func anim_v2(path: String, rows: int, n: int, fps: float, looped: bool, pos: Vector2, depth := 0) -> AnimatedSprite2D:
	var t: Texture2D = load(path)
	var sf := SpriteFrames.new()
	sf.set_animation_speed("default", fps)
	sf.set_animation_loop("default", looped)
	for i in n:
		var a := AtlasTexture.new()
		a.atlas = t
		a.region = Rect2(Vector2(i % 4, i / 4) * 256.0, Vector2(256, 256))
		sf.add_frame("default", a)
	var s := AnimatedSprite2D.new()
	s.sprite_frames = sf
	s.position = pos
	s.scale = Vector2(0.5, 0.5)
	s.z_index = depth
	s.autoplay = "default"
	add_child(s)
	s.play()
	return s


func _build_v2_scenery() -> void:
	var camada := DFCamada.new()
	camada.depth = ESTRUTURA_DEPTH
	camada.z_index = -13
	level.add_child(camada)
	level.bg_layers.append(camada)
	for e in ESTRUTURAS:
		var cam: Vector2 = e[4]
		var pos := Vector2(float(e[2]) - cam.x * (1.0 - ESTRUTURA_DEPTH), float(e[3]) + 30.0 - cam.y * (1.0 - ESTRUTURA_DEPTH))
		var sp := atlas(V2 + "DF204_estrutura.png", Vector2i(5, 2), (e[1] - 1) * 5 + e[0] - 1, Vector2(512, 1536),
			pos, 0, 0.4, camada)
		if e[5] > 0.0:
			sp.material = _nevoa(e[5])
	for d in DECORACAO:
		var media: bool = d[0] == "media"
		atlas(V2 + "DF206_%s.png" % d[0], Vector2i(5, 2) if media else Vector2i(7, 2),
			(d[2] - 1) * (5 if media else 7) + d[1] - 1, Vector2(256, 512) if media else Vector2(128, 256),
			Vector2(d[3], d[4]), -2)
	for h in SUSPENSAS:
		var x: float = h[2]
		var y: float = h[3]
		atlas(V2 + "DF207_moldura.png", Vector2i(4, 2), (h[1] - 1) * 4 + h[0] - 1, Vector2(256, 0), Vector2(x, y), -9)
		# corrente (célula 1, 1: 251 px de jogo) por cima até o topo da fase
		var cy := y
		while cy > TOPO:
			cy -= 250.0
			atlas(V2 + "DF207_moldura.png", Vector2i(4, 2), 0, Vector2(256, 0), Vector2(x, cy), -9)
	# DF208: primeiro plano escuro só na frente dos pisos largos (nunca sobre fossos, Câmara ou Saída)
	for seg in [[-120.0, 780.0, 700.0, false], [1180.0, 1495.0, 700.0, false], [1760.0, 2720.0, 700.0, true],
			[4980.0, 5490.0, 770.0, true], [6030.0, 6990.0, 770.0, true]]:
		var t: Texture2D = load(V2 + ("DF208_primeiro_plano_interior.png" if seg[3] else "DF208_primeiro_plano.png"))
		var fg := Sprite2D.new()
		fg.texture = t
		fg.centered = false
		fg.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		fg.region_enabled = true
		fg.region_rect = Rect2(seg[0] * 2.0, 0, (seg[1] - seg[0]) * 2.0, t.get_height())
		fg.position = Vector2(seg[0], seg[2] + 190.0 - t.get_height() * 0.5)   # base 190 px abaixo do piso
		fg.scale = Vector2(0.5, 0.5)
		fg.z_index = 30
		add_child(fg)
	# DF209: vapor ambiente nas frestas (8 quadros em ciclo) e faíscas de solda (6 quadros, em intervalos)
	for v in [Vector2(2395, 548), Vector2(6150, 352)]:
		anim_v2(V2 + "DF209_vapor.png", 2, 8, 6.25, true, v, -3)
	for f in [[Vector2(6790, 650), 2.6, 0.0], [Vector2(5132, 655), 3.4, 1.1]]:
		var sp := anim_v2(V2 + "DF209_faiscas.png", 2, 6, 12.5, false, f[0], 2)
		sp.visible = false
		ambient.append([sp, f[1], f[2]])


## Névoa do exterior: aproxima a peça da cor do horizonte, para ela recuar atrás do plano do jogo.
func _nevoa(amount: float) -> ShaderMaterial:
	var sh := Shader.new()
	sh.code = "shader_type canvas_item;\nuniform vec4 nevoa : source_color;\nuniform float quanto;\n" + \
		"void fragment() { COLOR.rgb = mix(COLOR.rgb, nevoa.rgb, quanto); }"
	var m := ShaderMaterial.new()
	m.shader = sh
	m.set_shader_parameter("nevoa", NEVOA)
	m.set_shader_parameter("quanto", amount)
	return m


## Tirante DF205 (16 px de jogo, repetível na vertical) de y0 a y1 em x: o que pende do alto mostra de onde pende.
func rod(x: float, y0: float, y1: float, depth := -5, parent: Node = self) -> Sprite2D:
	var t: Texture2D = load("res://assets/deserto/terreno/tirante.png")
	var sprite := Sprite2D.new()
	sprite.texture = t
	sprite.centered = false
	sprite.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	sprite.region_enabled = true
	sprite.region_rect = Rect2(0, 0, t.get_width(), (y1 - y0) * 2.0)
	sprite.position = Vector2(roundf(x - t.get_width() / 4.0), y0)
	sprite.scale = Vector2(0.5, 0.5)
	sprite.z_index = depth
	parent.add_child(sprite)
	return sprite


func _ambient(_dt: float) -> void:
	for a in ambient:
		var sp: AnimatedSprite2D = a[0]
		var ph := fmod(clock + float(a[2]), float(a[1]))
		if ph < _dt * 1.01 + 0.0001 or (not sp.visible and ph < 0.05):
			if not sp.visible or not sp.is_playing():
				sp.visible = true
				sp.frame = 0
				sp.play()
		if sp.visible and not sp.is_playing():
			sp.visible = false


func attack_area(rect: Rect2, parent: Node, pit := false) -> Area2D:
	var area := Area2D.new()
	area.collision_layer = 32 if pit else 16
	area.collision_mask = 0
	area.monitoring = false
	area.add_to_group("hazard" if pit else "enemy_attack", true)    # persistente: vai junto na cena
	var shape := CollisionShape2D.new()
	var box := RectangleShape2D.new()
	box.size = rect.size
	shape.shape = box
	area.position = rect.get_center()
	area.add_child(shape)
	parent.add_child(area)
	return area


func _ready() -> void:
	if montada:
		_ligar()
	else:
		_montar()
	var done: bool = level.main.boss_done.has("deserto")
	set_door("in", true)
	set_door("out", done and level.main.frags.has("deserto"))


## Cena: refaz as listas que _physics_process usa a partir dos metadados gravados por _montar().
func _ligar() -> void:
	var vlist := []
	for c in get_children():
		if c.has_meta("prensa"):
			var m: Array = c.get_meta("prensa")
			presses.append([c, get_node(m[0]), m[1], m[2], m[3], false])
		if c.has_meta("carrinho"):
			var m: Array = c.get_meta("carrinho")
			carts.append([c, m[0], m[1]])
		if c.has_meta("valvula"):
			var m: Array = c.get_meta("valvula")
			vlist.append([m[0], [c, get_node(m[1]), get_node(m[2])]])
		if c.has_meta("lampada"):
			var m: Array = c.get_meta("lampada")
			lamps.append([c, get_node(m[0]), get_node(m[1])])
		if c.has_meta("faisca"):
			var m: Array = c.get_meta("faisca")
			ambient.append([c, m[0], m[1]])
		if c.has_meta("porta"):
			var m: Array = c.get_meta("porta")
			doors[m[0]] = [get_node(m[1]), get_node(m[2]), get_node(m[3])]
		if c.has_meta("engrenagem"):
			wheel = c
		if c.has_meta("serra"):
			saw = c
		if c.has_meta("esteira"):
			belt = c
		if c.has_meta("piscante"):
			flickering_lamp = c
	vlist.sort_custom(func(a, b): return a[0] < b[0])
	for v in vlist:
		vents.append(v[1])
	# a Forja-Mãe monta as próprias peças (e as válvulas da Câmara no Deserto): entra como no código, por último
	forja = Forja.new()
	forja.name = "ForjaMae"
	forja.level = level
	forja.desert = self
	add_child(forja)


## Código: monta o cenário, as máquinas e a Forja (também usado para gerar a cena).
func _montar() -> void:
	for i in 3:
		var bg := VerdBg.new()
		bg.tex = texture("DF%d" % (10+i))
		bg.depth = [0.06,0.20,0.38][i]
		if i > 0 and ResourceLoader.exists(MID[i - 1]):
			# DF201 (DA-03): escala 1; linha de base 490 do arquivo em y MID_BASE da camada.
			# 0,20: cópia única, coluna 686 no x 0; 0,38: repete a cada 2.560 px, sem espelhar
			bg.tex = load(MID[i - 1])
			var base: float = MID_BASE[i - 1]
			if i == 1:
				bg.place(1.0, Vector2(-686.0, base - 490.0))
			else:
				bg.place(1.0, Vector2(0.0, base - 490.0), true, Vector2(580.0 * bg.depth - 1100.0, 8320.0 * bg.depth + 1100.0))
		elif i == 0 and ResourceLoader.exists(SKY):
			# DF200 (DA-03): imagem inteira a 0,645, sem espelhar; coluna 1.020 do arquivo no x 0 da camada e
			# linha 720 no y 30, para o centro da câmera correr entre x 1.070 e 1.490 e a faixa útil ser 210–1.230
			bg.tex = load(SKY)
			bg.place(SKY_SCALE, Vector2(-SKY_ORIGIN.x * SKY_SCALE, 30.0 - SKY_ORIGIN.y * SKY_SCALE))
		else:
			bg.fit(Vector2(1500,860),Vector2(580,8320),Vector2(248,732),[1.7,0.8,0.8][i])   # céu largo: um sol só na tela
		bg.z_index = -60 + i
		level.add_child(bg)
		level.bg_layers.append(bg)
	tile("DF22",Rect2(1495,170,205,530),Vector2(0.55,0.55),-14)     # fachada da Fábrica: ainda a da v0.8
	# DF202 e DF203 (2×, repetíveis): Fábrica a partir de (1700, −80), Salão a partir de (3580, −80) e na Saída,
	# Câmara inteira em (7050, 150)
	wall_tile(FUNDO + "DF202_fabrica.png", Rect2(1700,-80,1880,1090), Vector2(1700,-80))
	wall_tile(FUNDO + "DF202_salao.png", Rect2(3580,-80,3410,1150), Vector2(3580,-80))
	wall_tile(FUNDO + "DF203_camara.png", Rect2(7050,150,1440,620), Vector2(7050,150))
	wall_tile(FUNDO + "DF202_salao.png", Rect2(8550,400,350,390), Vector2(3580,-80))
	_build_v2_scenery()
	# terreno DF205 (DA-03): só desenho; as colisões são as de layout()
	var terrain := DFTerrain.new()
	for r in FLOOR + WALLS:
		if r.size.y < 60.0:
			terrain.thin.append(r)
		else:
			terrain.blocks.append(r)
	terrain.pits = PITS
	terrain.suspended = [FLOOR[5], FLOOR[6]]
	add_child(terrain)
	for r in FLOOR:
		if r.position.x == 1700:
			belt = tile_v2("DF26_esteira_v2",Rect2(r.position,Vector2(r.size.x,60)))     # DF222: apoio na linha 0
		elif r.position.x == 2870 or r.position.x == 3100:
			# DF53: só as correntes (a laje da arte antiga dá lugar ao tabuleiro da DF205); terminam no apoio
			var large: bool = r.position.x == 3100
			var chains := prop("DF53b" if large else "DF53a",Rect2(r.position-Vector2(0,135),Vector2(r.size.x,157)),-1)
			var slab: float = DF53_SLAB[1] if large else DF53_SLAB[0]
			var full := chains.texture.get_size()
			chains.region_enabled = true
			chains.region_rect = Rect2(0, 0, full.x, slab)
			chains.scale = Vector2(r.size.x / full.x, 135.0 / slab)
			chains.position = Vector2(r.get_center().x, r.position.y - 135.0 / 2.0)
			for f in ([0.167, 0.83] if large else [0.13, 0.865]):    # as correntes continuam em tirantes até o alto
				rod(r.position.x + r.size.x * f, TOPO, r.position.y - 133.0, -2)
	for pit in PITS:
		attack_area(pit,self,true)
	# DF206: as duas sucatas médias substituem DF30_1 e DF30_2 no mesmo lugar e tamanho (155 × 76 e 110 × 56)
	atlas(V2 + "DF206_media.png", Vector2i(5, 2), 0, Vector2(256, 512), Vector2(362, 700), -2)
	atlas(V2 + "DF206_media.png", Vector2i(5, 2), 1, Vector2(256, 512), Vector2(1295, 700), -2)
	# DF220 (2×): mesmos retângulos de jogo da v0.8, agora com escala uniforme 0,5
	prop_v2("DF31_mastro_viga_v2",Rect2(686,463,310,237),-2)     # olhal em (578, 34) → (975, 480): o DF57 pende dali
	prop_v2("DF32_chamine_v2",Rect2(1530,44,72,128),-2)
	effect(self,"DF80",6,Vector2(1566,50),1.3,true)    # base da fumaça na boca da chaminé
	prop_v2("DF33_porta_fabrica_v2",Rect2(1550,525,140,175),-2)
	wheel = prop_v2("DF34_engrenagem_fundo_v2",Rect2(2220,250,320,320),-8)   # pivô (320, 320) = centro
	prop_v2("DF35_abertura_parede_v2",Rect2(3460,226,140,190),-6)
	prop_v2("DF36_torre_nucleo_v2",Rect2(4700,-15,298,785),-10)   # cabos presos em (240, 174) → (4820, 72)
	for x in [3710,4580]:
		cable_v2(Vector2(x,415), Vector2(4820,72), 0.5, -4)
	# DF221: lâmpada 38 × 69 com o fio no centro de cima; acesa e apagada no mesmo lugar; halo DF209 junto
	for x in [1870,2640,5180,5830,6410,7075,8455]:
		var top := -80.0 if x < 7050 else 150.0
		var lamp_rect := Rect2(x,top+232,38,69)
		cable_v2(Vector2(x+19,top), Vector2(x+19,top+233), 0.25, -5)
		var off := prop_v2("DF37b_lampada_apagada_v2",lamp_rect,-4)
		var on := prop_v2("DF37_lampada_v2",lamp_rect,-3)
		var halo := halo_v2(Vector2(x+19,top+232+60))
		lamps.append([on, off, halo])
		if x == 6410:
			flickering_lamp = on
	prop_v2("DF39_painel_v2",Rect2(5100,630,65,90),-4)
	prop_v2("DF39b_canos_v2",Rect2(5960,333,240,120),-5)
	# DF222: pontas imóveis, pivô (60, 60) no centro do rolo
	peca_v2("DF26b_esteira_ponta_esq_v2",Vector2(60,60),Vector2(1730,730),1)
	peca_v2("DF26c_esteira_ponta_dir_v2",Vector2(60,60),Vector2(2750,730),1)
	# DF224: o gancho entra pela argola (38, 73 do PNG) na âncora lógica; o topo fica 36,5 px acima
	for hook in HOOKS + ARENA_HOOKS:
		peca_v2("DF57_ponto_gancho_v2",Vector2(38,73),hook,3)
		# a do mastro pende do olhal da DF31; a da abertura da Fábrica, da verga da DF35; as outras, do teto
		if hook == HOOKS[1]:
			rod(hook.x, 238.0, hook.y - 35.0, 2)
		elif hook != HOOKS[0]:
			rod(hook.x, ROOM.position.y if hook.x > ROOM.position.x else TOPO, hook.y - 35.0, 2)
	make_press(1950,700,false,0.0)
	make_press(2540,700,false,1.25)
	make_press(4500,415,true,0.8)
	# DF223: base apoiada no piso (700); o eixo da serra (70, 70) no encaixe da base (80, 0)
	peca_v2("DF52b_serra_base_v2",Vector2(80,0),Vector2(2250,668))
	saw = peca_v2("DF52_serra_v2",Vector2(70,70),Vector2(2250,668),1)
	attack_area(Rect2(2225,642,50,55),self)
	tile_v2("DF27_trilho_vertical_v2",Rect2(4875,415,74,365),-3)
	make_cart(Vector2(4860,415),Vector2(0,355),true)
	tile_v2("DF55b_trilho_horizontal_v2",Rect2(5480,650,560,16),-2)
	make_cart(Vector2(5490,770),Vector2(430,0),false)
	for x in [6290,6520]:
		var r := Rect2(x-36,759,72,12)
		prop_v2("DF56_valvula_inativa_v2",r)
		var lamp := prop_v2("DF56_valvula_aviso_v2",r,1)
		var jet := effect(self,"DF81",8,Vector2(x,764),1.5,true)     # sai da válvula e cobre a área de dano
		var hit := attack_area(Rect2(x-22,634,44,136),self)
		vents.append([lamp,jet,hit])
	_make_door("in", DOOR_IN)
	_make_door("out", DOOR_OUT)
	for i in MACHINES.size():
		if level.main.collected.has("df_enemy%d" % i):
			continue
		var machine := DesertEnemy.new()
		machine.level = level
		machine.pid = "df_enemy%d" % i
		machine.drone = MACHINES[i][0]
		machine.patrol = Vector2(MACHINES[i][1],MACHINES[i][2])
		machine.position = Vector2(machine.patrol.x,MACHINES[i][3])
		level.entities.add_child.call_deferred(machine)
	forja = Forja.new()
	forja.level = level
	forja.desert = self
	add_child(forja)
	gravar_metas()


## Metadados que _ligar() lê na cena: o papel de cada nó animado e os caminhos dos nós ligados a ele.
## O gerador da cena chama de novo depois de dar nome aos nós (os caminhos dependem dos nomes).
func gravar_metas() -> void:
	wheel.set_meta("engrenagem", true)
	saw.set_meta("serra", true)
	belt.set_meta("esteira", true)
	flickering_lamp.set_meta("piscante", true)
	for pr in presses:
		pr[0].set_meta("prensa", [get_path_to(pr[1]), pr[2], pr[3], pr[4]])
	for ct in carts:
		ct[0].set_meta("carrinho", [ct[1], ct[2]])
	for i in vents.size():
		vents[i][0].set_meta("valvula", [i, get_path_to(vents[i][1]), get_path_to(vents[i][2])])
	for l in lamps:
		l[0].set_meta("lampada", [get_path_to(l[1]), get_path_to(l[2])])
	for a in ambient:
		a[0].set_meta("faisca", [a[1], a[2]])
	for k in doors:
		var d: Array = doors[k]
		d[0].get_parent().set_meta("porta", [k, get_path_to(d[0]), get_path_to(d[1]), get_path_to(d[2])])


## Porta DF38 com colisão: aberta, o jogador passa; fechada, bloqueia.
func _make_door(key: String, r: Rect2) -> void:
	var body := StaticBody2D.new()
	body.collision_layer = 1
	body.collision_mask = 0
	var cs := CollisionShape2D.new()
	var box := RectangleShape2D.new()
	box.size = r.size
	cs.shape = box
	cs.position = r.get_center()
	body.add_child(cs)
	add_child(body)
	var art := Rect2(r.get_center().x - 75, r.position.y, 150, r.size.y)
	var closed := prop_v2("DF38_porta_fechada_v2", art, 1)     # DF225: 300 × 380 a 2×, base no chão
	var open := prop_v2("DF38_porta_aberta_v2", art, -3)
	doors[key] = [cs, closed, open]


func set_door(key: String, opened: bool) -> void:
	var d: Array = doors[key]
	d[0].set_deferred("disabled", opened)
	d[1].visible = not opened
	d[2].visible = opened


func door_open(key: String) -> bool:
	return doors[key][0].disabled


func on_fragment_taken() -> void:
	set_door("out", true)
	set_door("in", true)
	AudioMgr.sfx("porta", Vector2(8520, 700), 0.0, 0.0)


func make_cart(start: Vector2, travel: Vector2, vertical: bool) -> void:
	var body := AnimatableBody2D.new()
	body.position = start
	body.collision_layer = 1
	body.collision_mask = 0
	var w := 120.0
	var shape := CollisionShape2D.new()
	var box := RectangleShape2D.new()
	box.size = Vector2(w,16)
	shape.shape = box
	shape.position = box.size / 2.0
	body.add_child(shape)
	add_child(body)
	var r := Rect2(0,0,w,24) if vertical else Rect2(0,-112,w,132)
	prop_v2("DF54_elevador_v2" if vertical else "DF55_carrinho_v2",r,1,body)     # DF224: rodas no trilho, piso em 0
	carts.append([body,start,travel])


func make_press(x: int, ground: int, small: bool, phase: float) -> void:
	var id := "DF51%s_prensa_pequena_%s_v2" if small else "DF50%s_prensa_%s_v2"     # DF223
	var width := 70 if small else 106
	prop_v2(id % ["c", "suporte"],Rect2(x-width/2.0,ground-219,width,35),2)
	for dx in [-width * 0.3, width * 0.3]:      # o suporte pende de dois tirantes até o alto
		rod(x + dx, TOPO, ground - 216.0, 1)
	var rod := tile_v2(id % ["b", "haste"],Rect2(x-10,ground-190,20,175))
	var root := Node2D.new()
	add_child(root)
	prop_v2(id % ["a", "cabeca"],Rect2(-width/2.0,-30,width,30),2,root)
	attack_area(Rect2(-width/2.0,-26,width,26),root)
	presses.append([root,rod,x,ground,phase,false])


## Jatos das válvulas atingem também os inimigos (o drone puxado pelo ímã até a válvula explode, D03).
func vent_hits(pos: Vector2) -> bool:
	for v in vents:
		var hit: Area2D = v[2]
		if hit.collision_layer != 0 and absf(pos.x - hit.position.x) < 30.0 and pos.y > 670.0:
			return true
	return false


func _physics_process(dt: float) -> void:
	clock += dt
	flickering_lamp.visible = fmod(clock,3.4) > 0.11
	for l in lamps:
		l[2].visible = l[0].visible       # halo só com a lâmpada acesa
	_ambient(dt)
	wheel.rotation = clock * 0.13
	saw.rotation = clock * 5.5
	belt.region_rect.position.x = -clock * 130     # 65 px/s no jogo, a mesma velocidade que empurra
	var p := level.player
	if not is_instance_valid(p):
		return
	if p.is_on_floor() and p.position.x > 1700 and p.position.x < 2780 and absf(p.position.y-700)<5:
		p.move_and_collide(Vector2(65*dt,0))
	for press in presses:
		var phase := fmod(clock + float(press[4]),3.2)
		var down := smoothstep(1.4,1.74,phase) * (1.0-smoothstep(2.02,2.9,phase))
		var y := float(press[3]) - 160*(1-down)
		press[0].position = Vector2(press[2],y)
		press[1].region_rect.size.y = maxf(1,y-22-press[1].position.y)/press[1].scale.y
		if down > 0.99 and not press[5]:
			effect(self,"DF82",6,Vector2(press[2],press[3]),1.5)
		press[5] = down > 0.99
	for cart in carts:
		cart[0].position = cart[1] + cart[2] * (0.5-0.5*cos(clock*TAU/5.5))
	for i in vents.size():
		var phase := fmod(clock+i*1.8,3.6)
		var v: Array = vents[i]
		v[0].visible = phase >= 1.45 and phase < 2.15
		v[1].visible = phase >= 2.15 and phase < 2.95
		v[1].pause()
		v[1].frame = clampi(int((phase-2.15)*10),0,7)
		v[2].collision_layer = 16 if v[1].visible and v[1].frame in [2,3,4,5] else 0
	dust_clock -= dt
	if dust_clock < 0 and p.position.x < 1500:
		dust_clock = 0.38
		# DF209: um grão por célula (8 variantes), escala 0,5, em rajadas
		var dust := atlas(V2 + "DF209_poeira.png", Vector2i(4, 2), randi_range(0, 7), Vector2(128, 128),
			p.position+Vector2(randf_range(-450,450),randf_range(-270,-25)), 6)
		var drift := create_tween()
		drift.tween_property(dust,"position:x",dust.position.x+125,1.1)
		drift.tween_callback(dust.queue_free)
