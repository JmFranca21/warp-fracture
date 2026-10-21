class_name Hud
extends Control
## Interface: Integridade, Energia de Fase, Células, fragmentos, dicas, títulos de área, pausa e vitória.

var main
var t := 0.0
var prompt := ""
var tip := ""
var tip_a := 0.0
var notice_txt := ""
var notice_t := 0.0
var title := ""
var subtitle := ""
var title_t := -1.0
var banner_a := ""
var banner_b := ""
var banner_t := -1.0
var dmg_t := 0.0
var cell_pulse := 0.0
var energy_disp := 0.0
var denied_t := 0.0
var paused_shown := false
var pause_screen := "main"
var pause_list := MenuList.new()
var map_open := false
var victory := false
var victory_t := 0.0


func _ready() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func reset() -> void:
	prompt = ""
	tip = ""
	tip_a = 0.0
	notice_t = 0.0
	title_t = -1.0
	banner_t = -1.0
	paused_shown = false
	map_open = false
	victory = false


func set_prompt(s: String) -> void:
	prompt = s


func show_tip(s: String) -> void:
	tip = s


func hide_tip() -> void:
	tip = ""


func notice(s: String) -> void:
	notice_txt = s
	notice_t = 3.0


func show_title(a: String, b: String) -> void:
	title = a
	subtitle = b
	title_t = 0.0


func show_banner(a: String, b: String) -> void:
	banner_a = a
	banner_b = b
	banner_t = 0.0


func damage() -> void:
	dmg_t = 0.35


func pulse_cells() -> void:
	cell_pulse = 0.3


func energy_denied() -> void:
	denied_t = 0.4
	AudioMgr.sfx("negado", Vector2.INF, 0.0, 0.0)


func show_victory() -> void:
	victory = true
	victory_t = 0.0


func _process(dt: float) -> void:
	t += dt
	tip_a = move_toward(tip_a, 1.0 if tip != "" else 0.0, dt * 4.0)
	notice_t -= dt
	if title_t >= 0.0:
		title_t += dt
		if title_t > 4.5:
			title_t = -1.0
	if banner_t >= 0.0:
		banner_t += dt
		if banner_t > 6.0:
			banner_t = -1.0
	dmg_t = maxf(0.0, dmg_t - dt)
	cell_pulse = maxf(0.0, cell_pulse - dt)
	denied_t = maxf(0.0, denied_t - dt)
	if victory:
		victory_t += dt
	if main != null and is_instance_valid(main.player):
		energy_disp = lerpf(energy_disp, main.player.energy, 1.0 - exp(-dt * 10.0))
	queue_redraw()


func _draw() -> void:
	var sz := get_viewport_rect().size
	if dmg_t > 0.0:
		var a := dmg_t / 0.35
		draw_rect(Rect2(Vector2.ZERO, sz), Color(1, 1, 1, 0.12 * a))
	if main == null:
		return
	var p: Player = main.player
	if p != null and is_instance_valid(p) and not victory:
		_draw_stats(p)
	if title_t >= 0.0:
		_draw_title(sz)
	if banner_t >= 0.0:
		_draw_banner(sz)
	if notice_t > 0.0:
		var na := clampf(notice_t, 0.0, 1.0)
		Art.text(self, Vector2(0, sz.y * 0.2), notice_txt, 20, Color(0.85, 0.95, 1.0, na), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 6)
	if tip_a > 0.01 and tip != "":
		var w := minf(820.0, sz.x - 80.0)
		var r := Rect2((sz.x - w) / 2.0, sz.y - 150.0, w, 74.0)
		draw_rect(r, Color(0.02, 0.04, 0.07, 0.72 * tip_a))
		draw_line(r.position, Vector2(r.end.x, r.position.y), Color(0.5, 0.85, 1.0, 0.6 * tip_a), 1.5)
		draw_multiline_string(Art.font(), r.position + Vector2(18, 28), tip, HORIZONTAL_ALIGNMENT_CENTER, w - 36.0, 17, 3, Color(0.88, 0.94, 1.0, tip_a))
	if prompt != "" and not victory:
		var pr := Rect2(sz.x / 2.0 - 190.0, sz.y - 62.0, 380.0, 36.0)
		draw_rect(pr, Color(0.02, 0.04, 0.07, 0.75))
		draw_rect(pr, Color(0.5, 0.85, 1.0, 0.5 + 0.2 * sin(t * 4.0)), false, 1.5)
		Art.text(self, pr.position + Vector2(0, 24), prompt, 18, Color(1, 1, 1), HORIZONTAL_ALIGNMENT_CENTER, pr.size.x)
	if main.level != null and main.level.boss_active and main.level.boss != null and is_instance_valid(main.level.boss):
		_draw_boss_bar(sz, main.level.boss)
	if map_open:
		_draw_map(sz)
	elif paused_shown:
		_draw_pause(sz)
	if victory:
		_draw_victory(sz)


