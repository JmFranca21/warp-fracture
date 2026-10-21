class_name Lever
extends Interactable
## Alavanca: aciona um mecanismo (ex.: elevador) uma única vez.

var level
var target := ""
var pulled := false
var spr: Sprite2D
var hint := ""


func _setup() -> void:
	size = Vector2(80, 90)
	prompt = "[E] Puxar a alavanca"
	spr = Props.sprite("alavanca", 0.42)
	add_child(spr)
	var g := Art.glow(Color(1.0, 0.3, 0.2, 0.35), 34)
	g.position = Vector2(10, -38)
	add_child(g)
	set_meta("glow", g)


func interact() -> void:
	if pulled:
		return
	pulled = true
	AudioMgr.sfx("alavanca", Vector2.INF, 0.0, 0.0)
	prompt = ""
	refresh_prompt()
	spr.scale.x = -absf(spr.scale.x)
	(get_meta("glow") as Sprite2D).modulate = Color(0.3, 1.0, 0.6, 0.5)
	Fx.burst(level.fx, global_position + Vector2(0, -30), Color(0.4, 1.0, 0.7), 14, 200, 0.4, 0.05)
	main.add_shake(5.0)
	level.trigger(target)
	if hint != "":
		main.hud.notice(hint)
