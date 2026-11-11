class_name Desert
extends Node2D
## Cenário, máquinas e percurso do Deserto de Ferrugem.

const FLOOR := [Rect2(-120,700,900,360), Rect2(1180,700,520,360), Rect2(1700,700,1080,360),
	Rect2(2870,625,145,26), Rect2(3100,545,240,28), Rect2(3580,415,430,40),
	Rect2(4410,415,450,40), Rect2(4980,770,510,320), Rect2(6030,770,960,320)]
const PITS := [Rect2(780,850,400,60), Rect2(2780,900,2200,60), Rect2(5490,900,540,60)]
const HOOKS := [Vector2(975,510), Vector2(3510,345), Vector2(4205,230)]
const MACHINES := [
	[true,780,1180,563], [false,1205,1620,700], [false,3125,3315,545],
	[false,3605,3980,415], [false,5010,5450,770], [true,6220,6540,635]]
var level: Level
var clock := 0.0
var presses: Array = []
var carts: Array = []
var vents: Array = []
var wheel: Sprite2D
var saw: Sprite2D
var belt: Sprite2D
var exit_closed: Sprite2D
var exit_open: Sprite2D
var flickering_lamp: Sprite2D
var dust_clock := 0.0

static func layout() -> Dictionary:
	var pickups := []
	var points := [Vector2(855,598),Vector2(975,510),Vector2(1100,589),Vector2(1775,658),
		Vector2(2250,563),Vector2(2940,572),Vector2(3220,490),Vector2(4100,326),
		Vector2(4290,316),Vector2(4790,365),Vector2(5760,708),Vector2(6410,718)]
	for i in points.size():
		pickups.append(["cell",points[i],"df_c%d" % i])
	return {"theme":"deserto","form":"human","name":"DESERTO DE FERRUGEM","sub":"Dunas de sucata",
		"bounds":Rect2(0,-80,6990,1140),"spawn":Vector2(110,695),"kill_y":1060.0,
		"solids":FLOOR + [Rect2(-60,-200,60,1350),Rect2(6990,-200,60,1350)],
		"hazards":[],"hooks":[[HOOKS[0]],[HOOKS[1]],[HOOKS[2],125]],"enemies":[],
		"checkpoints":[Vector2(1650,700),Vector2(4730,415)],"terminals":[],"signs":[],"pickups":pickups,
		"rooms":[["A",Rect2(0,-80,1700,1140),"Dunas de sucata"],["B",Rect2(1700,-80,1880,1140),"Fábrica autônoma"],
		["C",Rect2(3580,-80,3410,1140),"Núcleo central"]]}

static func texture(id: String) -> Texture2D:
	return load("res://assets/deserto/" + id + ".webp")

static func animation(id: String, count: int, fps: float, looped: bool) -> AnimatedSprite2D:
	var frames := SpriteFrames.new()
	frames.set_animation_speed("default",fps)
	frames.set_animation_loop("default",looped)
	var sheet := texture(id)
	var cell := sheet.get_size() / Vector2(4,2)
	for i in count:
		var tile := AtlasTexture.new()
		tile.atlas = sheet
		tile.region = Rect2(Vector2(i % 4, floori(i / 4.0)) * cell, cell)
		frames.add_frame("default",tile)
	var sprite := AnimatedSprite2D.new()
	sprite.sprite_frames = frames
	sprite.play()
	return sprite

static func effect(parent: Node, id: String, count: int, pos: Vector2, size: Vector2, looped := false) -> AnimatedSprite2D:
	var sprite := animation(id,count,12.0,looped)
	sprite.position = pos
	sprite.scale = size / Vector2(128,192)
	parent.add_child(sprite)
	if not looped:
		sprite.animation_finished.connect(sprite.queue_free)
	return sprite

func prop(id: String, rect: Rect2, depth := 0, parent: Node = self) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.texture = texture(id)
	sprite.position = rect.get_center()
	sprite.scale = rect.size / sprite.texture.get_size()
	sprite.z_index = depth
	parent.add_child(sprite)
	return sprite

func tile(id: String, rect: Rect2, factor: Vector2, depth := 0) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.centered = false
	sprite.texture = texture(id)
	sprite.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	sprite.region_enabled = true
	sprite.region_rect = Rect2(Vector2.ZERO,rect.size / factor)
	sprite.position = rect.position
	sprite.scale = factor
	sprite.z_index = depth
	add_child(sprite)
	return sprite

