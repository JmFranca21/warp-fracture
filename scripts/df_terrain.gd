class_name DFTerrain
extends Node2D
## Terreno do Deserto (DF205, DA-03): areia de ferrugem nas Dunas e chapa sobre estrutura no resto.
## Só desenha: as colisões continuam as de Desert.layout(). Peças guardadas a 2× em assets/deserto/terreno/;
## as linhas de referência (px do arquivo) vêm do ENTREGA.md da DF205.

const DIR := "res://assets/deserto/terreno/"
# linhas de apoio, em px do jogo (metade do arquivo)
const AREIA_APOIO := 25.0          # areia_chao y 50
const CHAPA_APOIO := 8.0           # chapa_chao y 16
const BORDA_FACE := 3.0            # *_borda x 6
const CANTO_ESQ := Vector2(9, 25)  # areia_canto_esquerdo (18, 50); chapa usa y 8
const CANTO_DIR := Vector2(81, 25) # areia_canto_direito (162, 50)
const TETO_FACE := 80.0            # teto_chapa y 160
const TETO_CANTO := Vector2(48, 48)
const PASSARELA_APOIO := 4.0       # y 8
const PONTA := 48.0
const PAINEL := 32.0
const JUNCAO := 16.0               # chapa de junção: Rect2(64,0,32,128) na esquerda, Rect2(0,0,32,128) na direita
const FOSSO_DANO := 16.0           # fosso_fundo y 32
const TRANSICAO := Vector2(1700, 690)
const BOTTOM := 1080.0             # abaixo do kill_y (1060): nada aparece vazio embaixo da tela
const FOSSO_ESCURO := Color8(13, 17, 24)   # média das últimas linhas de fosso_fundo
# a primeira versão dos cantos de areia trazia um bloco escuro de 23 px acima do apoio (HANDOFF, seção 15.3):
# com ela, desenhamos só a partir de 4 px do jogo acima do apoio (y 42 do arquivo); o retoque vem inteiro
const AREIA_CANTO_TOPO := 42.0
var areia_canto_topo := 0.0   # vira AREIA_CANTO_TOPO só se o canto carregado ainda tiver o bloco (versão de cbdd27c)

var blocks: Array = []      # sólidos grossos (pisos, paredes, tetos)
var thin: Array = []        # passarelas e plataformas de máquina (altura < 60)
var pits: Array = []
var belt := Rect2(1700, 700, 1080, 360)
var suspended: Array = []   # passarelas penduradas por tirantes (as de máquina ficam sobre colunas)
var tex := {}


static func panels(width: float) -> int:
	return int(floor((width - 2.0 * PONTA) / PAINEL))


## Repete a textura (guardada em 2×) em dest, com a grade alinhada a origin. A repetição é a do amostrador
## (texture_repeat), sem frestas entre as cópias. pos e flip posicionam e espelham a peça (bordas da direita).
func _tile(t: Texture2D, dest: Rect2, origin: Vector2, pos := Vector2.ZERO, flip := 1.0) -> void:
	draw_set_transform(pos + Vector2(origin.x * flip, origin.y), 0.0, Vector2(0.5 * flip, 0.5))
	var src := Rect2((dest.position - origin) * 2.0, dest.size * 2.0)
	draw_texture_rect_region(t, src, src)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)


func _ready() -> void:
	texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	for n in ["areia_chao", "areia_subsolo", "areia_borda", "areia_canto_esquerdo", "areia_canto_direito",
			"chapa_chao", "estrutura_subsolo", "chapa_borda", "chapa_canto_esquerdo", "chapa_canto_direito",
			"transicao_areia_estrutura", "teto_chapa", "teto_canto_esquerdo", "teto_canto_direito", "verga_porta",
			"passarela_ponta_esquerda", "passarela_meio", "passarela_ponta_direita", "tirante", "fixacao",
			"coluna_trelica", "fosso_fundo"]:
		tex[n] = load(DIR + n + ".png")
	var img: Image = tex["areia_canto_esquerdo"].get_image()
	var a := 0.0
	for y in range(8, 48, 4):
		for x in range(20, 160, 10):
			a += img.get_pixel(x, y).a
	if a / (10.0 * 14.0) > 0.15:
		areia_canto_topo = AREIA_CANTO_TOPO
	queue_redraw()


