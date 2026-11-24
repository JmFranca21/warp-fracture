extends SceneTree
## DF205: confere a montagem do terreno do Deserto (passarelas, cantos, bordas) e que as colisões não mudaram.
## uso: godot --path . --script res://tools/test_df205.gd

var game
var fails := 0
# sólidos da v0.8 (antes da DF205), na ordem de layout()
const ANTES := [Rect2(-120,700,900,360), Rect2(1180,700,520,360), Rect2(1700,700,1080,360),
	Rect2(2870,625,145,26), Rect2(3100,545,240,28), Rect2(3580,415,430,40), Rect2(4410,415,450,40),
	Rect2(4980,770,510,320), Rect2(6030,770,2870,320), Rect2(-60,-200,60,1350), Rect2(6990,-200,60,780),
	Rect2(7050,-200,1440,350), Rect2(8490,-200,60,780), Rect2(8550,-200,350,600), Rect2(8900,-200,60,1350)]


func check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FALHA ") + what)
	if not ok:
		fails += 1


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func _initialize() -> void:
	_run.call_deferred()


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto.clear()
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	for id in Logs.ORDER:
		game.collected[id] = true
	game.load_level("deserto", Vector2(185, 690), false)
	await ticks(20)
	var lv: Level = game.level
	check(lv.data["solids"] == ANTES, "colisões iguais às da v0.8 (%d sólidos)" % ANTES.size())
	var t: DFTerrain = null
	for c in lv.desert.get_children():
		if c is DFTerrain:
			t = c
	check(t != null, "terreno DF205 montado")
	# passarelas: painéis inteiros de 32 px, miolo centralizado, chapas de junção dentro do vão
	var want := {145: 1, 240: 4, 430: 10, 450: 11}
	for r: Rect2 in t.thin:
		var w := int(r.size.x)
		var n := DFTerrain.panels(r.size.x)
		var gap := r.size.x - 2.0 * DFTerrain.PONTA
		var side := (gap - n * DFTerrain.PAINEL) / 2.0
		check(n == want.get(w, -1), "passarela de %d px: %d painéis (pedido: %d)" % [w, n, want.get(w, -1)])
		check(side >= 0.0 and side <= DFTerrain.JUNCAO, "  sobra de %.1f px por lado, coberta pela chapa de %d px" % [side, int(DFTerrain.JUNCAO)])
	check(t.suspended.size() == 2 and t.thin.size() == 4, "2 passarelas com tirantes e 2 plataformas de máquina com coluna")
	# cantos internos teto–parede
	var corners := t.inner_corners().map(func(c): return c[0])
	var expect := [Vector2(7050, 150), Vector2(8490, 150), Vector2(8550, 400), Vector2(8900, 400)]
	var all_in := true
	for e in expect:
		all_in = all_in and corners.has(e)
	check(all_in and corners.size() == 4, "4 cantos internos teto–parede: %s" % str(corners))
	# quinas de cima nas bordas dos fossos
	var open_l := []
	var open_r := []
	for r: Rect2 in t.blocks:
		if r.size.y > 100.0 and r.position.y > 0.0 and r != t.belt:
			if t._corner_open(r, -1):
				open_l.append(int(r.position.x))
			if t._corner_open(r, 1):
				open_r.append(int(r.end.x))
	check(open_l == [-120, 1180, 4980, 6030] and open_r == [780, 5490], "quinas: esquerda %s, direita %s" % [str(open_l), str(open_r)])
	# o Autômato apoia exatamente na linha de cada superfície
	var p: Player = game.player
	p.inv = 9999.0
	for e in lv.entities.get_children():
		if e != p:
			e.process_mode = Node.PROCESS_MODE_DISABLED
	var tops := [Vector2(300, 700), Vector2(1400, 700), Vector2(2300, 700), Vector2(2942, 625), Vector2(3220, 545),
		Vector2(3795, 415), Vector2(4635, 415), Vector2(5200, 770), Vector2(7770, 770), Vector2(8700, 770)]
	for tp: Vector2 in tops:
		p.global_position = tp - Vector2(0, 40)
		p.velocity = Vector2.ZERO
		await ticks(40)
		check(p.is_on_floor() and absf(p.global_position.y - tp.y) < 1.5, "apoio em x %d: pés em y %.1f (linha %d)" % [int(tp.x), p.global_position.y, int(tp.y)])
	print("DF205: %d falha(s)" % fails)
	AudioMgr.inst.shutdown()
	quit(1 if fails else 0)
