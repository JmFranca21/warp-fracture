"""Gera colaboracao/pedidos/GL_lote2_producao.md: os pedidos de produção de Nivária (lotes 2 e 3).

uso: python tools/gen_pedidos_nivaria_lote2.py

Cada peça sai como um prompt completo no padrão de troca com o ChatGPT (bloco ````markdown):
ID, arquivos, finalidade, ficha v2 de referência, escala, orientação, âncora ou pivô, estados e
quadros, dimensões e grade, fundo, conferência e entrega. As medidas vêm das fichas aprovadas e do
que o jogo já usa (tools/test_nivaria.gd, scripts/nivaria.gd, nv_enemy.gd, guardiao.gd).
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "colaboracao/pedidos/GL_lote2_producao.md"

INTRO = ("Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), "
         "a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`, na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. "
         "Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, "
         "com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).")
REGUA = ("Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. "
         "Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. "
         "2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. "
         "Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.")
COMMON_OK = ("cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; "
             "a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.")


def prompt(p: dict) -> str:
    lines = [
        f"**[{p['id']}] {p['titulo']}**", "", INTRO, "", REGUA, "",
        f"- **ID:** {p['id']}",
        f"- **Arquivo(s):** {p['arquivos']}",
        f"- **Finalidade no jogo:** {p['finalidade']}",
        f"- **Ficha v2 de referência:** {p['ref']}",
        f"- **Escala:** {p['escala']}",
        f"- **Orientação:** {p['orientacao']}",
        f"- **Âncora e pivô:** {p['ancora']}",
        f"- **Estados e quadros:** {p['estados']}",
        f"- **Dimensões e grade:** {p['grade']}",
        "- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto." if not p.get("fundo") else f"- **Fundo:** {p['fundo']}",
        f"- **Antes de apresentar, confira:** {p.get('confira', '')} {COMMON_OK}".strip(),
        (f"- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/{p['id']}/` "
         f"com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, "
         f"confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha {p['id']} do `colaboracao/STATUS.md` "
         f"para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`."),
    ]
    return f"## {p['id']}: {p['titulo']}\n\n" + (f"> {p['nota']}\n\n" if p.get("nota") else "") + "````markdown\n" + "\n".join(lines) + "\n````\n"


GRADE_DAYMON = ("**igual às folhas usadas hoje no jogo** (ver `arte_original/USADAS_NO_JOGO.md`): idle, run, jump, fall e dash de `arte_original/01_Daymon_sem_braco/` "
                "(`idle_v1_fundo_escuro.png`, `run_v2_verde.png`, `jump_v1.png`, `fall_v1.png`, `dash.png`) e hurt e death de `arte_original/02_Daymon_com_bracos/` "
                "(`hurt_v1.png`, `death_v1.png`): mesma tela, mesma grade e mesma posição do corpo em cada célula, **sem o braço da frente**. "
                "O jogo troca a textura sem mexer no rig (offset −18,33/−71,50 px, escala 0,3 da textura).")

PECAS = [
    # ------------------------------------------------ Daymon de inverno (GL01 v2)
    dict(id="GL10", titulo="Daymon de inverno: folhas do corpo (7 animações)",
         arquivos="`GL10_idle.png`, `GL10_run.png`, `GL10_jump.png`, `GL10_fall.png`, `GL10_dash.png`, `GL10_hurt.png`, `GL10_death.png`",
         finalidade="substitui o corpo do laboratório usado hoje como placeholder em Nivária (forma `inverno`). O braço armado e o cachecol são peças separadas (GL11 e GL12) e **não** entram nestas folhas.",
         ref="`colaboracao/entregas/GL01/GL01_ficha_daymon_inverno_v2.png` (parca, capuz baixo, luvas, botas com cravos, faixa ciano) e as folhas atuais do Daymon listadas em `arte_original/USADAS_NO_JOGO.md` (movimento e registro).",
         escala="D = 400 px, exatamente a altura do Daymon da ficha oficial; a parca soma no máximo ~15% de largura por lado.",
         orientacao="de perfil, olhando para a **direita** (o jogo espelha).",
         ancora="centro da base entre os pés, no mesmo ponto de cada célula das folhas atuais; o ombro do braço armado no mesmo lugar das folhas atuais (o braço é montado ali).",
         estados="idle 6 quadros (loop) · run 8 (loop) · jump 3 · fall 3 (loop) · dash 4 · hurt 2 · death 6 — as mesmas quantidades e o mesmo ritmo das folhas atuais.",
         grade=GRADE_DAYMON,
         confira="sobreponha cada quadro ao quadro correspondente da folha atual: pés, quadril e ombro no mesmo lugar; o rosto idêntico ao da ficha oficial;"),
    dict(id="GL11", titulo="Daymon de inverno: braço armado com manga e luva",
         arquivos="`GL11_braco_inverno.png` (repouso) e `GL11_braco_inverno_disparo.png` (recuo do disparo)",
         finalidade="o braço que gira para mirar em Nivária; o Estabilizador de Fase é o mesmo, só a manga da parca e a luva térmica mudam.",
         ref="GL01 v2 (bloco “braço armado / perfil direito”) e `arte_original/03_Arma/braco_arma_v2.png` (formato e pivô).",
         escala="a mesma de `braco_arma_v2.png` (o jogo usa 0,35 da textura).",
         orientacao="apontando para a **direita**, na horizontal.",
         ancora="pivô no ombro, no mesmo ponto de `braco_arma_v2.png` (offset 62,50/0,20 px no jogo); a boca do cano na mesma posição.",
         estados="repouso (1) e disparo (1, recuo de ~6 px).",
         grade="mesma tela e mesma posição de `braco_arma_v2.png`."),
    dict(id="GL12", titulo="Daymon de inverno: cachecol em peças",
         arquivos="`GL12_cachecol_no.png`, `GL12_cachecol_seg1.png`, `GL12_cachecol_seg2.png`, `GL12_cachecol_ponta.png`",
         finalidade="o cachecol é simulado por código (5 pontos, segmentos de ~9,5 px no jogo) a partir da cruz “saída do cachecol”; cada peça é girada no ponto de articulação.",
         ref="GL01 v2, bloco “cachecol / articulações” (nó + 3 segmentos, laranja `#EF9655` com faixas `#B67A51`).",
         escala="D = 400 px: cada segmento com ~42 px de comprimento e ~24 px de largura; o nó com ~30 × 26 px.",
         orientacao="segmentos na horizontal, a ponta presa à **esquerda** e a extremidade livre à direita.",
         ancora="cruz de articulação na extremidade presa de cada segmento; o nó com a cruz no ponto onde sai do pescoço.",
         estados="uma imagem por peça; a ponta com as franjas de tricô.",
         grade="cada peça em PNG próprio, recortado justo com 4 px de margem."),
    dict(id="GL13", titulo="Geada e bloco de gelo",
         arquivos="`GL13_geada_1.png`, `GL13_geada_2.png`, `GL13_geada_3.png`, `GL13_bloco.png` (folha)",
         finalidade="as camadas de geada aparecem sobre o corpo a cada golpe de frio; com três, o Daymon fica preso no bloco por 1,5 s e o jogador quebra o gelo batendo.",
         ref="GL01 v2, bloco “acúmulo de geada” (01, 02, 03 e bloco) e GL04 v2 (gelo).",
         escala="D = 400 px; o bloco envolve o Daymon inteiro com ~1,15 D de altura (~460 px).",
         orientacao="de perfil, olhando para a direita.",
         ancora="centro da base entre os pés (o mesmo do corpo GL10).",
         estados="geada: 3 sobreposições transparentes (só os cristais de gelo, para pôr por cima do corpo em qualquer quadro: ombros, braços, joelhos e cachecol) · bloco: inteiro, rachado 1, rachado 2 e estilhaçando em 4 quadros (7 quadros).",
         grade="sobreposições em 512 × 512 px; bloco em grade de 4 × 2 células de 512 × 640 px."),
    dict(id="GL14", titulo="Pulso Térmico (efeito)",
         arquivos="`GL14_pulso_termico.png`",
         finalidade="anel de calor laranja que sai do traje (raio de 140 px no jogo, ~615 px na escala D) e derrete a geada, as placas de gelo e as placas do Guardião.",
         ref="GL01 v2, bloco “pulso térmico” (linhas laranja sob a parca e anel no chão).",
         escala="o anel cresce de 0,2 D a 1,55 D de raio (diâmetro final ~1.230 px na escala D).",
         orientacao="frontal, centrado no peito do Daymon.",
         ancora="centro da célula = centro do anel.",
         estados="8 quadros: brilho nas linhas do traje (2), anel saindo (4), anel se desfazendo (2). Laranja `#EF9655`, sem branco puro.",
         grade="4 × 2 células de 640 × 640 px (o jogo reduz)."),
    # ------------------------------------------------ inimigos (GL02 v2)
    dict(id="GL30", titulo="Gelinho: folha de animação",
         arquivos="`GL30_gelinho.png` e `GL30_sopro.png` (efeito)",
         finalidade="inimigo terrestre do Cume, da Caverna e da Encosta: patrulha, infla por 0,5 s (aviso) e solta um sopro de geada curto à frente (~100 px no jogo).",
         ref="`colaboracao/entregas/GL02/GL02_ficha_inimigos_nivaria_v2.png` (perfil, frontal, aviso e sopro).",
         escala="Gelinho com 229 × 240 px na escala D (0,6 D de altura; ~55 px no jogo), como na ENTREGA_v2 da GL02.",
         orientacao="perfil olhando para a **direita** (o jogo espelha); o foco vermelho voltado para onde ele sopra.",
         ancora="centro da base (apoio no chão); boca do sopro marcada no `ENTREGA.md` em pixels.",
         estados="patrulha 6 (loop) · aviso 4 (inflando) · sopro 6 · dano 2 · morte 6 (desfaz em neve) — 24 quadros; efeito do sopro: 6 quadros em cone de ~440 × 160 px (escala D).",
         grade="Gelinho: grade de 6 × 4 células de 320 × 320 px; sopro: 6 × 1 células de 480 × 200 px."),
    dict(id="GL31", titulo="Drone Gélido: folha de animação, esfera e gelo no chão",
         arquivos="`GL31_drone.png`, `GL31_esfera.png`, `GL31_gelo_chao.png`",
         finalidade="voador que patrulha, mira (foco aceso por 0,6 s) e solta uma esfera lenta de geada; onde ela cai fica uma mancha de gelo escorregadio por 3 s.",
         ref="GL02 v2 (perfil, frontal, mira acesa, esfera e gelo no chão).",
         escala="Drone com 460 × 189 px na escala D (~105 × 43 px no jogo); esfera com ~130 px; mancha com ~400 × 60 px.",
         orientacao="perfil olhando para a **direita**; a lente na frente.",
         ancora="Drone: centro do corpo; esfera: centro; mancha: centro da base (apoio no chão).",
         estados="Drone: voo 4 (loop, aletas) · mira 3 · disparo 3 · dano 1 · morte 6 (17 quadros). Esfera: 4 (girando). Mancha: formar 4 · derreter 4.",
         grade="Drone: 6 × 3 células de 512 × 256 px; esfera: 4 × 1 de 160 × 160 px; mancha: 4 × 2 de 448 × 96 px."),
    dict(id="GL32", titulo="Morcego-de-Cristal: folha de animação",
         arquivos="`GL32_morcego.png`",
         finalidade="dorme pendurado no teto da Caverna parecendo uma estalactite (só um brilho vermelho o denuncia), se solta e dá um rasante em arco de ~1,1 s.",
         ref="GL02 v2 (repouso no teto, rasante em arco, frontal) e a estalactite da GL04 v2 (para o disfarce).",
         escala="envergadura de 352 px na escala D aberto (~80 px no jogo); pendurado com ~0,5 D de altura.",
         orientacao="rasante de perfil olhando para a **direita**; pendurado de cabeça para baixo.",
         ancora="pendurado: o ponto preso ao teto (topo da célula); em voo: centro do corpo.",
         estados="pendurado 4 (loop, respiração quase parada) · soltar 3 · rasante 6 (loop) · dano 1 · morte 6 — 20 quadros.",
         grade="5 × 4 células de 400 × 320 px."),
    # ------------------------------------------------ Guardião (GL03 v2) — lote 3
    dict(id="GL100", titulo="Guardião Glacial: poses de combate", nota="Lote 3. Pode ir junto com o lote 2 se o João preferir.",
         arquivos="`GL100_guardiao_frontal.png`, `GL100_aviso.png`, `GL100_investida.png`, `GL100_atordoado.png`, `GL100_estacas.png`, `GL100_onda.png`, `GL100_derrota.png`",
         finalidade="o chefe de Nivária (D08). Hoje o jogo usa a frontal e as seis poses pequenas da ficha, ampliadas; estas folhas substituem tudo na escala certa.",
         ref="`colaboracao/entregas/GL03/GL03_ficha_guardiao_v2.png` e `GL03_esquema_arena_v2.png`.",
         escala="3,0 D = 1.200 px de altura de pé (273 px no jogo). Todas as poses na **mesma escala** da frontal (as poses curvadas ficam mais baixas, não menores).",
         orientacao="frontal para idle, aviso, atordoado e derrota; perfil olhando para a **esquerda** na investida, nas estacas e na onda (o jogo espelha).",
         ancora="centro da base entre os pés, no mesmo ponto de todas as células; o centro do peito marcado (as placas GL101 são montadas ali, a −0,57 D da base no jogo).",
         estados="frontal 4 (respiração, loop) · aviso 4 (bate os pés, 0,6 s) · investida 6 (loop de corrida curvado) · atordoado 4 (loop, cabeça baixa, estilhaços) · estacas 6 (crava o punho) · onda 6 (sopro rente ao chão) · derrota 8 (racha e desaba em neve, sobra o fragmento flutuando).",
         grade="uma folha por pose, células de 1.280 × 1.280 px, 4 colunas.",
         confira="o peito sem placas desenhadas (as placas são a GL101); olhos vermelhos com 4–10% da silhueta; o perfil legível;"),
    dict(id="GL101", titulo="Guardião Glacial: placas do peito e núcleo",
         arquivos="`GL101_placa_1.png`, `GL101_placa_2.png`, `GL101_placa_3.png`, `GL101_nucleo.png`, `GL101_derreter.png`",
         finalidade="as três placas de gelo que cobrem o fragmento; o Pulso Térmico no atordoamento derrete uma e o núcleo fica exposto por 3 s (4 tiros).",
         ref="GL03 v2, bloco “blindagem do peito” (3, 2, 1 placas e exposto).",
         escala="o conjunto das três placas com ~0,55 D de largura (~220 px na escala D; ~123 px no jogo).",
         orientacao="frontal.",
         ancora="todas as peças com o mesmo centro (o centro do peito marcado na GL100).",
         estados="cada placa sozinha (3 imagens, empilháveis) · núcleo exposto: 4 quadros (pulsa, o fragmento com brilho frio) · derretendo: 6 quadros (uma placa vira água e vapor laranja do calor).",
         grade="placas e núcleo em 320 × 320 px; derreter em 6 × 1 células de 320 × 320 px."),
    dict(id="GL102", titulo="Guardião Glacial: efeitos da luta",
         arquivos="`GL102_estaca.png`, `GL102_onda.png`, `GL102_impacto.png`",
         finalidade="Estacas de Gelo (rachadura vermelha de aviso por 0,45 s, depois sobem por 0,5 s), Onda de Gelo (sopro rente ao chão, ~60 px de altura no jogo, congela na hora) e o impacto da Investida na parede.",
         ref="GL03 v2 (poses de estacas e onda), GL04 v2 (estaca de gelo do chefe) e `GL03_esquema_arena_v2.png` (alturas).",
         escala="estaca com ~110 px no jogo (~480 px na escala D) e 70 px de base; onda com ~260 px de altura e ~300 px de largura na escala D; impacto com ~1,2 D.",
         orientacao="estaca de frente; onda andando para a **esquerda** (o jogo espelha); impacto com a parede à esquerda.",
         ancora="estaca e onda: centro da base (chão); impacto: ponto de contato com a parede.",
         estados="estaca: rachadura 2 (piscando) · subindo 3 · parada 1 · afundando 2 (8) · onda: 6 (loop) · impacto: 6.",
         grade="estaca 8 × 1 células de 320 × 520 px; onda 6 × 1 de 360 × 300 px; impacto 6 × 1 de 560 × 560 px."),
    # ------------------------------------------------ cenário (GL00 + GL04 v2)
    dict(id="GL50", titulo="Fundos em parallax: céu, picos e colinas",
         arquivos="`GL50_ceu.png`, `GL50_picos.png`, `GL50_colinas.png`",
         finalidade="substituem o fundo desenhado por código (céu em degradê, aurora rosa, lua, estrelas e duas cordilheiras). Profundidades no jogo: 0,02, 0,12 e 0,30.",
         ref="`colaboracao/entregas/GL00/GL00_prancha_nivaria.png` (faixa do Cume Congelado e paleta).",
         escala="o Daymon (91 px) contra as cordilheiras como na faixa da GL00; luma média de cada camada ≤ 0,20 (R6).",
         orientacao="paisagem lateral.",
         ancora="as três imagens repetem na horizontal sem emenda; a base das cordilheiras é reta para encaixar uma camada na outra.",
         estados="1 imagem por camada; a aurora pode vir em camada própria (`GL50_aurora.png`) para ondular por código.",
         grade="céu 2.048 × 1.024 px; picos 2.048 × 768 px; colinas 2.048 × 512 px, todas repetíveis na horizontal.",
         fundo="o céu opaco; picos e colinas com transparência acima do recorte."),
    dict(id="GL51", titulo="Fundos da Caverna de Cristal e da Arena",
         arquivos="`GL51_caverna.png`, `GL51_arena.png`",
         finalidade="paredes de fundo das zonas fechadas: Caverna (320 px de altura jogável, x 2.400–4.700) e Arena do Guardião (1.400 × 520 px).",
         ref="GL00 (faixas da Caverna de Cristal e da Arena do Guardião) e `GL03_esquema_arena_v2.png`.",
         escala="caverna em tile de 1.024 × 320 px **na escala do jogo**; arena em 1.400 × 520 px na escala do jogo (entregue a 2×: 2.800 × 1.040 px).",
         orientacao="lateral.",
         ancora="caverna repetível na horizontal; arena com o chão no pé da imagem e as paredes laterais dentro dela.",
         estados="1 imagem cada; cristais lavanda e brilho frio sem competir com as figuras (luma média ≤ 0,20).",
         grade="caverna 2.048 × 640 px (2×), repetível; arena 2.800 × 1.040 px.",
         fundo="opaco."),
    dict(id="GL52", titulo="Terreno de Nivária em tiles",
         arquivos="`GL52_chao_neve.png`, `GL52_rocha.png`, `GL52_teto.png`, `GL52_rampa.png`, `GL52_laje.png`",
         finalidade="substitui o terreno desenhado por código: chão com topo de neve, corpo de rocha, teto da caverna com pingentes, a rampa da Encosta (sobe 400 px em 2.050 px, ~11°) e as lajes (520 × 30 px, 120 × 22 px).",
         ref="GL00 v2 (superfícies de apoio: neve, gelo suspenso, pedra, parede) e a paleta de materiais.",
         escala="na escala do jogo, entregue a 2×: topo de neve com ~18 px de espessura no jogo (só nas superfícies jogáveis), rocha da GL00.",
         orientacao="lateral.",
         ancora="chão e rampa: a linha do topo da neve no alto do tile; teto: a borda de baixo do tile é a borda do teto.",
         estados="chão de neve (topo + face) repetível na horizontal; rocha repetível nos dois eixos; teto com pingentes repetível na horizontal; rampa em tile inclinado repetível ao longo da diagonal; laje com as duas pontas.",
         grade="tiles de 512 × 256 px (chão, teto), 512 × 512 px (rocha), 1.024 × 256 px (rampa), 1.040 × 120 px (laje).",
         confira="a costura dos tiles não aparece a 91 px de Daymon;"),
    # ------------------------------------------------ objetos (GL04 v2)
    dict(id="GL70", titulo="Objetos de Nivária animados (perigos)",
         arquivos="`GL70_gelo_fino.png`, `GL70_estalactite.png`, `GL70_cristais.png`, `GL70_nevoa.png`, `GL70_espinhos.png`",
         finalidade="perigos da fase, hoje recortados da GL04: gelo fino (100–110 px de largura no jogo), estalactite (64 px), cristais ressonantes em par chão/teto com arco vertical de 320 px, névoa da fratura no fundo dos poços e espinhos de gelo.",
         ref="`colaboracao/entregas/GL04/GL04_prancha_objetos_v2.png`.",
         escala="D = 400 px (o jogo reduz a 0,2275).",
         orientacao="lateral; cristal de teto é o de chão de cabeça para baixo (pode ser a mesma peça).",
         ancora="gelo fino: topo da placa; estalactite: ponto preso ao teto; cristais: base; névoa: linha de cima; espinhos: base.",
         estados="gelo fino: íntegro, trincas, crítico, rompido + 4 quadros de queda dos cacos · estalactite: parada, tremendo 3, caindo 1, quebrando 4 · cristais: apagado, aviso 2, ativo 2 + arco vertical 6 quadros (loop) · névoa: 8 quadros em loop repetível na horizontal · espinhos: 1 tile repetível.",
         grade="uma folha por objeto, células de 512 × 512 px (névoa 512 × 256 px), 4 colunas."),
    dict(id="GL71", titulo="Objetos de Nivária animados (interação e coletáveis)",
         arquivos="`GL71_braseiro.png`, `GL71_placa_gelo.png`, `GL71_bolas.png`, `GL71_gancho.png`, `GL71_plataformas.png`, `GL71_coletaveis.png`, `GL71_marco.png`",
         finalidade="braseiro (checkpoint de Nivária), placa de gelo que derrete com o Pulso (**alta e estreita**: 70 × 120 px no jogo), bolas de neve (0,5 D e 1,2 D de diâmetro), gancho de teto com suporte e corrente + gancho de rocha solta (Encosta), elevador, plataforma móvel, bloco flutuante, célula/núcleo/registro e o marco de madeira das dicas.",
         ref="GL04 v2 (todas as famílias) e GL00 (madeira e metal das estações).",
         escala="D = 400 px. Bola pequena 200 px e grande 480 px de diâmetro; braseiro 0,57 D de altura aceso; gancho com o aro de ~0,28 D.",
         orientacao="lateral.",
         ancora="peças de chão pela base; gancho pelo centro do aro (é o ponto que o Arpão puxa) e pelo ponto de fixação no teto; bolas pelo centro (giram por código).",
         estados="braseiro: apagado, acendendo 4, aceso 6 (loop) · placa: inteira + derretendo 6 · bolas: inteira, trincando 2, explodindo 6 (cada tamanho) · gancho: aceso/apagado · elevador, plataforma e bloco: 1 cada · célula 6, núcleo 6 e registro 4 (loop, brilho) · marco: 1.",
         grade="uma folha por família, células de 512 × 512 px, 4 colunas."),
    # ------------------------------------------------ interface
    dict(id="GL90", titulo="Glifo de Nivária no Arco e ícone de Geada",
         arquivos="`GL90_glifo.png` e `GL90_geada_hud.png`",
         finalidade="a folha PT13 só tem os glifos do Laboratório, de Verdâmia e do Deserto: o glifo de Nivária (hoje um floco desenhado por código) aparece no painel do Arco e na escolha de destino. O ícone de Geada fica no HUD, ao lado da Integridade.",
         ref="`colaboracao/entregas/PT13/` (estilo dos glifos) e GL01 v2 (geada).",
         escala="glifo na célula de 192 × 256 px da PT13, do mesmo tamanho dos outros; ícone de geada com 48 × 48 px.",
         orientacao="frontal.",
         ancora="centro da célula.",
         estados="glifo apagado (cinza-azulado) e aceso (rosa `#FF8FD0`) · geada: 0, 1, 2 e 3 camadas e congelado (5).",
         grade="glifo em 384 × 256 px (2 células lado a lado: apagado, aceso); geada em 5 × 1 células de 64 × 64 px."),
]


def main() -> None:
    head = """# Pedido GL (lotes 2 e 3): produção de Nivária

