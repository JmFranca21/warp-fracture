class_name SaveGame
extends RefCounted
## Salvamento em user://warp_save.json (nas Estações de Recarga e ao trocar de área).

const PATH := "user://warp_save.json"
const VERSION := 1


static func exists() -> bool:
	return FileAccess.file_exists(PATH)


static func write(main) -> void:
	var d := {
		"version": VERSION,
		"level": main.checkpoint_level,
		"pos": [main.checkpoint_pos.x, main.checkpoint_pos.y],
		"terminals": main.terminals.keys(),
		"collected": main.collected.keys(),
		"boss_done": main.boss_done.keys(),
		"visited": main.visited.keys(),
		"fragments": main.fragments,
		"frags": main.frags.keys(),
		"cells": main.cells,
		"deaths": main.deaths,
		"play_time": main.play_time,
		"modules": main.modules.keys(),
		"upgrades": main.upgrades,
	}
	var f := FileAccess.open(PATH, FileAccess.WRITE)
	if f != null:
		f.store_string(JSON.stringify(d, "\t"))


static func read() -> Dictionary:
	if not exists():
		return {}
	var f := FileAccess.open(PATH, FileAccess.READ)
	if f == null:
		return {}
	var d = JSON.parse_string(f.get_as_text())
	return d if d is Dictionary else {}


static func erase() -> void:
	if exists():
		DirAccess.remove_absolute(ProjectSettings.globalize_path(PATH))


static func to_set(arr) -> Dictionary:
	var out := {}
	if arr is Array:
		for k in arr:
			out[k] = true
	return out


## Fragmentos recuperados, por fase. Saves sem o campo "frags" (até a v0.6) são migrados:
## cada fase com chefe derrotado conta como coletada enquanto houver "fragments" para cobrir.
## Assim, Rainha vencida + fragments >= 1 vira ["verdamia"] (e um contador 2/4, do defeito
## da v0.6, volta a 1/4); Rainha vencida + fragments = 0 mantém o fragmento no altar.
static func fragment_set(d: Dictionary) -> Dictionary:
	if d.has("frags"):
		return to_set(d["frags"])
	var out := {}
	var n := int(d.get("fragments", 0))
	var bd = d.get("boss_done", [])
	if bd is Array:
		for lv in bd:
			if n <= 0:
				break
			out[String(lv)] = true
			n -= 1
	return out


## resumo curto para o menu ("Laboratório Hélix · 12:34 · 1/4 fragmentos")
static func summary() -> String:
	var d := read()
	if d.is_empty():
		return ""
	var lv: String = LevelData.get_level(String(d.get("level", "lab")))["name"]
	var secs := int(d.get("play_time", 0.0))
	return "%s  ·  %02d:%02d  ·  %d/4 fragmentos" % [lv.capitalize(), secs / 60, secs % 60, fragment_set(d).size()]
