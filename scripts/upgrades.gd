class_name Upgrades
extends RefCounted
## Melhorias compradas na Bancada com Células de Fase.

# id: [nome, descrição, custos por nível]
const LIST := {
	"blindagem": ["Blindagem do Traje", "+1 de Integridade máxima por nível.", [12, 30]],
	"energia": ["Condensador de Fase", "Acertos rendem +40% de Energia de Fase por nível.", [10, 24]],
	"esquiva": ["Propulsor de Esquiva", "A esquiva recarrega quase duas vezes mais rápido.", [18]],
	"disparo": ["Gatilho Rápido", "O Estabilizador dispara 30% mais rápido.", [15]],
}


static func level(main, id: String) -> int:
	return int(main.upgrades.get(id, 0))


static func max_level(id: String) -> int:
	return (LIST[id][2] as Array).size()


static func cost(main, id: String) -> int:
	var lv := level(main, id)
	var costs: Array = LIST[id][2]
	return -1 if lv >= costs.size() else int(costs[lv])


static func extra_hp(main) -> int:
	return int(main.upgrades.get("hp", 0)) + level(main, "blindagem")


static func energy_mult(main) -> float:
	return 1.0 + 0.4 * level(main, "energia")


static func dash_cd(main) -> float:
	return 0.28 if level(main, "esquiva") > 0 else 0.5


static func fire_cd(main) -> float:
	return 0.14 if level(main, "disparo") > 0 else 0.2
