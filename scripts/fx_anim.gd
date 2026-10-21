class_name FxAnim
extends AnimatedSprite2D
## Efeito animado de uma vez só (explosão, caixa quebrando, impacto). Some ao terminar.

static var _cache := {}


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
	f.animation_finished.connect(f.queue_free)
	return f


static func explosion(parent: Node, pos: Vector2, sc := 1.4) -> void:
	spawn(parent, SpriteMeta.FX_EXPLOSAO_FRAMES, SpriteMeta.FX_EXPLOSAO_OFFSET, pos, sc)


static func crate_break(parent: Node, pos: Vector2, sc := 0.63) -> void:
	spawn(parent, SpriteMeta.FX_CAIXA_FRAMES, SpriteMeta.FX_CAIXA_OFFSET, pos, sc)


static func impact(parent: Node, pos: Vector2, sc := 0.5) -> void:
	spawn(parent, SpriteMeta.FX_IMPACTO_FRAMES, SpriteMeta.FX_IMPACTO_OFFSET, pos, sc, "play", randf() * TAU, true)
