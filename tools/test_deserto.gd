extends SceneTree
## Executar com XDG_DATA_HOME temporário. Exercita o menu, o arpão, as máquinas e a saída.

var game
var failures := 0

func _initialize() -> void:
	run.call_deferred()

func check(ok: bool, message: String) -> void:
	print("PASS " if ok else "FAIL ",message)
	if not ok:
		failures += 1

func ticks(count: int) -> void:
	for i in count:
		await physics_frame

func place(pos: Vector2) -> void:
	game.player.position = pos
	game.player.velocity = Vector2.ZERO
	game.player.inv = 8.0
	await ticks(4)

func cross(start: Vector2, target_x: float, use_hook: bool) -> void:
	await place(start)
	var p: Player = game.player
	Input.action_press("right")
	if use_hook:
		check(p.hook_candidate() != null,"gancho alcançável em %d" % start.x)
		Input.action_press("hook")
	else:
		Input.action_press("jump")
	await ticks(2)
	Input.action_release("hook")
	var reached := false
	for i in 95:
		if use_hook and i > 12 and p.hook == null and not p.is_on_floor():
			Input.action_press("jump")
		if p.position.x >= target_x and p.is_on_floor():
			reached = true
			break
		await physics_frame
	Input.action_release("jump")
	Input.action_release("right")
	check(reached,"travessia física %d → %d (fim %s)" % [start.x,target_x,p.position.round()])

func run() -> void:
	if FileAccess.file_exists(SaveGame.DESERT_PATH) or SaveGame.exists():
		printerr("Use um diretório de dados temporário para preservar o save do Deserto.")
		quit(2)
		return
	game = load("res://main.tscn").instantiate()
	root.add_child(game)
	await ticks(2)
	check(game.menu.list.items.any(func(item): return item.id == "deserto"),"entrada no menu")
	game._on_menu("deserto")
	await ticks(110)
	var level: Level = game.level
	check(level.id == "deserto" and game.player.has_module("arpao"),"Daymon com arpão")
	var machines := get_nodes_in_group("enemies")
	check(machines.size()==6 and get_nodes_in_group("hooks").size()==3,"seis máquinas e três ganchos")
	check(level.data.pickups.size()==12,"12 células")
	var desert: Desert
	for child in level.get_children():
		if child is Desert:
			desert = child
	await cross(Vector2(760,699),1190,true)
	await cross(Vector2(2760,699),2875,false)
	await cross(Vector2(3000,624),3110,false)
	await cross(Vector2(3325,544),3590,true)
	await cross(Vector2(3990,414),4420,true)
	await place(Vector2(1780,700))
	var belt_start: float = game.player.position.x
	await ticks(28)
	check(game.player.position.x>belt_start+20,"esteira transporta o jogador")
	var warned := false
	var active := false
	for i in 220:
		var vent: Array = desert.vents[0]
		warned = warned or vent[0].visible
		active = active or (vent[1].visible and vent[2].collision_layer==16)
		await physics_frame
	check(warned and active,"aviso e dano da válvula")
	for cart in desert.carts:
		var body: AnimatableBody2D = cart[0]
		await place(body.position+Vector2(60,-1))
		var before: Vector2 = game.player.position
		await ticks(44)
		check(game.player.is_on_floor() and game.player.position.distance_to(before)>12,"plataforma transporta o jogador")
	var robot: DesertEnemy = machines[1]
	robot.take_hit(3,robot.position)
	await ticks(50)
	check(not is_instance_valid(robot),"robô derrotado em três tiros")
	game.set_checkpoint(Vector2(4730,415))
	game.show_menu()
	game._on_menu("deserto")
	await ticks(110)
	check(absf(game.player.position.x-4730)<10 and get_nodes_in_group("enemies").size()==5,"checkpoint e máquina derrotada persistem")
	await place(Vector2(6840,769))
	Input.action_press("right")
	await ticks(28)
	Input.action_release("right")
	check(game.state=="victory" and not FileAccess.file_exists(SaveGame.DESERT_PATH),"saída e encerramento")
	game.show_menu()
	game.checkpoint_level = "verdamia"
	game.checkpoint_pos = LevelData.get_level("verdamia")["spawn"]
	game.load_level("verdamia",game.checkpoint_pos,false)
	game.collect_fragment()
	var confirm := InputEventAction.new()
	confirm.action = "confirm"
	confirm.pressed = true
	game._unhandled_input(confirm)
	await ticks(110)
	check(game.level.id == "deserto" and game.player.form == "human","entrada após o fragmento de Verdâmia")
	game.show_menu()
	AudioMgr.inst.shutdown()
	await ticks(4)
	OS.delay_msec(250)
	quit(1 if failures else 0)
