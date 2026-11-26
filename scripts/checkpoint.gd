class_name Checkpoint
extends Interactable
## Estação de Recarga: restaura a Integridade e salva o ponto de retorno.

var glow: Sprite2D
var used_t := 0.0
var estacao: Array = []     # Deserto: [apagada, ativa]


func _setup() -> void:
	prompt = "[E] Descansar na Estação de Recarga"
	glow = Art.glow(Color(0.4, 0.95, 1.0, 0.4) if theme in ["lab", "deserto", "nivaria"] else Color(0.6, 1.0, 0.7, 0.4), 110)
	glow.position = Vector2(0, -50)
	add_child(glow)
	if theme == "deserto":
		# DF210: estação apagada (0) e ativa (1), base (256, 472) no chão, escala do jogo
		for i in 2:
			var st := Sprite2D.new()
			st.texture = DFArt.cell("DF210_objetos", i, 4, 2)
			st.offset = DFArt.offset(Vector2(512, 512), Vector2(256, 472))
			st.scale = Vector2.ONE * DFArt.NODE
			add_child(st)
			estacao.append(st)
		glow.position = Vector2(0, -48)
	elif theme in ["lab", "nivaria"]:
		var spr := Props.sprite("celula_suporte", 0.55)
		add_child(spr)
		glow.position = Vector2(0, -42)
	else:
		# santuário orgânico (VD_checkpoint), apoiado no chão
		var shrine := Props.sprite(SpriteMetaVerd.OBJ_DIR + "checkpoint.png", SpriteMetaVerd.OBJ_SCALE)
		shrine.position = Vector2(0, 5)
		add_child(shrine)
		glow.position = Vector2(0, -38)
		glow.scale *= 0.7


func interact() -> void:
	main.set_checkpoint(global_position)
	used_t = 1.0
	Fx.burst(main.level.fx, global_position + Vector2(0, -40), Color(0.5, 1.0, 0.9), 30, 260, 0.8, 0.08, -100)
	Fx.ring(main.level.fx, global_position + Vector2(0, -40), Color(0.5, 1.0, 0.9), 120, 0.5, 5)


func _process(dt: float) -> void:
	super._process(dt)
	used_t = maxf(0.0, used_t - dt)
	glow.modulate.a = 0.35 + 0.1 * sin(t * 2.0) + used_t * 0.5
	if not estacao.is_empty():
		var ativa: bool = main.checkpoint_level == main.level.id and main.checkpoint_pos.distance_to(global_position) < 20.0
		estacao[0].visible = not ativa
		estacao[1].visible = ativa


func _draw() -> void:
	if theme in ["lab", "deserto", "nivaria"]:
		var k := 0.35 + 0.15 * sin(t * 2.0) + used_t * 0.5
		draw_arc(Vector2(0, -2), 46.0, 0.0, TAU, 40, Color(0.35, 0.9, 1.0, k * 0.6), 2.0, true)
		for i in 3:
			var y := -20.0 - fmod(t * 25.0 + i * 20.0, 70.0)
			var x := -26.0 + i * 26.0
			draw_line(Vector2(x - 4, y), Vector2(x + 4, y), Color(0.5, 1.0, 1.0, 0.6), 2.0)
			draw_line(Vector2(x, y - 4), Vector2(x, y + 4), Color(0.5, 1.0, 1.0, 0.6), 2.0)
		return
