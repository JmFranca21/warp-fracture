extends SceneTree
## DF205: captura no jogo os sete recortes do gabarito de colisões e as quatro larguras de passarela,
## com e sem a colisão desenhada por cima (ciano: apoio e faces; vermelho: linha de dano dos fossos).
## uso: godot --path . --script res://tools/df205_encaixes.gd -- out=/pasta

var game
var out := "user://"
const CROPS := {   # tools/gen_gabarito_df205.py
	"1_dunas_fosso": Rect2(560, 460, 860, 540),
	"2_dunas_fabrica": Rect2(1420, 460, 860, 540),
	"3_fabrica_maquinas": Rect2(2600, 340, 860, 660),
	"4_salao_passarelas": Rect2(3480, 140, 1560, 860),
	"5_salao_fosso": Rect2(4900, 500, 1260, 500),
	"6_camara": Rect2(6900, 80, 1720, 920),
	"7_saida": Rect2(8440, 300, 540, 700),
}


const DETAIL := {   # emendas conferidas em 1:4 (ponto do mundo no centro)
	"areia_fosso_780": Vector2(780, 720), "areia_fosso_1180": Vector2(1180, 720), "fosso_dunas": Vector2(980, 870),
	"transicao_1700": Vector2(1700, 730), "esteira_fim_2780": Vector2(2780, 730), "coluna_2942": Vector2(2942, 680),
	"chapa_4980": Vector2(4980, 790), "chapa_5490": Vector2(5490, 790), "chapa_6030": Vector2(6030, 790),
	"camara_canto_7050": Vector2(7050, 160), "camara_canto_8490": Vector2(8490, 160),
	"verga_6990": Vector2(7020, 590), "verga_8490": Vector2(8520, 590),
	"saida_canto_8550": Vector2(8550, 410), "saida_canto_8900": Vector2(8900, 410), "saida_chao_8900": Vector2(8880, 770),
}


class Overlay extends Node2D:
	var solids: Array = []
	var pits: Array = []
	func _draw() -> void:
		for r: Rect2 in solids:
			draw_rect(r, Color(0.22, 0.9, 1.0, 0.9), false, 1.0)
		for p: Rect2 in pits:
			draw_line(p.position, Vector2(p.end.x, p.position.y), Color(1.0, 0.19, 0.23), 1.0)


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func shot(name: String) -> void:
	await process_frame
	await process_frame
	await process_frame
	root.get_viewport().get_texture().get_image().save_png(out.path_join(name + ".png"))


func look(rect: Rect2, zmax := 4.0) -> void:
	game.cam.limit_left = -10000
	game.cam.limit_top = -10000
	game.cam.limit_right = 20000
	game.cam.limit_bottom = 20000
	var z := minf(minf(1280.0 / rect.size.x, 720.0 / rect.size.y), zmax)
	game.cam.zoom = Vector2(z, z)
	game.cam.position = rect.get_center()
	game.cam.reset_smoothing()
	for lv in game.level.bg_layers:
		lv.queue_redraw()


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	for id in Logs.ORDER:
		game.collected[id] = true
	game.load_level("deserto", Vector2(185, 690), false)
	await ticks(20)
	var lv: Level = game.level
	for e in lv.entities.get_children():
		e.visible = false
		if e != game.player:
			e.process_mode = Node.PROCESS_MODE_DISABLED
	game.player.inv = 9999.0
	game.cam.limit_left = -10000
	game.cam.limit_top = -10000
	game.cam.limit_right = 20000
	game.cam.limit_bottom = 20000
	game.cam.position_smoothing_enabled = false
	var ov := Overlay.new()
	ov.solids = lv.data["solids"]
	ov.pits = Desert.PITS
	ov.z_index = 100
	lv.add_child(ov)
	var shots := {}
	for k in CROPS:
		shots[k] = CROPS[k]
	var i := 0
	for r: Rect2 in Desert.FLOOR:
		if r.size.y < 60.0:
			shots["passarela_%d" % int(r.size.x)] = r.grow_individual(30, 70, 30, 60)
		i += 1
	for k in DETAIL:
		shots["emenda_" + k] = Rect2(DETAIL[k] - Vector2(150, 90), Vector2(300, 180))
	for k in shots:
		paused = true
		# main segue o jogador mesmo com a árvore pausada: o alvo dele (70 à frente, 165 acima) vai ao centro do recorte
		var p: Player = game.player
		p.global_position = shots[k].get_center() - Vector2(p.facing * 70.0, -165.0)
		look(shots[k], 4.0 if not CROPS.has(k) else 1.0)
		await ticks(2)
		ov.visible = false
		await shot(k)
		ov.visible = true
		await shot(k + "_colisao")
		paused = false
	print("capturas: ", shots.size())
	AudioMgr.inst.shutdown()
	quit(0)
