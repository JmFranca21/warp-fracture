class_name Door
extends StaticBody2D
## Porta de emergência do laboratório (arte: porta.png). Recolhe para cima quando destravada.

var rect := Rect2()
var opened := false
var amt := 0.0
var cs: CollisionShape2D
var light: Sprite2D
var spr: Sprite2D
var t := 0.0
var tex_h := 152.0
var sc := 1.0


func _ready() -> void:
	collision_layer = 1
	collision_mask = 0
	z_index = 1
	cs = CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = rect.size
	cs.shape = r
	cs.position = rect.get_center()
	add_child(cs)
	var tex := Props.tex("porta")
	tex_h = tex.get_height()
	sc = rect.size.y / tex_h
	spr = Sprite2D.new()
	spr.texture = tex
	spr.centered = false
	spr.region_enabled = true
	spr.region_rect = Rect2(0, 0, tex.get_width(), tex_h)
	spr.scale = Vector2(sc, sc)
	spr.position = Vector2(rect.get_center().x - tex.get_width() * sc / 2.0, rect.position.y)
	add_child(spr)
	# luz de status no topo da porta (vermelha = travada, verde = liberada)
	light = Art.glow(Color(1, 0.2, 0.15, 0.7), 46)
	light.position = spr.position + Vector2(55, 10) * sc
	add_child(light)


func open(instant: bool) -> void:
	if opened:
		return
	opened = true
	cs.set_deferred("disabled", true)
	if instant:
		amt = 1.0
	else:
		AudioMgr.sfx("porta", global_position + rect.get_center(), 0.0, 0.0)
		var tw := create_tween()
		tw.tween_property(self, "amt", 1.0, 1.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)


func _process(dt: float) -> void:
	t += dt
	if opened:
		light.modulate = Color(0.3, 1.0, 0.6, 0.75)
	else:
		light.modulate = Color(1, 0.2, 0.15, 0.45 + 0.35 * sin(t * 5.0))
	# recolhe a folha da porta para cima: mostra só a parte de baixo da imagem, encolhendo
	var vis := tex_h * (1.0 - amt * 0.82)
	spr.region_rect = Rect2(0, tex_h - vis, spr.texture.get_width(), vis)
	spr.modulate = Color(1, 1, 1) if amt < 0.99 else Color(0.8, 0.85, 0.9)
