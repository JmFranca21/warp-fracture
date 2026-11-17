class_name DFArt
extends RefCounted
## Carregamento da arte da Fase 2 (Autômato, Forja-Mãe e portais), importada em meia resolução
## por tools/import_fase2.py. Escala do jogo: K = 0,214 do desenho original (D = 400 px vira ~86 px);
## como a textura já está em 0,5, o nó usa NODE = 0,428. As âncoras são as dos pedidos (pixels do original).

const K := 0.214
const IMPORT := 0.5
const NODE := K / IMPORT
const DIR_DF := "res://assets/deserto/"
const DIR_PT := "res://assets/portais/"

static var _cache := {}


static func tex(id: String) -> Texture2D:
	if _cache.has(id):
		return _cache[id]
	var path := (DIR_PT if id.begins_with("PT") else DIR_DF) + id + ".webp"
	var t: Texture2D = load(path)
	_cache[id] = t
	return t


## Quadro (região) de uma folha em grade. cols × rows células iguais.
static func cell(id: String, i: int, cols := 4, rows := 2) -> AtlasTexture:
	var sheet := tex(id)
	var cs := sheet.get_size() / Vector2(cols, rows)
	var a := AtlasTexture.new()
	a.atlas = sheet
	a.region = Rect2(Vector2(i % cols, floori(float(i) / cols)) * cs, cs)
	return a


## Faixa de uma folha (linhas de 256 × 256 do original, como DF98 e DF110).
static func strip(id: String, row: int, i: int, n := 4, rows := 2) -> AtlasTexture:
	return cell(id, row * n + i, n, rows)


static func add_anim(sf: SpriteFrames, anim: String, id: String, frames: Array, fps: float, loop: bool, cols := 4, rows := 2) -> void:
	if not sf.has_animation(anim):
		sf.add_animation(anim)
	sf.set_animation_speed(anim, fps)
	sf.set_animation_loop(anim, loop)
	for i in frames:
		sf.add_frame(anim, cell(id, int(i), cols, rows))


## Deslocamento (em pixels da textura importada) que leva a âncora do original para a origem do nó.
## cell_size e anchor em pixels do original.
static func offset(cell_size: Vector2, anchor: Vector2) -> Vector2:
	return (cell_size / 2.0 - anchor) * IMPORT


## Sprite simples de uma imagem inteira com a âncora (original) na origem.
static func sprite(id: String, anchor: Vector2, sc := 1.0) -> Sprite2D:
	var s := Sprite2D.new()
	s.texture = tex(id)
	s.offset = offset(s.texture.get_size() / IMPORT, anchor)
	s.scale = Vector2.ONE * NODE * sc
	return s


## Animação solta (efeito) com a âncora no centro da célula; some no fim se não for loop.
static func fx(parent: Node, id: String, n: int, pos: Vector2, fps := 14.0, loop := false, sc := 1.0, first := 0) -> AnimatedSprite2D:
	var sf := SpriteFrames.new()
	add_anim(sf, "default", id, range(first, first + n), fps, loop)
	var s := AnimatedSprite2D.new()
	s.sprite_frames = sf
	s.position = pos
	s.scale = Vector2.ONE * NODE * sc
	s.z_index = 2
	parent.add_child(s)
	s.play("default")
	if not loop:
		s.animation_finished.connect(s.queue_free)
	return s
