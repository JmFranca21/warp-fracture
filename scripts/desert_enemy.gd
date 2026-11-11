class_name DesertEnemy
extends Enemy

var drone := false
var patrol := Vector2.ZERO
var pid := ""
var direction := 1
var altitude := 0.0
var cooldown := 1.5
var warning := 0.0
var recoil := 0.0
var sprite: AnimatedSprite2D

func _ready() -> void:
	altitude = position.y
	hp = 2 if drone else 3
	max_hp = hp
	var size := Vector2(50,28) if drone else Vector2(54,47)
	setup_hurt(size,Vector2.ZERO if drone else Vector2(0,-22))
	var specs := [["fly","DF66",6],["warn","DF67",3],["fire","DF68",3],["hurt","DF69",2],["dead","DF69b",6]] if drone else [
		["idle","DF60",4],["walk","DF61",6],["warn","DF62",3],["fire","DF63",3],["hurt","DF64",2],["dead","DF65",6]]
	sprite = AnimatedSprite2D.new()
	sprite.sprite_frames = SpriteFrames.new()
	for spec in specs:
		var temp := Desert.animation(spec[1],spec[2],10,false)
		sprite.sprite_frames.add_animation(spec[0])
		sprite.sprite_frames.set_animation_loop(spec[0],spec[0] in ["idle","walk","fly"])
		sprite.sprite_frames.set_animation_speed(spec[0],6 if spec[0]=="warn" else 10)
		for i in int(spec[2]):
			sprite.sprite_frames.add_frame(spec[0],temp.sprite_frames.get_frame_texture("default",i))
		temp.free()
	# Mantém o centro do drone e os pés do robô nas âncoras das folhas.
	sprite.scale = Vector2(0.56,0.50)
	sprite.position.y = 0 if drone else -40
	add_child(sprite)
	sprite.play("fly" if drone else "idle")

func _physics_process(dt: float) -> void:
	if dead:
		return
	tick(dt)
	cooldown -= dt
	recoil -= dt
	var p := player()
	if flash > 0:
		sprite.play("hurt")
		return
	if warning > 0:
		warning -= dt
		if warning <= 0:
			fire()
		return
	if recoil > 0 or stun > 0:
		return
	if p != null and cooldown <= 0:
		var delta_pos := p.position-position
		var target := absf(delta_pos.x)<85 and delta_pos.y>0 and delta_pos.y<380 if drone else absf(delta_pos.y)<80 and delta_pos.x*direction>0 and absf(delta_pos.x)<520
		if target:
			warning = 0.5
			sprite.play("warn")
			return
	position.x += direction*(60.0 if drone else 40.0)*dt
	if position.x >= patrol.y or position.x <= patrol.x:
		position.x = clampf(position.x,patrol.x,patrol.y)
		direction = -1 if position.x >= patrol.y else 1
	sprite.flip_h = direction < 0
	if drone:
		position.y = altitude+6*sin(t*2.8)
	sprite.play("fly" if drone else "walk")

func fire() -> void:
	sprite.play("fire")
	recoil = 0.3
	cooldown = 2.0
	var shot := DesertShot.new()
	shot.drone = drone
	shot.vel = Vector2.DOWN*255 if drone else Vector2(direction*270,0)
	shot.position = position + (Vector2(0,18) if drone else Vector2(direction*30,-27))
	level.fx.add_child(shot)

func die() -> void:
	if dead:
		return
	dead = true
	level.main.collected[pid] = true
	sprite.play("dead")
	AudioMgr.sfx("inimigo_morre",position)
	Desert.effect(level.fx,"DF84",8,position-Vector2(0,18),Vector2(110,115))
	await sprite.animation_finished
	queue_free()

class DesertShot extends EnemyBullet:
	var drone := false

	func _ready() -> void:
		super()
		var visual := Desert.effect(self,"DF71" if drone else "DF70",4,Vector2.ZERO,Vector2(72,80),true)
		visual.flip_h = vel.x < 0
		color = Color("#cb4336") if drone else Color("#f2b24c")

	func _draw() -> void:
		pass

	func pop() -> void:
		if not is_queued_for_deletion():
			Desert.effect(get_parent(),"DF85",4,position,Vector2(75,75))
			queue_free()
