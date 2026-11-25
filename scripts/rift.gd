class_name Rift
extends Interactable
## Fenda de Dobra (D05): rasgo no universo aberto pela energia de um fragmento ou do portal.
## A base (PT22) apoia no chão; a borda (PT21) nasce dela; a membrana (PT20), tingida pelo destino,
## fica atrás da borda. Estados: "dormente" (rachadura fina), "abrindo" (PT23), "aberta" (PT21 em loop),
## "fechando" (PT23 ao contrário, depois dormente).

signal opened

@export var target := "lab"
var state := "dormente"
var label := "[E] Voltar ao Laboratório Hélix"
var base: Sprite2D
var edge: AnimatedSprite2D
var memb: AnimatedSprite2D
var glow: Sprite2D

const EDGE_SC := 0.214 / 0.766 / 0.5     # a borda foi desenhada a 0,766 da escala D (340 × 490 na célula)
const MEMB_SC := 0.214 / 0.8 / 0.5


func _setup() -> void:
	size = Vector2(110, 150)
	z_index = -1
	var col := Portal.dest_color(target)
	glow = Art.glow(Color(col.r, col.g, col.b, 0.0), 130)
	glow.position = Vector2(0, -70)
	add_child(glow)
	var sf := SpriteFrames.new()
	DFArt.add_anim(sf, "loop", "PT20", range(8), 9.0, true)
	memb = AnimatedSprite2D.new()
	memb.sprite_frames = sf
	memb.scale = Vector2.ONE * MEMB_SC * 0.9
	memb.position = Vector2(0, -(500 - 256) * 0.214 / 0.766 + 0)   # centro do oval da borda
	memb.material = Art.add_mat()
	memb.modulate = Color(col.r, col.g, col.b, 0.0)
	add_child(memb)
	memb.play("loop")
	var ef := SpriteFrames.new()
	DFArt.add_anim(ef, "open", "PT23", range(8), 10.0, false)
	DFArt.add_anim(ef, "loop", "PT21", range(8), 10.0, true)
	edge = AnimatedSprite2D.new()
	edge.sprite_frames = ef
	edge.offset = DFArt.offset(Vector2(384, 512), Vector2(192, 500))
	edge.scale = Vector2.ONE * EDGE_SC
	add_child(edge)
	edge.animation_finished.connect(_anim_done)
	base = DFArt.sprite("PT22", Vector2(512, 380))
	add_child(base)
	_set_dormant()


func _set_dormant() -> void:
	state = "dormente"
	edge.play("open")
	edge.pause()
	edge.frame = 0
	edge.modulate.a = 0.6
	memb.visible = false
	prompt = ""
	refresh_prompt()


func open_now() -> void:
	state = "aberta"
	edge.modulate.a = 1.0
	edge.play("loop")
	memb.visible = true
	prompt = label
	refresh_prompt()


func open_anim() -> void:
	state = "abrindo"
	edge.modulate.a = 1.0
	edge.play("open")
	memb.visible = true
	AudioMgr.sfx("fenda_abre", global_position, -2.0, 0.0)
	Fx.burst(get_parent(), global_position + Vector2(0, -60), Portal.dest_color(target), 24, 260, 0.6, 0.06, 0)


func close_anim() -> void:
	state = "fechando"
	prompt = ""
	refresh_prompt()
	edge.play_backwards("open")


func _anim_done() -> void:
	if state == "abrindo":
		open_now()
		opened.emit()
	elif state == "fechando":
		_set_dormant()


func interact() -> void:
	if state == "aberta":
		main.enter_portal(target, global_position + Vector2(0, 30))


func _process(dt: float) -> void:
	super._process(dt)
	var col := Portal.dest_color(target)
	var k := 0.0
	match state:
		"aberta":
			k = 1.0
		"abrindo", "fechando":
			k = clampf(edge.frame / 7.0, 0.0, 1.0)
	memb.modulate = Color(col.r, col.g, col.b, k * 0.75)
	memb.scale = Vector2.ONE * MEMB_SC * (0.25 + 0.65 * k)
	glow.modulate = Color(col.r, col.g, col.b, 0.08 + 0.3 * k + 0.05 * sin(t * 3.0))
	base.modulate = Color(1, 1, 1, 0.75 + 0.25 * k)
