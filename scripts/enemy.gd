class_name Enemy
extends CharacterBody2D
## Base dos inimigos ("hazards com inteligência").

var level
var hp := 2
var max_hp := 2
var flash := 0.0
var stun := 0.0
var knock_t := 0.0
var dead := false
var t := 0.0
var hurt_area: Area2D
var drops := 2
var heavy := false
var main_color := Color(0.7, 0.5, 1.0)


func _enter_tree() -> void:
	add_to_group("enemies")


func setup_body(size: Vector2) -> void:
	collision_layer = 0
	collision_mask = 1
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = size
	cs.shape = r
	cs.position = Vector2(0, -size.y / 2.0)
	add_child(cs)


func setup_hurt(size: Vector2, off: Vector2) -> void:
	hurt_area = Area2D.new()
	hurt_area.collision_layer = 4
	hurt_area.collision_mask = 0
	hurt_area.monitoring = false
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = size
	cs.shape = r
	cs.position = off
	hurt_area.add_child(cs)
	hurt_area.set_meta("enemy", self)
	add_child(hurt_area)


func tick(dt: float) -> void:
	t += dt
	flash = maxf(0.0, flash - dt)
	stun -= dt
	knock_t -= dt


func player() -> Player:
	if level == null or not is_instance_valid(level.player) or level.player.dead:
		return null
	return level.player


func take_hit(dmg: int, from: Vector2) -> void:
	if dead:
		return
	hp -= dmg
	flash = 0.12
	AudioMgr.sfx("acerto", global_position, -3.0, 0.12)
	if not heavy:
		knock_t = 0.16
		var d := (global_position + Vector2(0, -16) - from).normalized()
		velocity = d * 340.0
	Fx.burst(level.fx, global_position + Vector2(0, -16), Color(1, 1, 1), 10, 260, 0.3, 0.05)
	if hp <= 0:
		die()


func die() -> void:
	if dead:
		return
	dead = true
	AudioMgr.sfx("inimigo_morre", global_position, -2.0, 0.1)
	Fx.burst(level.fx, global_position + Vector2(0, -16), main_color, 28, 360, 0.7, 0.09)
	Fx.ring(level.fx, global_position + Vector2(0, -16), main_color, 70, 0.35, 4)
	for i in drops:
		level.drop_cell(global_position + Vector2(0, -24))
	level.main.add_shake(6.0)
	queue_free()


func fc(c: Color) -> Color:
	if flash > 0.0:
		return c.lerp(Color(1, 1, 1, c.a), 0.85)
	return c


func draw_stun(p: Vector2) -> void:
	if stun <= 0.0:
		return
	for i in 3:
		var a := t * 6.0 + TAU * i / 3.0
		draw_circle(p + Vector2(cos(a) * 14.0, sin(a) * 5.0), 2.5, Color(0.9, 1.0, 0.6, 0.9))
