class_name LevelData
extends RefCounted
## Onde estão as fases. O Laboratório e Verdâmia são cenas (scenes/fases/); o Deserto e Nivária são descritos em
## Desert.layout() e Nivaria.layout(). Coordenadas em pixels; y cresce para baixo; a origem dos personagens fica nos pés.


## Fases em cena: o Laboratório e Verdâmia são editados no Godot (scenes/fases/). O dicionário de cada uma é lido
## da própria cena (Level.descrever) e guardado na primeira leitura.
const CENAS := {"lab": "res://scenes/fases/lab.tscn", "verdamia": "res://scenes/fases/verdamia.tscn"}
static var _cache := {}


static func get_level(id: String) -> Dictionary:
	if id == "deserto":
		return Desert.layout()
	if id == "nivaria":
		return Nivaria.layout()
	var path := scene_path(id)
	if path == "":
		path = CENAS["lab"]
	if not _cache.has(path):
		var lv: Level = load(path).instantiate()
		_cache[path] = lv.descrever()
		lv.free()
	return (_cache[path] as Dictionary).duplicate(true)


## Caminho da cena da fase, ou "" se ela é montada pelo código.
static func scene_path(id: String) -> String:
	return CENAS.get(id, "")


