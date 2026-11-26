extends SceneTree
## Gera scenes/fases/deserto.tscn a partir da montagem em código (Desert.layout() + Level._build + Desert._montar),
## fora da árvore: o que cada nó cria no próprio _ready (sprites dos inimigos, peças da Forja, arte de placas e
## itens) não vai para a cena e é recriado quando o jogo carrega. Depois dela, a cena é a fonte:
## rodar de novo APAGA o que foi editado no Godot.
## uso: godot --headless --audio-driver Dummy --path . --script res://tools/gerar_cena_deserto.gd

const DESTINO := "res://scenes/fases/deserto.tscn"
const NOMES := {
	"Sign": "Placa", "Checkpoint": "Checkpoint", "Rift": "FendaDeChegada", "Pickup": "Item", "GrappleHook": "Gancho",
	"VerdBg": "Fundo", "DesertEnemy": "Maquina",
}

var game
var cont := {}


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


func _conta(prefixo: String) -> String:
	cont[prefixo] = int(cont.get(prefixo, 0)) + 1
	return "%s_%02d" % [prefixo, cont[prefixo]]


func _base(t: Texture2D) -> String:
	if t is AtlasTexture:
		var a: AtlasTexture = t
		var cell := a.region.position
		return "%s_%d_%d" % [a.atlas.resource_path.get_file().get_basename(), int(cell.x), int(cell.y)]
	if t == null:
		return "sprite"
	return t.resource_path.get_file().get_basename()


## Nome legível pela arte: "DF31_mastro_viga_v2_01", "DF206_media_0_0_01", "Anim_DF81_01"...
func _nome_arte(c: Node) -> String:
	if c is AnimatedSprite2D:
		var sf: SpriteFrames = c.sprite_frames
		var t: Texture2D = sf.get_frame_texture("default", 0)
		var b := (t as AtlasTexture).atlas.resource_path.get_file().get_basename() if t is AtlasTexture else "anim"
		return _conta("Anim_" + b)
	if c is Sprite2D:
		return _conta(_base(c.texture))
	return _conta(c.get_class())


func _nomear_deserto(d: Desert) -> void:
	d.name = "Deserto"
	for c in d.get_children():
		if c is DFTerrain:
			c.name = "Terreno"
		elif c.has_meta("prensa"):
			c.name = _conta("Prensa")
			for k in c.get_children():
				k.name = _conta("Prensa_" + ("Ataque" if k is Area2D else "Cabeca"))
		elif c.has_meta("carrinho"):
			c.name = _conta("Plataforma")
			for k in c.get_children():
				k.name = "Colisao" if k is CollisionShape2D else "Arte"
		elif c is StaticBody2D:
			c.name = "Porta_" + String(c.get_meta("porta")[0]) if c.has_meta("porta") else _conta("Corpo")
			for k in c.get_children():
				k.name = "Colisao"
		elif c is Area2D:
			c.name = _conta("Fosso" if c.collision_layer == 32 else "Ataque")
			for k in c.get_children():
				k.name = "Forma"
		else:
			c.name = _nome_arte(c)


func _nomear_fase(lv: Level) -> void:
	for c in lv.get_children():
		if c == lv.objects:
			c.name = "Objetos"
		elif c == lv.entities:
			c.name = "Entidades"
		elif c == lv.fx:
			c.name = "Efeitos"
		elif c is CanvasLayer:
			c.name = "Ceu"
			c.get_child(0).name = "Gradiente"
		elif c is StaticBody2D and c.get_script() == null:
			c.name = _conta("Solido")
			c.get_child(0).name = "Colisao"
			(c.get_child(0) as CollisionShape2D).debug_color = Color(0.3, 0.85, 1.0, 0.12)
		elif c is Desert:
			_nomear_deserto(c)
		elif c is DFCamada:
			c.name = "EstruturasDeFundo"
			for k in c.get_children():
				k.name = _nome_arte(k)
		else:
			c.name = _conta(NOMES.get(_cls(c), _cls(c)))
	for parent in [lv.objects, lv.entities]:
		for c in parent.get_children():
			if c is Pickup and c.pid != "":
				c.name = "Item_" + c.pid
			elif c is DesertEnemy:
				c.name = ("Drone_" if c.drone else "Robo_") + c.pid.trim_prefix("df_")
			else:
				c.name = _conta(NOMES.get(_cls(c), _cls(c)))


func _dono(n: Node, owner_node: Node) -> void:
	for c in n.get_children():
		c.owner = owner_node
		_dono(c, owner_node)


func _run() -> void:
	game = JogoNovo.new()           # jogo novo: todos os itens, as máquinas e a Forja presentes
	root.add_child(game)
	var d: Dictionary = Desert.layout()
	var lv := Level.new()
	lv.main = game
	lv.id = "deserto"
	lv.data = d
	lv._build()                      # fora da árvore: nenhum _ready dos filhos roda
	var des: Desert = lv.desert
	des._montar()                    # o que o _ready do Deserto montaria (cenário, máquinas, Forja)
	for i in 3:                      # máquinas entram adiadas (call_deferred)
		await process_frame
	lv.name = "Deserto"
	lv.montada = true
	lv.nome = d["name"]
	lv.subtitulo = d["sub"]
	lv.tema = d["theme"]
	lv.forma = d["form"]
	lv.limites = d["bounds"]
	lv.kill_y = d["kill_y"]
	lv.salas = d.get("rooms", [])
	des.montada = true
	des.remove_child(des.forja)      # a Forja monta tudo no próprio _ready; a cena a recria em Desert._ligar()
	des.forja.free()
	des.forja = null
	_nomear_fase(lv)
	des.gravar_metas()               # caminhos com os nomes finais
	var marc := Node2D.new()
	marc.name = "Marcadores"
	lv.add_child(marc)
	var ini := Marker2D.new()
	ini.name = "Inicio"
	ini.position = d["spawn"]
	marc.add_child(ini)
	var fr := Marker2D.new()
	fr.name = "FendaDeRetorno"
	fr.position = d["return_rift"]
	marc.add_child(fr)
	var pv: Node2D = load("res://scripts/previa_editor.gd").new()
	pv.name = "PreviaEditor"
	marc.add_child(pv)
	_dono(lv, lv)
	var ps := PackedScene.new()
	var err := ps.pack(lv)
	assert(err == OK, "pack: %d" % err)
	err = ResourceSaver.save(ps, DESTINO)
	assert(err == OK, "save: %d" % err)
	var n := 0
	var pilha := [lv]
	while not pilha.is_empty():
		var x: Node = pilha.pop_back()
		n += 1
		pilha.append_array(x.get_children())
	print("deserto: %d nós -> %s" % [n, DESTINO])
	lv.free()
	quit(0)
