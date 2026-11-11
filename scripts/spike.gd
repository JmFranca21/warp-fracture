class_name Spike
extends Area2D
## Raiz espinhosa que irrompe do chão (ataque da Rainha Micélia). Avisa antes de subir.

var t := 0.0
var warn := 0.6
var up := 0.5
var height := 140.0
var active := false
var spr: AnimatedSprite2D
const HIT_W := 56.0


func _ready() -> void:
	collision_layer = 16
	collision_mask = 0
	monitoring = false
	add_to_group("enemy_attack")
	z_index = 6
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = Vector2(HIT_W, height)
	cs.shape = r
	cs.position = Vector2(0, -height / 2.0)
	add_child(cs)
	var g := Art.glow(Color(0.7, 0.35, 1.0, 0.6), 50)
	g.position = Vector2(0, -6)
	add_child(g)
	spr = AnimatedSprite2D.new()
	add_child(spr)
	_show("aviso_raiz", 0)


func _show(nome: String, fr: int) -> void:
	var d: Array = SpriteMetaVerd.FX[nome]
	var sf := FxAnim.frames(d[0])
	if spr.sprite_frames != sf:
		spr.sprite_frames = sf
		spr.offset = d[1]
		spr.scale = Vector2.ONE * float(d[2])
		spr.animation = "play"
	spr.frame = fr


func _physics_process(dt: float) -> void:
	t += dt
	if t > warn and not active and t < warn + up:
		active = true
		get_tree().root.get_node("Main").add_shake(5.0)
		AudioMgr.sfx("raiz", global_position, -4.0, 0.1)
	if t >= warn + up and active:
		active = false
	if t > warn + up + 0.35:
		queue_free()
	# aviso no chão (VD_fx_aviso_raiz) → raiz irrompe (VD_fx_raiz 1–2), fica alta (3–4) e recolhe (5–6).
	# O dano vale só enquanto a raiz está de pé: da subida até começar a recolher.
	if t < warn:
		_show("aviso_raiz", mini(3, int(t / warn * 4.0)))
	elif t < warn + 0.05:
		_show("raiz", 0)
	elif t < warn + 0.12:
		_show("raiz", 1)
	elif t < warn + up:
		_show("raiz", 2 if int((t - warn) * 8.0) % 2 == 0 else 3)
	elif t < warn + up + 0.17:
		_show("raiz", 4)
	else:
		_show("raiz", 5)


func is_harmful() -> bool:
	return active
