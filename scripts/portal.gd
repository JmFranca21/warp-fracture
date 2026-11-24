class_name Portal
extends Interactable
## Arco de Dobra do Laboratório Hélix (D05): hub que escolhe o destino, calibra e atravessa.
## Peças (mesmo registro: centro da base em x 512, y 984 do original): PT10 traseira, membrana PT20,
## 8 lâminas PT12, personagem, PT11 frente. Glifo do destino (PT13) no painel do topo.
## Estados: "bloqueado" (diafragma fechado, glifo apagado), "sinal" (fechado, glifo pisca),
## "calibrando" (lâminas tremendo, membrana instável), "aberto" (lâminas recolhidas, membrana estável).
## O que o E faz depende do progresso (main.portal_action).

const DESTS := {
	"lab": {"nome": "Laboratório Hélix", "cor": Color("2ec7e6"), "glifo": 0},
	"verdamia": {"nome": "Verdâmia", "cor": Color("a6e05a"), "glifo": 1},
	"deserto": {"nome": "Deserto de Ferrugem", "cor": Color("f2b24c"), "glifo": 2},
	"nivaria": {"nome": "Nivária", "cor": Color("ff8fd0"), "glifo": 3},
}
const OPEN_C := Vector2(0, -344)       # centro da abertura (original) em relação ao centro da base

var target := "verdamia"
var active := false
var state := "sinal"
var open_k := 0.0                      # 0 = diafragma fechado, 1 = recolhido
var power := 0.0
var back: Sprite2D
var front: Sprite2D
var memb: AnimatedSprite2D
var blades: Array = []
var glyph: Sprite2D
var halo: Sprite2D
var floor_light: Sprite2D
var parts: CPUParticles2D


## Glifo do destino (PT13). A folha PT13 só tem três glifos; o de Nivária (floco) é desenhado aqui
## até o lote 2 (pedido GL90).
static func glyph_tex(id: String, lit: bool) -> Texture2D:
	if id == "nivaria":
		return NvArt.glyph(lit)
	return DFArt.cell("PT13", DESTS[id]["glifo"] + (4 if lit else 0))


static func dest_color(id: String) -> Color:
	return DESTS.get(id, DESTS["lab"])["cor"]


func _setup() -> void:
	size = Vector2(140, 170)
	prompt = "[E] Calibrar o portal"
	z_index = -1
	var c := OPEN_C * DFArt.K
	halo = Art.glow(Color(0.55, 0.4, 1.0, 0.4), 200)
	halo.position = c
	add_child(halo)
	back = DFArt.sprite("PT10", Vector2(512, 984))
	add_child(back)
	var dark := Polygon2D.new()            # fundo escuro da abertura (o portal fechado não é transparente)
	dark.polygon = Art.ellipse(c, 200 * DFArt.K, 300 * DFArt.K, 32)
	dark.color = Color("0a0f18")
	add_child(dark)
	var sf := SpriteFrames.new()
	DFArt.add_anim(sf, "loop", "PT20", range(8), 9.0, true)
	memb = AnimatedSprite2D.new()
	memb.sprite_frames = sf
	memb.position = c
	memb.scale = Vector2.ONE * (DFArt.K / 0.8) / DFArt.IMPORT
	memb.material = Art.add_mat()
	add_child(memb)
	memb.play("loop")
	for i in 8:
		var b := DFArt.sprite("PT12", Vector2(256, 448))
		b.position = c
		b.rotation = i * TAU / 8.0
		add_child(b)
		blades.append(b)
	parts = CPUParticles2D.new()
	parts.position = c
	parts.amount = 26
	parts.lifetime = 0.9
	parts.emission_shape = CPUParticles2D.EMISSION_SHAPE_SPHERE
	parts.emission_sphere_radius = 70.0
	parts.radial_accel_min = -160.0
	parts.radial_accel_max = -120.0
	parts.gravity = Vector2.ZERO
	parts.texture = Art.glow_tex()
	parts.material = Art.add_mat()
	parts.scale_amount_min = 0.03
	parts.scale_amount_max = 0.07
	parts.emitting = false
	add_child(parts)
	floor_light = Art.glow(Color(0.5, 0.9, 1.0, 0.0), 90)
	floor_light.scale = Vector2(2.2, 0.35) * floor_light.scale
	floor_light.position = Vector2(0, -2)
	add_child(floor_light)
	glyph = Sprite2D.new()
	glyph.position = Vector2(0, (150 - 984) * DFArt.K)
	glyph.scale = Vector2.ONE * DFArt.NODE * 1.1
	add_child(glyph)
	# a frente (pilares) fica na frente do personagem
	front = DFArt.sprite("PT11", Vector2(512, 984))
	front.z_as_relative = false
	front.z_index = 7
	add_child(front)
	refresh_state()