func _sand(r: Rect2) -> bool:
	return r.end.x <= TRANSICAO.x


## Desenha a textura (guardada em 2×) em dest, com o canto de cima à esquerda da peça em pos (px do jogo).
func _piece(n: String, pos: Vector2, region := Rect2()) -> void:
	var t: Texture2D = tex[n]
	var src := region if region.size != Vector2.ZERO else Rect2(Vector2.ZERO, t.get_size())
	draw_texture_rect_region(t, Rect2(pos, src.size / 2.0), src)


func _draw() -> void:
	# 1) fundo dos fossos (linha de dano em y 32 do arquivo)
	for p: Rect2 in pits:
		var t: Texture2D = tex["fosso_fundo"]
		var top := p.position.y - FOSSO_DANO
		# abaixo da faixa (que termina semitransparente) não pode aparecer o céu: escuro do fim da peça
		draw_rect(Rect2(p.position.x, top + 84.0, p.size.x, BOTTOM - top - 84.0), FOSSO_ESCURO)
		_tile(t, Rect2(p.position.x, top, p.size.x, t.get_height() / 2.0), Vector2(0, top))
	# 2) corpo: areia nas Dunas; estrutura nos pisos de chapa, embaixo da esteira e dentro de paredes e tetos
	for r: Rect2 in blocks:
		var v := r.intersection(Rect2(-200, -200, 9400, BOTTOM + 200))
		if v.size.x <= 0.0:
			continue
		if r == belt:
			v = Rect2(v.position.x, r.position.y + 50.0, v.size.x, BOTTOM - r.position.y - 50.0)
		elif r.size.y > 100.0 and r.position.y > 0.0:
			v.size.y = BOTTOM - v.position.y
		_tile(tex["areia_subsolo" if _sand(r) else "estrutura_subsolo"], v, Vector2.ZERO)
	# 3) emenda Dunas → Fábrica, sob a ponta esquerda da esteira
	var tr: Texture2D = tex["transicao_areia_estrutura"]
	draw_texture_rect(tr, Rect2(TRANSICAO - Vector2(tr.get_width() / 4.0, 0), tr.get_size() / 2.0), false)
	# 4) laterais expostas (a borda é desenhada do lado esquerdo e espelhada no direito)
	for r: Rect2 in blocks:
		var n := "areia_borda" if _sand(r) else "chapa_borda"
		var bw: float = tex[n].get_width() / 2.0
		var w := minf(bw, r.size.x / 2.0 + BORDA_FACE)
		for side in [-1, 1]:
			var x := r.position.x if side < 0 else r.end.x
			for seg: Vector2 in _exposed(r, side):
				var y0 := maxf(seg.x, -200.0)
				var y1 := minf(seg.y, BOTTOM)
				if y1 - y0 < 8.0:
					continue
				# a face da peça (x 6 do arquivo) cai sobre a borda da colisão; à direita, espelhada
				_tile(tex[n], Rect2(0, y0, w, y1 - y0), Vector2(0, y0), Vector2(x - side * BORDA_FACE, 0), -side)
	# 5) faixa do topo dos pisos (a esteira cobre o topo da Fábrica)
	for r: Rect2 in blocks:
		if r == belt or r.size.y <= 100.0 or r.position.y < 0.0:
			continue
		var n := "areia_chao" if _sand(r) else "chapa_chao"
		var ap := AREIA_APOIO if _sand(r) else CHAPA_APOIO
		var t: Texture2D = tex[n]
		_tile(t, Rect2(r.position.x, r.position.y - ap, r.size.x, t.get_height() / 2.0),
			Vector2(0, r.position.y - ap))
	# 6) face de baixo dos tetos e verga das paredes sobre as portas
	for r: Rect2 in blocks:
		if r.position.y >= 0.0 or r.end.y > 700.0:
			continue
		if r.size.x > 100.0:          # teto
			var t: Texture2D = tex["teto_chapa"]
			_tile(t, Rect2(r.position.x, r.end.y - TETO_FACE, r.size.x, t.get_height() / 2.0),
				Vector2(0, r.end.y - TETO_FACE))
		elif r.end.y < 700.0:          # parede que termina sobre uma porta
			var vg: Texture2D = tex["verga_porta"]
			_piece("verga_porta", Vector2(r.get_center().x - vg.get_width() / 4.0, r.end.y - vg.get_height() / 2.0))
	# 7) quinas de cima e cantos internos teto–parede
	for r: Rect2 in blocks:
		if r == belt or r.size.y <= 100.0 or r.position.y < 0.0:
			continue
		var sand := _sand(r)
		var off := Vector2(0, 0 if sand else AREIA_APOIO - CHAPA_APOIO)
		var cut := Rect2(0, areia_canto_topo, 180, 260 - areia_canto_topo) if sand and areia_canto_topo > 0.0 else Rect2()
		var dy := Vector2(0, areia_canto_topo / 2.0) if sand else Vector2.ZERO
		if _corner_open(r, -1):
			_piece("areia_canto_esquerdo" if sand else "chapa_canto_esquerdo", r.position - CANTO_ESQ + off + dy, cut)
		if _corner_open(r, 1):
			_piece("areia_canto_direito" if sand else "chapa_canto_direito", Vector2(r.end.x, r.position.y) - CANTO_DIR + off + dy, cut)
	for c: Array in inner_corners():
		_piece("teto_canto_esquerdo" if c[1] < 0 else "teto_canto_direito", c[0] - TETO_CANTO)
	# 8) passarelas e plataformas de máquina
	for r: Rect2 in thin:
		_walkway(r)


