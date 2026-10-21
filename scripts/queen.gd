class_name Queen
extends Enemy
## Chefe: Rainha Micélia (Verdâmia). Chuva de esporos, raízes do chão, rajada e invocação de mariposas.

var state := "sleep"
var st := 0.0
var phase2 := false
var last_attack := ""
var attack_glow := 0.0
var spot_glows: Array = []
const ARENA_L := 3900.0
const ARENA_R := 4600.0


func _ready() -> void:
	hp = 22
	max_hp = 22
	heavy = true
	drops = 0
	main_color = Color(0.7, 0.5, 1.0)
	collision_layer = 0
	collision_mask = 0
	setup_hurt(Vector2(150, 220), Vector2(0, -110))
	var big := Art.glow(Color(0.55, 0.4, 1.0, 0.35), 260)
	big.position = Vector2(0, -170)
	add_child(big)
	var spots := [Vector2(-80, -205), Vector2(-30, -232), Vector2(30, -238), Vector2(85, -208), Vector2(0, -205), Vector2(-55, -180), Vector2(60, -182)]
	for s in spots:
		var g := Art.glow(Color(0.45, 1.0, 0.85, 0.7), 24)
		g.position = s
		add_child(g)
		spot_glows.append(g)


func wake() -> void:
	AudioMgr.sfx("rainha_ruge", Vector2.INF, 0.0, 0.0)
	AudioMgr.music("chefe")
	state = "idle"
	st = 1.6


func _physics_process(dt: float) -> void:
	tick(dt)
	attack_glow = maxf(0.0, attack_glow - dt)
	for i in spot_glows.size():
		(spot_glows[i] as Sprite2D).modulate.a = 0.5 + 0.3 * sin(t * 2.0 + i) + attack_glow * 0.5
	if state == "sleep" or dead:
		queue_redraw()
		return
	if not phase2 and hp <= max_hp / 2:
		phase2 = true
		level.main.add_shake(16.0)
		AudioMgr.sfx("rainha_ruge", Vector2.INF, 0.0, 0.05)
		level.main.hud.notice("A Rainha se enfurece!")
		Fx.ring(level.fx, global_position + Vector2(0, -150), Color(0.8, 0.5, 1.0), 400, 0.7, 10)
		st = 1.0
	st -= dt
	if st <= 0.0:
		_next_attack()
	queue_redraw()


func _next_attack() -> void:
	var opts := ["rain", "roots", "volley", "summon"]
	opts.erase(last_attack)
	var moths := 0
	for e in get_tree().get_nodes_in_group("enemies"):
		if e is Moth:
			moths += 1
	if moths >= 2:
		opts.erase("summon")
	var a: String = opts[randi() % opts.size()]
	last_attack = a
	attack_glow = 1.0
	var idle := 0.9 if phase2 else 1.5
	match a:
		"rain":
			_rain()
			st = 2.2 + idle
		"roots":
			_roots()
			st = 2.0 + idle
		"volley":
			_volley()
			st = 1.2 + idle
		"summon":
			_summon()
			st = 1.0 + idle


func _rain() -> void:
	var n := 9 if phase2 else 7
	var p := player()
	for i in n:
		var b := EnemyBullet.new()
		b.color = Color(0.75, 0.5, 1.0)
		b.radius = 9.0
		b.grav = 650.0
		b.delay = 0.6 + i * 0.12
		var x := randf_range(ARENA_L, ARENA_R)
		if i == 0 and p != null:
			x = p.global_position.x
		b.position = Vector2(x, 360)
		level.add_fx(b)


func _roots() -> void:
	var count := 4 if phase2 else 3
	for i in count:
		get_tree().create_timer(i * 0.5, false).timeout.connect(_spawn_spike)


func _spawn_spike() -> void:
	if dead or not is_instance_valid(level):
		return
	var p := player()
	if p == null:
		return
	var s := Spike.new()
	s.position = Vector2(clampf(p.global_position.x, ARENA_L, ARENA_R + 100.0), 800)
	level.add_fx(s)


func _volley() -> void:
	var count := 5 if phase2 else 3
	for i in count:
		get_tree().create_timer(i * 0.22, false).timeout.connect(_shoot_spore)


func _shoot_spore() -> void:
	if dead:
		return
	var p := player()
	if p == null:
		return
	var start := global_position + Vector2(-40, -200)
	var tgt := p.global_position + Vector2(randf_range(-60, 60), -20)
	var T := clampf(absf(tgt.x - start.x) / 500.0, 0.6, 1.4)
	var g := 900.0
	var b := EnemyBullet.new()
	b.color = Color(0.45, 1.0, 0.75)
	b.radius = 9.0
	b.grav = g
	b.vel = Vector2((tgt.x - start.x) / T, (tgt.y - start.y - 0.5 * g * T * T) / T)
	b.position = start
	level.add_fx(b)


