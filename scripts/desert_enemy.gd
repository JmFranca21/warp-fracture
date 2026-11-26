class_name DesertEnemy
extends Enemy
## Robô (DF60–DF65, DF64b) e Drone (DF66–DF69c) do Deserto, do protótipo, com as regras do Autômato (D03):
## - aviso de 0,5 s antes de cada tiro (DF62/DF67);
## - Pulso Magnético: derruba drones e para robôs por 2 s;
## - feixe do Ímã de Fase sem âncora ao alcance: puxa o drone até o chão, atordoado por 1,5 s;
## - drone derrubado cai; se cair no fosso ou no jato de uma válvula, explode.

@export var drone := false
@export var patrol := Vector2.ZERO
@export var pid := ""
var direction := 1
var altitude := 0.0
var cooldown := 1.5
var warning := 0.0
var recoil := 0.0
var sprite: AnimatedSprite2D
var downed := 0.0           # drone no chão (atordoado)
var falling := false
var pull_to := Vector2.INF  # alvo do feixe do ímã
var vy := 0.0


func _ready() -> void:
	altitude = position.y
	hp = 2 if drone else 3
	max_hp = hp
	heavy = true
	# hitbox do desenho v2 na escala do jogo (K = 0,214): robô 231 × 320 → 49 × 68; drone 270 × 175 → 58 × 37
	var size := Vector2(54,34) if drone else Vector2(48,64)
	setup_hurt(size,Vector2.ZERO if drone else Vector2(0,-32))
	# folhas v2 (4 × 2 de 384 × 512): robô com os pés em (192, 472) na origem; drone com o centro da carcaça
	# (192, 256) na origem, e derrubado (DF69c) com a base (472) no chão, 14 px abaixo
	var specs := [["fly","DF66",6],["warn","DF67",3],["fire","DF68",3],["hurt","DF69",2],["down","DF69c",4],
		["dead","DF69b",6]] if drone else [["idle","DF60",4],["walk","DF61",6],["warn","DF62",3],["fire","DF63",3],
		["hurt","DF64",2],["stun","DF64b",4],["dead","DF65",6]]
	sprite = AnimatedSprite2D.new()
	sprite.sprite_frames = SpriteFrames.new()
	for spec in specs:
		var fps := 6.0 if spec[0] == "warn" else 10.0
		DFArt.add_anim(sprite.sprite_frames, spec[0], spec[1], range(spec[2]), fps, spec[0] in ["idle","walk","fly","stun","down"])
	sprite.scale = Vector2.ONE * DFArt.NODE
	add_child(sprite)
	_play("fly" if drone else "idle")


## Troca de animação com a âncora certa (só o drone derrubado muda de âncora).
func _play(anim: String) -> void:
	var anchor := Vector2(192, 472) if not drone else (Vector2(192, 472 - 14.0 / DFArt.K) if anim == "down" else Vector2(192, 256))
	sprite.offset = DFArt.offset(Vector2(384, 512), anchor)
	sprite.play(anim)


## Pulso Magnético (D03): drone cai, robô para.
func magnet_pulse() -> void:
	if dead:
		return
	if drone:
		knock_down()
	else:
		stun = 2.0
		warning = 0.0
		_play("stun")


func knock_down() -> void:
	if dead or not drone:
		return
	falling = true
	pull_to = Vector2.INF
	vy = 0.0
	warning = 0.0
	stun = 1.5
	_play("hurt")


## Feixe do ímã: puxa o drone até o chão à frente do Autômato.
func magnet_pull(to: Vector2) -> void:
	if dead or not drone:
		return
	pull_to = to
	warning = 0.0
	_play("hurt")


