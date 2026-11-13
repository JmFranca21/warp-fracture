class_name Debris
extends Node2D
## Pedaço do teto do laboratório caindo na Fuga do Eco (A6), com aviso:
## 1) o teto racha (A8) e uma marca vermelha aparece no chão (0,9 s);
## 2) o pedaço cai e fere quem estiver embaixo;
## 3) bate no chão com poeira (A7) e fica caído, sem ferir, até sumir.

const WARN := 0.9
const CEIL_Y := 220.0
const SIZE := 64.0

var level
var target := Vector2.ZERO     # ponto do chão onde cai
var variant := 0
var t := 0.0
var spr: Sprite2D
var falling := false
var landed := false
var vy := 0.0


func _ready() -> void:
	z_index = 6
	var c := FxAnim.spawn(level.fx, SpriteMetaCells.RACHADURA_TETO_FRAMES, SpriteMetaCells.RACHADURA_TETO_OFFSET,
		Vector2(target.x, CEIL_Y), 0.58 * 1.3)
	if c != null:
		c.linger = 2.0
		c.z_index = 2
	AudioMgr.sfx("rachadura", Vector2(target.x, CEIL_Y), -3.0, 0.08)
	spr = Sprite2D.new()
	spr.texture = Props.tex(SpriteMetaCells.ENTULHO[variant])
	spr.scale = Vector2.ONE * (SIZE / 256.0) * 1.55
	spr.position = Vector2(target.x, CEIL_Y + 18.0)
	spr.rotation = randf_range(-0.3, 0.3)
	spr.visible = false
	add_child(spr)


func _process(dt: float) -> void:
	t += dt
	if not falling and t >= WARN:
		falling = true
		spr.visible = true
	if falling and not landed:
		vy += 2400.0 * dt
		spr.position.y += vy * dt
		spr.rotation += dt * 2.0
		_check_hit()
		if spr.position.y >= target.y - SIZE * 0.42:
			spr.position.y = target.y - SIZE * 0.42
			landed = true
			FxAnim.spawn(level.fx, SpriteMetaCells.POEIRA_LAB_FRAMES, SpriteMetaCells.POEIRA_LAB_OFFSET, target, 0.58 * 1.2)
			AudioMgr.sfx("desaba", target, -2.0, 0.1)
			level.main.add_shake(9.0)
			var tw := create_tween()
			tw.tween_interval(3.5)
			tw.tween_property(self, "modulate:a", 0.0, 0.8)
			tw.tween_callback(queue_free)
	queue_redraw()


func _check_hit() -> void:
	var p: Player = level.player
	if not is_instance_valid(p):
		return
	var r := Rect2(spr.position - Vector2(SIZE, SIZE) * 0.45, Vector2(SIZE, SIZE) * 0.9)
	var pr := Rect2(p.global_position + Vector2(-12, -62), Vector2(24, 62))
	if r.intersects(pr) and p.dash_t <= 0.0:
		p.hurt(spr.position, 1)


func _draw() -> void:
	if landed:
		return
	# marca de aviso no chão: faixa vermelha tracejada que pulsa mais rápido perto da queda
	var k := clampf(t / WARN, 0.0, 1.0)
	var a := 0.35 + 0.45 * absf(sin(t * (8.0 + 14.0 * k)))
	var w := SIZE * 1.1
	var x0 := target.x - w / 2.0
	var i := 0
	while i * 12.0 < w:
		draw_rect(Rect2(x0 + i * 12.0, target.y - 4.0, 7.0, 4.0), Color(1.0, 0.25, 0.25, a))
		i += 1
	# poeira caindo do teto durante o aviso
	if not falling:
		for j in 3:
			var yy := CEIL_Y + fmod(t * 260.0 + j * 37.0, 120.0)
			draw_circle(Vector2(target.x - 14.0 + j * 14.0, yy), 2.0, Color(0.66, 0.72, 0.8, 0.6))
