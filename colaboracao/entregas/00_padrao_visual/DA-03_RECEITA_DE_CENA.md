# Warp Fracture — Receita de cena (DA-03)

**Status:** PROPOSTA (24/11/2026). O João aprovou o plano (receita primeiro, depois Nivária, depois o Deserto); os números aguardam a revisão do ChatGPT e a aprovação final dele. Vale junto com a [DA-01](PADRAO_VISUAL_OFICIAL.md) (estilo) e a [DA-02](DA-02_CONSISTENCIA.md) (personagens, inimigos e objetos).
**Por que existe:** o João avaliou que o Laboratório Hélix e Verdâmia têm o padrão e a qualidade que o jogo quer, e que o Deserto de Ferrugem e Nivária estão bem abaixo. A DA-02 resolveu a consistência das figuras, mas não a da **cena**: como fundo, chão, decoração, primeiro plano e luz se juntam numa tela. Esta régua mede as duas fases boas e transforma o que elas fazem em regra.
**Medição:** `tools/scene_metrics.gd` captura quatro pontos de cada fase (com tudo, sem primeiro plano e sem o jogador) e `tools/scene_metrics.py` calcula as medidas. Luma em sRGB (Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′), sem o canto do HUD.

## O que as fases boas fazem (medido em 24/11/2026)

| Medida | Laboratório | Verdâmia | Deserto | Nivária (v0.9) | Leitura |
| --- | --- | --- | --- | --- | --- |
| Luma média da tela | 0,090 | 0,167 | **0,263** | 0,158 | O Deserto é claro demais |
| Luma do terço de cima (fundo) | 0,092 | 0,138 | **0,285** | 0,124 | Fundo das boas: escuro |
| Contraste do jogador (luma do personagem − anel de 8 px em volta, do joelho para cima) | +0,07 a +0,12 | +0,12 a +0,13 | **+0,02 a +0,03** | +0,12 | No Deserto o personagem some |
| Densidade de bordas (estrutura e detalhe) | 0,051 | 0,092 | 0,075 | **0,038** | Nivária é a mais vazia |
| Área sem estrutura (blocos de 40 px lisos) | 0,54 | 0,18 | 0,33 | **0,69** | Nivária tem dois terços de tela vazia |
| Camadas de fundo em parallax | 3 | 2 (pintadas, cobrindo a tela) | 3 | 3 (código) | |
| Parede ou estrutura de fundo no plano do jogo | sim (colunas, janelas, canos) | sim (troncos, cogumelos gigantes) | painéis chapados | **não** | |
| Primeiro plano na frente do jogador | sim (entulho) | sim (vegetação) | **não** | **não** | |
| Luzes pontuais (brilhos) | 63 em 6.900 px | 8 + brilho próprio da arte | 2 | **0** | |
| Partículas de ambiente | 2 sistemas | 2 sistemas | **0** | **0** | |

**Nivária depois da composição provisória pela DA-03** (24/11/2026, peças desenhadas por código até o lote 2): luma 0,156; terço de cima 0,132; contraste do jogador +0,17; bordas 0,051; área lisa 0,50. Passa em C2 e C3, mas só a arte do lote 2 (GL50–GL59) leva a cena ao acabamento do Laboratório e de Verdâmia.

O que se vê nas capturas, além dos números:

- **Laboratório:** fundo azul-marinho quase preto, com estrutura (colunas, janelas, painéis, canos). Plataformas suspensas por cabos. Pontos de luz ciano e vermelhos marcam o que importa: estação, porta, alerta, perigo. O personagem é a coisa mais clara da tela.
- **Verdâmia:** a tela inteira é floresta. Árvores e cogumelos de 2 a 4 D fecham o fundo, cipós descem do alto e moldam a tela, e o chão tem borda viva (musgo, raízes, grama) e subsolo escuro. A cor dominante é um verde-azulado escuro e o lima aparece só nos detalhes.
- **Deserto:** céu e paredes claros e chapados, tudo laranja. As peças vêm em escalas que não conversam (engrenagem gigante, coluna bege clara) e o personagem fica no mesmo valor do fundo.
- **Nivária (v0.9):** céu vazio, chão em retângulos com uma faixa de neve, objetos soltos e fora de proporção, sem primeiro plano nem luz.

## As regras

