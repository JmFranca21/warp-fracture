class_name Settings
extends RefCounted
## Opções do jogador (salvas em user://settings.cfg): volumes, tela cheia, tremor de tela.

const PATH := "user://settings.cfg"
static var master := 0.9
static var musica := 0.7
static var efeitos := 0.9
static var fullscreen := false
static var shake := true
static var loaded := false


static func load_cfg() -> void:
	var c := ConfigFile.new()
	if c.load(PATH) == OK:
		master = c.get_value("audio", "master", master)
		musica = c.get_value("audio", "musica", musica)
		efeitos = c.get_value("audio", "efeitos", efeitos)
		fullscreen = c.get_value("video", "fullscreen", fullscreen)
		shake = c.get_value("video", "shake", shake)
	loaded = true
	apply()


static func save_cfg() -> void:
	var c := ConfigFile.new()
	c.set_value("audio", "master", master)
	c.set_value("audio", "musica", musica)
	c.set_value("audio", "efeitos", efeitos)
	c.set_value("video", "fullscreen", fullscreen)
	c.set_value("video", "shake", shake)
	c.save(PATH)


static func apply() -> void:
	AudioMgr.set_volume("Master", master)
	AudioMgr.set_volume("Musica", musica)
	AudioMgr.set_volume("Efeitos", efeitos)
	if DisplayServer.get_name() != "headless":
		var want := DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED
		if DisplayServer.window_get_mode() != want and not (want == DisplayServer.WINDOW_MODE_WINDOWED and DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED):
			DisplayServer.window_set_mode(want)
