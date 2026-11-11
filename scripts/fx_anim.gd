class_name FxAnim
extends AnimatedSprite2D
## Efeito animado de uma vez só (explosão, caixa quebrando, impacto). Some ao terminar.

static var _cache := {}
var vel := Vector2.ZERO     # movimento opcional (ex.: corpo de inimigo caindo)
var grav := 0.0
var linger := 0.0           # segundos parado no último quadro antes de desvanecer


static func frames(path: String) -> SpriteFrames:
	if not _cache.has(path):
		_cache[path] = load(path)
	return _cache[path]


static func spawn(parent: Node, path: String, off: Vector2, pos: Vector2, sc: float,
		anim := "play", rot := 0.0, add := false) -> FxAnim:
	if parent == null or not is_instance_valid(parent):
		return null
	var f := FxAnim.new()
	f.sprite_frames = frames(path)
	f.offset = off
	f.position = pos
	f.scale = Vector2.ONE * sc
	f.rotation = rot
	f.z_index = 9
	if add:
		f.material = Art.add_mat()
	parent.add_child.call_deferred(f)
	f.ready.connect(func(): f.play(anim))
	f.animation_finished.connect(f._done)
	return f


func _done() -> void:
	if linger <= 0.0:
		queue_free()
		return
	var tw := create_tween()
	tw.tween_interval(linger)
	tw.tween_property(self, "modulate:a", 0.0, 0.5)
	tw.tween_callback(queue_free)


func _process(dt: float) -> void:
	if vel == Vector2.ZERO and grav == 0.0:
		return
	vel.y += grav * dt
	position += vel * dt


## Efeitos de Verdâmia (SpriteMetaVerd.FX): raiz, aviso_raiz, impacto_esporo, invocacao, poeira, garras, clarao
static func verd(parent: Node, nome: String, pos: Vector2, mult := 1.0, rot := 0.0) -> FxAnim:
	var d: Array = SpriteMetaVerd.FX[nome]
	return spawn(parent, d[0], d[1], pos, float(d[2]) * mult, "play", rot)


static func explosion(parent: Node, pos: Vector2, sc := 1.4) -> void:
	spawn(parent, SpriteMeta.FX_EXPLOSAO_FRAMES, SpriteMeta.FX_EXPLOSAO_OFFSET, pos, sc)


static func crate_break(parent: Node, pos: Vector2, sc := 0.63) -> void:
	spawn(parent, SpriteMeta.FX_CAIXA_FRAMES, SpriteMeta.FX_CAIXA_OFFSET, pos, sc)


static func impact(parent: Node, pos: Vector2, sc := 0.5) -> void:
	spawn(parent, SpriteMeta.FX_IMPACTO_FRAMES, SpriteMeta.FX_IMPACTO_OFFSET, pos, sc, "play", randf() * TAU, true)