## Recalcula estado, destino e texto do E a partir do progresso.
func refresh_state() -> void:
	if main == null:
		return
	var a: Dictionary = main.portal_action()
	target = a["target"]
	if not active:
		state = a["state"]
	prompt = "" if active else a["prompt"]
	refresh_prompt()
	glyph.texture = glyph_tex(target, state != "bloqueado")


func interact() -> void:
	if active:
		main.enter_portal(target, global_position)
		return
	main.portal_interact(self)


## Concluída a calibração (ou destino já calibrado): diafragma abre.
func activate() -> void:
	active = true
	state = "aberto"
	prompt = ""
	refresh_prompt()
	AudioMgr.sfx("portal_abre", global_position, -2.0, 0.0)
	Fx.ring(main.level.fx, global_position + OPEN_C * DFArt.K, dest_color(target), 200, 0.6, 6)


## Aberto, mas a viagem só começa com o último E (deserto, D02 passo 9).
func arm(t_id: String) -> void:
	target = t_id
	active = true
	state = "aberto"
	prompt = "[E] Atravessar"
	refresh_prompt()
	glyph.texture = glyph_tex(target, true)
	AudioMgr.sfx("portal_abre", global_position, -2.0, 0.0)


func disarm() -> void:
	active = false
	refresh_state()


func _process(dt: float) -> void:
	super._process(dt)
	var goal := 0.0
	match state:
		"calibrando":
			goal = 0.45
		"aberto":
			goal = 1.0
	if main != null and main.state == "calib" and main.calib_portal == self:
		goal = 0.45
		state = "calibrando"
	elif state == "calibrando" and not active:
		state = "sinal"
	open_k = move_toward(open_k, goal, dt * 1.6)
	power = move_toward(power, 1.0 if state == "aberto" else (0.5 if state == "calibrando" else 0.15), dt * 1.5)
	var col := dest_color(target)
	var shake := 2.5 if state == "calibrando" else 0.0
	for i in 8:
		var b: Sprite2D = blades[i]
		var base := i * TAU / 8.0
		b.rotation = base + open_k * 0.9 + randf_range(-0.03, 0.03) * shake
		b.scale = Vector2.ONE * DFArt.NODE * (1.0 - open_k * 0.55)
		b.modulate.a = clampf(1.0 - (open_k - 0.6) * 2.5, 0.0, 1.0)
	memb.visible = open_k > 0.15
	memb.modulate = Color(col.r, col.g, col.b, clampf(open_k * 1.2, 0.0, 1.0) * (0.55 + 0.25 * power))
	_move_membrane(dt, col)
	halo.modulate = Color(col.r, col.g, col.b, 0.12 + 0.3 * power + 0.06 * sin(t * 3.0))
	floor_light.modulate = Color(col.r, col.g, col.b, 0.5 * maxf(0.0, open_k - 0.6))
	parts.emitting = state == "aberto"
	parts.color = col
	var blink := state == "sinal" and fmod(t, 0.9) < 0.45
	glyph.modulate = Color(1, 1, 1, 0.45 if blink else 1.0)


## Movimento da membrana por destino (D05): Hélix pulsa para dentro, Verdâmia gira em espiral
## no sentido anti-horário, Deserto ondula na horizontal como ar quente. Calibrando: tremor.
func _move_membrane(_dt: float, _col: Color) -> void:
	var base := (DFArt.K / 0.8) / DFArt.IMPORT
	var c := OPEN_C * DFArt.K
	memb.position = c
	memb.rotation = 0.0
	memb.scale = Vector2.ONE * base
	if state == "calibrando":
		memb.position += Vector2(randf_range(-2, 2), randf_range(-2, 2))
		memb.scale *= 0.92 + randf_range(-0.04, 0.04)
		return
	memb.flip_h = target == "verdamia"      # véus girando no sentido anti-horário
	memb.speed_scale = 0.7 if target == "verdamia" else 1.0
	match target:
		"verdamia":
			memb.scale *= 1.0 + 0.02 * sin(t * 1.5)
		"deserto":
			memb.scale.x = base * (1.0 + 0.05 * sin(t * 7.0))
			memb.position.x += sin(t * 11.0) * 1.5
		"nivaria":
			# cristaliza: a membrana pulsa devagar e treme de frio
			memb.scale *= 1.0 + 0.03 * sin(t * 0.9)
			memb.position.y += sin(t * 23.0) * 0.6
		_:
			memb.scale *= 1.0 - 0.05 * fmod(t * 0.8, 1.0)
