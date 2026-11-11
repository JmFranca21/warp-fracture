class_name SporePlant
extends Enemy
## Esporângio — planta fixa que lança esporos em arco.

var cd := 1.5
var charging := 0.0
const SPORE_G := 900.0
const MOUTH := Vector2(30, -60)     # boca do bulbo na arte (olhando para a direita)
var spr: AnimatedSprite2D
var glow: Sprite2D
var face := -1.0
var shot_t := 0.0


func _ready() -> void:
	hp = 3
	max_hp = 3
	heavy = true
	drops = 3
	main_color = Color(0.4, 1.0, 0.8)
	collision_layer = 0
	collision_mask = 0
	setup_hurt(Vector2(40, 60), Vector2(0, -32))
	glow = Art.glow(Color(0.6, 1.0, 0.5, 0.35), 44)
	add_child(glow)
	spr = make_sprite(SpriteMetaVerd.ESPORANGIO_FRAMES, SpriteMetaVerd.ESPORANGIO_OFFSET, SpriteMetaVerd.ESPORANGIO_SCALE, "idle")
	spr.frame = randi() % 6
	cd = 1.0 + randf() * 1.5


func _physics_process(dt: float) -> void:
	tick(dt)
	shot_t -= dt
	var p := player()
	if p != null and stun <= 0.0:
		var d := p.global_position - global_position
		if absf(d.x) > 12.0 and shot_t <= 0.0:
			face = signf(d.x)
		if absf(d.x) < 560.0 and absf(d.y) < 320.0:
			cd -= dt
			charging = clampf(1.0 - cd / 0.6, 0.0, 1.0)
			if cd <= 0.0:
				_shoot(p)
				cd = 2.3
				charging = 0.0
				shot_t = 0.3
	_animate()
	queue_redraw()


## idle → contrai e incha (E_esporangio_attack 1–2) enquanto carrega → cospe (3) → recolhe (4) → idle
func _animate() -> void:
	spr.scale.x = SpriteMetaVerd.ESPORANGIO_SCALE * face
	spr.modulate = flash_mod()
	glow.position = Vector2(14.0 * face, -62.0)
	glow.modulate.a = 0.3 + 0.4 * charging
	if shot_t > 0.0:
		_pose("attack", 2 if shot_t > 0.14 else 3)
	elif charging > 0.0:
		_pose("attack", 0 if charging < 0.5 else 1)
	elif spr.animation != "idle" or not spr.is_playing():
		spr.play("idle")
	spr.speed_scale = 0.3 if stun > 0.0 else 1.0


func _pose(an: String, fr: int) -> void:
	if spr.animation != an:
		spr.play(an)
	spr.pause()
	spr.frame = fr


func die() -> void:
	if dead:
		return
	# murcha no lugar (E_esporangio_death)
	var f := FxAnim.spawn(level.fx, SpriteMetaVerd.ESPORANGIO_FRAMES, SpriteMetaVerd.ESPORANGIO_OFFSET,
		global_position, SpriteMetaVerd.ESPORANGIO_SCALE, "death")
	if f != null:
		f.scale.x *= face
		f.linger = 0.6
		f.z_index = -1
	super.die()


func _shoot(p: Player) -> void:
	var start := global_position + Vector2(MOUTH.x * face, MOUTH.y)
	var tgt := p.global_position + Vector2(p.velocity.x * 0.3, -20)
	var dx := tgt.x - start.x
	var dy := tgt.y - start.y
	var T := clampf(absf(dx) / 420.0, 0.7, 1.3)
	AudioMgr.sfx("esporo", global_position, -4.0, 0.1)
	var b := EnemyBullet.new()
	b.color = Color(0.45, 1.0, 0.75)
	b.radius = 8.0
	b.grav = SPORE_G
	b.sprite = "esporo_verde"
	b.vel = Vector2(dx / T, (dy - 0.5 * SPORE_G * T * T) / T)
	b.position = start
	level.add_fx(b)
	Fx.burst(level.fx, start, Color(0.75, 1.0, 0.45), 6, 120, 0.3, 0.04)


func _draw() -> void:
	draw_stun(Vector2(8.0 * face, -92))
