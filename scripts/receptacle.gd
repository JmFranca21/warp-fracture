class_name Receptacle
extends Interactable
## Receptáculo da Máquina de Dobra (D02, PT15): pedestal com quatro soquetes ligado ao Arco por um cabo.
## Instalar um fragmento dá energia ao portal para um novo destino. Depois disso funciona como
## estação: restaura a Integridade e salva o jogo.

const SOCKETS := [Vector2(515, 585), Vector2(430, 655), Vector2(590, 650), Vector2(510, 725)]   # losango (original, medido)
const ORDER := ["verdamia", "deserto", "hidropolis", "umbra"]

var portal_x := 0.0
var spr: Sprite2D
var gems: Array = []
var glow: Sprite2D
var beam_t := 0.0


func _setup() -> void:
	size = Vector2(110, 120)
	z_index = -1
	glow = Art.glow(Color(0.4, 0.9, 1.0, 0.3), 90)
	glow.position = Vector2(0, -60)
	add_child(glow)
	spr = DFArt.sprite("PT15", Vector2(512, 984))
	add_child(spr)
	for s in SOCKETS:
		var g := Props.centered(SpriteMetaVerd.OBJ_DIR + "fragmento.png", SpriteMetaVerd.OBJ_SCALE * 0.32)
		g.position = (s - Vector2(512, 984)) * DFArt.K
		g.visible = false
		add_child(g)
		gems.append(g)
	refresh()


func refresh() -> void:
	if main == null:
		return
	var n := 0
	for i in ORDER.size():
		var on: bool = main.installed.has(ORDER[i])
		gems[i].visible = on
		if on:
			n += 1
	if main.pending_install() != "":
		prompt = "[E] Instalar o fragmento"
	elif n > 0:
		prompt = "[E] Descansar no Receptáculo"
	else:
		prompt = ""
	refresh_prompt()


func interact() -> void:
	var f: String = main.pending_install()
	if f != "":
		beam_t = 1.2
		main.install_fragment(f, self)
	else:
		main.set_checkpoint(global_position)
		Fx.ring(main.level.fx, global_position + Vector2(0, -50), Color(0.5, 1.0, 0.9), 110, 0.5, 5)
	refresh()


func _process(dt: float) -> void:
	super._process(dt)
	beam_t = maxf(0.0, beam_t - dt)
	var lit: bool = main != null and not main.installed.is_empty()
	var pend: bool = main != null and main.pending_install() != ""
	glow.modulate.a = (0.35 if lit else 0.1) + (0.25 * absf(sin(t * 4.0)) if pend else 0.0) + beam_t * 0.4
	for g in gems:
		if g.visible:
			g.modulate = Color(1, 1, 1, 0.8 + 0.2 * sin(t * 3.0))


func _draw() -> void:
	# cabo do Receptáculo até a base do Arco (sai pela borda direita da peça, y ≈ 900 do original)
	var y := (900 - 984) * DFArt.K
	var a := Vector2((1000 - 512) * DFArt.K, y)
	var b := Vector2(portal_x - global_position.x - 70.0, -4.0)
	if b.x <= a.x:
		return
	draw_line(a, Vector2(b.x, a.y), Color("1b2433"), 5.0)
	draw_line(Vector2(b.x, a.y), b, Color("1b2433"), 5.0)
	var col := Color(0.35, 0.92, 1.0, 0.25 + beam_t * 0.6)
	draw_line(a, Vector2(b.x, a.y), col, 2.0)
	if beam_t > 0.0:
		var k := 1.0 - beam_t / 1.2
		var p := a.lerp(Vector2(b.x, a.y), clampf(k * 1.4, 0.0, 1.0))
		draw_circle(p, 5.0, Color(0.8, 1.0, 1.0, 0.9))
