class_name TerrainDraw
extends Node2D
## Desenha o terreno sólido (chão, paredes, plataformas).

var theme := "lab"
var rects: Array = []
var thin_art: Array = []    # Verdâmia: arte de cada plataforma fina, na ordem em que aparecem em rects


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	if theme != "lab":
		_verd_all()
		return
	var rng := RandomNumberGenerator.new()
	rng.seed = 4242
	for rv in rects:
		_lab_rect(rv, rng)


func _lab_rect(r: Rect2, rng: RandomNumberGenerator) -> void:
	var fill := Color("0b1018")
	var edge := Color("4a5d73")
	var seam := Color("141c27")
	draw_rect(r, fill)
	var thin := r.size.y < 40.0
	draw_rect(Rect2(r.position, Vector2(r.size.x, minf(26.0, r.size.y))), Color("121a25"))
	var x := r.position.x + 60.0
	while x < r.end.x - 10.0:
		draw_line(Vector2(x, r.position.y + 4), Vector2(x, minf(r.end.y, r.position.y + 400)), seam, 2)
		x += 120.0
	draw_line(r.position, Vector2(r.end.x, r.position.y), edge, 3)
	draw_line(r.position + Vector2(0, 5), Vector2(r.end.x, r.position.y + 5), Color(0.29, 0.36, 0.45, 0.35), 1)
	if thin:
		draw_line(Vector2(r.position.x, r.end.y), r.end, Color("27323f"), 2)
		var px := r.position.x + 20.0
		while px < r.end.x - 10.0:
			draw_line(Vector2(px, r.end.y), Vector2(px - 8, r.end.y + 10), Color("0b1018"), 3)
			px += 40.0
	var rv := r.position.x + 20.0
	while rv < r.end.x:
		draw_circle(Vector2(rv, r.position.y + 12), 1.6, Color("2a3646"))
		rv += 40.0
	# teto: acabamento na face de baixo com suportes
	if r.end.y <= 240.0 and r.size.y > 100.0 and r.size.x > 100.0:
		draw_rect(Rect2(r.position.x, r.end.y - 16, r.size.x, 16), Color("16202e"))
		draw_line(Vector2(r.position.x, r.end.y), r.end, Color("2c3b52"), 2)
		var bx := r.position.x + 80.0
		while bx < r.end.x - 40.0:
			draw_rect(Rect2(bx - 14, r.end.y - 22, 28, 22), Color("1b2738"))
			draw_circle(Vector2(bx, r.end.y - 11), 3.0, Color("2f4058"))
			bx += 240.0
	# parede que termina acima do chão = batente de passagem (verga com faixa de aviso)
	if r.size.x < 200.0 and r.size.y > 200.0 and r.end.y < 790.0 and r.end.y > 300.0:
		var lt := Rect2(r.position.x - 8, r.end.y - 20, r.size.x + 16, 20)
		draw_rect(lt, Color("1b2738"))
		var sx := lt.position.x
		var on := false
		while sx < lt.end.x:
			if on:
				var a := Vector2(sx, lt.end.y - 9)
				draw_colored_polygon(PackedVector2Array([a, a + Vector2(10, 0), a + Vector2(16, 9), a + Vector2(6, 9)]), Color(0.85, 0.65, 0.15, 0.85))
			sx += 10.0
			on = not on
		draw_line(Vector2(lt.position.x, lt.end.y), lt.end, Color("2c3b52"), 2)
	# paredes verticais: borda lateral iluminada
	if r.size.y > 300 and r.size.x < 200:
		draw_line(Vector2(r.position.x, r.position.y), Vector2(r.position.x, r.end.y), Color(0.29, 0.36, 0.45, 0.6), 2)
		draw_line(Vector2(r.end.x, r.position.y), Vector2(r.end.x, r.end.y), Color(0.29, 0.36, 0.45, 0.6), 2)


