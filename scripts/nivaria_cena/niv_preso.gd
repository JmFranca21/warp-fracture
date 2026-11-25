@tool
class_name NivPreso
extends Node2D
## Alpinista preso num bloco de gelo: obstáculo sólido que fecha a passagem.
## Quebra com bolas de neve ou chute giratório (aguenta 4 de dano). Quando o gelo parte, o alpinista
## se solta e foge correndo para o lado contrário ao Yeti, até sumir.
## A posição do nó é o meio da base do bloco, no chão. Arte: assets/nivaria/props/alpinista.png.

const TEX := "res://assets/nivaria/props/alpinista.png"
const CELL := Vector2(300, 300)
const ANCHOR := Vector2(150, 292)
const ESCALA := 0.55
const HP := 4
const TAMANHO := Vector2(64, 96)     # colisão do bloco

var level                            # Level (o Nivaria preenche)
var hp := HP
var broken := false
var spr: Sprite2D
var body: StaticBody2D
var runner: CharacterBody2D
var flash := 0.0
var anim_t := 0.0
var run_dir := 1.0
var stage := 0                       # 0 preso · 1 soltando · 2 correndo


func _ready() -> void:
	spr = Sprite2D.new()
	spr.texture = load(TEX) if ResourceLoader.exists(TEX) else null
	spr.region_enabled = true
	spr.centered = false
	spr.scale = Vector2(ESCALA, ESCALA)
	spr.position = -ANCHOR * ESCALA
	_frame(0, 0)
	add_child(spr)
	if Engine.is_editor_hint():
		return
	z_index = 2
	body = StaticBody2D.new()
	body.collision_layer = 1
	body.collision_mask = 0
	body.set_meta("breakable", self)
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = TAMANHO
	cs.shape = r
	cs.position = Vector2(0, -TAMANHO.y / 2.0)
	body.add_child(cs)
	add_child(body)


func _frame(row: int, i: int) -> void:
	spr.region_rect = Rect2(i * CELL.x, row * CELL.y, CELL.x, CELL.y)


func take_hit(dmg: int, from: Vector2) -> void:
	if broken:
		return
	hp -= dmg
	flash = 0.08
	var c := global_position + Vector2(0, -TAMANHO.y * 0.5)
	if level != null:
		Fx.burst(level.fx, c, Color(0.75, 0.92, 1.0, 0.9), 6, 180, 0.35, 0.05, 300)
		level.main.add_shake(2.0)
	AudioMgr.sfx("caixa_quebra", c, -8.0, 0.2)
	if hp <= 0:
		_break(from)
	else:
		_frame(0, clampi(HP - hp, 0, 2))


func _break(from: Vector2) -> void:
	broken = true
	stage = 1
	anim_t = 0.0
	body.queue_free()
	var c := global_position + Vector2(0, -TAMANHO.y * 0.5)
	AudioMgr.sfx("caixa_quebra", c, 0.0, 0.05)
	if level != null:
		Fx.burst(level.fx, c, Color(0.75, 0.92, 1.0, 0.95), 22, 320, 0.6, 0.08, 500)
		Fx.ring(level.fx, c, Color(0.85, 0.95, 1.0, 0.5), 70, 0.3, 4)
		level.main.add_shake(5.0)
	# foge para o lado oposto ao Yeti (ou a quem bateu)
	var px := from.x
	if level != null and is_instance_valid(level.player):
		px = level.player.global_position.x
	run_dir = 1.0 if global_position.x >= px else -1.0


func _process(dt: float) -> void:
	if Engine.is_editor_hint():
		return
	flash = maxf(0.0, flash - dt)
	spr.modulate = Color(1.8, 1.9, 2.0) if flash > 0.0 else Color(1, 1, 1)
	anim_t += dt
	match stage:
		1:
			var f := 3 + int(anim_t * 11.0)
			if f <= 7:
				_frame(0, f)
				# olha para onde vai fugir
				spr.flip_h = run_dir < 0.0
				spr.position = Vector2((ANCHOR.x - CELL.x) * ESCALA if spr.flip_h else -ANCHOR.x * ESCALA, -ANCHOR.y * ESCALA)
			if anim_t > 0.75:
				_start_run()
		2:
			_frame(1, int(anim_t * 14.0) % 8)
			if anim_t > 4.0:
				spr.modulate.a = clampf(1.0 - (anim_t - 4.0) / 0.5, 0.0, 1.0)
				if anim_t > 4.5:
					queue_free()


## O sprite passa para um corpo com gravidade que corre pelo terreno (desce encostas e cai de beiradas).
func _start_run() -> void:
	stage = 2
	anim_t = 0.0
	runner = CharacterBody2D.new()
	runner.collision_layer = 0
	runner.collision_mask = 1 | 256
	runner.floor_snap_length = 10.0
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = Vector2(26, 60)
	cs.shape = r
	cs.position = Vector2(0, -30)
	runner.add_child(cs)
	add_child(runner)
	spr.reparent(runner, false)
	# a prancha de corrida olha para a esquerda
	spr.flip_h = run_dir > 0.0
	spr.position = Vector2((ANCHOR.x - CELL.x) * ESCALA if spr.flip_h else -ANCHOR.x * ESCALA, -ANCHOR.y * ESCALA)


func _physics_process(dt: float) -> void:
	if Engine.is_editor_hint() or runner == null:
		return
	runner.velocity.x = run_dir * 230.0
	runner.velocity.y = 0.0 if runner.is_on_floor() else minf(runner.velocity.y + 1400.0 * dt, 900.0)
	runner.move_and_slide()
	if runner.is_on_wall():
		run_dir = -run_dir
		spr.flip_h = run_dir > 0.0
		spr.position = Vector2((ANCHOR.x - CELL.x) * ESCALA if spr.flip_h else -ANCHOR.x * ESCALA, -ANCHOR.y * ESCALA)
	if runner.global_position.y > 1300.0:
		queue_free()