func _summon() -> void:
	for i in 2:
		var pos := global_position + Vector2(-120 - i * 80, -260 + i * 40)
		Fx.burst(level.fx, pos, Color(1.0, 0.9, 0.5), 16, 200, 0.5, 0.07)
		level.spawn_enemy("moth", pos)


func take_hit(dmg: int, from: Vector2) -> void:
	if state == "sleep":
		return
	super.take_hit(dmg, from)


func die() -> void:
	if dead:
		return
	dead = true
	state = "dead"
	AudioMgr.sfx("explosao", Vector2.INF, -2.0, 0.0)
	AudioMgr.music("verdamia")
	level.main.add_shake(22.0)
	for i in 5:
		Fx.burst(level.fx, global_position + Vector2(randf_range(-80, 80), randf_range(-240, -20)), Color(0.75, 0.55, 1.0), 30, 420, 1.0, 0.12)
	Fx.ring(level.fx, global_position + Vector2(0, -150), Color(0.85, 1.0, 0.7), 600, 1.0, 12)
	for e in get_tree().get_nodes_in_group("enemies"):
		if e is Moth and is_instance_valid(e):
			e.die()
	for i in 12:
		level.drop_cell(global_position + Vector2(randf_range(-60, 60), -120))
	level.on_boss_dead()
	var tw := create_tween()
	tw.tween_property(self, "modulate", Color(1, 1, 1, 0), 1.2)
	tw.tween_callback(queue_free)


func _draw() -> void:
	var breath := sin(t * 1.6) * 3.0
	var dark := fc(Color("1d1530"))
	var cap := fc(Color("33255a"))
	var cap2 := fc(Color("40306e"))
	var pale := fc(Color("e7e2d6"))
	# raízes
	for i in 9:
		var s := (float(i) / 8.0) * 2.0 - 1.0
		var pts := PackedVector2Array()
		for j in 8:
			var k := float(j) / 7.0
			pts.append(Vector2(s * 40.0 + s * k * 140.0, -40.0 * (1.0 - k) + sin(t * 1.5 + i + k * 3.0) * 4.0 * k))
		draw_polyline(pts, dark, 7.0 - absf(s) * 3.0, true)
		draw_circle(pts[pts.size() - 1], 3.0, Color(0.7, 0.5, 1.0, 0.7))
	# corpo/haste
	Art.poly(self, PackedVector2Array([Vector2(-60, 0), Vector2(60, 0), Vector2(42, -120 + breath), Vector2(-42, -120 + breath)]), dark)
	# saia de lamelas
	var gill := PackedVector2Array()
	for i in 17:
		var s2 := float(i) / 16.0
		gill.append(Vector2(-75 + s2 * 150.0, -60 + 10.0 * sin(s2 * PI * 6.0 + t * 2.0)))
	gill.append(Vector2(48, -130 + breath))
	gill.append(Vector2(-48, -130 + breath))
	Art.poly(self, gill, fc(Color("261c40")))
	# máscara
	var mc := Vector2(0, -150 + breath)
	Art.poly(self, Art.ellipse(mc, 34, 40, 28), pale)
	var eye_c := Color(0.55, 1.0, 0.85, 0.9)
	if attack_glow > 0.0 or phase2:
		eye_c = Color(0.85, 0.6, 1.0, 1.0)
	for sx: float in [-1.0, 1.0]:
		Art.poly(self, PackedVector2Array([mc + Vector2(sx * 6, -4), mc + Vector2(sx * 24, -12), mc + Vector2(sx * 20, -2)]), eye_c)
	for i in 5:
		var gx := -16.0 + i * 8.0
		draw_line(mc + Vector2(gx, 14), mc + Vector2(gx * 0.8, 34), Color(0.35, 0.28, 0.45, 0.8), 2.0, true)
	draw_line(mc + Vector2(0, -36), mc + Vector2(0, -14), Color(0.55, 0.45, 0.7, 0.6), 2.0, true)
	# chapéu
	var cc := Vector2(0, -185 + breath)
	var dome := PackedVector2Array()
	for i in 29:
		var a := PI + PI * float(i) / 28.0
		dome.append(cc + Vector2(cos(a) * 140.0, sin(a) * 78.0))
	dome.append(cc + Vector2(120, 22))
	dome.append(cc + Vector2(-120, 22))
	Art.poly(self, dome, cap)
	var dome2 := PackedVector2Array()
	for i in 21:
		var a2 := PI + PI * float(i) / 20.0
		dome2.append(cc + Vector2(cos(a2) * 110.0, -4 + sin(a2) * 58.0))
	Art.poly(self, dome2, cap2)
	draw_line(cc + Vector2(-120, 22), cc + Vector2(120, 22), Color(0.6, 0.45, 1.0, 0.6), 3.0, true)
	for g in spot_glows:
		var sp: Vector2 = (g as Sprite2D).position
		Art.poly(self, Art.circle(sp + Vector2(0, breath), 7.0, 14), Color(0.55, 1.0, 0.85, 0.9))
