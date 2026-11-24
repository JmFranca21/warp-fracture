class_name NvArt
extends RefCounted
## Arte de Nivária. Enquanto o lote 2 não chega, as peças são recortes das fichas aprovadas
## (GL01–GL04 v2), feitos por tools/import_nivaria.py em assets/nivaria/. Cada peça é dimensionada
## pela medida de jogo (Daymon ≈ 91 px; D = 400 px da ficha vira K = 0,2275), sempre em escala
## uniforme (DA-02, R1).

const DIR := "res://assets/nivaria/"
const K := 91.0 / 400.0
# Paleta aprovada (GL00 / GL04)
const CEU_A := Color("13182c")
const CEU_B := Color("1b2943")
const NEVE_SOMBRA := Color("4f6386")
const NEVE := Color("8597b5")
const NEVE_TOPO := Color("b9c7dc")      # topo de neve abaixo do branco: o personagem é o mais claro (DA-03, C2)
const ROCHA_A := Color("1e2338")
const ROCHA_B := Color("2e3550")
const ROCHA_C := Color("535d78")
const GELO := Color("628499")
const CRISTAL := Color("7a6fc9")
const NEVOA := Color("6b2fa8")
const AURORA := Color("ff8fd0")
const CALOR := Color("ef9655")
const PERIGO := Color("e0303a")

static var _cache := {}


static func tex(id: String) -> Texture2D:
	if not _cache.has(id):
		_cache[id] = load(DIR + id + ".webp")
	return _cache[id]


## Sprite com a peça medida em pixels de jogo. by = "h" (altura) ou "w" (largura).
## anchor: "base" (pés/apoio na origem), "centro" ou "topo" (preso ao teto).
static func sprite(id: String, size: float, by := "h", anchor := "base") -> Sprite2D:
	var s := Sprite2D.new()
	s.texture = tex(id)
	var ts := s.texture.get_size()
	var k := size / (ts.y if by == "h" else ts.x)
	s.scale = Vector2(k, k)
	match anchor:
		"base":
			s.offset = Vector2(0, -ts.y / 2.0)
		"topo":
			s.offset = Vector2(0, ts.y / 2.0)
	return s


## Fator de escala (uniforme) para uma peça ocupar `size` px na medida escolhida.
static func fit(id: String, size: float, by := "h") -> float:
	var ts := tex(id).get_size()
	return size / (ts.y if by == "h" else ts.x)


## PLACEHOLDER do glifo de Nivária no Arco (célula de 192 × 256 da PT13): floco de seis pontas.
static func glyph(lit: bool) -> Texture2D:
	var key := "glifo_%s" % lit
	if _cache.has(key):
		return _cache[key]
	var img := Image.create(192, 256, false, Image.FORMAT_RGBA8)
	var c := Color("ff8fd0") if lit else Color("4b5a72")
	var dark := Color("1d2a3c")
	for pass_i in 2:
		var col := dark if pass_i == 0 else c
		var w := 5 if pass_i == 0 else 3
		for k in 6:
			var a := TAU * k / 6.0 - PI / 2.0
			for r in range(0, 34):
				var q := Vector2(96, 128) + Vector2(cos(a), sin(a)) * r
				img.fill_rect(Rect2i(int(q.x) - w / 2, int(q.y) - w / 2, w, w), col)
				if r == 20:
					for side in [-1, 1]:
						var b: float = a + side * 0.7
						for r2 in 10:
							var q2 := q + Vector2(cos(b), sin(b)) * r2
							img.fill_rect(Rect2i(int(q2.x) - w / 2, int(q2.y) - w / 2, w, w), col)
	var tex := ImageTexture.create_from_image(img)
	_cache[key] = tex
	return tex
