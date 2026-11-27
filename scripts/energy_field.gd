class_name EnergyField
extends StaticBody2D
## Campo de força (sprite animado fx_campo) bloqueando uma passagem vertical.

@export var sid := ""
@export var rect := Rect2()
var spr: Node2D
var cs: CollisionShape2D
var glow: Sprite2D
var off := false
# colunas do quadro da fx_campo onde o poste de cima termina e o de baixo começa (antes de girar)
const CORTES := [0, 31, 183, 213]
static var _cache: Array = []


## três SpriteFrames (poste, miolo, poste) com as mesmas regiões de cada quadro da fx_campo, recortadas
static func _partes() -> Array:
	if not _cache.is_empty():
		return _cache
	var base: SpriteFrames = load(SpriteMeta.FX_CAMPO_FRAMES)
	for k in 3:
		var sf := SpriteFrames.new()
		sf.set_animation_speed("default", base.get_animation_speed("loop"))
		sf.set_animation_loop("default", true)
		for i in base.get_frame_count("loop"):
			var src: AtlasTexture = base.get_frame_texture("loop", i)
			var at := AtlasTexture.new()
			at.atlas = src.atlas
			at.region = Rect2(src.region.position + Vector2(CORTES[k], 0), Vector2(CORTES[k + 1] - CORTES[k], src.region.size.y))
			sf.add_frame("default", at, base.get_frame_duration("loop", i))
		_cache.append(sf)
	return _cache


func _ready() -> void:
	add_to_group("switchable")
	collision_layer = 1
	collision_mask = 0
	z_index = 2
	cs = CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = rect.size
	cs.shape = r
	cs.position = rect.get_center()
	add_child(cs)
	# A arte (quadros de 213 × 156) é horizontal: poste | campo | poste. Girada 90°, o comprimento vira a
	# altura. Antes era uma cópia esticada (0,98 × 0,43 num campo de 200 px). Agora, com escala uniforme:
	# o poste de cima, o miolo do campo repetido n vezes e o poste de baixo, recortados do próprio quadro
	# (os raios sempre chegam aos postes nas mesmas alturas, então as cópias do miolo se emendam).
	# Largura perto dos 64 px de antes. Revisão geral: nenhum sprite com escala não uniforme.
	var partes := _partes()
	var w: Array = [CORTES[1] - CORTES[0], CORTES[2] - CORTES[1], CORTES[3] - CORTES[2]]
	var postes: float = w[0] + w[2]
	var n := maxi(1, roundi((rect.size.y * 148.0 / 64.0 - postes) / w[1]))
	var sc: float = rect.size.y / (postes + w[1] * n)
	spr = Node2D.new()      # nó que agrupa as peças (o desligar esmaece este nó)
	spr.position = rect.get_center()
	add_child(spr)
	var y := -rect.size.y / 2.0
	var ordem := [0]
	for i in n:
		ordem.append(1)
	ordem.append(2)
	for i in ordem.size():
		var k: int = ordem[i]
		var c := AnimatedSprite2D.new()
		c.sprite_frames = partes[k]
		c.rotation = PI / 2.0
		c.scale = Vector2.ONE * sc
		c.position = Vector2(0, y + w[k] * sc / 2.0)
		y += w[k] * sc
		spr.add_child(c)
		c.play("default")
		c.frame = 0 if k != 1 else (i * 2) % c.sprite_frames.get_frame_count("default")
	glow = Art.glow(Color(0.6, 0.35, 1.0, 0.4), rect.size.y * 0.6)
	glow.position = rect.get_center()
	add_child(glow)


func activate() -> void:
	if off:
		return
	off = true
	AudioMgr.sfx("campo_desliga", global_position + rect.get_center(), 0.0, 0.0)
	cs.set_deferred("disabled", true)
	var tw := create_tween()
	tw.tween_property(spr, "modulate", Color(1, 1, 1, 0), 0.6)
	tw.parallel().tween_property(glow, "modulate", Color(1, 1, 1, 0), 0.6)
