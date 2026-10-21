class_name SporePlant
extends Enemy
## Esporângio — planta fixa que lança esporos em arco.

var cd := 1.5
var charging := 0.0
const SPORE_G := 900.0


func _ready() -> void:
	hp = 3
	max_hp = 3
	heavy = true
	drops = 3
	main_color = Color(0.4, 1.0, 0.8)
	collision_layer = 0
	collision_mask = 0
	setup_hurt(Vector2(40, 60), Vector2(0, -32))
	var g := Art.glow(Color(0.35, 1.0, 0.8, 0.5), 50)
	g.position = Vector2(0, -50)
	add_child(g)
	cd = 1.0 + randf() * 1.5


func _physics_process(dt: float) -> void:
	tick(dt)
	var p := player()
	if p != null and stun <= 0.0:
		var d := p.global_position - global_position
		if absf(d.x) < 560.0 and absf(d.y) < 320.0:
			cd -= dt
			charging = clampf(1.0 - cd / 0.6, 0.0, 1.0)
			if cd <= 0.0:
				_shoot(p)
				cd = 2.3
				charging = 0.0
	queue_redraw()


func _shoot(p: Player) -> void:
	var start := global_position + Vector2(0, -52)
	var tgt := p.global_position + Vector2(p.velocity.x * 0.3, -20)
	var dx := tgt.x - start.x
	var dy := tgt.y - start.y
	var T := clampf(absf(dx) / 420.0, 0.7, 1.3)
	AudioMgr.sfx("esporo", global_position, -4.0, 0.1)
	var b := EnemyBullet.new()
	b.color = Color(0.45, 1.0, 0.75)
	b.radius = 8.0
	b.grav = SPORE_G
	b.vel = Vector2(dx / T, (dy - 0.5 * SPORE_G * T * T) / T)
	b.position = start
	level.add_fx(b)
	Fx.burst(level.fx, start, Color(0.45, 1.0, 0.75), 8, 150, 0.4, 0.05)


func _draw() -> void:
	var sway := sin(t * 1.8) * 4.0
	var stalk := fc(Color("0a1d1c"))
	var bulbc := fc(Color("123634"))
	for s: float in [-1.0, 1.0]:
		draw_line(Vector2(0, -4), Vector2(s * 18.0, 0), stalk, 4.0, true)
		draw_line(Vector2(s * 6.0, -2), Vector2(s * 26.0, 2), stalk, 2.5, true)
	var pts := PackedVector2Array()
	for i in 9:
		var s2 := float(i) / 8.0
		pts.append(Vector2(sway * s2 * s2, -s2 * 40.0))
	draw_polyline(pts, stalk, 7.0, true)
	var bc := Vector2(sway, -52)
	var swell := 1.0 + charging * 0.3 + 0.04 * sin(t * 4.0)
	Art.poly(self, Art.ellipse(bc, 17.0 * swell, 15.0 * swell, 22), bulbc)
	for i in 4:
		var a := -PI * 0.9 + i * 0.6
		var sp := bc + Vector2(cos(a) * 9.0, sin(a) * 7.0) * swell
		draw_circle(sp, 3.0 + charging * 2.0, Color(0.5, 1.0, 0.8, 0.6 + 0.4 * charging))
	Art.poly(self, PackedVector2Array([bc + Vector2(-6, -13 * swell), bc + Vector2(0, -24 * swell), bc + Vector2(6, -13 * swell)]), bulbc)
	draw_stun(Vector2(sway, -82))
