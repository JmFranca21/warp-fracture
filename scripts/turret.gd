class_name Turret
extends Enemy
## Turreta Sentinela: fixa no chão. Carrega (aviso) e dispara um feixe horizontal.
## O jogador escapa pulando por cima do feixe.

const SPR_SCALE := 0.44
var dir := -1
var state := "idle"
var st := 1.2
var beam_len := 0.0
var spr: Sprite2D
var eye: Sprite2D
var beam_y := -0.0


func _ready() -> void:
	hp = 5
	max_hp = 5
	heavy = true
	drops = 4
	main_color = Color(1.0, 0.3, 0.3)
	collision_layer = 0
	collision_mask = 0
	setup_hurt(Vector2(42, 68), Vector2(0, -35))
	spr = Props.sprite("res://assets/inimigos/turreta/turreta.png", SPR_SCALE, dir < 0)
	add_child(spr)
	# o olho vermelho fica em (93, 43) na imagem de 106x159
	var tex_w := 106.0
	var tex_h := 159.0
	var ex := (93.0 - tex_w / 2.0) * SPR_SCALE * float(dir)
	beam_y = -(tex_h - 43.0) * SPR_SCALE
	eye = Art.glow(Color(1.0, 0.2, 0.2, 0.4), 30)
	eye.position = Vector2(ex, beam_y)
	add_child(eye)
	z_index = 1


func beam_active() -> bool:
	return state == "fire"


func _physics_process(dt: float) -> void:
	tick(dt)
	if dead:
		return
	var p := player()
	if stun > 0.0:
		state = "idle"
		st = 0.6
	st -= dt
	match state:
		"idle":
			if st <= 0.0 and p != null and absf(p.global_position.x - global_position.x) < 760.0 and absf(p.global_position.y - global_position.y) < 200.0:
				state = "charge"
				st = 0.8
				AudioMgr.sfx("turreta_carrega", global_position, -4.0, 0.03)
		"charge":
			if st <= 0.0:
				state = "fire"
				st = 0.55
				AudioMgr.sfx("turreta_feixe", global_position, -2.0, 0.03)
				level.main.add_shake(5.0)
		"fire":
			if st <= 0.0:
				state = "idle"
				st = 1.6
	_update_beam()
	var k := 0.4
	if state == "charge":
		k = 0.5 + 0.5 * absf(sin(t * 20.0))
	elif state == "fire":
		k = 1.0
	eye.modulate.a = k
	eye.scale = Vector2.ONE * (30.0 + (40.0 if state != "idle" else 0.0)) * 2.0 / 128.0
	spr.modulate = Color(2.4, 2.4, 2.4) if flash > 0.0 else Color(1, 1, 1)
	queue_redraw()


func _update_beam() -> void:
	var origin := global_position + Vector2(eye.position.x, beam_y)
	var q := PhysicsRayQueryParameters2D.create(origin, origin + Vector2(dir * 1400.0, 0), 1)
	var hit := get_world_2d().direct_space_state.intersect_ray(q)
	beam_len = 1400.0
	if not hit.is_empty():
		beam_len = absf(hit.position.x - origin.x)
	var p := player()
	if state == "fire" and p != null:
		var ph: Rect2 = Rect2(p.global_position + Vector2(-11, -54), Vector2(22, 54))
		var br := Rect2(minf(origin.x, origin.x + dir * beam_len), origin.y - 8, beam_len, 16)
		if ph.intersects(br):
			p.hurt(origin)


func _draw() -> void:
	var o := Vector2(eye.position.x, beam_y)
	var end := o + Vector2(dir * beam_len, 0)
	if state == "charge":
		var a := 0.25 + 0.35 * absf(sin(t * 20.0))
		draw_line(o, end, Color(1.0, 0.3, 0.3, a), 1.5, true)
	elif state == "fire":
		var w := 10.0 + 3.0 * sin(t * 50.0)
		draw_line(o, end, Color(1.0, 0.2, 0.25, 0.35), w * 2.2, true)
		draw_line(o, end, Color(1.0, 0.35, 0.4, 0.9), w, true)
		draw_line(o, end, Color(1.0, 0.9, 0.9, 1.0), w * 0.3, true)
	draw_stun(Vector2(0, -82))
