class_name Fuga
extends Node2D
## Fuga do Eco (Etapa 7): clímax do Laboratório Hélix.
## Começa quando o jogador entra na Sala G depois de abrir a porta com os dois terminais.
## Salva um ponto de retorno no início, liga o alarme e a trilha de fuga, faz o Eco surgir por uma
## fenda atrás da porta e derruba o teto e o piso pelo caminho até o portal da Galeria.
## Perto do portal, a luz do portal segura o Eco à distância (dá para calibrar com calma).
## Ao atravessar, o Eco se desfaz e o evento fica salvo ("fuga_lab").

var level
var main
var cfg: Dictionary
var active := false
var done := false
var eco: Eco
var debris_left: Array = []
var slab: CollapseSlab
var slab_fired := false
var alarm_t := 0.0
var red: ColorRect


func _ready() -> void:
	debris_left = cfg["debris"].duplicate()
	slab = CollapseSlab.new()
	slab.rect = cfg["slab"]
	level.add_child(slab)


func _physics_process(dt: float) -> void:
	var p: Player = level.player
	if not is_instance_valid(p) or done:
		return
	if not active:
		if level.door != null and level.door.opened and p.global_position.x >= cfg["trigger_x"] \
				and p.global_position.y > 500.0 and not main.transitioning:
			_start()
		return
	# teto cedendo à frente do jogador
	for i in range(debris_left.size() - 1, -1, -1):
		var d: Array = debris_left[i]
		if p.global_position.x >= float(d[0]) - 380.0:
			var e := Debris.new()
			e.level = level
			e.target = Vector2(d[0], d[1])
			e.variant = i % 3
			level.add_fx(e)
			debris_left.remove_at(i)
	# piso se fendendo sobre o fosso da Galeria
	if not slab_fired and p.global_position.x >= cfg["slab_trigger_x"]:
		slab_fired = true
		slab.collapse()
	# zona do portal
	if is_instance_valid(eco) and level.portal != null:
		var near := absf(p.global_position.x - level.portal.global_position.x) < float(cfg["portal_safe"])
		eco.hold_x = level.portal.global_position.x - float(cfg["portal_safe"]) - 40.0 if near else INF
		if not near and eco.state == "hold":
			eco.state = "advance"
			eco._play("advance")
	# alarme
	alarm_t -= dt
	if alarm_t <= 0.0:
		alarm_t = 1.6
		AudioMgr.sfx("alarme", Vector2.INF, -9.0, 0.0)
	if red != null:
		red.color.a = 0.07 + 0.05 * sin(Time.get_ticks_msec() * 0.008)
	if randf() < dt * 0.8:
		main.add_shake(2.5)


func _start() -> void:
	active = true
	var start: Vector2 = cfg["start"]
	main.set_checkpoint(start)        # ponto de retorno no início da fuga (Integridade cheia)
	AudioMgr.music("fuga")
	main.add_shake(16.0)
	main.hud.show_title("FUGA", "O laboratório está desabando")
	main.hud.notice("IRIS: \"Daymon, a fratura está se abrindo! Corra para o portal!\"")
	var cl := CanvasLayer.new()
	cl.layer = 5
	red = ColorRect.new()
	red.color = Color(1.0, 0.1, 0.15, 0.0)
	red.mouse_filter = Control.MOUSE_FILTER_IGNORE
	red.set_anchors_preset(Control.PRESET_FULL_RECT)
	cl.add_child(red)
	add_child(cl)
	# o Eco nasce de uma fenda atrás da porta
	var sp: Vector2 = cfg["eco_spawn"]
	var f := FxAnim.spawn(level.fx, SpriteMetaCells.ECO_DOBRA_FRAMES, SpriteMetaCells.ECO_DOBRA_OFFSET, sp, 0.58)
	if f != null:
		f.z_index = 3
	AudioMgr.sfx("eco_dobra", sp)
	await get_tree().create_timer(0.45, false).timeout
	if done or not is_instance_valid(level.player):
		return
	eco = Eco.new()
	eco.level = level
	eco.player = level.player
	eco.position = sp
	level.entities.add_child(eco)
	eco.seed_trail()


## Chamado ao entrar no portal.
func finish() -> void:
	if done:
		return
	done = true
	if is_instance_valid(eco):
		eco.vanish()
	main.events["fuga_lab"] = true
