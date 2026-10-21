class_name LevelData
extends RefCounted
## Layout das fases (baseado no Caderno de 10 páginas).
## Coordenadas em pixels; y cresce para baixo; a origem dos personagens fica nos pés.


static func get_level(id: String) -> Dictionary:
	if id == "verdamia":
		return _verdamia()
	return _lab()


static func _lab() -> Dictionary:
	# Seções: A despertar | B fosso | C turreta | D sala alta (terminal A) | E lasers + câmera
	#         F sala do campo de força (terminal B) | G saída com portal
	# Física do Daymon: pulo máx. ≈144 px de altura; corrida+pulo ≈240 px; +esquiva ≈360 px.
	return {
		"name": "LABORATÓRIO HÉLIX",
		"sub": "Setor de Pesquisa Dimensional — 2100",
		"theme": "lab",
		"form": "human",
		"spawn": Vector2(60, 790),
		"bounds": Rect2(-200, -300, 5250, 1450),
		"kill_y": 1300.0,
		"solids": [
			Rect2(-260, -300, 60, 1700),     # parede esquerda
			Rect2(-260, -300, 2240, 520),    # teto A–C (grosso, base em y=220)
			Rect2(-260, 800, 1260, 600),     # chão A
			Rect2(1000, 1040, 320, 360),     # fundo do fosso
			Rect2(1320, 800, 3200, 600),     # chão C–G
			Rect2(1980, -320, 740, 60),      # teto da sala alta D (base em y=-260)
			Rect2(1980, -320, 40, 920),      # parede esquerda da sala D (passagem embaixo)
			Rect2(2680, -80, 40, 680),       # parede direita da sala D (abertura no alto p/ a ala secreta)
			Rect2(2020, 470, 170, 22),       # beiral da alavanca (preso na parede)
			Rect2(2560, 120, 120, 22),       # beiral do terminal A (preso na parede)
			Rect2(2720, -300, 2390, 40),     # topo da ala secreta
			Rect2(2720, -80, 300, 300),      # piso da ala secreta / teto do corredor de lasers
			Rect2(3020, 100, 460, 120),      # fundo do fosso da ala secreta
			Rect2(3480, -80, 150, 300),      # piso da ala (sala do núcleo)
			Rect2(3690, -80, 130, 300),      # piso da ala (após o alçapão)
			Rect2(3820, -260, 1290, 480),    # teto F–G
			Rect2(3700, 220, 40, 380),       # parede acima do campo de força
			Rect2(4010, 580, 130, 22),       # beiral do terminal B (preso na parede)
			Rect2(4140, 220, 110, 380),      # parede acima da porta
			Rect2(4520, 690, 590, 710),      # bloco elevado da saída
			Rect2(5050, -300, 60, 1700),     # parede direita
		],
		# [tipo, retângulo, (deslocamento), {hang: y do teto, sid: id do gatilho, period}]
		"platforms": [
			["movel", Rect2(1030, 700, 150, 24), Vector2(140, 0), {}],
			["suspensa", Rect2(1600, 680, 180, 24), {"hang": 220.0}],
			["suspensa", Rect2(2100, 690, 160, 24), {"hang": -260.0}],
			["suspensa", Rect2(2330, 580, 160, 24), {"hang": -260.0}],
			["movel", Rect2(2400, 470, 150, 24), Vector2(0, -358), {"sid": "elevador", "period": 5.0}],
			["suspensa", Rect2(2050, 250, 130, 24), {"hang": -260.0}],
			["quebravel", Rect2(3840, 690, 140, 24), {"hang": 220.0}],
			["suspensa", Rect2(4560, 560, 140, 24), {"hang": 220.0}],
		],
		"hazards": [
			Rect2(1000, 1008, 320, 32),      # piso eletrificado do fosso
			Rect2(3020, 70, 460, 30),        # fosso eletrificado da ala secreta
		],
		# ganchos do Arpão: [posição, y do teto onde o suporte está preso]
		"hooks": [
			[Vector2(2700, -200), -260.0],
			[Vector2(3150, -215), -260.0],
			[Vector2(3400, -215), -260.0],
		],
		"lasers": [[2960.0, 0.0], [3210.0, 1.4]],
		"cameras": [[Vector2(2880, 220), 1, [Vector2(3430, 790), Vector2(3470, 790)]]],
		"levers": [[Vector2(2100, 470), "elevador", "O elevador foi ligado!"]],
		"fields": [["campo", Rect2(3700, 600, 40, 200)]],
		"locks": [[Vector2(3665, 800), "campo"]],
		"enemies": [
			["crawler", Vector2(840, 790)],
			["drone", Vector2(1560, 560)],
			["crawler", Vector2(1700, 790)],
			["turret_l", Vector2(1935, 800)],
			["crawler", Vector2(2450, 790)],
			["drone", Vector2(2330, 160)],
			["crawler", Vector2(3900, 790)],
			["crawler", Vector2(2880, -90)],
			["drone", Vector2(4440, 450)],
			["turret_l", Vector2(4700, 690)],
			["crawler", Vector2(4860, 680)],
		],
		"crates": [
			["caixa", Vector2(380, 800)],
			["barril", Vector2(760, 800)],
			["barril", Vector2(3530, 800)],
			["caixa_pesada", Vector2(3960, 800), "heal"],
			["caixa", Vector2(4380, 800)],
			["caixa", Vector2(4424, 800)],
			["caixa", Vector2(4402, 764)],
		],
		# [tipo, posição, id, (reaparece em s)]
		"pickups": [
			["cell", Vector2(1160, 640), "lab_c1"],
			["energy", Vector2(1250, 630), "lab_e1"],
			["cell", Vector2(1690, 640), "lab_c2"],
			["heal", Vector2(1810, 770), "lab_h1"],
			["cell", Vector2(2180, 650), "lab_c3"],
			["cell", Vector2(2410, 540), "lab_c4"],
			["energy", Vector2(2140, 215), "lab_e2"],
			["registro", Vector2(2075, 212), "log_03"],
			["registro", Vector2(455, 776), "log_01"],
			["registro", Vector2(1755, 646), "log_02"],
			["registro", Vector2(3720, -100), "log_04"],
			["registro", Vector2(4070, 776), "log_05"],
			["modulo", Vector2(2598, 92), "lab_arpao"],
			["cell", Vector2(2800, -110), "lab_s1"],
			["cell", Vector2(3275, -200), "lab_s2"],
			["nucleo", Vector2(3555, -115), "lab_nucleo1"],
			["cell", Vector2(3760, -110), "lab_s3"],
			["cell", Vector2(3085, 760), "lab_c6"],
			["energy", Vector2(3610, 760), "", 8.0],
			["cell", Vector2(3910, 650), "lab_c7"],
			["cell", Vector2(4630, 520), "lab_c8"],
		],
		"backwall": {
			"spans": [[-200, 2020, 220, 800], [1000, 1320, 800, 1040], [1980, 2720, -260, 800], [2680, 5050, 220, 800],
				[2720, 3820, -260, -80], [3020, 3480, -80, 100], [3630, 3690, -80, 220]],
			"columns": [120, 560, 990, 1330, 1760, 2350, 2900, 3330, 3940, 4400, 4800, 3000, 3500],
			"breaches": [[775, 520, 70], [3500, 560, 75]],
			"pipes": [[120, 560, 330], [1330, 1980, 320], [2900, 3330, 300], [4400, 4800, 330]],
			"drops": [[200, 684, 330], [1860, 684, 320], [4470, 684, 330]],
		},
		# decoração: [nome, posição, escala, espelhar, ancoragem(chao/teto/centro), brilho]
		"decor": [
			["janela", Vector2(340, 480), 1.0, false, "centro", 0.8],
			["janela", Vector2(1545, 470), 1.0, true, "centro", 0.8],
			["janela", Vector2(2185, 40), 1.0, false, "centro", 0.8],
			["janela", Vector2(3115, 470), 1.0, false, "centro", 0.8],
			["janela", Vector2(4040, 400), 0.9, true, "centro", 0.8],
			["janela", Vector2(4600, 440), 1.0, false, "centro", 0.8],
			["tanque", Vector2(200, 800), 0.8],
			["tanque", Vector2(1860, 800), 0.8],
			["tanque", Vector2(4470, 800), 0.8],
			["tubulacao", Vector2(185, 330), 0.9, false, "centro", 0.85],
			["tubulacao", Vector2(1395, 320), 0.9, false, "centro", 0.85],
			["tubulacao", Vector2(3265, 300), 0.9, true, "centro", 0.85],
			["tubulacao", Vector2(4735, 330), 0.9, true, "centro", 0.85],
			["bandeira", Vector2(650, 220), 0.9, false, "teto"],
			["bandeira", Vector2(2520, -260), 0.9, false, "teto"],
			["bandeira", Vector2(4330, 220), 0.9, false, "teto"],
			["cabos", Vector2(1100, 220), 1.0, false, "teto"],
			["cabos", Vector2(1880, 220), 1.0, true, "teto"],
			["cabos", Vector2(2790, 220), 0.9, false, "teto"],
			["cabos", Vector2(3600, 220), 1.0, true, "teto"],
			["cabos", Vector2(4920, 220), 1.0, false, "teto"],
			["cabos", Vector2(2860, -260), 0.8, false, "teto"],
			["bandeira", Vector2(3740, -260), 0.7, false, "teto"],
			["tanque", Vector2(3780, -80), 0.6],
			["camera_corpo", Vector2(4650, 220), 0.7, true, "teto", 0.8],
			["alerta", Vector2(4115, 800), 0.7, false, "chao", 0.9],
			["alerta", Vector2(4275, 800), 0.7, false, "chao", 0.9],
			["alerta", Vector2(3765, 800), 0.7, false, "chao", 0.9],
		],
		"signs": [
			[Vector2(230, 800), "A / D para mover  ·  ESPAÇO para pular (segure para ir mais alto)  ·  SHIFT para esquivar"],
			[Vector2(520, 800), "Clique esquerdo (ou J) dispara o Estabilizador de Fase — a arma mira no cursor do mouse. Caixas quebram; barris EXPLODEM."],
			[Vector2(1410, 800), "Acertar inimigos carrega a ENERGIA DE FASE (clique direito = tiro carregado). Plataformas podem ser atravessadas por baixo; S + ESPAÇO desce delas."],
			[Vector2(2080, 800), "IRIS: \"O Terminal A está no alto desta sala. A alavanca no beiral religa o elevador.\""],
			[Vector2(2830, 800), "IRIS: \"Lasers alternados e uma câmera de segurança. Se ela te enxergar, o alarme solta Rastejadores.\""],
			[Vector2(3545, 800), "IRIS: \"Um campo de força protege o Terminal B. A trava precisa de 1/3 da sua Energia de Fase.\""],
			[Vector2(4880, 690), "IRIS: \"O portal está instável... calibre-o no painel.\""],
		],
		"checkpoints": [Vector2(1450, 800), Vector2(2790, 800), Vector2(4300, 800)],
		"benches": [Vector2(645, 800)],
		# salas do mapa: [id, retângulo, nome]
		"rooms": [
			["A", Rect2(-200, 220, 1200, 580), "Despertar"],
			["B", Rect2(1000, 220, 320, 820), "Fosso"],
			["C", Rect2(1320, 220, 660, 580), "Turreta"],
			["D", Rect2(1980, -260, 740, 1060), "Sala Alta"],
			["E", Rect2(2720, 220, 1020, 580), "Lasers"],
			["F", Rect2(3740, 220, 400, 580), "Campo"],
			["G", Rect2(4140, 220, 910, 580), "Saída"],
			["S", Rect2(2720, -260, 1100, 200), "Ala Secreta"],
		],
		"terminals": [["A", Vector2(2625, 120)], ["B", Vector2(4075, 580)]],
		"door": {"rect": Rect2(4140, 600, 110, 200), "needs": ["A", "B"]},
		"portal": {"pos": Vector2(4960, 690), "target": "verdamia"},
	}


