@tool
class_name PreviaEditor
extends Node2D
## Só no editor do Godot: desenha por cima da fase o que só aparece quando o jogo roda (itens, inimigos, plataformas,
## objetos de interação, perigos, a Fuga do Eco, a luta e as salas do mapa), com o nome de cada nó. Fica dentro de
## Marcadores, que o Level remove antes de a fase entrar no jogo (preparar). Desligue "mostrar" para esconder.

@export var mostrar := true:
	set(v):
		mostrar = v
		queue_redraw()
@export var mostrar_salas := true:
	set(v):
		mostrar_salas = v
		queue_redraw()

const C_ITEM := Color(0.35, 1.0, 0.85)
const C_INIMIGO := Color(1.0, 0.35, 0.35)
const C_OBJETO := Color(0.55, 0.8, 1.0)
const C_PLAT := Color(1.0, 0.8, 0.3)
const C_PERIGO := Color(0.8, 0.3, 1.0)
const C_FUGA := Color(1.0, 0.5, 0.2)
var _t := 0.0


func _ready() -> void:
	if not Engine.is_editor_hint():
		queue_free()
		return
	z_index = 100
	z_as_relative = false


func _process(dt: float) -> void:
	_t += dt
	if _t > 0.25:      # acompanha o que for movido no editor
		_t = 0.0
		queue_redraw()


func _txt(p: Vector2, s: String, c: Color, size := 13) -> void:
	var f := ThemeDB.fallback_font
	draw_string_outline(f, p, s, HORIZONTAL_ALIGNMENT_LEFT, -1, size, 4, Color(0, 0, 0, 0.85))
	draw_string(f, p, s, HORIZONTAL_ALIGNMENT_LEFT, -1, size, c)


func _icone(p: Vector2, c: Color, nome: String, r := 9.0) -> void:
	draw_circle(p, r, Color(c, 0.35))
	draw_arc(p, r, 0, TAU, 20, c, 2.0)
	_txt(p + Vector2(r + 3, -r), nome, c)


