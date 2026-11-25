extends SceneTree
## Gera scenes/fases/lab.tscn e verdamia.tscn a partir da descrição em código da v0.9 (tools/referencia_fases_v09.gd),
## usando a própria montagem do Level (_build) fora da árvore: o que cada nó cria no _ready dele não vai para a cena
## e é recriado quando o jogo carrega. Serve para a conversão e para conferir; depois dela, as cenas são a fonte
## (rodar de novo APAGA o que foi editado no Godot).
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/gerar_cenas_fases.gd [-- so=lab]

const REF := preload("res://tools/referencia_fases_v09.gd")
const DESTINO := {"lab": "res://scenes/fases/lab.tscn", "verdamia": "res://scenes/fases/verdamia.tscn"}
const NOMES := {   # classe -> prefixo do nome do nó na cena
	"BgLayer": "Fundo", "VerdBg": "Fundo", "BackWall": "ParedeDeFundo", "TerrainDraw": "Terreno",
	"Hazard": "Perigo", "SpritePlatform": "Plataforma", "Fuga": "FugaDoEco", "FgLayer": "PrimeiroPlano",
	"Sign": "Placa", "Checkpoint": "Checkpoint", "Terminal": "Terminal", "Door": "Porta", "Portal": "Portal",
	"Receptacle": "Receptaculo", "Rift": "FendaDeChegada", "Pickup": "Item", "LaserGate": "Laser",
	"Lever": "Alavanca", "EnergyField": "CampoDeForca", "EnergyLock": "Trava", "Bench": "Banco",
	"GrappleHook": "Gancho", "SecurityCam": "CameraDeSeguranca", "Crate": "Caixa", "Crawler": "Rastejador",
	"Drone": "Drone", "Moth": "Mariposa", "SporePlant": "PlantaDeEsporos", "Turret": "Torreta",
	"Queen": "RainhaMicelia", "BlinkLight": "LuzDeAlerta",
}

var game


## O estado de um jogo novo, que a montagem consulta (itens pegos, terminais, chefes, fragmentos, eventos).
class JogoNovo extends Node:
	var collected := {}
	var terminals := {}
	var boss_done := {}
	var frags := {}
	var events := {}
	var modules := {}


func _initialize() -> void:
	_run.call_deferred()


func _cls(n: Node) -> String:
	var sc: Script = n.get_script()
	return sc.get_global_name() if sc != null else n.get_class()


## Nomes legíveis e únicos: "Placa_03", "Item_lab_c1", "Solido_12"...
func _nomear(lv: Level) -> void:
	var cont := {}
	var conta := func(prefixo: String) -> String:
		cont[prefixo] = int(cont.get(prefixo, 0)) + 1
		return "%s_%02d" % [prefixo, cont[prefixo]]
	for c in lv.get_children():
		var cls := _cls(c)
		if c == lv.objects:
			c.name = "Objetos"
		elif c == lv.entities:
			c.name = "Entidades"
		elif c == lv.fx:
			c.name = "Efeitos"
		elif c is CanvasLayer:
			c.name = "Ceu"
			c.get_child(0).name = "Gradiente"
		elif c is CPUParticles2D:
			c.name = conta.call("Particulas")
		elif c is StaticBody2D and c.get_script() == null:
			c.name = conta.call("Solido")
			c.get_child(0).name = "Colisao"
			# só a cor da colisão no editor (e em Depurar > Formas de colisão): clara, para a arte aparecer
			(c.get_child(0) as CollisionShape2D).debug_color = Color(0.3, 0.85, 1.0, 0.12)
		elif cls == "Node2D":
			c.name = "Decoracao"
			for s in c.get_children():
				if s is Sprite2D and s.texture is GradientTexture2D:
					s.name = conta.call("Brilho")
				elif s is Sprite2D:
					var arq := (s.texture.resource_path as String).get_file().get_basename()
					s.name = conta.call("Deco_" + (arq if arq != "" else "sprite"))
				else:
					s.name = conta.call(NOMES.get(_cls(s), _cls(s)))
		elif cls in ["BackWall", "TerrainDraw", "Fuga", "FgLayer"]:
			c.name = NOMES[cls]
		else:
			c.name = conta.call(NOMES.get(cls, cls))
	for parent in [lv.objects, lv.entities]:
		for c in parent.get_children():
			var cls := _cls(c)
			if c is Pickup and c.pid != "":
				c.name = "Item_" + c.pid
			elif c is Terminal:
				c.name = "Terminal_" + c.tid
			elif cls in ["Door", "Portal", "Receptacle", "Rift", "Queen"]:
				c.name = NOMES[cls]
			else:
				c.name = conta.call(NOMES.get(cls, cls))


