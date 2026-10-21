class_name EnergyField
extends StaticBody2D
## Campo de força (sprite animado fx_campo) bloqueando uma passagem vertical.

var sid := ""
var rect := Rect2()
var spr: AnimatedSprite2D
var cs: CollisionShape2D
var glow: Sprite2D
var off := false


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
	spr = AnimatedSprite2D.new()
	spr.sprite_frames = load(SpriteMeta.FX_CAMPO_FRAMES)
	spr.offset = SpriteMeta.FX_CAMPO_OFFSET
	spr.position = rect.get_center()
	spr.rotation = PI / 2.0
	# a imagem é horizontal (≈205x148 na textura): girada, o comprimento vira a altura
	spr.scale = Vector2(rect.size.y / 205.0, 64.0 / 148.0)
	add_child(spr)
	spr.play("loop")
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