func _draw() -> void:
	if not Engine.is_editor_hint() or not mostrar:
		return
	var lv := get_parent().get_parent() as Level
	if lv == null:
		return
	if mostrar_salas:
		for s in lv.salas:
			var r: Rect2 = s[1]
			draw_rect(r, Color(0.6, 0.75, 1.0, 0.5), false, 2.0)
			_txt(r.position + Vector2(8, 22), "Sala %s · %s" % [s[0], s[2] if s.size() > 2 else ""], Color(0.75, 0.85, 1.0), 16)
	for m in get_parent().get_children():
		if m is Marker2D:
			draw_line(m.position, m.position + Vector2(0, -60), Color.WHITE, 2.0)
			draw_colored_polygon(PackedVector2Array([m.position + Vector2(0, -60), m.position + Vector2(30, -50),
				m.position + Vector2(0, -40)]), Color(1, 1, 1, 0.8))
			_txt(m.position + Vector2(4, -66), m.name, Color.WHITE, 14)
	if lv.chefe.has("trigger_x"):
		var tx: float = lv.chefe["trigger_x"]
		draw_dashed_line(Vector2(tx, lv.limites.position.y), Vector2(tx, lv.limites.end.y), C_INIMIGO, 2.0, 12.0)
		_txt(Vector2(tx + 6, lv.limites.position.y + 40), "início da luta", C_INIMIGO)
		draw_rect(lv.chefe["gate"], Color(C_INIMIGO, 0.25))
		_icone(lv.chefe["fragment"], Color(0.8, 0.6, 1.0), "Fragmento (depois da luta)")
	for c in lv.get_children():
		if c is SpritePlatform:
			draw_rect(c.rect, Color(C_PLAT, 0.45))
			draw_rect(c.rect, C_PLAT, false, 2.0)
			if c.travel != Vector2.ZERO:
				var a: Vector2 = c.rect.get_center()
				draw_line(a, a + c.travel, C_PLAT, 2.0)
				draw_rect(Rect2(c.rect.position + c.travel, c.rect.size), C_PLAT, false, 1.0)
			if not is_nan(c.hang_y):
				draw_dashed_line(Vector2(c.rect.get_center().x, c.hang_y), Vector2(c.rect.get_center().x, c.rect.position.y), C_PLAT, 1.0, 6.0)
			_txt(c.rect.position + Vector2(0, -6), "%s (%s)" % [c.name, c.kind], C_PLAT)
		elif c is Hazard:
			draw_rect(c.rect, Color(C_PERIGO, 0.4))
			_txt(c.rect.position + Vector2(4, -4), c.name, C_PERIGO)
		elif c is Fuga:
			var cfg: Dictionary = c.cfg
			var tx2: float = cfg.get("trigger_x", 0.0)
			draw_dashed_line(Vector2(tx2, 220), Vector2(tx2, 800), C_FUGA, 2.0, 12.0)
			_txt(Vector2(tx2 + 6, 240), "Fuga do Eco: começa aqui", C_FUGA)
			if cfg.has("slab"):
				draw_rect(cfg["slab"], Color(C_FUGA, 0.4))
				_txt((cfg["slab"] as Rect2).position + Vector2(0, -6), "piso que desaba", C_FUGA)
			if cfg.has("eco_spawn"):
				_icone(cfg["eco_spawn"], C_FUGA, "Eco")
			for dbr in cfg.get("debris", []):
				draw_line(Vector2(dbr[0], dbr[1] - 40), Vector2(dbr[0], dbr[1]), C_FUGA, 3.0)
	for c in lv.get_node("Objetos").get_children():
		if c is Pickup:
			var k: Color = C_ITEM
			draw_colored_polygon(PackedVector2Array([c.position + Vector2(0, -10), c.position + Vector2(8, 0),
				c.position + Vector2(0, 10), c.position + Vector2(-8, 0)]), k)
			_txt(c.position + Vector2(10, -6), "%s (%s)" % [c.pid if c.pid != "" else c.name, c.kind], k)
		elif c is Door:
			draw_rect(c.rect, Color(C_OBJETO, 0.35))
			_txt(c.rect.position + Vector2(4, -6), "Porta (requer %s)" % ", ".join(lv.porta_requer), C_OBJETO)
		elif c is EnergyField:
			draw_rect(c.rect, Color(C_OBJETO, 0.35))
			_txt(c.rect.position + Vector2(4, -6), "%s (%s)" % [c.name, c.sid], C_OBJETO)
		elif c is LaserGate:     # no editor só as variáveis com @export existem: o resto vem do padrão do script
			var y0: float = c.get("top_y") if c.get("top_y") != null else 220.0
			var y1: float = c.get("bottom_y") if c.get("bottom_y") != null else 800.0
			draw_line(Vector2(c.position.x, y0), Vector2(c.position.x, y1), C_INIMIGO, 3.0)
			_txt(Vector2(c.position.x + 6, y0 + 20), c.name, C_INIMIGO)
		elif c is SecurityCam:
			var alc: float = c.get("range_px") if c.get("range_px") != null else 700.0
			draw_line(c.position, c.position + Vector2(c.side * alc, 120), Color(C_INIMIGO, 0.5), 2.0)
			_icone(c.position, C_INIMIGO, c.name)
		elif c is GrappleHook:
			_icone(c.position, C_OBJETO, c.name, 7.0)
			if not is_nan(c.ceil_y):
				draw_line(Vector2(c.position.x, c.ceil_y), c.position, C_OBJETO, 1.0)
		elif c is Node2D:
			var extra := ""
			if c is Sign:
				extra = ": " + (c.text as String).left(40) + ("…" if (c.text as String).length() > 40 else "")
			elif c is Terminal:
				extra = " " + c.tid
			elif c is Lever or c is EnergyLock:
				extra = " → " + c.target
			elif c is Portal:
				extra = " → " + c.target
			_icone(c.position + Vector2(0, -30), C_OBJETO, c.name + extra)
	for c in lv.get_node("Entidades").get_children():
		if c is Node2D:
			var cor: Color = C_INIMIGO if c is Enemy else Color(0.85, 0.65, 0.4)
			_icone(c.position + Vector2(0, -24), cor, c.name, 14.0 if c is Queen else 9.0)
