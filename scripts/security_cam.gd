class_name SecurityCam
extends Node2D
## Câmera de segurança presa no teto. Varre o chão com um cone; se vir o jogador,
## dispara o alarme e libera Rastejadores pelas fendas (uma vez).

var level
var side := 1                 # 1 = olha para a direita, -1 = esquerda
var spawns: Array = []        # pontos de onde saem os Rastejadores
var range_px := 700.0
var floor_y := 800.0
var half := deg_to_rad(15.0)
var t := 0.0
var alarm := false
var alarm_t := 0.0
var spr: Sprite2D
var lights: Array = []


func _ready() -> void:
	z_index = 3
	spr = Props.hanging("camera_corpo", 0.7, side < 0)
	add_child(spr)


func aim_angle() -> float:
	var base := PI / 2.0 - side * 0.75
	return base + sin(t * 0.9) * 0.45


func _physics_process(dt: float) -> void:
	t += dt
	if alarm:
		alarm_t += dt
	var p = level.player
	if not alarm and is_instance_valid(p) and not p.dead:
		var eye := global_position + Vector2(side * 16, 36)
		var to: Vector2 = p.global_position + Vector2(0, -32) - eye
		if p.global_position.y <= floor_y + 2 and to.length() < range_px and absf(angle_difference(to.angle(), aim_angle())) < half:
			var q := PhysicsRayQueryParameters2D.create(eye, eye + to, 1)
			if get_world_2d().direct_space_state.intersect_ray(q).is_empty():
				_trigger_alarm()
	queue_redraw()


func _trigger_alarm() -> void:
	alarm = true
	AudioMgr.sfx("alarme", Vector2.INF, -2.0, 0.0)
	level.main.hud.notice("ALERTA! A câmera detectou você.")
	level.main.add_shake(6.0)
	for s in spawns:
		var pos: Vector2 = s
		Fx.burst(level.fx, pos + Vector2(0, -20), Color(0.6, 0.35, 1.0), 24, 260, 0.6, 0.08)
		Fx.ring(level.fx, pos + Vector2(0, -20), Color(0.7, 0.45, 1.0), 70, 0.4, 4)
		level.spawn_enemy("crawler", pos)
	for b in get_tree().get_nodes_in_group("alarm_lights"):
		b.alarm = true


func _draw() -> void:
	var eye := Vector2(side * 16, 36)
	var a := aim_angle()
	var c := Color(1.0, 0.25, 0.2, 0.10)
	if alarm:
		c = Color(1.0, 0.15, 0.1, 0.18 + 0.12 * sin(alarm_t * 12.0))
	var pts := PackedVector2Array([eye, eye + Vector2.from_angle(a - half) * range_px, eye + Vector2.from_angle(a + half) * range_px])
	# recorta o cone no chão (não atravessa o piso)
	var fy := floor_y - global_position.y
	var clip := PackedVector2Array([Vector2(-2000, -50), Vector2(2000, -50), Vector2(2000, fy), Vector2(-2000, fy)])
	for poly in Geometry2D.intersect_polygons(pts, clip):
		draw_colored_polygon(poly, c)
	var dirv := Vector2.from_angle(a)
	var len := range_px
	if dirv.y > 0.01:
		len = minf(range_px, (fy - eye.y) / dirv.y)
	draw_line(eye, eye + dirv * len, Color(1.0, 0.3, 0.25, 0.25), 1.0, true)
	draw_circle(eye, 3.5, Color(1.0, 0.3, 0.25, 0.9))