static func _verdamia() -> Dictionary:
	return {
		"name": "VERDÂMIA",
		"sub": "Universo 1 — A Floresta Bioluminescente",
		"theme": "verd",
		"form": "lince",
		"spawn": Vector2(80, 790),
		"bounds": Rect2(-200, -100, 5120, 1250),
		"kill_y": 1300.0,
		"solids": [
			Rect2(-260, -600, 60, 2000),
			Rect2(-260, 800, 1060, 600),     # chão 1
			Rect2(800, 1040, 300, 360),      # fundo do fosso de espinhos
			Rect2(1100, 800, 620, 600),      # chão 2
			Rect2(1560, 250, 50, 430),       # pilar (lado esquerdo do poço de escalada)
			Rect2(1720, 300, 140, 1100),     # paredão
			Rect2(1860, 800, 600, 600),      # vale de espinhos
			Rect2(1960, 360, 180, 24),
			Rect2(2230, 420, 160, 24),
			Rect2(2460, 800, 2460, 600),     # chão 3 + arena
			Rect2(4000, 640, 150, 24),       # plataformas da arena
			Rect2(4260, 560, 150, 24),
			Rect2(4920, -600, 60, 2000),
		],
		"hazards": [
			Rect2(800, 1004, 300, 36),
			Rect2(1860, 768, 600, 32),
		],
		"enemies": [
			["moth", Vector2(1300, 600)],
			["spore", Vector2(1430, 800)],
			["moth", Vector2(2060, 240)],
			["moth", Vector2(2750, 600)],
			["spore", Vector2(2950, 800)],
			["moth", Vector2(3250, 560)],
			["spore", Vector2(3480, 800)],
		],
		"pickups": [
			["cell", Vector2(950, 690), "v_c1"],
			["cell", Vector2(1665, 420), "v_c2"],
			["cell", Vector2(2050, 300), "v_c3"],
			["heal", Vector2(2310, 370), "v_h1"],
			["heal", Vector2(3760, 760), "v_h2"],
			["registro", Vector2(420, 776), "log_06"],
			["registro", Vector2(2680, 776), "log_07"],
			["registro", Vector2(3600, 776), "log_08"],
		],
		"signs": [
			[Vector2(200, 800), "NOVA FORMA — LINCE-VAGALUME.  Aperte ESPAÇO de novo no ar para dar um PULO DUPLO."],
			[Vector2(520, 800), "Clique esquerdo (ou J): garras.  No ar, segure S + ataque para golpear para baixo e QUICAR em inimigos e espinhos."],
			[Vector2(1230, 800), "Segure na direção da parede para deslizar. ESPAÇO encostado na parede = SALTO DE PAREDE. Suba pelo poço!"],
			[Vector2(2600, 800), "Clique direito (ou K) com 1/3 de energia: CLARÃO — fere e atordoa tudo ao redor."],
			[Vector2(3700, 800), "IRIS: \"O sinal do Fragmento está logo à frente... e algo enorme está enraizado em volta dele.\""],
		],
		"checkpoints": [Vector2(2570, 800)],
		"rooms": [
			["A", Rect2(-200, 100, 1000, 700), "Clareira"],
			["B", Rect2(800, 100, 300, 940), "Espinhos"],
			["C", Rect2(1100, 100, 620, 700), "Bosque"],
			["E", Rect2(1720, 100, 740, 700), "Paredão e Vale"],
			["F", Rect2(2460, 100, 1376, 700), "Trilha"],
			["G", Rect2(3836, 100, 1084, 700), "Templo"],
		],
		"terminals": [],
		"boss": {"pos": Vector2(4730, 800), "trigger_x": 3960.0, "gate": Rect2(3836, 300, 50, 500), "fragment": Vector2(4330, 768)},
	}