func _draw_stats(p: Player) -> void:
	var oc := Vector2(62, 64)
	var r := 32.0
	Art.poly(self, Art.circle(oc, r + 4.0, 40), Color(0.02, 0.03, 0.05, 0.85))
	var ratio := clampf(energy_disp / 99.0, 0.0, 1.0)
	if ratio > 0.01:
		var top := oc.y + r - 2.0 * r * ratio
		var pts := PackedVector2Array()
		for i in 48:
			var a := TAU * float(i) / 48.0
			var q := oc + Vector2(cos(a), sin(a)) * r
			q.y = maxf(q.y, top)
			pts.append(q)
		draw_colored_polygon(pts, Color(0.35, 0.85, 1.0, 0.85))
		draw_line(Vector2(oc.x - sqrt(maxf(0.0, r * r - pow(top - oc.y, 2))), top), Vector2(oc.x + sqrt(maxf(0.0, r * r - pow(top - oc.y, 2))), top), Color(0.85, 1.0, 1.0, 0.9), 2.0, true)
	var rim := Color(0.9, 0.95, 1.0, 0.95)
	if energy_disp >= 33.0:
		rim = Color(0.6, 1.0, 1.0, 0.8 + 0.2 * sin(t * 6.0))
	if denied_t > 0.0:
		rim = Color(1.0, 0.4, 0.3, 1.0)
	draw_arc(oc, r + 2.0, 0.0, TAU, 48, rim, 3.0, true)
	for k: int in [1, 2]:
		var yy := oc.y + r - 2.0 * r * (k / 3.0)
		draw_line(Vector2(oc.x + r - 6, yy), Vector2(oc.x + r + 2, yy), Color(1, 1, 1, 0.5), 1.5)
	for i in p.max_hp:
		var c := Vector2(122 + i * 30, 48)
		if i < p.hp:
			Art.poly(self, Art.shard(c, 1.0), Color(0.93, 0.95, 1.0))
			draw_line(c + Vector2(0, -10), c + Vector2(0, 8), Color(0.45, 0.85, 1.0, 0.8), 2.0)
		else:
			var sh := Art.shard(c, 1.0)
			sh.append(sh[0])
			draw_polyline(sh, Color(0.5, 0.6, 0.7, 0.6), 1.5, true)
	if main.modules.has("arpao"):
		var mc := Vector2(62, 118)
		draw_arc(mc, 11.0, 0, TAU, 24, Color(0.35, 0.92, 1.0, 0.85), 2.0, true)
		draw_line(mc + Vector2(-5, 5), mc + Vector2(4, -4), Color(1, 1, 1), 2.0, true)
		draw_arc(mc + Vector2(4, -1), 4.0, -PI * 0.9, PI * 0.4, 10, Color(1, 1, 1), 2.0, true)
		Art.text(self, mc + Vector2(16, 5), "F", 13, Color(0.75, 0.85, 0.95))
	var cc := Vector2(126, 90)
	var s := 1.0 + cell_pulse * 1.5
	Art.poly(self, PackedVector2Array([cc + Vector2(0, -8) * s, cc + Vector2(5, 0) * s, cc + Vector2(0, 8) * s, cc + Vector2(-5, 0) * s]), Color(0.55, 0.95, 1.0))
	Art.text(self, cc + Vector2(14, 7), str(main.cells), 20, Color(0.9, 0.95, 1.0), HORIZONTAL_ALIGNMENT_LEFT, -1, 4)
	var fx0 := get_viewport_rect().size.x - 40.0
	Art.text(self, Vector2(fx0 - 300, 40), "FRAGMENTOS", 14, Color(0.7, 0.8, 0.9, 0.8), HORIZONTAL_ALIGNMENT_RIGHT, 220)
	for i in 4:
		var fc := Vector2(fx0 - i * 22, 34)
		var pts2 := PackedVector2Array([fc + Vector2(0, -9), fc + Vector2(6, 0), fc + Vector2(0, 9), fc + Vector2(-6, 0)])
		if 3 - i < main.fragments:
			Art.poly(self, pts2, Color(0.75, 0.9, 1.0))
		else:
			pts2.append(pts2[0])
			draw_polyline(pts2, Color(0.5, 0.6, 0.7, 0.6), 1.5, true)