**Lote 2: folhas de produção** (e lote 3 do Guardião). Fase 3, Nivária ([proposta](../../docs/fases/nivaria/proposta_fase3.md)).
**Estado:** ABERTO. As fichas GL01–GL04 v2 estão aprovadas e publicadas na `main` (commit `22828aa`).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 24/11/2026
**Diretrizes obrigatórias:** DA-01 e DA-02. As fichas v2 decidem desenho, cor e acabamento; estes pedidos só fixam o que o jogo precisa (escala, apoio, pivô, quadros, grade).

A fase já roda inteira com **placeholders**: recortes das fichas v2 (`tools/import_nivaria.py`), o corpo do Daymon do laboratório com o cachecol desenhado por código, e terreno e fundos desenhados por código com a paleta da GL00. Cada pedido abaixo substitui um desses placeholders. Ordem sugerida: **GL10 → GL11 → GL12 → GL13 → GL30 → GL31 → GL32 → GL70 → GL71 → GL52 → GL50 → GL51 → GL14 → GL90 → GL100 → GL101 → GL102**.

Cada bloco é um prompt completo. Copie **um por vez** e mande o seguinte só depois de aprovar o anterior.

| ID | Peça | Substitui no jogo |
|---|---|---|
"""
    rows = {
        "GL10": "corpo do laboratório em Nivária", "GL11": "braço do laboratório", "GL12": "cachecol desenhado por código",
        "GL13": "tinta azul na geada e recorte do bloco da GL01", "GL14": "anel desenhado por código", "GL30": "recortes estáticos da GL02",
        "GL31": "recortes estáticos da GL02", "GL32": "recortes estáticos da GL02", "GL100": "frontal e poses pequenas ampliadas da GL03",
        "GL101": "recortes da blindagem da GL03", "GL102": "estaca da GL04 e onda desenhada por código", "GL50": "céu e cordilheiras por código",
        "GL51": "retângulos escuros", "GL52": "terreno desenhado por código", "GL70": "recortes estáticos da GL04",
        "GL71": "recortes estáticos da GL04 e marco por código", "GL90": "floco desenhado por código e ícone de geada por código"}
    for p in PECAS:
        head += f"| {p['id']} | {p['titulo']} | {rows[p['id']]} |\n"
    head += "\n**Fora da arte (pendente):** música de Nivária (hoje toca a do menu) e efeitos sonoros próprios (sopro, congelar, quebrar o gelo, Pulso Térmico, bola de neve rolando, estalactite). O jogo usa efeitos existentes por enquanto.\n\n---\n\n"
    OUT.write_text(head + "\n---\n\n".join(prompt(p) for p in PECAS), encoding="utf-8")
    print(OUT, len(PECAS), "pedidos")


if __name__ == "__main__":
    main()
