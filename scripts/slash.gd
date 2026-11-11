class_name Slash
extends Area2D
## Golpe de garras do Lince-Vagalume (lado, cima ou baixo com quique).

var dir := Vector2.RIGHT
var player
var life := 0.14
var total := 0.14
var hit := {}


func _ready() -> void:
	collision_layer = 8
	collision_mask = 1 | 4 | 32
	z_index = 3
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	var center := Vector2(0, -18)
	if dir.y == 0.0:
		r.size = Vector2(76, 56)
		cs.position = center + dir * 44.0
	else:
		r.size = Vector2(62, 74)
		cs.position = center + dir * 44.0
	cs.shape = r
	add_child(cs)
	# corte de garras (VD_fx_garras): a arte corta para a direita; gira para cima/baixo e espelha para a esquerda
	var d: Array = SpriteMetaVerd.FX["garras"]
	var fx := AnimatedSprite2D.new()
	fx.sprite_frames = FxAnim.frames(d[0])
	fx.offset = d[1]
	fx.scale = Vector2.ONE * float(d[2])
	fx.position = cs.position
	if dir.y != 0.0:
		fx.rotation = dir.angle()
		fx.scale.y *= float(player.facing)
	elif dir.x < 0.0:
		fx.scale.x *= -1.0
	add_child(fx)
	fx.play("play")


func _physics_process(dt: float) -> void:
	life -= dt
	for a in get_overlapping_areas():
		if hit.has(a):
			continue
		hit[a] = true
		if a.has_meta("enemy"):
			var e = a.get_meta("enemy")
			if is_instance_valid(e) and not e.dead:
				e.take_hit(1, player.global_position + Vector2(0, -18))
				player.on_hit_enemy(dir)
		elif a.is_in_group("hazard") and dir.y > 0.0:
			player.pogo()
			Fx.burst(player.level.fx, player.global_position + Vector2(0, 30), Color(1, 1, 1), 8, 200, 0.25, 0.05)
	for b in get_overlapping_bodies():
		if b.has_meta("breakable") and not hit.has(b):
			hit[b] = true
			var c = b.get_meta("breakable")
			c.take_hit(1, player.global_position)
			if dir.y > 0.0:
				player.pogo()
	if life <= 0.0:
		queue_free()