### C1. Cinco camadas em toda tela
1. **Fundo distante** (parallax 0,02–0,15): céu e silhueta do lugar. Preenche toda a altura da tela; nunca termina em vazio.
2. **Fundo intermediário** (parallax 0,25–0,5): massas grandes do universo (cordilheiras, árvores, fábricas), mais escuras e menos saturadas que o plano do jogo.
3. **Estrutura de fundo no plano do jogo** (parallax 1): paredes, colunas, troncos e arcos atrás do jogador, que dão escala e ritmo. Em área aberta, uma silhueta de média distância cumpre esse papel.
4. **Plano do jogo:** terreno com borda decorada e subsolo, objetos e decoração.
5. **Primeiro plano** (parallax 1,0–1,2): silhuetas escuras na borda de baixo (vegetação, entulho, gelo), nunca escondendo perigos ou o personagem.

Mais as **luzes e partículas** por cima de tudo.

### C2. Valores
- Luma média da tela entre **0,08 e 0,18**; terço de cima até **0,15**.
- Contraste do personagem contra o entorno (do joelho para cima) de pelo menos **+0,07** de luma.
- A cor mais clara da tela é do personagem, da energia ou de um perigo; nunca do fundo.
- Fundos mais escuros e menos saturados que o plano do jogo; quanto mais longe, mais escuro e mais próximo da cor do céu.

### C3. Estrutura e detalhe
- Densidade de bordas entre **0,05 e 0,10**.
- Área sem estrutura até **0,55** (o Laboratório, com as paredes escuras e lisas entre colunas, é o limite; Verdâmia fica em 0,18).
- Toda tela tem uma **moldura**: algo descendo do alto (cipós, cabos, estalactites, correntes) ou subindo dos lados.

### C4. Escala da decoração em relação ao Daymon (D)
Cada tela tem as três faixas:
- **Pequena** (0,15–0,5 D): pedras, tufos, cristais, placas, cabos. **6 a 12 por tela.**
- **Média** (1–2 D): cogumelos, tanques, telescópios, máquinas, rochas. **2 a 4 por tela.**
- **Grande** (3–6 D, ou a altura da tela): árvores, colunas, torres, paredões. **1 a 2 por tela**, sempre atrás do plano do jogo.
- Nunca uma peça plana enorme no lugar de estrutura (os painéis chapados do Deserto). Peças da mesma família na mesma escala.

### C5. Terreno
- O topo do chão nunca é uma linha reta e lisa: tem borda própria do material (musgo, neve acumulada, rebites, raízes) que quebra a silhueta.
- O corpo do chão tem **subsolo** escuro com textura, mais escuro que o topo.
- Cantos e pontas de plataforma têm peça própria (canto esquerdo e direito).
- **Nada flutua sem motivo:** plataformas suspensas mostram o que as segura (cabos, raízes, correntes, suportes). Flutuar só vale para o que é mágico ou mecânico e diz isso visualmente.

### C6. Luz e ambiente
- **Luzes pontuais:** de 1 a 3 por tela, na cor de energia do universo ou de perigo, marcando o que importa (estação, porta, perigo, coletável).
- **Partículas:** dois sistemas de partículas de ambiente por fase (poeira, esporos, neve, faíscas), lentas e discretas.
- Um **brilho próprio** nos objetos de energia (cristais, telas, brasas) que ilumina o entorno.

### C7. Cor da cena
- **Uma cor escura dominante** por universo: Laboratório azul-marinho, Verdâmia verde-azulado, Deserto ferrugem **escura**, Nivária azul de noite.
- **Um acento de energia** só nos detalhes (ciano, lima, âmbar, rosa).
- O azul-marinho comum do jogo (`#0F1422` a `#253045`) nas sombras mais profundas de todas as fases.

### C8. Densidade de jogo
- Inimigos: cerca de **1,2 a 1,4 por 1.000 px**, como Verdâmia.
- Um elemento interativo ou de leitura (coletável, perigo, alavanca, registro) a cada **400–600 px**.

## Como cada entrega de cenário comprova a régua

Toda entrega de fundo, terreno ou conjunto de decoração vem com uma **prancha de cena** (`<ID>_cena.png`): uma tela de jogo de 1.280 × 720 montada com as peças novas, com o Daymon a ~91 px, ao lado de uma captura do Laboratório e uma de Verdâmia. O `ENTREGA.md` diz em que faixa de escala (C4) cada peça entra e quais camadas (C1) ela ocupa.

Do lado do desenvolvimento: antes de cada entrega de fase, `tools/scene_metrics.gd` e `tools/scene_metrics.py` rodam nos quatro pontos e os números entram no HANDOFF. Uma fase só sai se cumprir C2 e C3.
