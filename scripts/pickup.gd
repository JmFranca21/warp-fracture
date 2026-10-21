class_name Pickup
extends Area2D
## Coletáveis: Célula de Fase (moeda) e Célula de Energia (cura 1).

var main
var kind := "cell"
var pid := ""
var vel := Vector2.ZERO
var dropped := false
var t := 0.0
var base_y := 0.0
var taken := false
var g: Sprite2D
var art: Sprite2D = null
var respawn := 0.0   # >0: reaparece depois desse tempo (ex.: Célula de Energia ao lado da trava)


func _ready() -> void:
	collision_layer = 64
	collision_mask = 2
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = 16.0
	cs.shape = c
	add_child(cs)
	body_entered.connect(_on_body)
	base_y = position.y
	t = randf() * 3.0
	var col := Color(0.4, 0.9, 1.0, 0.6) if kind == "cell" else Color(0.5, 1.0, 0.6, 0.7)
	if kind == "energy":
		col = Color(0.3, 0.85, 1.0, 0.75)
	g = Art.glow(col, 30 if kind == "cell" else 48)
	add_child(g)
	if kind == "registro":
		g.modulate = Color(0.45, 0.9, 1.0, 0.45)
	if kind in ["modulo", "nucleo"]:
		g.modulate = Color(0.35, 0.92, 1.0, 0.8) if kind == "modulo" else Color(1.0, 0.85, 0.45, 0.8)
		g.scale = Vector2.ONE * 70.0 * 2.0 / 128.0
	elif main.level != null and main.level.data.get("theme", "") == "lab" and kind in ["heal", "energy"]:
		art = Props.centered("kit_reparo" if kind == "heal" else "celula_energia", 0.42 if kind == "heal" else 0.4)
		add_child(art)
	z_index = 2


func _physics_process(dt: float) -> void:
	t += dt
	var p: Player = main.player
	if dropped:
		if t < 0.45 or p == null:
			vel.y += 1000.0 * dt
			vel *= 0.985
			position += vel * dt
		else:
			var tgt := p.global_position + Vector2(0, -24)
			position = position.move_toward(tgt, (500.0 + t * 400.0) * dt)
	else:
		position.y = base_y + sin(t * 2.5) * 5.0
		if p != null and kind == "cell" and global_position.distance_to(p.global_position + Vector2(0, -24)) < 110.0:
			position = position.move_toward(p.global_position + Vector2(0, -24), 500.0 * dt)
			base_y = position.y
	queue_redraw()


func _on_body(b: Node) -> void:
	if taken or not (b is Player):
		return
	if dropped and t < 0.3:
		return
	taken = true
	if pid != "":
		main.collected[pid] = true
	AudioMgr.sfx({"cell": "celula", "heal": "cura", "energy": "energia"}.get(kind, "celula"), Vector2.INF, -5.0 if kind == "cell" else -2.0, 0.08)
	if kind == "registro":
		main.read_log(pid)
	elif kind == "modulo":
		main.gain_module("arpao")
		Fx.ring(get_parent(), global_position, Color(0.4, 0.95, 1.0), 160, 0.6, 6)
	elif kind == "nucleo":
		main.gain_core()
		Fx.ring(get_parent(), global_position, Color(1.0, 0.85, 0.45), 160, 0.6, 6)
	elif kind == "cell":
		main.add_cells(1)
		Fx.burst(get_parent(), global_position, Color(0.5, 0.95, 1.0), 6, 120, 0.3, 0.05, 0)
	elif kind == "energy":
		(b as Player).energy = minf(99.0, (b as Player).energy + 33.0)
		main.hud.notice("+1/3 Energia de Fase")
		Fx.burst(get_parent(), global_position, Color(0.4, 0.9, 1.0), 16, 200, 0.5, 0.07, -100)
	else:
		(b as Player).heal(1)
		main.hud.notice("+1 Integridade")
		Fx.burst(get_parent(), global_position, Color(0.5, 1.0, 0.6), 16, 200, 0.5, 0.07, -100)
	if respawn > 0.0:
		visible = false
		set_deferred("monitoring", false)
		await get_tree().create_timer(respawn, false).timeout
		if is_instance_valid(self):
			taken = false
			visible = true
			set_deferred("monitoring", true)
			Fx.burst(get_parent(), global_position, Color(0.4, 0.9, 1.0), 10, 120, 0.4, 0.05, 0)
		return
	queue_free()


func _draw() -> void:
	if art != null:
		return
	if kind == "registro":
		# tablet de dados
		draw_rect(Rect2(-10, -13, 20, 26), Color("162232"))
		draw_rect(Rect2(-10, -13, 20, 26), Color(0.45, 0.9, 1.0, 0.8), false, 1.5)
		var a := 0.5 + 0.4 * sin(t * 5.0)
		for i in 3:
			draw_line(Vector2(-6, -7 + i * 6), Vector2(4 - i * 2, -7 + i * 6), Color(0.6, 0.95, 1.0, a), 1.5)
		return
	if kind == "modulo":
		# ícone do Arpão: gancho + cabo
		var r := 16.0 + 1.5 * sin(t * 4.0)
		draw_arc(Vector2.ZERO, r, 0, TAU, 32, Color(0.35, 0.92, 1.0, 0.9), 2.5, true)
		draw_line(Vector2(-8, 8), Vector2(6, -6), Color(1, 1, 1), 3.0, true)
		draw_arc(Vector2(6, -2), 6.0, -PI * 0.9, PI * 0.4, 12, Color(1, 1, 1), 3.0, true)
		return
	if kind == "nucleo":
		var s2 := 1.0 + 0.08 * sin(t * 5.0)
		var pts2 := PackedVector2Array([Vector2(0, -15) * s2, Vector2(11, -3) * s2, Vector2(7, 13) * s2, Vector2(-7, 13) * s2, Vector2(-11, -3) * s2])
		Art.poly(self, pts2, Color(1.0, 0.85, 0.45))
		draw_polyline(pts2 + PackedVector2Array([pts2[0]]), Color(1, 1, 1, 0.9), 1.5, true)
		draw_circle(Vector2(0, 0), 4.0, Color(1, 1, 1))
		return
	if kind == "cell":
		var s := 0.55 + 0.08 * sin(t * 6.0)
		var pts := PackedVector2Array([Vector2(0, -12) * s * 1.5, Vector2(7, 0) * s * 1.5, Vector2(0, 12) * s * 1.5, Vector2(-7, 0) * s * 1.5])
		Art.poly(self, pts, Color(0.55, 0.95, 1.0))
		draw_line(Vector2(0, -9) * s * 1.5, Vector2(0, 9) * s * 1.5, Color(1, 1, 1, 0.8), 1.2)
	else:
		Art.poly(self, Art.circle(Vector2.ZERO, 9.0, 18), Color(0.25, 0.6, 0.35, 0.9))
		draw_arc(Vector2.ZERO, 9.0, 0, TAU, 20, Color(0.7, 1.0, 0.75), 2.0, true)
		draw_line(Vector2(-4, 0), Vector2(4, 0), Color(1, 1, 1), 2.5)
		draw_line(Vector2(0, -4), Vector2(0, 4), Color(1, 1, 1), 2.5)