func _physics_process(dt: float) -> void:
	if dead:
		return
	tick(dt)
	cooldown -= dt
	recoil -= dt
	if drone and level.desert != null and level.desert.vent_hits(position):
		die()
		return
	if drone and (pull_to != Vector2.INF or falling or downed > 0.0):
		_downed_physics(dt)
		return
	var p := player()
	if flash > 0:
		_play("hurt")
		return
	if stun > 0:
		_play("hurt" if drone else "stun")
		return
	if warning > 0:
		warning -= dt
		if warning <= 0:
			fire()
		return
	if recoil > 0:
		return
	if p != null and cooldown <= 0:
		var delta_pos := p.position-position
		var target := absf(delta_pos.x)<85 and delta_pos.y>0 and delta_pos.y<380 if drone else absf(delta_pos.y)<80 and delta_pos.x*direction>0 and absf(delta_pos.x)<520
		if target:
			warning = 0.5
			_play("warn")
			AudioMgr.sfx("drone_carrega" if drone else "turreta_carrega", position, -6.0, 0.08)
			return
	position.x += direction*(60.0 if drone else 40.0)*dt
	if position.x >= patrol.y or position.x <= patrol.x:
		position.x = clampf(position.x,patrol.x,patrol.y)
		direction = -1 if position.x >= patrol.y else 1
	sprite.flip_h = direction < 0
	if drone:
		position.y = move_toward(position.y, altitude+6*sin(t*2.8), 120.0 * dt)
	_play("fly" if drone else "walk")


## Drone puxado, caindo, no chão atordoado e subindo de volta.
func _downed_physics(dt: float) -> void:
	sprite.rotation = 0.0
	if pull_to != Vector2.INF:
		var d := pull_to - position
		if d.length() < 14.0:
			pull_to = Vector2.INF
			falling = true
			vy = 0.0
		else:
			position += d.normalized() * minf(d.length(), 620.0 * dt)
			return
	if falling:
		vy = minf(vy + 1800.0 * dt, 900.0)
		var q := PhysicsRayQueryParameters2D.create(position, position + Vector2(0, vy * dt + 16.0), 1)
		var hit := get_world_2d().direct_space_state.intersect_ray(q)
		if hit.is_empty():
			position.y += vy * dt
			sprite.rotation = sin(t * 20.0) * 0.4
		else:
			position.y = hit["position"].y - 14.0
			falling = false
			downed = 1.5
			stun = 1.5
			AudioMgr.sfx("pouso", position, -2.0, 0.1)
			Desert.effect(level.fx, "DF83", 6, position + Vector2(0, 14))
		if position.y > float(level.data["kill_y"]) - 120.0 or (level.desert != null and level.desert.vent_hits(position)):
			die()
		return
	if level.desert != null and level.desert.vent_hits(position):
		die()
		return
	downed -= dt
	_play("down" if downed > 0.0 else "hurt")
	if downed <= 0.0:
		position.y = move_toward(position.y, altitude, 200.0 * dt)
		if absf(position.y - altitude) < 2.0:
			downed = 0.0
			_play("fly")


func fire() -> void:
	_play("fire")
	recoil = 0.3
	cooldown = 2.0
	AudioMgr.sfx("drone_tiro" if drone else "turreta_feixe", position, -5.0, 0.08)
	var shot := DesertShot.new()
	shot.drone = drone
	shot.vel = Vector2.DOWN*255 if drone else Vector2(direction*270,0)
	shot.position = position + (Vector2(0,18) if drone else Vector2(direction*30,-27))
	level.fx.add_child(shot)


func die() -> void:
	if dead:
		return
	dead = true
	if pid != "":
		level.main.collected[pid] = true
	sprite.rotation = 0.0
	_play("dead")
	AudioMgr.sfx("explosao", position, -6.0, 0.1)
	Desert.effect(level.fx,"DF84",8,position-(Vector2.ZERO if drone else Vector2(0,32)),1.4)
	for i in drops:
		level.drop_cell(global_position + Vector2(0, -24))
	level.main.add_shake(6.0)
	await sprite.animation_finished
	queue_free()


class DesertShot extends EnemyBullet:
	var drone := false

	func _ready() -> void:
		add_to_group("enemy_shots")
		super()
		var visual := Desert.effect(self,"DF71" if drone else "DF70",4,Vector2.ZERO,1.5,true)
		visual.flip_h = vel.x < 0
		color = Color("#cb4336") if drone else Color("#f2b24c")

	func _draw() -> void:
		pass

	func pop() -> void:
		if not is_queued_for_deletion():
			Desert.effect(get_parent(),"DF85",4,position,1.2)
			queue_free()
