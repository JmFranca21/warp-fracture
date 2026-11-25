class_name Snowball
extends Bullet
## Bola de neve do Yeti (ataque esquerdo). Mira livre como o Estabilizador do laboratório,
## mas é mais lenta e faz um arco leve por causa da gravidade.

const GRAV_SNOW := 520.0
var vel := Vector2.ZERO
var spin := 0.0


func _ready() -> void:
	speed = 820.0
	life = 1.3
	super._ready()
	g.modulate = Color(0.85, 0.95, 1.0, 0.35)
	vel = dir * speed


func _physics_process(dt: float) -> void:
	vel.y += GRAV_SNOW * dt
	dir = vel.normalized()
	speed = vel.length()
	spin += dt * 12.0
	super._physics_process(dt)


func _pop() -> void:
	if is_queued_for_deletion():
		return
	Fx.burst(get_parent(), global_position, Color(0.95, 0.98, 1.0, 0.95), 12, 200, 0.4, 0.06, 260)
	queue_free()


func _draw() -> void:
	# rastro de neve e bola com sombra do lado de baixo
	draw_line(-dir * 16.0, Vector2.ZERO, Color(0.9, 0.96, 1.0, 0.35), 8.0, true)
	draw_circle(Vector2.ZERO, 8.0, Color(0.72, 0.8, 0.92))
	draw_circle(Vector2(-1.5, -1.5), 6.5, Color(0.96, 0.98, 1.0))
	draw_circle(Vector2(cos(spin), sin(spin)) * 3.5, 1.6, Color(0.75, 0.83, 0.95))
