class_name AudioMgr
extends Node
## Gerenciador de áudio: efeitos com variação de tom e atenuação pela distância da câmera,
## música com troca suave (crossfade). Barramentos: Master, Musica, Efeitos.

static var inst: AudioMgr
const SFX_DIR := "res://assets/audio/sfx/"
const MUS_DIR := "res://assets/audio/music/"
const POOL := 24

var players: Array[AudioStreamPlayer] = []
var cache := {}
var last_play := {}
var mus_a: AudioStreamPlayer
var mus_b: AudioStreamPlayer
var current_track := ""
var main
var played := 0


func shutdown() -> void:
	_exit_tree()


func _exit_tree() -> void:
	for q in players:
		q.stop()
		q.stream = null
	for m in [mus_a, mus_b]:
		if m != null:
			m.stop()
			m.stream = null
	cache.clear()
	if inst == self:
		inst = null


static func sfx(name: String, pos: Vector2 = Vector2.INF, vol_db := 0.0, pitch_var := 0.06) -> void:
	if inst != null:
		inst._play(name, pos, vol_db, pitch_var)


static func music(track: String) -> void:
	if inst != null:
		inst._music(track)


func _ready() -> void:
	inst = self
	process_mode = Node.PROCESS_MODE_ALWAYS
	_setup_buses()
	for i in POOL:
		var p := AudioStreamPlayer.new()
		p.bus = "Efeitos"
		add_child(p)
		players.append(p)
	mus_a = AudioStreamPlayer.new()
	mus_b = AudioStreamPlayer.new()
	for m in [mus_a, mus_b]:
		m.bus = "Musica"
		m.volume_db = -80.0
		add_child(m)


func _setup_buses() -> void:
	for b in ["Musica", "Efeitos"]:
		if AudioServer.get_bus_index(b) == -1:
			AudioServer.add_bus()
			var idx := AudioServer.bus_count - 1
			AudioServer.set_bus_name(idx, b)
			AudioServer.set_bus_send(idx, "Master")


static func set_volume(bus: String, linear: float) -> void:
	var idx := AudioServer.get_bus_index(bus)
	if idx >= 0:
		AudioServer.set_bus_volume_db(idx, linear_to_db(maxf(linear, 0.0001)))
		AudioServer.set_bus_mute(idx, linear <= 0.001)


func _stream(path: String) -> AudioStream:
	if not cache.has(path):
		cache[path] = load(path) if ResourceLoader.exists(path) else null
	return cache[path]


func _play(name: String, pos: Vector2, vol_db: float, pitch_var: float) -> void:
	var st := _stream(SFX_DIR + name + ".wav")
	if st == null:
		return
	# evita empilhar o mesmo som no mesmo instante (ex.: 6 células coletadas juntas)
	var now := Time.get_ticks_msec()
	if last_play.has(name) and now - int(last_play[name]) < 35:
		return
	last_play[name] = now
	var v := vol_db
	if pos != Vector2.INF and main != null and main.cam != null:
		var d: float = pos.distance_to(main.cam.get_screen_center_position())
		if d > 1500.0:
			return
		v -= clampf((d - 350.0) / 60.0, 0.0, 20.0)
	var p: AudioStreamPlayer = null
	for q in players:
		if not q.playing:
			p = q
			break
	if p == null:
		p = players[0]
	p.stream = st
	p.volume_db = v
	p.pitch_scale = 1.0 + randf_range(-pitch_var, pitch_var)
	p.play()
	played += 1


func _music(track: String) -> void:
	if track == current_track:
		return
	current_track = track
	var incoming := mus_b if mus_a.playing and mus_a.volume_db > -40.0 else mus_a
	var outgoing := mus_a if incoming == mus_b else mus_b
	var tw := create_tween().set_parallel(true)
	if track != "":
		var st := _stream(MUS_DIR + track + ".ogg")
		if st is AudioStreamOggVorbis:
			(st as AudioStreamOggVorbis).loop = true
		incoming.stream = st
		incoming.volume_db = -40.0
		incoming.play()
		tw.tween_property(incoming, "volume_db", 0.0, 1.2)
	tw.tween_property(outgoing, "volume_db", -80.0, 1.2)
	tw.chain().tween_callback(func():
		if outgoing.volume_db <= -79.0:
			outgoing.stop())
