class_name Fx
extends RefCounted
## Partículas e efeitos rápidos.


static func burst(parent: Node, pos: Vector2, color: Color, amount: int = 16, speed: float = 260.0,
		life: float = 0.5, size: float = 0.08, grav: float = 400.0) -> void:
	if parent == null or not is_instance_valid(parent):
		return
	var p := CPUParticles2D.new()
	p.one_shot = true
	p.explosiveness = 1.0
	p.amount = amount
	p.lifetime = life
	p.texture = Art.glow_tex()
	p.material = Art.add_mat()
	p.direction = Vector2.UP
	p.spread = 180.0
	p.initial_velocity_min = speed * 0.35
	p.initial_velocity_max = speed
	p.gravity = Vector2(0, grav)
	p.damping_min = 60.0
	p.damping_max = 160.0
	p.scale_amount_min = size * 0.5
	p.scale_amount_max = size
	var g := Gradient.new()
	g.set_color(0, color)
	g.set_color(1, Color(color, 0.0))
	p.color_ramp = g
	p.position = pos
	p.z_index = 8
	parent.add_child.call_deferred(p)
	p.set_deferred("emitting", true)
	parent.get_tree().create_timer(life + 0.4).timeout.connect(p.queue_free)


static func ring(parent: Node, pos: Vector2, color: Color, radius: float = 160.0, dur: float = 0.4, width: float = 6.0) -> void:
	if parent == null or not is_instance_valid(parent):
		return
	var r := RingFx.new()
	r.color = color
	r.max_r = radius
	r.dur = dur
	r.width = width
	r.position = pos
	parent.add_child.call_deferred(r)
