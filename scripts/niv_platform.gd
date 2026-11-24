@tool
class_name NivPlatform
extends AnimatableBody2D
## Plataformas atravessáveis de Nivária (one-way), com arte provisória desenhada por código (paleta GL00):
##  "gelo"     – placa de gelo suspensa; o brilho roxo embaixo é a fratura que a mantém no ar (lore da proposta)
##  "movel"    – placa de gelo que vai e volta
##  "elevador" – plataforma de metal das estações, pendurada em cabos (a viga fica no Nivaria)
##  "quebradica" – placa de gelo que racha quando o Yeti pisa, cai e volta depois de alguns segundos
## Gelo, móvel e quebradiça usam a arte de assets/nivaria/props (tools/import_nivaria_props.py).
## A posição do nó é o meio da borda de cima (onde Daymon pisa), no ponto de partida.

@export_enum("gelo", "movel", "elevador", "quebradica") var kind := "gelo":
	set(v):
		kind = v
		_refresh()
@export var largura := 130.0:
	set(v):
		largura = v
		_refresh()
@export var altura := 20.0:
	set(v):
		altura = v
		_refresh()
## Quanto a plataforma anda a partir da posição inicial (só "movel" e "elevador"); vai e volta.
@export var travel := Vector2.ZERO:
	set(v):
		travel = v
		_refresh()
## Segundos de uma ida e volta completa.
@export var period := 4.0

var rect := Rect2()
var start := Vector2.ZERO
var t := 0.0
var icicles: Array = []

const TEX_GELO := "res://assets/nivaria/props/plat_gelo.png"
const TEX_QUEBRA := "res://assets/nivaria/props/plat_quebra.png"
const QUEBRA_FRAME := Vector2(813, 199)
const ESPESSURA := 1.35        # a arte é fina demais na proporção original
const RACHA := 0.5             # segundos rachando antes de cair
const VOLTA := 2.6             # segundos sumida antes de voltar

var level                      # Level (o Nivaria preenche)
var tex: Texture2D
var cs: CollisionShape2D
var glow: Sprite2D
var state := 0                 # quebradiça: 0 inteira · 1 rachando · 2 caindo · 3 sumida · 4 voltando
var st := 0.0


func _ready() -> void:
	_refresh()
	if Engine.is_editor_hint():
		set_notify_transform(true)
		return
	collision_layer = 256   # camada das plataformas atravessáveis
	collision_mask = 0
	z_index = 1
	start = position
	# como no SpritePlatform: sync_to_physics ANTES da posição, senão a plataforma vai para (0,0)
	sync_to_physics = kind == "movel" or kind == "elevador"
	position = start
	cs = CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = rect.size
	cs.shape = r
	cs.position = Vector2(0, rect.size.y / 2.0)
	cs.one_way_collision = true
	cs.one_way_collision_margin = 8.0
	add_child(cs)
	if kind != "elevador":
		glow = Art.glow(Color(0.7, 0.42, 0.92, 0.28), rect.size.x * 0.55)
		glow.position = Vector2(0, rect.size.y + 26)
		add_child(glow)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED and Engine.is_editor_hint():
		_refresh()


func _refresh() -> void:
	rect = Rect2(position - Vector2(largura / 2.0, 0), Vector2(largura, altura))
	icicles.clear()
	var rng := RandomNumberGenerator.new()
	rng.seed = int(rect.position.x * 7 + rect.position.y)
	var x := -largura / 2.0 + rng.randf_range(10, 20)
	while x < largura / 2.0 - 10:
		icicles.append(Vector3(x, rng.randf_range(8, 14), rng.randf_range(14, 32)))
		x += rng.randf_range(18, 34)
	queue_redraw()


func _physics_process(dt: float) -> void:
	if Engine.is_editor_hint():
		return
	if kind == "quebradica":
		_crumble(dt)
		return
	if kind == "gelo":
		return
	t += dt
	position = start + travel * (0.5 - 0.5 * cos(t / period * TAU))