func attack_area(rect: Rect2, parent: Node, pit := false) -> Area2D:
	var area := Area2D.new()
	area.collision_layer = 32 if pit else 16
	area.collision_mask = 0
	area.monitoring = false
	area.add_to_group("hazard" if pit else "enemy_attack")
	var shape := CollisionShape2D.new()
	var box := RectangleShape2D.new()
	box.size = rect.size
	shape.shape = box
	area.position = rect.get_center()
	area.add_child(shape)
	parent.add_child(area)
	return area

func _ready() -> void:
	for i in 3:
		var bg := VerdBg.new()
		bg.tex = texture("DF%d" % (10+i))
		bg.depth = [0.06,0.20,0.38][i]
		bg.fit(Vector2(1500,760),Vector2(580,6410),Vector2(248,732),0.8)
		bg.z_index = -60 + i
		level.add_child(bg)
		level.bg_layers.append(bg)
	tile("DF22",Rect2(1495,170,205,530),Vector2(0.55,0.55),-14)
	tile("DF23",Rect2(1700,-80,1880,1090),Vector2(0.65,0.65),-14)
	tile("DF24",Rect2(4980,-80,2010,1150),Vector2(0.75,0.75),-14)
	for r in FLOOR:
		if r.position.x < 1700:
			tile("DF20",r,Vector2(0.75,r.size.y/256.0))
		elif r.position.x == 1700:
			belt = tile("DF26",Rect2(r.position,Vector2(r.size.x,60)),Vector2(0.62,0.625))
		elif r.position.x == 2870 or r.position.x == 3100:
			var large: bool = r.position.x == 3100
			prop("DF53b" if large else "DF53a",Rect2(r.position-Vector2(0,135),Vector2(r.size.x,157)),-1)
			tile("DF25",Rect2(r.position,Vector2(r.size.x,12)),Vector2(0.28,0.2))
		else:
			tile("DF25",Rect2(r.position,Vector2(r.size.x,40)),Vector2(0.625,0.625))
	for pit in PITS:
		tile("DF21",pit,Vector2(0.5,pit.size.y/128.0))
		attack_area(pit,self,true)
	prop("DF30_1",Rect2(135,624,155,76),-2)
	prop("DF30_2",Rect2(1240,644,110,56),-2)
	prop("DF31",Rect2(686,463,310,237),-2)
	prop("DF32",Rect2(1530,44,72,128),-2)
	effect(self,"DF80",6,Vector2(1566,-12),Vector2(105,116),true)
	prop("DF33",Rect2(1550,525,140,175),-2)
	wheel = prop("DF34",Rect2(2220,250,320,320),-8)
	prop("DF35",Rect2(3460,226,140,190),-6)
	prop("DF36",Rect2(4700,-15,298,785),-10)
	for x in [3710,4580]:
		var cable := tile("DF28",Rect2(x,415,Vector2(x,415).distance_to(Vector2(4820,72)),8),Vector2(0.3,0.25),-4)
		cable.rotation = Vector2(4820-x,-343).angle()
	for x in [1870,2640,5180,5830,6410,6730]:
		var lamp_rect := Rect2(x,152,38,69)
		var wire := tile("DF28",Rect2(x+21,-80,232,4),Vector2(0.24,0.125),-5)
		wire.rotation = PI/2.0
		if x == 6410:
			prop("DF37b",lamp_rect,-4)
			flickering_lamp = prop("DF37",lamp_rect,-3)
		else:
			prop("DF37",lamp_rect,-4)
	prop("DF39",Rect2(5100,630,65,90),-4)
	prop("DF39b",Rect2(5960,333,240,120),-5)
	prop("DF26b",Rect2(1700,700,60,60),1)
	prop("DF26c",Rect2(2720,700,60,60),1)
	for hook in HOOKS:
		prop("DF57",Rect2(hook-Vector2(19,30),Vector2(38,48)),3)
	make_press(1950,700,false,0.0)
	make_press(2540,700,false,1.25)
	make_press(4500,415,true,0.8)
	prop("DF52b",Rect2(2210,675,80,32))
	saw = prop("DF52",Rect2(2215,633,70,70),1)
	attack_area(Rect2(2225,642,50,55),self)
	tile("DF27",Rect2(4875,415,74,365),Vector2(0.57,0.55),-3)
	make_cart(Vector2(4860,415),Vector2(0,355),true)
	tile("DF55b",Rect2(5480,650,560,16),Vector2(0.3,0.25),-2)
	make_cart(Vector2(5490,770),Vector2(430,0),false)
	for x in [6290,6520]:
		var r := Rect2(x-36,759,72,12)
		prop("DF56_inativa",r)
		var lamp := prop("DF56_aviso",r,1)
		var jet := effect(self,"DF81",8,Vector2(x,693),Vector2(85,150),true)
		var hit := attack_area(Rect2(x-22,634,44,136),self)
		vents.append([lamp,jet,hit])
	exit_closed = prop("DF38_fechada",Rect2(6790,580,150,190),-2)
	exit_open = prop("DF38_aberta",Rect2(6790,580,150,190),-2)
	exit_open.hide()
	for i in MACHINES.size():
		if level.main.collected.has("df_enemy%d" % i):
			continue
		var machine := DesertEnemy.new()
		machine.level = level
		machine.pid = "df_enemy%d" % i
		machine.drone = MACHINES[i][0]
		machine.patrol = Vector2(MACHINES[i][1],MACHINES[i][2])
		machine.position = Vector2(machine.patrol.x,MACHINES[i][3])
		level.entities.add_child(machine)