# ------------------------------------------------------------ Verdâmia (arte VD_*)
## Subsolo repetido em todo o bloco, chão com musgo no topo, borda de parede nas laterais expostas,
## quina nos cantos expostos e arte própria nas plataformas finas (raízes ou tronco).
func _verd_all() -> void:
	var m := SpriteMetaVerd
	var dir: String = m.TERRENO_DIR
	var sub: Texture2D = Props.tex(dir + "subsolo.png")
	var chao: Texture2D = Props.tex(dir + "chao_musgo.png")
	var borda: Texture2D = Props.tex(dir + "parede_borda.png")
	var ce: Texture2D = Props.tex(dir + "canto_esquerdo.png")
	var cd: Texture2D = Props.tex(dir + "canto_direito.png")
	var thin_i := 0
	var blocks: Array = []
	for rv in rects:
		var r: Rect2 = rv
		if r.size.y < 40.0:
			var nm: String = thin_art[thin_i] if thin_i < thin_art.size() else "plataforma_raizes"
			thin_i += 1
			var tex: Texture2D = Props.tex(dir + nm + ".png")
			var surf: float = m.PLATAFORMA_RAIZES_SURF if nm == "plataforma_raizes" else m.TRONCO_PLATAFORMA_SURF
			var s := r.size.x / float(tex.get_width())
			draw_texture_rect(tex, Rect2(r.position.x, r.position.y - surf * s, r.size.x, tex.get_height() * s), false)
		else:
			blocks.append(r)
	# 1) subsolo, alinhado ao mundo para emendar entre blocos vizinhos
	for r: Rect2 in blocks:
		var v := r.intersection(Rect2(-400, -700, 6000, 1900))
		tile(self, sub, v, Vector2.ZERO)
	# 2) bordas de parede nas laterais expostas
	var bw := borda.get_width() / 2.0
	for r: Rect2 in blocks:
		var w := minf(bw, r.size.x / 2.0 + m.PAREDE_EDGE)
		for side in [-1, 1]:
			var x := r.position.x if side < 0 else r.end.x
			for seg: Vector2 in _exposed(r, side, blocks):
				if seg.y - seg.x < 24.0:
					continue
				# desenha em coordenadas locais (x a partir da borda) para poder espelhar o lado direito
				if side < 0:
					draw_set_transform(Vector2(x - m.PAREDE_EDGE, 0), 0.0, Vector2.ONE)
				else:
					draw_set_transform(Vector2(x + m.PAREDE_EDGE, 0), 0.0, Vector2(-1, 1))
				tile(self, borda, Rect2(0, seg.x, w, seg.y - seg.x), Vector2.ZERO)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	# 3) chão com musgo no topo
	var ch := chao.get_height() / 2.0
	for r: Rect2 in blocks:
		if r.position.y < -200.0:
			continue
		var h := minf(ch, r.size.y + m.CHAO_SURF)
		tile(self, chao, Rect2(r.position.x, r.position.y - m.CHAO_SURF, r.size.x, h), Vector2(0, r.position.y - m.CHAO_SURF))
	# 4) quinas nos cantos de cima expostos
	var cw := ce.get_width() / 2.0
	var chh := ce.get_height() / 2.0
	for r: Rect2 in blocks:
		if r.position.y < -200.0:
			continue
		var w2 := minf(cw, r.size.x / 2.0 + 4.0)
		var hh := minf(chh, r.size.y + 30.0)
		if _corner_open(r, -1, blocks):
			var q: Vector2 = m.CANTO_ESQUERDO_QUINA
			draw_texture_rect_region(ce, Rect2(r.position.x - q.x, r.position.y - q.y, w2, hh), Rect2(0, 0, w2 * 2.0, hh * 2.0))
		if _corner_open(r, 1, blocks):
			var q2: Vector2 = m.CANTO_DIREITO_QUINA
			draw_texture_rect_region(cd, Rect2(r.end.x + q2.x - w2, r.position.y - q2.y, w2, hh),
				Rect2((cw - w2) * 2.0, 0, w2 * 2.0, hh * 2.0))


## Preenche "dest" repetindo a textura (guardada em 2x) numa grade alinhada a "origin".
## Faz a repetição à mão, quadro a quadro, para não depender do modo de repetição do renderizador.
static func tile(ci: CanvasItem, tex: Texture2D, dest: Rect2, origin: Vector2) -> void:
	var ts := Vector2(tex.get_width(), tex.get_height()) / 2.0
	var iy := int(floor((dest.position.y - origin.y) / ts.y))
	while origin.y + iy * ts.y < dest.end.y:
		var ix := int(floor((dest.position.x - origin.x) / ts.x))
		while origin.x + ix * ts.x < dest.end.x:
			var cell := Rect2(origin + Vector2(ix, iy) * ts, ts)
			var part := cell.intersection(dest)
			if part.size.x > 0.01 and part.size.y > 0.01:
				ci.draw_texture_rect_region(tex, part, Rect2((part.position - cell.position) * 2.0, part.size * 2.0))
			ix += 1
		iy += 1


## Trechos verticais [y0, y1] da lateral de r (side -1 = esquerda, 1 = direita) sem vizinho encostado.
func _exposed(r: Rect2, side: int, blocks: Array) -> Array:
	var segs: Array = [Vector2(maxf(r.position.y + 6.0, -150.0), minf(r.end.y, 1200.0))]
	var x := r.position.x if side < 0 else r.end.x
	for o: Rect2 in blocks:
		if o == r:
			continue
		var touches := (o.end.x >= x - 1.0 and o.position.x < x) if side < 0 else (o.position.x <= x + 1.0 and o.end.x > x)
		if not touches:
			continue
		var next: Array = []
		for s: Vector2 in segs:
			if o.end.y <= s.x or o.position.y >= s.y:
				next.append(s)
				continue
			if o.position.y > s.x:
				next.append(Vector2(s.x, o.position.y))
			if o.end.y < s.y:
				next.append(Vector2(o.end.y, s.y))
		segs = next
	return segs


func _corner_open(r: Rect2, side: int, blocks: Array) -> bool:
	for seg: Vector2 in _exposed(r, side, blocks):
		if seg.x <= r.position.y + 7.0 and seg.y - seg.x >= 40.0:
			return true
	return false
