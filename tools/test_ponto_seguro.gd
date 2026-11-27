extends SceneTree
## Revisão geral: o ponto seguro (para onde o jogador volta ao cair num perigo) nunca pode ficar em cima de
## algo que se move ou desaba. No Deserto, o elevador e os carrinhos (AnimatableBody2D, camada 1) ficam
## sobre os fossos: parado num deles por 0,12 s, o jogo gravava o ponto seguro ali; quando a máquina
## andava e o jogador caía no fosso, ele voltava para o ar e caía de novo, perdendo vida a cada volta.
## Cobre: (1) ficar no elevador e no carrinho não muda o ponto seguro; (2) cair no fosso depois disso
## custa 1 de vida e devolve o jogador num chão firme, fora do fosso.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/test_ponto_seguro.gd

var game
var fails := 0


func _initialize() -> void:
	_run.call_deferred()


func check(ok: bool, what: String) -> void:
	print(("ok   " if ok else "FALHA ") + what)
	if not ok:
		fails += 1


func ticks(n: int) -> void:
	for i in n:
		await physics_frame


func _run() -> void:
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	game.auto = {"at": "1e12"}
	await ticks(4)
	game._reset_progress()
	game.menu.visible = false
	game.load_level("deserto", LevelData.get_level("deserto")["spawn"], false)
	await ticks(30)
	var p: Player = game.player
	var d: Desert = null
	for n in [game.level] + game.level.find_children("*", "", true, false):
		if n is Desert:
			d = n
			break
	check(d != null and not d.carts.is_empty(), "Deserto com elevador/carrinhos (%d)" % (d.carts.size() if d else 0))
	if d == null:
		quit(1)
		return
	# chão firme conhecido: o começo das Dunas
	var firme: Vector2 = LevelData.get_level("deserto")["spawn"]
	for cart in d.carts:
		var body: AnimatableBody2D = cart[0]
		var sobre_fosso := false
		for pit in Desert.PITS:
			if body.global_position.x + 60.0 > pit.position.x and body.global_position.x + 60.0 < pit.end.x:
				sobre_fosso = true
		if not sobre_fosso:
			continue
		# 1) parado na máquina
		p.global_position = firme
		p.velocity = Vector2.ZERO
		await ticks(30)
		var antes: Vector2 = p.last_safe
		for i in 40:
			p.global_position = body.global_position + Vector2(60, -1)
			p.velocity = Vector2.ZERO
			await physics_frame
		await ticks(20)
		check(p.last_safe.distance_to(antes) < 1.0,
			"máquina em x %d: ficar em cima não vira ponto seguro (%s → %s)" % [body.global_position.x, antes, p.last_safe])
		# 2) cai no fosso logo abaixo
		p.hp = p.max_hp
		p.inv = 0.0
		var hp0 := p.hp
		var fosso: Rect2
		for pit in Desert.PITS:
			if body.global_position.x + 60.0 > pit.position.x and body.global_position.x + 60.0 < pit.end.x:
				fosso = pit
		p.global_position = Vector2(body.global_position.x + 60.0, fosso.position.y - 40.0)
		p.velocity = Vector2(0, 400)
		await ticks(int(3.0 * 60))
		var no_fosso := false
		for pit in Desert.PITS:
			if pit.grow(30.0).has_point(p.global_position):
				no_fosso = true
		check(hp0 - p.hp == 1 and not p.dead, "máquina em x %d: a queda custa 1 de vida (perdeu %d)" % [body.global_position.x, hp0 - p.hp])
		check(p.is_on_floor() and not no_fosso, "máquina em x %d: volta num chão firme fora do fosso (%s)" % [body.global_position.x, p.global_position])
		p.hp = p.max_hp
	print("ponto seguro: %d falha(s)" % fails)
	quit(1 if fails else 0)