func make_cart(start: Vector2, travel: Vector2, vertical: bool) -> void:
	var body := AnimatableBody2D.new()
	body.position = start
	body.collision_layer = 1
	body.collision_mask = 0
	var w := 120.0
	var shape := CollisionShape2D.new()
	var box := RectangleShape2D.new()
	box.size = Vector2(w,16)
	shape.shape = box
	shape.position = box.size / 2.0
	body.add_child(shape)
	add_child(body)
	var r := Rect2(0,0,w,24) if vertical else Rect2(0,-112,w,132)
	prop("DF54" if vertical else "DF55",r,1,body)
	carts.append([body,start,travel])

func make_press(x: int, ground: int, small: bool, phase: float) -> void:
	var id := "DF51" if small else "DF50"
	var width := 70 if small else 106
	prop(id+"c",Rect2(x-width/2.0,ground-219,width,35),2)
	var rod := tile(id+"b",Rect2(x-10,ground-190,20,175),Vector2(0.16,0.35))
	var root := Node2D.new()
	add_child(root)
	prop(id+"a",Rect2(-width/2.0,-30,width,30),2,root)
	attack_area(Rect2(-width/2.0,-26,width,26),root)
	presses.append([root,rod,x,ground,phase,false])

func _physics_process(dt: float) -> void:
	clock += dt
	flickering_lamp.visible = fmod(clock,3.4) > 0.11
	wheel.rotation = clock * 0.13
	saw.rotation = clock * 5.5
	belt.region_rect.position.x = -clock * 85
	var p := level.player
	if not is_instance_valid(p):
		return
	if p.is_on_floor() and p.position.x > 1700 and p.position.x < 2780 and absf(p.position.y-700)<5:
		p.move_and_collide(Vector2(65*dt,0))
	for press in presses:
		var phase := fmod(clock + float(press[4]),3.2)
		var down := smoothstep(1.4,1.74,phase) * (1.0-smoothstep(2.02,2.9,phase))
		var y := float(press[3]) - 160*(1-down)
		press[0].position = Vector2(press[2],y)
		press[1].region_rect.size.y = maxf(1,y-22-press[1].position.y)/press[1].scale.y
		if down > 0.99 and not press[5]:
			effect(self,"DF82",6,Vector2(press[2],press[3]-31),Vector2(110,74))
		press[5] = down > 0.99
	for cart in carts:
		cart[0].position = cart[1] + cart[2] * (0.5-0.5*cos(clock*TAU/5.5))
	for i in vents.size():
		var phase := fmod(clock+i*1.8,3.6)
		var v: Array = vents[i]
		v[0].visible = phase >= 1.45 and phase < 2.15
		v[1].visible = phase >= 2.15 and phase < 2.95
		v[1].pause()
		v[1].frame = clampi(int((phase-2.15)*10),0,7)
		v[2].collision_layer = 16 if v[1].visible and v[1].frame in [2,3,4,5] else 0
	dust_clock -= dt
	if dust_clock < 0 and p.position.x < 1500:
		dust_clock = 0.38
		var dust := effect(self,"DF86",8,p.position+Vector2(randf_range(-450,450),randf_range(-270,-25)),Vector2(40,40),true)
		dust.pause()
		dust.frame = randi_range(0,7)
		var drift := create_tween()
		drift.tween_property(dust,"position:x",dust.position.x+125,1.1)
		drift.tween_callback(dust.queue_free)
	exit_open.visible = p.position.x > 6680
	exit_closed.visible = not exit_open.visible
	if p.position.x > 6860 and absf(p.position.y-770)<75 and level.main.state == "level" and not p.dead:
		level.main.finish_desert()
