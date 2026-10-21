class_name Crate
extends StaticBody2D
## Caixa (quebra com tiros/garras), Caixa Pesada (só com tiro carregado ou Clarão)
## e Barril explosivo (explode e fere tudo ao redor, inclusive o jogador).

var level
var kind := "caixa"
var drop := ""   # item extra ao quebrar ("heal" / "energy")
var hp := 2
var min_dmg := 1
var broken := false
var spr: Sprite2D
var flash := 0.0
var size := Vector2(44, 40)
var glow: Sprite2D


func _ready() -> void:
	collision_layer = 1
	collision_mask = 0
	z_index = 2
	set_meta("breakable", self)
	var sc := 0.42
	match kind:
		"caixa":
			hp = 2
			size = Vector2(42, 36)
			sc = 0.42
		"caixa_pesada":
			hp = 1
			min_dmg = 3
			size = Vector2(46, 46)
			sc = 0.46
		"barril":
			hp = 1
			size = Vector2(28, 40)
			sc = 0.42
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = size
	cs.shape = r
	cs.position = Vector2(0, -size.y / 2.0)
	add_child(cs)
	if kind == "barril":
		glow = Art.glow(Color(1.0, 0.25, 0.2, 0.35), 40)
	else:
		glow = Art.glow(Color(0.3, 0.9, 1.0, 0.18), 40)
	glow.position = Vector2(0, -size.y * 0.5)
	add_child(glow)
	spr = Props.sprite(kind, sc)
	add_child(spr)


func _process(dt: float) -> void:
	flash = maxf(0.0, flash - dt)
	spr.modulate = Color(2.2, 2.2, 2.2) if flash > 0.0 else Color(1, 1, 1)
	if kind == "barril":
		glow.modulate.a = 0.25 + 0.15 * sin(Time.get_ticks_msec() / 200.0)


func take_hit(dmg: int, _from: Vector2) -> void:
	if broken:
		return
	if dmg < min_dmg:
		flash = 0.06
		Fx.burst(level.fx, global_position + Vector2(0, -size.y / 2), Color(0.7, 0.8, 0.9), 4, 120, 0.2, 0.04)
		if level.main.hud != null:
			level.main.hud.notice("Muito resistente. Tente um tiro carregado.")
		return
	hp -= dmg
	flash = 0.08
	if hp <= 0:
		_break()


func _break() -> void:
	broken = true
	var c := global_position + Vector2(0, -size.y / 2)
	if kind == "barril":
		AudioMgr.sfx("explosao", c, 0.0, 0.05)
		_explode(c)
	else:
		AudioMgr.sfx("caixa_quebra", c, -2.0, 0.1)
		FxAnim.crate_break(level.fx, c, 0.63 if kind == "caixa" else 0.72)
		Fx.burst(level.fx, c, Color(0.35, 0.9, 1.0), 6, 160, 0.4, 0.05, 0)
		level.main.add_shake(4.0)
		var n := 2 if kind == "caixa" else 6
		for i in n:
			level.drop_cell(c)
		if drop != "":
			var pk := Pickup.new()
			pk.main = level.main
			pk.kind = drop
			pk.position = c + Vector2(0, -10)
			level.objects.add_child.call_deferred(pk)
	queue_free()


func _explode(c: Vector2) -> void:
	FxAnim.explosion(level.fx, c + Vector2(0, -20), 1.35)
	Fx.burst(level.fx, c, Color(1.0, 0.55, 0.25), 16, 420, 0.5, 0.08, 300)
	Fx.ring(level.fx, c, Color(1.0, 0.5, 0.3, 0.6), 150, 0.35, 5)
	level.main.add_shake(14.0)
	for e in get_tree().get_nodes_in_group("enemies"):
		if is_instance_valid(e) and not e.dead and e.global_position.distance_to(c) < 150.0:
			e.take_hit(3, c)
	for cr in get_tree().get_nodes_in_group("crates"):
		if cr != self and is_instance_valid(cr) and not cr.broken and cr.global_position.distance_to(global_position) < 150.0:
			cr.call_deferred("take_hit", 3, c)
	var p = level.player
	if is_instance_valid(p) and p.global_position.distance_to(global_position) < 120.0:
		p.hurt(c)


func _enter_tree() -> void:
	add_to_group("crates")
