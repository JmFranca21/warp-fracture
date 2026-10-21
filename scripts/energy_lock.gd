class_name EnergyLock
extends Interactable
## Trava de energia: recebe 1/3 da Energia de Fase do jogador e desliga o campo de força.

const COST := 33.0
var level
var target := ""
var open := false
var spr: Sprite2D
var ring: Sprite2D


func _setup() -> void:
	size = Vector2(90, 110)
	prompt = "[E] Transferir 1/3 de Energia de Fase"
	spr = Props.centered("trava", 0.42)
	spr.position = Vector2(0, -82)
	add_child(spr)
	ring = Art.glow(Color(0.6, 0.35, 1.0, 0.5), 40)
	ring.position = spr.position
	add_child(ring)


func interact() -> void:
	if open:
		return
	var p: Player = main.player
	if p.energy < COST:
		main.hud.energy_denied()
		main.hud.notice("Energia insuficiente. Acerte inimigos ou pegue uma Célula de Energia.")
		return
	p.energy -= COST
	open = true
	prompt = ""
	refresh_prompt()
	ring.modulate = Color(0.3, 1.0, 0.6, 0.6)
	Fx.burst(level.fx, global_position + Vector2(0, -82), Color(0.4, 0.9, 1.0), 20, 220, 0.5, 0.06)
	level.trigger(target)
	main.hud.notice("Trava energizada: campo de força desligado!")


func _process(dt: float) -> void:
	super._process(dt)
	if not open:
		ring.modulate.a = 0.35 + 0.25 * sin(t * 4.0)


func _draw() -> void:
	# pedestal que sustenta a trava (preso ao chão)
	var dark := Color("141d2a")
	draw_rect(Rect2(-9, -64, 18, 64), dark)
	draw_rect(Rect2(-18, -8, 36, 8), Color("1b2738"))
	draw_line(Vector2(-9, -64), Vector2(-9, 0), Color("26364d"), 2.0)
	var c := Color(0.3, 1.0, 0.6) if open else Color(0.75, 0.45, 1.0)
	draw_rect(Rect2(-4, -48, 8, 3), Color(c, 0.8))