func _draw_title(sz: Vector2) -> void:
	var a := 1.0
	if title_t < 1.0:
		a = title_t
	elif title_t > 3.5:
		a = 4.5 - title_t
	a = clampf(a, 0.0, 1.0)
	var y := sz.y * 0.3
	Art.text(self, Vector2(0, y), title, 46, Color(0.95, 0.97, 1.0, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 8)
	var lw := 220.0 * a
	draw_line(Vector2(sz.x / 2.0 - lw, y + 20), Vector2(sz.x / 2.0 + lw, y + 20), Color(0.8, 0.9, 1.0, a * 0.8), 1.5, true)
	draw_circle(Vector2(sz.x / 2.0, y + 20), 3.0, Color(0.8, 0.9, 1.0, a))
	Art.text(self, Vector2(0, y + 50), subtitle, 18, Color(0.75, 0.85, 0.95, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 5)


func _draw_banner(sz: Vector2) -> void:
	var a := clampf(minf(banner_t - 1.2, 6.0 - banner_t), 0.0, 1.0)
	if a <= 0.0:
		return
	var y := sz.y * 0.48
	draw_rect(Rect2(0, y - 34, sz.x, 76), Color(0.02, 0.05, 0.04, 0.6 * a))
	Art.text(self, Vector2(0, y), banner_a, 26, Color(0.85, 1.0, 0.6, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 5)
	Art.text(self, Vector2(0, y + 28), banner_b, 16, Color(0.85, 0.95, 0.9, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 4)


func _draw_boss_bar(sz: Vector2, b: Queen) -> void:
	var w := 520.0
	var r := Rect2((sz.x - w) / 2.0, sz.y - 40.0, w, 10.0)
	draw_rect(r, Color(0.05, 0.03, 0.08, 0.85))
	draw_rect(Rect2(r.position, Vector2(w * clampf(float(b.hp) / b.max_hp, 0, 1), 10)), Color(0.7, 0.5, 1.0))
	draw_rect(r, Color(0.9, 0.85, 1.0, 0.6), false, 1.0)
	Art.text(self, Vector2(0, r.position.y - 8), "RAINHA MICÉLIA", 15, Color(0.9, 0.85, 1.0), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 4)


func open_pause() -> void:
	paused_shown = true
	pause_screen = "main"
	pause_list.set_items([
		{"id": "resume", "label": "Continuar"},
		{"id": "map", "label": "Mapa"},
		{"id": "logs", "label": "Registros do Projeto (%d/%d)" % [Logs.read_count(main), Logs.ORDER.size()]},
		{"id": "options", "label": "Opções"},
		{"id": "menu", "label": "Salvar e sair para o menu"},
	])
	pause_list.sel = 0
	pause_list.font_size = 24
	pause_list.spacing = 44.0


## Trata a entrada da pausa. Devolve "resume", "menu" ou "map" quando o jogo precisa agir.
func pause_input(event: InputEvent) -> String:
	var id := pause_list.handle(event)
	if pause_screen == "options":
		if id == "back" or event.is_action_pressed("pause"):
			Settings.save_cfg()
			open_pause()
			pause_list.sel = 3
		return ""
	if event.is_action_pressed("pause"):
		return "resume"
	match id:
		"resume":
			return "resume"
		"map":
			return "map"
		"logs":
			return "logs"
		"menu":
			return "menu"
		"options":
			pause_screen = "options"
			pause_list.set_items(MenuList.options_items())
			pause_list.sel = 0
	return ""


func _draw_pause(sz: Vector2) -> void:
	draw_rect(Rect2(Vector2.ZERO, sz), Color(0.0, 0.01, 0.03, 0.78))
	Art.text(self, Vector2(0, sz.y * 0.2), "PAUSADO" if pause_screen == "main" else "OPÇÕES", 44, Color(0.95, 0.97, 1.0), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
	pause_list.draw(self, sz.x / 2.0, sz.y * 0.34, 520.0 if pause_screen == "options" else 420.0, t)
	if pause_screen == "main":
		var lines := [
			"A/D mover · ESPAÇO pular · S+ESPAÇO descer · SHIFT esquiva · E interagir · TAB mapa",
			"Clique esquerdo/J atirar (W/S mudam a direção) · Clique direito/K especial (1/3 da energia)",
			"Controle: A pula · X ataca · Y especial · B esquiva · LB interage · Select mapa",
		]
		for i in lines.size():
			Art.text(self, Vector2(0, sz.y * 0.80 + i * 24), lines[i], 15, Color(0.65, 0.73, 0.83), HORIZONTAL_ALIGNMENT_CENTER, sz.x)


func _draw_map(sz: Vector2) -> void:
	draw_rect(Rect2(Vector2.ZERO, sz), Color(0.01, 0.02, 0.04, 0.92))
	var lv = main.level
	if lv == null:
		return
	var d: Dictionary = lv.data
	var rooms: Array = d.get("rooms", [])
	Art.text(self, Vector2(0, 58), String(d["name"]), 30, Color(0.9, 0.95, 1.0), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 5)
	if rooms.is_empty():
		return
	var bb: Rect2 = rooms[0][1]
	for r in rooms:
		bb = bb.merge(r[1])
	var area := Rect2(70, 100, sz.x - 140, sz.y - 200)
	var sc := minf(area.size.x / bb.size.x, area.size.y / bb.size.y)
	var off := area.position + (area.size - bb.size * sc) / 2.0 - bb.position * sc
	var to_map := func(p: Vector2) -> Vector2: return off + p * sc
	var visited_rooms: Array = []
	for r in rooms:
		if main.visited.has(lv.id + ":" + String(r[0])):
			visited_rooms.append(r)
	# salas visitadas: fundo + terreno simplificado
	for r in visited_rooms:
		var rr: Rect2 = r[1]
		draw_rect(Rect2(to_map.call(rr.position), rr.size * sc), Color(0.08, 0.14, 0.2, 0.95))
	for sol in d["solids"]:
		var sr: Rect2 = sol
		for r in visited_rooms:
			# a sala é estendida um pouco para baixo para incluir a superfície do chão
			var inter: Rect2 = sr.intersection((r[1] as Rect2).grow_side(SIDE_BOTTOM, 26.0))
			if inter.has_area():
				draw_rect(Rect2(to_map.call(inter.position), inter.size * sc), Color(0.28, 0.38, 0.5, 0.95))
	for pl in d.get("platforms", []):
		var prr: Rect2 = pl[1]
		for r in visited_rooms:
			if (r[1] as Rect2).intersects(prr):
				draw_rect(Rect2(to_map.call(prr.position), Vector2(prr.size.x * sc, maxf(2.0, prr.size.y * sc))), Color(0.35, 0.8, 0.95, 0.8))
	for r in visited_rooms:
		var rr: Rect2 = r[1]
		draw_rect(Rect2(to_map.call(rr.position), rr.size * sc), Color(0.35, 0.8, 0.95, 0.6), false, 1.5)
		Art.text(self, to_map.call(rr.position) + Vector2(4, 14), String(r[1 + 1]) if r.size() > 2 else "", 11, Color(0.7, 0.85, 0.95, 0.85))
	# ícones (só em salas visitadas)
	var in_visited := func(p: Vector2) -> bool:
		for r in visited_rooms:
			if (r[1] as Rect2).grow(2.0).has_point(p + Vector2(0, -6)):
				return true
		return false
	for c in d.get("checkpoints", []):
		if in_visited.call(c):
			var q: Vector2 = to_map.call(c + Vector2(0, -20))
			draw_circle(q, 6.0, Color(0.35, 0.95, 1.0))
			draw_arc(q, 9.0, 0, TAU, 20, Color(0.35, 0.95, 1.0, 0.6), 1.5, true)
	for tm in d.get("terminals", []):
		if in_visited.call(tm[1]):
			var q2: Vector2 = to_map.call(tm[1] + Vector2(0, -20))
			var on: bool = main.terminals.has(tm[0])
			draw_rect(Rect2(q2 - Vector2(7, 7), Vector2(14, 14)), Color(0.4, 1.0, 0.6) if on else Color(1.0, 0.4, 0.3))
			Art.text(self, q2 + Vector2(-4, -10), String(tm[0]), 12, Color(1, 1, 1))
	if d.has("door") and in_visited.call((d["door"]["rect"] as Rect2).get_center()):
		var dr: Rect2 = d["door"]["rect"]
		draw_rect(Rect2(to_map.call(dr.position), dr.size * sc), Color(1.0, 0.75, 0.2) if lv.door == null or not lv.door.opened else Color(0.4, 1.0, 0.6))
	if d.has("portal") and in_visited.call(d["portal"]["pos"]):
		var pq: Vector2 = to_map.call(d["portal"]["pos"] + Vector2(0, -60))
		draw_arc(pq, 9.0, 0, TAU, 24, Color(0.65, 0.45, 1.0), 3.0, true)
	if d.has("boss") and in_visited.call(d["boss"]["pos"] + Vector2(0, -20)):
		var bq: Vector2 = to_map.call(d["boss"]["pos"] + Vector2(0, -60))
		draw_circle(bq, 8.0, Color(0.75, 0.5, 1.0) if not main.boss_done.has(lv.id) else Color(0.4, 0.5, 0.6))
	# jogador
	if is_instance_valid(main.player):
		var pp: Vector2 = to_map.call(main.player.global_position + Vector2(0, -30))
		var a := 0.55 + 0.45 * sin(t * 6.0)
		draw_circle(pp, 7.0, Color(1, 1, 1, a))
		draw_circle(pp, 3.5, Color(0.35, 0.92, 1.0))
	# legenda
	var ly := sz.y - 70.0
	var items := [[Color(0.35, 0.95, 1.0), "Estação de Recarga"], [Color(1.0, 0.4, 0.3), "Terminal pendente"], [Color(0.4, 1.0, 0.6), "Terminal ativo"], [Color(1.0, 0.75, 0.2), "Porta travada"], [Color(0.65, 0.45, 1.0), "Portal"], [Color(1, 1, 1), "Você"]]
	var total := 0.0
	for it in items:
		total += Art.font().get_string_size(it[1], HORIZONTAL_ALIGNMENT_LEFT, -1, 14).x + 46.0
	var x := (sz.x - total) / 2.0
	for it in items:
		draw_circle(Vector2(x, ly - 5), 5.0, it[0])
		Art.text(self, Vector2(x + 10, ly), it[1], 14, Color(0.75, 0.82, 0.9))
		x += Art.font().get_string_size(it[1], HORIZONTAL_ALIGNMENT_LEFT, -1, 14).x + 46.0
	Art.text(self, Vector2(0, sz.y - 30), "TAB ou ESC para fechar · salas aparecem conforme você explora", 14, Color(0.55, 0.62, 0.72), HORIZONTAL_ALIGNMENT_CENTER, sz.x)


func _draw_victory(sz: Vector2) -> void:
	var a := clampf(victory_t / 1.2, 0.0, 1.0)
	draw_rect(Rect2(Vector2.ZERO, sz), Color(0.0, 0.02, 0.04, 0.82 * a))
	var y := sz.y * 0.26
	Art.text(self, Vector2(0, y), "FRAGMENTO RECUPERADO", 46, Color(0.75, 0.92, 1.0, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x, 8)
	Art.text(self, Vector2(0, y + 48), "%d / 4" % main.fragments, 28, Color(0.95, 0.97, 1.0, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
	var secs := int(main.play_time)
	var stats := "Tempo  %02d:%02d     ·     Células de Fase  %d     ·     Quedas  %d" % [secs / 60, secs % 60, main.cells, main.deaths]
	Art.text(self, Vector2(0, y + 110), stats, 19, Color(0.8, 0.88, 0.95, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
	Art.text(self, Vector2(0, y + 170), "Fim do protótipo. Hidrópolis, Ferrumgrado e Umbra chegam nas próximas versões.", 17, Color(0.7, 0.78, 0.86, a), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
	if victory_t > 1.5:
		Art.text(self, Vector2(0, y + 240), "ENTER — voltar ao menu", 20, Color(1, 1, 1, 0.6 + 0.4 * sin(t * 3.0)), HORIZONTAL_ALIGNMENT_CENTER, sz.x)
