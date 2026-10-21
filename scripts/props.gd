class_name Props
extends RefCounted
## Carrega as artes recortadas das pranchas (assets/laboratorio) e cria sprites ancorados.

const DIR := "res://assets/laboratorio/"
static var _cache := {}


static func tex(name: String) -> Texture2D:
	if not _cache.has(name):
		var path := DIR + name + ".png"
		if name.begins_with("res://"):
			path = name
		_cache[name] = load(path)
	return _cache[name]


## Sprite com âncora no centro da base (pés no chão). scale_v ajusta o tamanho.
static func sprite(name: String, scale_v: float = 1.0, flip := false) -> Sprite2D:
	var s := Sprite2D.new()
	s.texture = tex(name)
	s.centered = true
	s.scale = Vector2(-scale_v if flip else scale_v, scale_v)
	s.offset = Vector2(0, -s.texture.get_height() / 2.0)
	return s


## Sprite com âncora no centro do topo (pendurado no teto).
static func hanging(name: String, scale_v: float = 1.0, flip := false) -> Sprite2D:
	var s := sprite(name, scale_v, flip)
	s.offset = Vector2(0, s.texture.get_height() / 2.0)
	return s


## Sprite centralizado.
static func centered(name: String, scale_v: float = 1.0, flip := false) -> Sprite2D:
	var s := sprite(name, scale_v, flip)
	s.offset = Vector2.ZERO
	return s
