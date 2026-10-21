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
	queue_redraw()


func _draw() -> void:
	var k := 1.0 - life / total
	var alpha := 1.0 - k * 0.8
	var c := Vector2(0, -18) + dir * 10.0
	var base_ang := dir.angle()
	var sweep := deg_to_rad(150.0)
	var a0 := base_ang - sweep * 0.5 + sweep * k * 0.25
	var a1 := base_ang + sweep * 0.5
	var outer := PackedVector2Array()
	var inner := PackedVector2Array()
	var n := 16
	for i in n + 1:
		var s := float(i) / float(n)
		var ang := lerpf(a0, a1, s)
		var thick := sin(s * PI)
		outer.append(c + Vector2.from_angle(ang) * (56.0 + 4.0 * thick))
		inner.append(c + Vector2.from_angle(ang) * (53.0 - 18.0 * thick))
	inner.reverse()
	var pts := outer + inner
	draw_colored_polygon(pts, Color(1, 1, 1, 0.85 * alpha))
	draw_polyline(outer, Color(0.8, 1.0, 0.7, 0.6 * alpha), 3.0, true)
