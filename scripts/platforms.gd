class_name SpritePlatform
extends AnimatableBody2D
## Plataformas atravessáveis por baixo (one-way), com arte:
##  "suspensa"  – presa ao teto por correntes (hang_y = altura do teto)
##  "movel"     – flutuante, vai e volta sobre um trilho; com sid fica parada até ser ativada
##  "quebravel" – presa por correntes; desmorona ~0,5 s após pisada e volta depois

var kind := "suspensa"
var rect := Rect2()
var travel := Vector2.ZERO
var period := 4.0
var hang_y := NAN
var sid := ""
var active := true
var level
var spr: Sprite2D
var cs: CollisionShape2D
var t := 0.0
var start := Vector2.ZERO
var crumble_t := -1.0
var gone_t := -1.0
var chain_x: Array = []
var surf := 1.0
var sc := 1.0


func _ready() -> void:
	collision_layer = 256   # camada das plataformas atravessáveis
	collision_mask = 0
	z_index = 1
	if sid != "":
		add_to_group("switchable")
		active = false
	# sync_to_physics vem LIGADO por padrão: precisa ser definido ANTES da posição,
	# senão a posição inicial se perde (a plataforma ia parar em 0,0)
	sync_to_physics = kind == "movel"
	start = rect.position + Vector2(rect.size.x / 2.0, 0)
	position = start
	global_position = start
	cs = CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = rect.size
	cs.shape = r
	cs.position = Vector2(0, rect.size.y / 2.0)
	cs.one_way_collision = true
	cs.one_way_collision_margin = 8.0
	add_child(cs)
	var name_map := {"suspensa": "plat_suspensa", "movel": "plat_movel", "quebravel": "plat_quebravel"}
	var tex := Props.tex(name_map[kind])
	spr = Sprite2D.new()
	spr.texture = tex
	spr.centered = false
	# topo da superfície na imagem: suspensa = 59 px (as correntes ficam acima); demais ≈ 1 px
	surf = 59.0 if kind == "suspensa" else 1.0
	sc = rect.size.x / float(tex.get_width())
	spr.scale = Vector2(sc, sc)
	spr.position = Vector2(-rect.size.x / 2.0, -surf * sc)
	add_child(spr)
	if kind == "movel":
		var g := Art.glow(Color(0.3, 0.9, 1.0, 0.35), rect.size.x * 0.6)
		g.position = Vector2(0, rect.size.y + 6)
		add_child(g)
	chain_x = [-rect.size.x * 0.40, rect.size.x * 0.40]
	if kind == "suspensa":
		chain_x = [-rect.size.x / 2.0 + 18.0 * sc, rect.size.x / 2.0 - 18.0 * sc]


func activate() -> void:
	if active:
		return
	active = true
	t = 0.0
	AudioMgr.sfx("elevador", global_position, 0.0, 0.0)
	Fx.burst(level.fx, global_position + Vector2(0, 10), Color(0.4, 0.9, 1.0), 16, 200, 0.5, 0.06, 0)


func _physics_process(dt: float) -> void:
	if kind == "movel":
		if active:
			t += dt
		var k := 0.5 - 0.5 * cos(t / period * TAU)
		position = start + travel * k
	elif kind == "quebravel":
		_crumble(dt)
	queue_redraw()


func _draw() -> void:
	if is_nan(hang_y) or (kind == "quebravel" and not spr.visible):
		return
	# correntes até o teto + suporte no teto (para a plataforma não "flutuar")
	var top := hang_y - global_position.y
	var from_y := -surf * sc if kind != "suspensa" else -surf * sc + 2.0
	for cx in chain_x:
		var y := top
		while y < from_y:
			draw_line(Vector2(cx, y), Vector2(cx, minf(y + 9.0, from_y)), Color("2a3a50"), 3.0)
			draw_line(Vector2(cx - 2, y + 4), Vector2(cx + 2, y + 4), Color("1a2636"), 2.0)
			y += 11.0
		draw_rect(Rect2(cx - 9, top, 18, 8), Color("1c2a3e"))


func _crumble(dt: float) -> void:
	if gone_t >= 0.0:
		gone_t -= dt
		if gone_t <= 0.0:
			gone_t = -1.0
			cs.set_deferred("disabled", false)
			spr.visible = true
			spr.modulate = Color(1, 1, 1, 0)
			create_tween().tween_property(spr, "modulate", Color(1, 1, 1, 1), 0.3)
		return
	var p = level.player if level != null else null
	if crumble_t < 0.0 and is_instance_valid(p) and p.is_on_floor():
		var px: float = p.global_position.x
		if absf(p.global_position.y - global_position.y) < 6.0 and px > global_position.x - rect.size.x / 2.0 - 10 and px < global_position.x + rect.size.x / 2.0 + 10:
			crumble_t = 0.55
	if crumble_t >= 0.0:
		crumble_t -= dt
		spr.position.x = -rect.size.x / 2.0 + randf_range(-2.0, 2.0)
		if crumble_t <= 0.0:
			crumble_t = -1.0
			gone_t = 2.6
			cs.set_deferred("disabled", true)
			spr.visible = false
			AudioMgr.sfx("plataforma_quebra", global_position, -3.0, 0.08)
			Fx.burst(level.fx, global_position + Vector2(0, 10), Color(0.45, 0.6, 0.8), 20, 220, 0.6, 0.07, 900)
