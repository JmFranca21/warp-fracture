class_name SpinKick
extends Area2D
## Chute giratório do Yeti (botão direito): acerta tudo em volta do corpo durante a parte
## ativa da animação, quebra caixas e rebate projéteis inimigos. Filho do jogador.

const RADIUS := 78.0
const ACTIVE_FROM := 0.12      # segundos depois do início
const ACTIVE_TO := 0.42
const DMG := 2

var player
var t := 0.0
var hit := {}
var ring_done := false


func _ready() -> void:
	collision_layer = 8
	collision_mask = 1 | 4 | 32
	z_index = 3
	var cs := CollisionShape2D.new()
	var c := CircleShape2D.new()
	c.radius = RADIUS
	cs.shape = c
	cs.position = Vector2(0, -34)
	add_child(cs)
	monitoring = false


func _physics_process(dt: float) -> void:
	t += dt
	var active := t >= ACTIVE_FROM and t <= ACTIVE_TO
	monitoring = active
	if active and not ring_done:
		ring_done = true
		var c: Vector2 = player.global_position + Vector2(0, -34)
		Fx.ring(player.level.fx, c, Color(0.9, 0.97, 1.0, 0.7), RADIUS, 0.28, 5)
		Fx.burst(player.level.fx, player.global_position, Color(0.95, 0.98, 1.0, 0.8), 16, 240, 0.4, 0.06, 80)
	if active:
		_hits()
	if t > ACTIVE_TO:
		queue_free()


func _hits() -> void:
	var c: Vector2 = player.global_position + Vector2(0, -34)
	for a in get_overlapping_areas():
		if hit.has(a):
			continue
		if a.has_meta("enemy"):
			hit[a] = true
			var e = a.get_meta("enemy")
			if is_instance_valid(e) and not e.dead:
				e.take_hit(DMG, c)
				player.on_hit_enemy(Vector2.ZERO)
	for b in get_overlapping_bodies():
		if b.has_meta("breakable") and not hit.has(b):
			hit[b] = true
			var cr = b.get_meta("breakable")
			if is_instance_valid(cr) and not cr.broken:
				cr.take_hit(DMG, c)
	# rebate tiros inimigos que entram no giro
	for eb in get_tree().get_nodes_in_group("enemy_attack"):
		if eb is EnemyBullet and is_instance_valid(eb) and eb.global_position.distance_to(c) < RADIUS:
			eb.pop()