func _dono(n: Node, owner_node: Node) -> void:
	for c in n.get_children():
		c.owner = owner_node
		_dono(c, owner_node)


func _gerar(id: String) -> void:
	var d: Dictionary = REF.get_level(id)
	var lv := Level.new()
	lv.main = game
	lv.id = id
	lv.data = d
	lv._build()                      # fora da árvore: nenhum _ready dos filhos roda
	for i in 3:                      # inimigos entram adiados (call_deferred)
		await process_frame
	lv.name = "Laboratorio" if id == "lab" else "Verdamia"
	lv.montada = true
	lv.nome = d["name"]
	lv.subtitulo = d["sub"]
	lv.tema = d["theme"]
	lv.forma = d["form"]
	lv.limites = d["bounds"]
	lv.kill_y = d["kill_y"]
	lv.salas = d.get("rooms", [])
	if d.has("door"):
		lv.porta_requer = d["door"]["needs"]
	if d.has("boss"):
		lv.chefe = {"trigger_x": d["boss"]["trigger_x"], "gate": d["boss"]["gate"], "fragment": d["boss"]["fragment"]}
	_nomear(lv)
	for c in lv.get_children():       # terreno e entulho passam a ler os Solido_ da cena
		if c is TerrainDraw:
			c.solidos_da_cena = true
			c.rects = []
		elif c is FgLayer:
			c.solidos_da_cena = true
			c.ground_rects = []
	var marc := Node2D.new()
	marc.name = "Marcadores"
	lv.add_child(marc)
	var ini := Marker2D.new()
	ini.name = "Inicio"
	ini.position = d["spawn"]
	marc.add_child(ini)
	if d.has("return_rift"):
		var fr := Marker2D.new()
		fr.name = "FendaDeRetorno"
		fr.position = d["return_rift"]
		marc.add_child(fr)
	if ResourceLoader.exists("res://scripts/previa_editor.gd"):
		var prev: Script = load("res://scripts/previa_editor.gd")
		var pv: Node2D = prev.new()
		pv.name = "PreviaEditor"
		marc.add_child(pv)
	_dono(lv, lv)
	var ps := PackedScene.new()
	var err := ps.pack(lv)
	assert(err == OK, "pack %s: %d" % [id, err])
	DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path("res://scenes/fases"))
	err = ResourceSaver.save(ps, DESTINO[id])
	assert(err == OK, "save %s: %d" % [id, err])
	var n := 0
	var pilha := [lv]
	while not pilha.is_empty():
		var x: Node = pilha.pop_back()
		n += 1
		pilha.append_array(x.get_children())
	print("%s: %d nós -> %s" % [id, n, DESTINO[id]])
	lv.free()


func _run() -> void:
	var so := ""
	for a in OS.get_cmdline_user_args():
		if a.begins_with("so="):
			so = a.substr(3)
	game = JogoNovo.new()           # jogo novo: todos os itens, a porta fechada, a Rainha e a Fuga presentes
	root.add_child(game)
	for id in DESTINO:
		if so == "" or so == id:
			await _gerar(id)
	quit(0)