func _draw() -> void:
	if Engine.is_editor_hint() and travel != Vector2.ZERO:
		# no editor: até onde a plataforma vai
		draw_dashed_line(Vector2.ZERO, travel, Color(1, 1, 1, 0.5), 2.0, 10.0)
		draw_rect(Rect2(travel - Vector2(largura / 2.0, 0), Vector2(largura, altura)), Color(1, 1, 1, 0.5), false, 2.0)
	var w := largura
	var h := altura
	if kind == "elevador":
		draw_rect(Rect2(-w / 2, 0, w, h), Nivaria.C_METAL[0])
		draw_rect(Rect2(-w / 2, 0, w, 5), Nivaria.C_METAL[1])
		draw_line(Vector2(-w / 2, 0), Vector2(w / 2, 0), Nivaria.C_METAL[2], 2.0)
		for x in [-60.0, 60.0]:
			draw_circle(Vector2(x, 2), 4.0, Nivaria.C_METAL[2])
		var px := -w / 2 + 10.0
		while px < w / 2 - 6:
			draw_line(Vector2(px, h), Vector2(px - 6, h + 8), Nivaria.C_METAL[0], 3.0)
			px += 20.0
		return
	if _draw_sprite(w):
		return
	var body := PackedVector2Array([Vector2(-w / 2, 0), Vector2(w / 2, 0), Vector2(w / 2 - 6, h), Vector2(-w / 2 + 6, h)])
	draw_colored_polygon(body, Nivaria.C_GELO[1])
	draw_rect(Rect2(-w / 2 + 4, 6, w - 8, 4), Color(Nivaria.C_GELO[2], 0.55))
	for ic: Vector3 in icicles:
		draw_colored_polygon(PackedVector2Array([Vector2(ic.x - ic.y / 2, h - 1), Vector2(ic.x + ic.y / 2, h - 1), Vector2(ic.x, h + ic.z)]), Nivaria.C_GELO[0])
		draw_line(Vector2(ic.x - ic.y / 5, h), Vector2(ic.x, h + ic.z * 0.7), Color(Nivaria.C_GELO[2], 0.6), 1.5)
	# camada fina de neve no topo
	draw_rect(Rect2(-w / 2 + 2, -4, w - 4, 6), Nivaria.C_NEVE[2])
	draw_line(Vector2(-w / 2 + 2, 2), Vector2(w / 2 - 2, 2), Nivaria.C_NEVE[1], 2.0)
	draw_circle(Vector2(-w / 2 + 4, -1), 4.0, Nivaria.C_NEVE[2])
	draw_circle(Vector2(w / 2 - 4, -1), 4.0, Nivaria.C_NEVE[2])


## Arte das placas de gelo (inteira ou quadro da quebradiça). Devolve false se a imagem ainda não existe.
func _draw_sprite(w: float) -> bool:
	var path := TEX_QUEBRA if kind == "quebradica" else TEX_GELO
	if tex == null or tex.resource_path != path:
		tex = load(path) if ResourceLoader.exists(path) else null
	if tex == null:
		return false
	if kind != "quebradica":
		var th := w * tex.get_height() / tex.get_width() * ESPESSURA
		draw_texture_rect(tex, Rect2(-w * 0.51, -4, w * 1.02, th), false)
		return true
	var frame := 0
	var drop := 0.0
	var a := 1.0
	var shake := 0.0
	match state:
		1:
			frame = mini(3, int(st / RACHA * 4.0))
			shake = sin(st * 70.0) * 1.5
		2:
			frame = 4 if st < 0.16 else 5
			drop = st * st * 700.0
			a = clampf(1.0 - st / 0.45, 0.0, 1.0)
		3:
			return true
		4:
			a = clampf(st / 0.3, 0.0, 1.0)
	var fh := w * QUEBRA_FRAME.y / QUEBRA_FRAME.x * ESPESSURA
	draw_texture_rect_region(tex, Rect2(-w * 0.51 + shake, -4 + drop, w * 1.02, fh),
		Rect2(frame * QUEBRA_FRAME.x, 0, QUEBRA_FRAME.x, QUEBRA_FRAME.y), Color(1, 1, 1, a))
	return true


## Quebradiça: racha quando o jogador para em cima, cai, some e volta (se não houver ninguém no lugar).
func _crumble(dt: float) -> void:
	st += dt
	match state:
		0:
			if _player_on():
				state = 1
				st = 0.0
				AudioMgr.sfx("caixa_quebra", global_position, -10.0, 0.2)
		1:
			if st >= RACHA:
				state = 2
				st = 0.0
				cs.set_deferred("disabled", true)
				AudioMgr.sfx("caixa_quebra", global_position, -2.0, 0.1)
				if level != null:
					Fx.burst(level.fx, global_position + Vector2(0, 8), Color(0.65, 0.88, 1.0, 0.9), 14, 200, 0.5, 0.06, 420)
		2:
			if st >= 0.45:
				state = 3
				st = 0.0
		3:
			if st >= VOLTA and not _player_near():
				state = 4
				st = 0.0
				cs.set_deferred("disabled", false)
		4:
			if st >= 0.3:
				state = 0
				st = 0.0
	if glow != null:
		glow.visible = state < 2 or state == 4
	queue_redraw()


func _player_on() -> bool:
	var p = level.player if level != null else null
	if p == null or not is_instance_valid(p) or p.dead or not p.is_on_floor():
		return false
	var d: Vector2 = p.global_position - global_position
	return absf(d.y) < 6.0 and absf(d.x) < largura / 2.0 + 14.0


func _player_near() -> bool:
	var p = level.player if level != null else null
	if p == null or not is_instance_valid(p):
		return false
	var d: Vector2 = p.global_position - global_position
	return absf(d.x) < largura / 2.0 + 30.0 and d.y > -10.0 and d.y < 90.0