## Cantos internos entre a face de baixo de um teto e a face de uma parede: [ponto, lado da parede (-1 esquerda)].
func inner_corners() -> Array:
	var out := []
	for c: Rect2 in blocks:
		if c.position.y >= 0.0 or c.size.x <= 100.0 or c.end.y > 700.0:
			continue
		for w: Rect2 in blocks:
			if w == c or w.end.y <= c.end.y + 8.0 or w.position.y > c.end.y:
				continue
			if absf(w.end.x - c.position.x) < 1.0:
				out.append([Vector2(c.position.x, c.end.y), -1])
			elif absf(w.position.x - c.end.x) < 1.0:
				out.append([Vector2(c.end.x, c.end.y), 1])
	return out


func _walkway(r: Rect2) -> void:
	var y := r.position.y - PASSARELA_APOIO
	var n := panels(r.size.x)
	var gap := r.size.x - 2.0 * PONTA
	var mid_w := n * PAINEL
	var mid_x := r.position.x + PONTA + (gap - mid_w) / 2.0
	if suspended.has(r):            # tirantes atrás do tabuleiro, subindo até sair da tela
		for x in [r.position.x + 30.0, r.end.x - 30.0]:
			_tile(tex["tirante"], Rect2(x - 8.0, -200.0, 16.0, y + 6.0 + 200.0), Vector2(x - 8.0, y + 6.0))
	else:                           # plataforma de máquina: coluna treliçada até o fundo do fosso
		var cx := r.get_center().x
		_tile(tex["coluna_trelica"], Rect2(cx - 24.0, r.end.y, 48.0, BOTTOM - r.end.y), Vector2(cx - 24.0, r.end.y))
	# miolo: n painéis inteiros, sem escala, centralizado no vão
	_tile(tex["passarela_meio"], Rect2(mid_x, y, mid_w, 64.0), Vector2(mid_x, y))
	_piece("passarela_ponta_esquerda", Vector2(r.position.x, y))
	_piece("passarela_ponta_direita", Vector2(r.end.x - PONTA, y))
	# chapas de junção por cima, a partir da face interna de cada ponta
	_piece("passarela_ponta_esquerda", Vector2(r.position.x + PONTA, y), Rect2(64, 0, 32, 128))
	_piece("passarela_ponta_direita", Vector2(r.end.x - PONTA - JUNCAO, y), Rect2(0, 0, 32, 128))
	if suspended.has(r):
		for x in [r.position.x + 30.0, r.end.x - 30.0]:
			_piece("fixacao", Vector2(x - 12.0, y - 6.0))


## Trechos verticais [y0, y1] da lateral de r sem vizinho encostado (como TerrainDraw._exposed).
func _exposed(r: Rect2, side: int) -> Array:
	var segs: Array = [Vector2(r.position.y + 6.0, r.end.y)]
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


func _corner_open(r: Rect2, side: int) -> bool:
	for seg: Vector2 in _exposed(r, side):
		if seg.x <= r.position.y + 7.0 and seg.y - seg.x >= 40.0:
			return true
	return false
