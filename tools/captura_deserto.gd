extends SceneTree
## Capturas reais do Deserto (1280 × 720, câmera do jogo, zoom 1,1) para conferir a integração da arte v2.
## Entra pelo fluxo do jogo (main.tscn → load_level), com inimigos visíveis e parados. Sem HUD.
## pan=1: a câmera anda pelas Dunas e pelo Salão (60 quadros de 16 px cada) para ver parallax e emendas.
## uso: godot --path . --script res://tools/captura_deserto.gd -- out=/pasta [pan=1] [so=nome]

var game
var out := "user://"
var pan := false
var so := ""
var done := false      # done=1: Forja vencida e fragmento pego (Saída aberta)
# posição do jogador (a câmera segue: 70 à frente, 165 acima, presa aos limites da fase)
const SPOTS := {
	"1_dunas_inicio": Vector2(185, 690), "1_dunas_mastro": Vector2(700, 700), "1_dunas_fosso": Vector2(980, 1000),
	"1_dunas_fachada": Vector2(1400, 700),
	"2_fabrica_esteira": Vector2(1880, 700), "2_fabrica_prensas": Vector2(2450, 700),
	"2_fabrica_plataformas": Vector2(3200, 545),
	"3_salao_passarela": Vector2(3795, 415), "3_salao_torre": Vector2(4635, 415), "3_salao_chao": Vector2(5150, 770),
	"3_salao_valvulas": Vector2(6400, 770),
	"4_camara_entrada": Vector2(7250, 770), "4_camara_centro": Vector2(7770, 770), "5_saida": Vector2(8720, 770),
}


func _initialize() -> void:
	for a in OS.get_cmdline_user_args():
		if a.begins_with("out="):
			out = a.substr(4)
		elif a == "pan=1":
			pan = true
		elif a == "done=1":
			done = true
		elif a.begins_with("so="):
			so = a.substr(3)
	_run.call_deferred()


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func shot(name: String) -> void:
	for i in 3:
		await process_frame
	root.get_viewport().get_texture().get_image().save_png(out.path_join(name + ".png"))


func place(p: Player, pos: Vector2, lv: Level, wait := 2) -> void:
	p.global_position = pos
	p.velocity = Vector2.ZERO
	p.facing = 1
	await ticks(wait)
	paused = true
	game.cam.position = game._cam_target()
	game.cam.reset_smoothing()
	await process_frame
	lv._process(0.0)            # árvore pausada: reposiciona as camadas de parallax para esta câmera


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.hud.visible = false
	if done:
		game.boss_done["deserto"] = true
		game.frags["deserto"] = true
	game.load_level("deserto", Vector2(185, 690), false)
	await ticks(30)
	var lv: Level = game.level
	for e in lv.entities.get_children():
		if e != game.player:
			e.process_mode = Node.PROCESS_MODE_DISABLED
	var p: Player = game.player
	p.inv = 9999.0
	if pan:
		for trecho in [["pan_dunas", Vector2(185, 690)], ["pan_salao", Vector2(3700, 415)]]:
			for f in 60:
				await place(p, trecho[1] + Vector2(f * 16.0, 0), lv)
				await shot("%s_%02d" % [trecho[0], f])
				paused = false
		AudioMgr.inst.shutdown()
		quit(0)
		return
	for k in SPOTS:
		if so != "" and not k.contains(so):
			continue
		await place(p, SPOTS[k], lv, 90 if k.contains("camara") else 2)   # a luta afasta a câmera em 0,8 s
		for i in 20:
			await process_frame
		await shot(k)
		paused = false
	AudioMgr.inst.shutdown()
	quit(0)
