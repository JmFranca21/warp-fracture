# Deserto de Ferrugem: pacote completo de arte v2 (uma só mão)

**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · **Data:** 25/11/2026
**Pedido do João Marcelo:** refazer **todos** os assets do Deserto de Ferrugem para que a fase pareça desenhada pelo mesmo artista do Laboratório Hélix e de Verdâmia ("como se fosse tudo feito por um único artista").
**Substitui, para efeito de produção:** o pedido [DF](DF_deserto_ferrugem.md) (v0.8), o lote do Autômato [DF87–DF99](DF87-DF99_automato.md), o lote da Forja [DF100–DF112](DF100-DF112_forja_mae.md) e os pedidos ainda abertos da [refação DA-03](DF_refacao_cena.md) (DF202–DF210, DF03 v2). Esses arquivos continuam valendo como histórico e como fonte das medidas.
**Diretrizes:** DA-01 (estilo), DA-02 (figuras), DA-03 (cena) e DA-04 (assinatura de estilo). Em conflito, vale a diretriz.

---

## Como usar este arquivo

1. **Abra uma conversa nova com o ChatGPT e cole primeiro o bloco [DF-BASE]** (seção 2). Ele é a "bíblia" do pacote; todos os outros prompts se referem a ele. Se mudar de conversa no meio do caminho, cole o DF-BASE de novo antes de continuar.
2. Mande os prompts **um por vez, na ordem das etapas** (seção 3). Só mande o próximo depois de aprovar o anterior.
3. Cada prompt já diz o que anexar. Os arquivos estão no repositório (`main` ou `dev/cenas`, como indicado).
4. O GPT apresenta a peça ao João; **o João aprova**; o GPT sobe na `main` com commit `[arte]`; o Claude integra na `dev/cenas` e devolve as capturas e medidas.
5. Nada aqui muda a jogabilidade: tamanhos, âncoras, grades e quadros são os que o jogo já usa (ou estão marcados como **NOVO**, quando o jogo vai passar a usar).

**Já aprovado e que fica como está:** DF00 v2 (prancha de valores), DF200 (céu). A DF205 (terreno) fica, com o retoque da borda pedido no DF205 v2.
**Fora deste pacote:** Daymon humano, Lince, portais e Receptáculo (PT10–PT23, comuns a todas as fases), HUD e menus.

---

## 1. Resumo das etapas e de todos os IDs

| Etapa | Prompt | Peças | Substitui no jogo |
|---|---|---|---|
| 0 | DF-BASE | bíblia do pacote (só texto) | — |
| 0 | DF-KEY | quadro-chave de estilo do Deserto + comparação (é o DA-04; pule se já foi aprovado) | — (referência) |
| 1 | DF02 v2 | ficha do Autômato | DF02 |
| 1 | DF01 v2 | ficha do Robô e do Drone | DF01 |
| 1 | DF03 v2 | ficha da Forja-Mãe e da Câmara | DF03 |
| 2 | DF201 v2 | fundo intermediário (2 camadas) na linguagem chapada | DF201 |
| 2 | DF205 v2 | retoque do terreno: borda de apoio em âmbar e faces limpas | DF205 (peças 1, 4–6, 9–10, 16–18) |
| 2 | DF202 | fundos internos: Fábrica e Salão do Núcleo | DF22, DF23, DF24 |
| 2 | DF203 | fundo da Câmara da Forja | DF24 na Câmara |
| 2 | DF204 | estrutura de fundo (10 peças grandes) | — (faltava) |
| 2 | DF206 | decoração média (10) e pequena (14) | DF30_1, DF30_2 e — (faltava) |
| 2 | DF207 | moldura: 8 peças que descem do alto | — (faltava) |
| 2 | DF208 | primeiro plano exterior e interior | — (faltava) |
| 2 | DF209 | efeitos de ambiente (poeira, faíscas, vapor, brilho) | DF86 e brilhos por código |
| 3 | DF220 | marcos do cenário: mastro, chaminé, porta da fábrica, engrenagem, abertura, torre do Núcleo | DF31–DF36 |
| 3 | DF221 | iluminação e enfeites de parede: lâmpada (2 estados), painel, canos, cabo | DF37, DF37b, DF39, DF39b, DF28 |
| 3 | DF222 | esteira e trilhos: esteira, pontas, trilho vertical, trilho horizontal | DF26, DF26b, DF26c, DF27, DF55b |
| 3 | DF223 | prensas grande e pequena (6 peças) e serra (2 peças) | DF50a–c, DF51a–c, DF52, DF52b |
| 3 | DF224 | plataformas móveis, válvula de vapor e ponto de gancho | DF54, DF55, DF56 (2 estados), DF57 |
| 3 | DF225 | portas da Câmara e da Saída (2 estados) | DF38 |
| 3 | DF210 | objetos do universo: estação, placa, célula, núcleo, registro | placa, estação e coletáveis do Laboratório |
| 4 | DF90–DF96 v2 | Autômato: 7 folhas do corpo | DF90–DF96 |
| 4 | DF97 v2 | braço-ímã | DF97 |
| 4 | DF87, DF88, DF98, DF99 v2 | rebite, clarão, feixe do ímã, pulso magnético | DF87, DF88, DF98, DF99 |
| 5 | DF60–DF65 v2 + DF64b | Robô: 6 folhas + paralisado (NOVO) | DF60–DF65 |
| 5 | DF66–DF69b v2 + DF69c | Drone: 5 folhas + derrubado (NOVO) | DF66–DF69b |
| 5 | DF70, DF71 v2 | projéteis do Robô e do Drone | DF70, DF71 |
| 6 | DF80–DF85 v2 | efeitos de máquina, areia, explosão e impacto | DF80–DF85 |
| 7 | DF100 v2 | Forja-Mãe: corpo | DF100 |
| 7 | DF101–DF108 v2 | lente, peito, carrinho, segmento, martelo, núcleo do pistão, escotilha, grade | DF101–DF108 |
| 7 | DF110–DF112 v2 | feixe, carga da lente, explosão de núcleo | DF110–DF112 |
| 8 | DF-UNIDADE | prancha final de conferência: todas as peças juntas na escala do jogo | — |

**Total:** 3 fichas, 1 quadro-chave, 2 refações de cenário já integrado, 8 peças de cena DA-03, 7 lotes de máquinas e objetos, 14 folhas do Autômato e efeitos, 14 folhas de inimigos e projéteis, 6 efeitos, 12 peças da Forja e 1 prancha final.

---

## 2. [DF-BASE] A bíblia do pacote

> Cole este bloco **primeiro**, sozinho. O GPT só responde "entendido" e o resumo das regras que vai seguir; nenhuma imagem ainda.

````markdown
**[DF-BASE] Bíblia do Deserto de Ferrugem v2: um só artista para o jogo inteiro**

Você é o diretor de arte do Warp Fracture, um metroidvania 2D de rolagem lateral feito no Godot. Vamos refazer **todos** os assets do Deserto de Ferrugem (Ferrumgrado), a Fase 2. O João Marcelo (autor do jogo) avaliou que o Deserto ainda não parece do mesmo jogo que o Laboratório Hélix e Verdâmia: "o jogo como um todo deve seguir um mesmo estilo de arte, como se fosse tudo feito por um único artista". Os próximos prompts pedem cada peça. Este bloco define as regras que valem para **todas** elas. Não gere imagem agora: responda só com "entendido" e um resumo, em tópicos, das regras que vai seguir.

## 1. O mundo

Ferrugrado é um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar, depois que todos foram embora. Máquinas que ainda batem, prensam, serram e acendem lâmpadas sozinhas. A fase, da esquerda para a direita:

| Zona | Coordenadas no jogo (px) | Clima |
|---|---|---|
| Dunas de sucata (exterior) | x 0–1.700, chão em y 700 | crepúsculo de tempestade de ferrugem: céu ferrugem escuro, sol baixo velado pela poeira |
| Fábrica autônoma (interior) | x 1.700–3.580, chão em y 700 | escuro, âmbar das lâmpadas e das fornalhas, esteira, prensas, serra |
| Salão do Núcleo (galeria alta) | x 3.580–6.990, passarelas em y 415, chão em y 770 | o mais escuro, torre do Núcleo, passarelas suspensas, elevador, válvulas de vapor |
| Câmara da Forja (arena do chefe) | x 7.050–8.490, teto em y 150, chão em y 770 | fornalha ao fundo, trilho dos braços no teto, a Forja-Mãe embutida na parede |
| Saída | x 8.550–8.900 | porta de saída |

O herói é Daymon Sagan. Neste universo, o Traje Âncora o transforma no **Autômato**, uma máquina magnetizada (ímã que mira e puxa, rebites como tiro, pulso magnético, arranque). Inimigos: o **Robô** sentinela (anda e atira na horizontal) e o **Drone** (voa e atira para baixo). Chefe: a **Forja-Mãe**, uma IA-fornalha embutida na parede, com dois braços-martelo num trilho de teto.

## 2. A linguagem gráfica comum (DA-04): o que faz o Laboratório e Verdâmia parecerem de um artista só

1. **Formas chapadas com sombreamento em degraus.** Cada material tem 2 ou 3 tons (luz, meio-tom, sombra) com fronteira nítida. Rochas e dunas facetadas em planos; metal em blocos com chanfro. **Sem textura pintada, ruído, hachura, granulado nem pincel aparente.**
2. **Sem traço de tinta no cenário.** O cenário se separa por valor e cor, nunca por linha preta ou marrom. Contorno escuro só nas figuras (personagens, inimigos, objetos de interação), sempre frio e parcial (seção 4).
3. **Detalhe que cresce do fundo para a frente.** Fundo distante: silhueta de 1–2 tons com névoa. Intermediário: 2 tons, poucos recortes. Plano do jogo: 3 tons, chanfros, rebites e detalhes. Nenhum fundo tem mais detalhe que o chão onde se pisa.
4. **Uma cor-assinatura por universo.** Laboratório = ciano; Verdâmia = verde-limão; **Deserto = âmbar incandescente `#EFAA55`** (com um tom mais quente e claro para o miolo das brasas, definido no quadro-chave). Ela aparece sempre nos mesmos lugares: **na borda de apoio do terreno** (crista da areia pegando a luz baixa; friso de metal aquecido na chapa), **nas luzes** (lâmpadas, fornalhas, fendas de calor, sempre com halo suave) e **nas máquinas ativas**. O resto da tela fica na família escura.
5. **Arestas limpas e cartum robusto.** Silhuetas legíveis em miniatura, cantos chanfrados ou arredondados, proporções levemente exageradas, curvas suaves; nada de borda serrilhada, rasgada ou "suja".
6. **Gradiente só na atmosfera.** Céu, névoa e halo de luz podem ter gradiente; as formas, não.
7. **Mesma resolução aparente.** Desenhe na escala pedida em cada prompt. Não pinte grande com detalhe fino para depois reduzir: o detalhe precisa sobreviver à escala do jogo (o Daymon tem ~91 px de altura na tela).

**Referências de estilo obrigatórias** (no repositório, branch `main`):
- `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` e `Folha de Inimigos do Laboratório Hélix.png` (objetos, máquinas e robôs do jogo);
- `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e acabamento de figura);
- `colaboracao/entregas/VD_verdamia/` (Verdâmia inteira: terreno, fundos, objetos, inimigos, efeitos);
- `colaboracao/entregas/DF00/DF00_prancha_deserto_v2.png` (valores e paleta do Deserto, aprovada);
- `colaboracao/entregas/DF200/` (céu aprovado);
- `docs/auditoria_cena/estilo_referencia_e_desvios.jpg` (branch `dev/cenas`: em cima, recortes 2× do Laboratório e de Verdâmia; embaixo, onde o Deserto antigo fugia);
- depois de aprovado, o **quadro-chave `DA04_quadro_chave_deserto.png`**: referência obrigatória de todas as peças seguintes.

**Não use como referência de estilo:** DF00 v1, DF01 v1, DF02 v1, DF03 v1, os fundos DF10–DF24 e as peças v0.8 (DF26–DF86, DF87–DF112). Elas servem só para entender **função, tamanho e encaixe**.

## 3. Paleta do Deserto

| Função | Cores |
|---|---|
| Areia de ferrugem (exterior) | `#3A2929`, `#59403A`, `#806050` |
| Chapa (pisos, paredes) | `#253045`, `#493736`, `#654947` |
| Viga e estrutura | `#1D2A3C`, `#3B3237`, `#615457` |
| Fornalha e escória | `#422D31`, `#754035`, `#B36341` |
| Céu e poeira | `#3A2929`, `#59403A`, `#493736`; topo em `#253045` a `#0F1422` |
| Sombra comum do jogo (todas as fases) | azul-marinho `#0F1422` a `#253045` |
| **Assinatura do Deserto** | **âmbar `#EFAA55`**: borda de apoio, luzes, máquinas ativas, energia do universo |
| Perigo (só onde fere) | vermelho `#E0303A` (brilho `#FF8A80`); faixas de aviso vermelho e cinza só na superfície que fere |
| Interação do jogador | ciano `#2EC7E6`: gancho, Traje Âncora, ímã, rebite. **Nunca** em inimigos nem no cenário |

Uma família escura dominante (ferrugem escura e azul-marinho), uma assinatura (âmbar), duas cores de função (vermelho = perigo, ciano = jogador). Nada de laranja claro ou bege em áreas grandes: isso era o Deserto antigo.

## 4. Régua das figuras (DA-02, aprovada)

Vale para o Autômato, o Robô, o Drone, a Forja e os objetos de interação.
- **Escala:** D = 400 px = altura do Daymon na ficha (no jogo, D ≈ 91 px). Inimigos terrestres 0,55–1,00 D; voadores com altura ≥ 0,55 D ou largura ≥ 0,70 D (corpo, sem hélice solta); chefes 2,5–3,5 D; objetos de interação 0,5–1,5 D.
- **Contorno:** traço escuro em no máximo **50% do perímetro externo**, cedendo à luz de recorte. Só as cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`; **nunca preto puro nem marrom-preto**, nem na ferrugem. Espessura mediana ≤ 4 px e P90 ≤ 6 px na escala D = 400. Objetos inertes podem fechar a borda com traço fino e frio.
- **Linhas internas:** uma junta pode ter linha; **rebite e placa não são fechados por linha escura**.
- **Tons:** 2–3 por material dominante, 1 nos detalhes; até 12 cores efetivas por figura. Volume por planos chapados; desgaste em manchas localizadas, sem textura espalhada.
- **Saturação:** média 0,20–0,55; acima de 0,80 só em energia e perigo, em até 10% da área.
- **Ponto de leitura dos inimigos:** uma região focal (olho, lente, núcleo) com 4–10% da silhueta, ≥ 0,20 de diferença de luma para o entorno, em vermelho de perigo, apontando a direção do ataque. Nunca laranja ou âmbar no foco do inimigo (é a cor do mundo).
- **Construção:** chapas em planos grandes; rebite só onde há união; poucos aros, chanfros e molduras repetidas; luz de recorte numa direção só em toda a cena.
- **A figura é o mais claro da sua vizinhança** e se separa do fundo em pelo menos 2/3 da borda (diferença de luma ≥ 0,10), com sombras frias.

## 5. Régua da cena (DA-03, aprovada)

- Luma média da tela 0,08–0,18; terço de cima ≤ 0,15 (Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′, sRGB).
- Cinco funções por zona: fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro; mais luzes e partículas.
- Decoração em três escalas: pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D.
- Terreno com linha de apoio legível, borda variada e subsolo distinto. Plataformas suspensas mostram o que as segura. 1–3 focos de luz por tela. Nada flutua sem apoio (exceto efeitos, projéteis e o que voa).

## 6. Formatos técnicos (o jogo recorta automaticamente: siga à risca)

- **A. Folha de animação de figura:** PNG 1536 × 1024, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512), quadros em ordem de leitura; células que sobram ficam **totalmente vazias**. Fundo transparente. Figuras olham para a **direita**. Mesma escala e mesma âncora em todos os quadros; margem mínima de 12 px na célula. Sem texto, grade, chão ou sombra projetada.
- **F. Folha de efeito:** o mesmo formato A, mas na escala **3 px do arquivo = 1 px do jogo**. Desenhe o efeito com a proporção da caixa do jogo indicada no prompt (o jogo passa a escalar sem distorcer).
- **B. Peça de cenário:** PNG transparente com a tela **exatamente** do tamanho pedido, na escala **2 px do arquivo = 1 px do jogo**. Apoio visível (base no chão, corrente ou suporte no teto, placa na parede).
- **C. Textura repetível:** na escala 2×, emendável na direção indicada (duas cópias lado a lado sem costura).
- **P. Camada de fundo:** dimensões e linhas de referência indicadas em cada prompt.
- **Peças animadas por código** (prensas, serra, engrenagem, esteira, plataformas, lâmpadas, portas): entregue as peças estáticas e os estados pedidos; o jogo anima o movimento.
- **Nomes:** os do prompt, com sufixo `_v2` quando a peça substitui uma antiga. Não apague as versões anteriores.

## 7. Conferência e entrega (vale para todos os prompts)

Antes de apresentar cada peça:
1. **Teste da mão única:** monte `<ID>_estilo.png` com um recorte 2× da peça ao lado de recortes 2× do Laboratório e de Verdâmia, e do quadro-chave. Se alguém consegue dizer qual veio de qual fase pelo jeito de desenhar, refaça.
2. **Teste de cena:** monte `<ID>_cena.png` (1.280 × 720): a peça no lugar dela, com o Autômato ou o Daymon a ~91 px, ao lado das capturas `docs/auditoria_cena/comparacao_cenas.png` do Laboratório e de Verdâmia, na mesma escala visual, sem esticar. A tela fica escura como as referências e o personagem é o mais claro.
3. **Figuras:** `<ID>_comparacao.png` (DA-02): a peça com Daymon a 400 px e uma referência aprovada do mesmo tipo; a mesma linha com Daymon a ~91 px sobre o fundo do Deserto.
4. Formato, tamanho, grade e âncora exatamente como no prompt.

Entrega:
1. Apresente ao João Marcelo (peças + montagens) e **só suba depois da aprovação explícita dele**.
2. Pasta `colaboracao/entregas/<ID>/` com um `ENTREGA_v2.md`: lista de peças e quadros; âncoras medidas em pixels; cores por material; tabela da DA-02 (figuras) ou medidas da DA-03 (cena); confirmação da aprovação; SHA-256 de cada PNG; o que não conseguiu cumprir.
3. Atualize a linha do ID no `colaboracao/STATUS.md` para `ENTREGUE (v2)`.
4. Commit `[arte]` na `main`. Não mexa em `scripts/`, `assets/` nem em outras branches.
````

---

## 3. Os prompts, etapa por etapa

### Etapa 0. Quadro-chave de estilo

#### [DF-KEY] Quadro-chave de estilo do Deserto

> É o pedido DA-04. **Se o quadro-chave já foi entregue e aprovado, pule.** Anexe `docs/auditoria_cena/estilo_referencia_e_desvios.jpg` e `docs/auditoria_cena/DF201_no_jogo.jpg` (branch `dev/cenas`).

````markdown
**[DF-KEY] Quadro-chave de estilo do Deserto de Ferrugem**

Siga o [DF-BASE]. Antes de qualquer peça, preciso de uma tela que prove a linguagem comum aplicada ao Deserto. Ela vira a referência obrigatória de todas as peças do pacote.

**Parte 1 (texto):** revise as sete regras da seção 2 do DF-BASE e a cor-assinatura âmbar: manter, ajustar ou retirar, com o porquê. Diga o que mais distingue o "artista" do Laboratório e de Verdâmia e não está escrito (forma e tamanho dos chanfros, espessura dos frisos, como a luz é pintada, densidade de detalhe por D, quantos tons por material). Defina o **tom do miolo das brasas** (hex) e o **halo das luzes** (raio e queda, em px do jogo).

**Parte 2 (imagens):**
- `DA04_quadro_chave_deserto.png`, 1.280 × 720: as Dunas de Sucata com a entrada da Fábrica à direita, no enquadramento da primeira linha de `DF201_no_jogo.jpg`. Camadas: céu DF200; duas camadas intermediárias em silhueta chapada; terreno de areia com a **borda de apoio em âmbar**; o Autômato (ou o Daymon) a ~91 px de altura, com os pés em y ≈ 541 da tela; uma lâmpada ou fornalha acesa; a parede da Fábrica com estrutura (vigas, janela alta âmbar).
- `DA04_quadro_chave_interior.png`, 1.280 × 720: um trecho da Fábrica (esteira, uma prensa, plataforma suspensa por tirantes, engrenagem escura ao fundo, lâmpada pendurada) na mesma linguagem.
- `DA04_quadro_chave_comparacao.png`: as duas telas ao lado de recortes do Laboratório e de Verdâmia na mesma escala visual.
- **Valores:** luma 0,08–0,18, terço de cima ≤ 0,15, personagem o mais claro.

**Entrega:** pasta `colaboracao/entregas/00_padrao_visual/DA04/`, com `ENTREGA.md` (Parte 1 e medidas DA-03 das duas telas). Linha DA-04 do `STATUS.md`. Regras de entrega do DF-BASE.
````

---

### Etapa 1. Fichas (referência de todas as figuras)

#### [DF02 v2] Ficha do Autômato

> Anexe a Ficha do Daymon, `VD_verdamia/D0_lince.png` e o quadro-chave aprovado.

````markdown
**[DF02 v2] Ficha de personagem: o Autômato (forma de Daymon no Deserto)**

Siga o [DF-BASE] e o quadro-chave aprovado. A DF02 v1 foi rejeitada (proporção de brinquedo, tronco em barril, contorno fechado preto-marrom, excesso de chapas e rebites): **não a use**.

**Conceito:** no Deserto, o Traje Âncora transforma Daymon numa **máquina magnetizada**, nativa daquele mundo de fábricas e sucata (DA-02, R2: a forma segue o universo, não o Daymon; o Lince é exemplo do princípio, não modelo). Silhueta livre (bípede, sobre rodas, de pernas articuladas...), mas sem cabeça enorme, barril e pés gigantes. Tem que se distinguir do Robô inimigo **em silhueta, a ~91 px e sem depender do rosto**.

**O que a forma faz no jogo (precisa estar visível na ficha):**
- **Ímã de Fase:** braço com eletroímã que **gira 360°** em volta de um pivô no ombro para mirar; dispara **rebites** (tiro) e um **feixe** que puxa drones e argolas de gancho.
- **Pulso Magnético:** onda em volta do corpo que derruba drones e paralisa robôs; marque de onde ela sai (peito ou núcleo).
- **Arranque:** investida curta e rápida no chão (rodinhas, esteiras ou propulsão nos pés).
- Anda mais devagar que o Daymon humano (passos pesados) e pula curto.

**Medidas que o jogo exige:**
- Altura entre 0,60 D e 1,10 D (240–440 px); informe a cota escolhida. A caixa de colisão no jogo é 30 × 62 px (o corpo deve caber razoavelmente nela).
- Pés numa linha de chão comum em todas as vistas. Cruz na base (âncora) e cruz no **pivô do ombro do ímã**.
- O braço-ímã é uma **peça separada** do corpo (o jogo o gira por cima). Mostre o corpo sem o braço e o braço sozinho, com o pivô e a ponta do ímã marcados.

**Cores:** dentro da paleta do DF-BASE. Corpo em ferro e cobre escurecidos, **ciano `#2EC7E6`** como cor do traje e do ímã (é a cor do jogador), sombras frias. **Sem âmbar e sem vermelho no visor ou nos olhos** (âmbar é o mundo, vermelho é o inimigo). O visor se distingue da lente dos inimigos mesmo em cinza.

- **Arquivo(s):** `DF02_ficha_automato_v2.png` (1536 × 1024, ficha com texto permitido, fundo azul-marinho escuro chapado) e `DF02_comparacao.png`.
- **Conteúdo da ficha:** (1) lateral olhando para a direita; (2) frontal; (3) 3/4; (4) o braço-ímã sozinho em repouso e ativo (garras abertas); (5) detalhe do ponto de onde sai o pulso; (6) paleta com hex por material e função; (7) faixa de escala com o Daymon em silhueta (400 px).
- **Comparação:** Daymon a 400 px, o Lince e o Robô da DF01 v1 (só para o teste de distinção); a mesma linha a ~91 px sobre o quadro-chave; uma linha só em silhueta.
- **Entrega:** `colaboracao/entregas/DF02/`, `ENTREGA_v2.md` com a tabela da DA-02 e as coordenadas do pivô do ombro e da ponta do ímã. Regras do DF-BASE.
````

#### [DF01 v2] Ficha do Robô e do Drone

> Mande **depois** da DF02 v2 aprovada. Anexe a Folha de Inimigos do Laboratório, `VD_verdamia/E0_inimigos.png`, a DF02 v2 e o quadro-chave.

````markdown
**[DF01 v2] Ficha de inimigos: Robô sentinela e Drone do Deserto**

Siga o [DF-BASE] e o quadro-chave aprovado. A DF01 v1 foi rejeitada (contorno preto-marrom, corpo do Robô some no fundo, Drone pequeno demais): **não a use**. Os dois são **primos de fábrica** do Rastejador, da Turreta e do Drone do Laboratório: mesma lógica de construção, outra matéria (ferrugem do Ferrugrado). Silhueta diferente do Autômato v2.

**Robô sentinela:** patrulha no chão e atira na horizontal, com **aviso de 0,5 s** antes de cada tiro; o Pulso Magnético o **paralisa por 2 s**.
- 0,80 D (320 px) de altura; corpo atarracado em planos grandes, duas pernas curtas e articuladas (ou esteiras), **canhão frontal** e **lente vermelha** que aponta para a frente.
- Ferrugem **mais clara e mais cinza** que a parede do Deserto (ex.: `#9A6A4E`, `#6E4A3E`), ferro frio nas juntas (`#4A5060`, `#2A2F40`), sombra fria `#3A3346`. O corpo inteiro se lê sobre a parede escura, não só a lente.

**Drone:** patrulha no alto e atira **para baixo**; o Pulso e o feixe do ímã o **derrubam** no chão.
- 0,60 D (240 px) de largura e ~0,50 D de altura sem as hélices. Corpo de chapa arredondado, hélices (laterais ou no topo), **lente vermelha embaixo**, **argola ou placa magnética no topo** (onde o ímã do Autômato puxa).

- **Arquivo(s):** `DF01_ficha_inimigos_deserto_v2.png` (1536 × 1024, texto permitido, fundo azul-marinho chapado) e `DF01_comparacao.png`.
- **Conteúdo:** Robô: (1) lateral; (2) frontal; (3) a lente nos estados normal, aviso (acesa forte) e apagada; (4) pose paralisada (faíscas contidas, lente piscando). Drone: (5) lateral; (6) frontal; (7) pose derrubado no chão, atordoado. (8) Paleta com hex. (9) Faixa de escala com Daymon (400 px), Robô e Drone.
- **Âncoras:** Robô com cruz entre os pés e na boca do canhão; Drone com cruz no centro do corpo, na lente de tiro e no ponto magnético.
- **Comparação:** Turreta do Laboratório ao lado do Robô, Drone do Laboratório ao lado do Drone novo, Daymon a 400 px; a mesma linha a ~91 px sobre o recorte de pior contraste (parede da Fábrica do quadro-chave).
- **Entrega:** `colaboracao/entregas/DF01/`, `ENTREGA_v2.md` com a tabela da DA-02 (inclusive área e tamanho do foco). Regras do DF-BASE.
````

#### [DF03 v2] Ficha da Forja-Mãe

> Anexe `colaboracao/entregas/DF03/` (v1, só para medidas), `colaboracao/entregas/GL03/GL03_ficha_guardiao_v2.png` (chefe aprovado de Nivária) e o quadro-chave.

````markdown
**[DF03 v2] Ficha da Forja-Mãe e esquema da Câmara**

Siga o [DF-BASE] e o quadro-chave aprovado. A Forja-Mãe é a IA da fábrica: uma **fornalha de ferro embutida na parede do fundo** da Câmara, com uma **lente-olho**, uma **câmara no peito** (três placas que o Pulso arranca, com o fragmento dentro), **duas escotilhas nos ombros** (soltam drones), uma **grade de fornalha** embaixo e **dois braços-martelo** pendurados em carrinhos que correm num **trilho de teto**. A v1 tinha contorno fechado preto-marrom (`#2C1C1B`), excesso de aros, rebites e chanfros e listras de aviso decorativas: **redesenhe na linguagem do quadro-chave**, mantendo as medidas e a função de cada peça (o jogo monta as peças por âncoras fixas, listadas abaixo).

**Medidas fixas (D = 400 px):**
- Corpo: 3,5 D × 3 D (1.400 × 1.200 px), base da fornalha apoiada no chão.
- Encaixes vazios no corpo (o jogo desenha as peças por cima): lente Ø 360 px; peito 420 × 360; escotilhas 240 × 160 (uma em cada ombro); grade 700 × 240.
- Lente Ø 340 px; peito 400 × 340; núcleo do pistão Ø 160 px.
- Martelo: bloco de 1,4 D × 0,6 D (560 × 240 px) com **face de baixo de esmagamento** (faixas vermelho e cinza só ali), **placa de âncora ciano** redonda em cima (o Autômato se prende nela com o ímã) e o **núcleo do pistão** na junta de cima.
- Braço: dois segmentos de viga articulados, 800 px entre pivôs, 0,35 D (140 px) de espessura; carrinho de 0,9 D (360 px) no trilho.

**Leitura:** corpo mais escuro que a lente e o núcleo; contorno frio e parcial; o âmbar da fornalha é a assinatura do mundo, o **vermelho** fica para os avisos de golpe (faixas do martelo, mira do feixe, luz das escotilhas) e o **ciano** só na placa de âncora.

- **Arquivo(s):** `DF03_ficha_forja_v2.png` (1536 × 1024, texto permitido) e `DF03_comparacao.png`.
- **Conteúdo:** (1) a Forja inteira montada, de frente, com os dois braços; (2) cada peça separada com as medidas acima; (3) os estados da lente (repouso âmbar, aviso âmbar forte, mira vermelha, apagada); (4) o peito fechado, aberto e danificado; (5) o martelo normal, em aviso, preso (âncora acesa) e quebrado; (6) esquema da Câmara (1.440 × 620 px de jogo; trilho no teto; portas de 60 × 190 px nas duas paredes); (7) paleta; (8) escala com Daymon e o Autômato v2.
- **Comparação:** a Forja com o Autômato a ~91 px sobre um esboço da Câmara, ao lado do Guardião Glacial (GL03 v2) e da Rainha Micélia na mesma escala.
- **Entrega:** `colaboracao/entregas/DF03/`, `ENTREGA_v2.md` com a tabela da DA-02. Regras do DF-BASE.
````

---

### Etapa 2. Cenário (camadas da DA-03)

#### [DF201 v2] Fundo intermediário na linguagem chapada

> A DF201 aprovada passa na régua de valor, mas é ilustração com traço e hachura (DA-04, regras 2, 3 e 7). Mesmas medidas: o código não muda. Anexe `docs/auditoria_cena/DF201_no_jogo.jpg` e a DF201 atual (`colaboracao/entregas/DF201/`).

````markdown
**[DF201 v2] Fundo intermediário das Dunas: redesenho na linguagem chapada**

Siga o [DF-BASE] e o quadro-chave aprovado. Redesenhe as duas camadas da DF201 **com as mesmas medidas, linhas e enquadramento**, trocando a linguagem: silhuetas chapadas em 2 tons, sem traço de tinta, sem hachura e sem detalhe vazado fino.

| | `DF201_distante_v2.png` | `DF201_proximo_v2.png` |
|---|---|---|
| Dimensões | 2.560 × 840 px | 2.560 × 840 px |
| Parallax no jogo | 0,20 | 0,38 |
| Conteúdo | horizonte: dunas distantes, a silhueta do complexo da fábrica e chaminés, em névoa | carcaças (escavadeira, robô gigante tombado, vagões), guindastes, torres de transmissão, dunas próximas |
| Repetição | nenhuma (a coluna 686 do arquivo fica no x 0 da camada) | repete na horizontal sem espelhar, período 2.560 px; **sem marco único** |
| Altura das silhuetas acima da base | 1–3 D (91–270 px); a fábrica pode chegar a 3 D | 2–3 D (180–270 px) |
| Linha de base | 490 (nas duas) | 490 |
| Nada acima da linha | 190 | 190 |
| Luma média das silhuetas | 0,10–0,13, desvio interno ≤ 0,03, 1–2 tons | 0,07–0,11, 2 tons, recorte nítido |

- **Escala:** 1 px do arquivo = 1 px do jogo; D = 91 px.
- **Fundo:** RGBA, transparente acima das silhuetas (borda suavizada de 1–2 px), opaco da linha 490 até a borda de baixo (dunas escurecendo até ~0,06).
- **Detalhe permitido:** na camada próxima, recortes grandes (vãos, vigas, cabos grossos) para dar estrutura, sem linhas finas; luz de borda **ferrugem** nas arestas viradas para o sol, pequena (≤ 0,20 de luma). No máximo uma lâmpada âmbar pequena a cada 1.280 px na camada próxima.
- **Profundidade:** a de trás tem menos contraste e saturação que a da frente; nenhuma é mais clara que a faixa do topo do terreno (0,20–0,25) nem que o Autômato.
- **Confira:** `DF201_v2_cena.png` com três painéis de 1.280 × 720 (Dunas normal, câmera no fundo do fosso, vão do Salão), com DF200 + DF201 v2 + DF205 e o Autômato a ~91 px; nas Dunas, luma 0,08–0,18, terço de cima ≤ 0,15, densidade de bordas ≥ 0,04, área lisa ≤ 0,60. A camada próxima emenda sem costura (colunas 0 e 2.559).
- **Entrega:** `colaboracao/entregas/DF201/`. Regras do DF-BASE.
````

#### [DF205 v2] Retoque do terreno: borda de apoio em âmbar

> Anexe a DF205 aprovada (`colaboracao/entregas/DF205/`), o gabarito `docs/auditoria_cena/DF205_gabarito_colisoes.png` e `docs/auditoria_cena/DF205_encaixes_no_jogo.jpg`.

````markdown
**[DF205 v2] Terreno do Deserto: borda de apoio na cor-assinatura e faces limpas**

Siga o [DF-BASE] e o quadro-chave aprovado. A DF205 está aprovada e integrada; o facetado está certo. Faltam duas coisas da DA-04: (1) a **borda de apoio na cor-assinatura**, como a luz ciano sob as plataformas do Laboratório e o musgo verde-limão de Verdâmia; (2) faces mais limpas, sem textura fina nem ruído.

**Retoque, não redesenho.** Mesmos arquivos, mesmas dimensões, mesmas linhas de apoio e de colisão, mesmos pontos de quina. O jogo troca os PNGs sem mudar nada.

| Peça | Arquivo (px) | O que muda |
|---|---|---|
| `areia_chao_v2.png` | 1.024 × 320; apoio em y 50 | crista da areia pegando a luz baixa: friso âmbar `#EFAA55` de 2–4 px do jogo (4–8 px do arquivo) logo abaixo do apoio, contínuo e com leve variação; a faixa de topo continua com luma 0,20–0,25 |
| `areia_canto_esquerdo_v2.png`, `areia_canto_direito_v2.png` | 180 × 260 | o friso âmbar dobra a quina e morre em 20–30 px na face lateral |
| `chapa_chao_v2.png` | 1.024 × 192; apoio em y 16 | friso de **metal aquecido** âmbar na aresta de cima da chapa, 2 px do jogo, mais forte perto das uniões; sem âmbar no corpo |
| `chapa_canto_esquerdo_v2.png`, `chapa_canto_direito_v2.png` | 180 × 260 | friso âmbar dobrando a quina |
| `passarela_ponta_esquerda_v2.png`, `passarela_meio_v2.png`, `passarela_ponta_direita_v2.png` | pontas 96 × 128; meio 256 × 128; apoio em y 8 | friso âmbar na aresta de cima do tabuleiro; treliça e chapa de junção iguais |
| todas as 22 peças | as mesmas | remova granulado, ruído e riscos finos; mantenha só planos chapados em 2–3 tons |

- **Regras do âmbar:** só na borda de apoio (nunca no subsolo, nas faces laterais além da quina ou no fundo do fosso); nenhuma área acima de 0,45 de luma maior que 8 × 8 px do jogo; o Autômato continua o mais claro da tela.
- **Confira:** remonte `DF205_encaixes_v2.png` (os sete recortes do gabarito, linha de colisão ciano por cima, apoio sobre a linha ±1 px) e `DF205_v2_cena.png` (Dunas, Fábrica, Salão e Câmara com o Autômato a ~91 px, ao lado do Laboratório e de Verdâmia). A linha de apoio deve "acender" onde se pisa, como nas referências.
- **Entrega:** `colaboracao/entregas/DF205/`, as 22 peças com sufixo `_v2` (as que não mudam além da limpeza também levam `_v2`). Regras do DF-BASE.
````

#### [DF202] Fundos internos: Fábrica e Salão do Núcleo

> Uma versão foi entregue e revertida na `main` (`728d459`, `8d86561`): não a reaproveite. Anexe o quadro-chave (interior) e capturas das paredes do Laboratório.

````markdown
**[DF202] Fundos internos: Fábrica e Salão do Núcleo**

Siga o [DF-BASE] e o quadro-chave aprovado (tela interior). Substituem os painéis chapados DF22–DF24, que hoje cobrem as paredes de fundo. Função: **estrutura escura e quieta que dá ritmo sem competir**, como as paredes do Laboratório (colunas, janelas altas, painéis escuros).

| | `DF202_fabrica.png` | `DF202_salao.png` |
|---|---|---|
| Onde entra | Fábrica, x 1.700–3.580, do teto até o chão (y −80 a 1.010) | Salão do Núcleo, x 3.580–6.990 (y −80 a 1.070); também a Saída (x 8.550–8.900, y 400–790) |
| Conteúdo | pilares e vigas de 3–6 D, janelas altas com luz âmbar (1–2 D), tubulações, engrenagens grandes **escuras** atrás, passarelas ao longe | galeria alta: pontes e correntes ao fundo, painéis grandes, tubulações verticais, poucas janelas |
| Luma média | 0,08–0,12 | 0,06–0,10 (o mais escuro da fase) |

- **Dimensões:** 2.048 × 2.048 px cada (escala 2×: 1.024 × 1.024 px de jogo), repetível na horizontal **e** na vertical, com duas variantes de módulo em cada imagem (variação a cada ~1.000 px de jogo).
- **Fundo:** opaco.
- **Luzes:** âmbar só em pontos (janelas, lâmpadas de parede), nunca em áreas grandes; 1–3 focos por tela de 1.280 × 720.
- **Confira:** `DF202_cena.png`: um painel da Fábrica (com a esteira e uma prensa na frente) e um do Salão (com a passarela e a torre), Autômato a ~91 px, ao lado das referências. Emenda horizontal e vertical sem costura.
- **Entrega:** `colaboracao/entregas/DF202/`. Regras do DF-BASE.
````

#### [DF203] Fundo da Câmara da Forja

> Mande depois da DF03 v2 aprovada. Anexe a DF03 v2 e o quadro-chave.

````markdown
**[DF203] Fundo da Câmara da Forja**

Siga o [DF-BASE], o quadro-chave e a DF03 v2 aprovada.
- **Onde entra:** a arena do chefe, 1.440 × 620 px de jogo (x 7.050–8.490; teto em y 150; chão em y 770). A Forja-Mãe fica embutida no centro do fundo; o trilho dos braços corre no teto; há portas de 60 × 190 px nas duas paredes laterais (y 580–770).
- **Conteúdo:** parede de fornalha ao fundo, tubulações e vigas que convergem para o lugar da Forja, o **trilho do teto** visível, brilho de fornalha contido. **Deixe o centro calmo e escuro** (região de ~600 × 560 px de jogo atrás da Forja) para ela se destacar.
- **Valores:** luma média 0,07–0,12; mais escuro que o corpo da Forja; o brilho da fornalha nunca tira o destaque da lente e do núcleo.
- **Arquivo:** `DF203_camara.png`, 2.880 × 1.240 px (2×), opaco, chão no pé da imagem, portas encostadas nas bordas.
- **Confira:** `DF203_cena.png` com a Forja v2 montada por cima e o Autômato a ~91 px no chão.
- **Entrega:** `colaboracao/entregas/DF203/`. Regras do DF-BASE.
````

#### [DF204] Estrutura de fundo (peças grandes)

````markdown
**[DF204] Estrutura de fundo: 10 peças grandes**

Siga o [DF-BASE] e o quadro-chave aprovado. Camada 3 da DA-03, que o Deserto não tinha: silhuetas grandes **atrás** do plano do jogo, mais escuras que ele, que organizam o espaço. Função igual ao cogumelo gigante e ao arco do templo de Verdâmia (`assets/verdamia/objetos/cogumelo_gigante.png`, `arco_templo.png`).
- **Peças (10):** 2 guindastes (um exterior, um interior de pórtico), 2 chaminés (alta e baixa), tanque cilíndrico, carcaça de escavadeira, carcaça de robô gigante tombado, coluna de aço com vigas cruzadas, esqueleto de galpão, engrenagem gigante meio enterrada.
- **Escala:** 3–6 D de altura (273–546 px de jogo). Peças da mesma família na mesma escala.
- **Valores:** 2–3 tons, luma média 0,06–0,11, sem âmbar (no máximo uma lâmpada pequena apagada); luz de recorte ferrugem fina na aresta voltada para a luz.
- **Arquivo:** `DF204_estrutura.png`, folha de 5.120 × 3.072 px, células de 1.024 × 1.536 px (5 colunas × 2 linhas), uma peça por célula, **base de cada peça na borda de baixo da célula**, centralizada. Escala do arquivo: 2,5 px = 1 px de jogo (uma peça de 6 D ocupa ~1.365 px de altura).
- **Fundo:** transparente, sem sombra projetada e sem texto.
- **Confira:** `DF204_cena.png`: três peças nas Dunas e três na Fábrica, atrás do terreno, Autômato a ~91 px.
- **Entrega:** `colaboracao/entregas/DF204/`, com a lista de peças, a altura em D e a posição da base em cada célula. Regras do DF-BASE.
````

#### [DF206] Decoração média e pequena

````markdown
**[DF206] Decoração média (10) e pequena (14)**

Siga o [DF-BASE] e o quadro-chave aprovado. As faixas média e pequena da DA-03, que o Deserto nunca teve. Acabamento e densidade como os objetos do Laboratório (`assets/laboratorio/`: barril, caixa, tanque, cabos) e de Verdâmia (`assets/verdamia/objetos/`).
- **Médias (10), 1–2 D:** monte de sucata A (substitui DF30_1: chapas, engrenagem e pneu; 155 × 76 px de jogo), monte de sucata B (substitui DF30_2; 110 × 56), tambor de óleo, pilha de caixas de ferro, carrinho de mina tombado, bancada com ferramentas, gerador desligado, roda de trem meio enterrada, poste de luz quebrado, painel de controle de chão.
- **Pequenas (14), 0,15–0,5 D:** parafusos e porcas soltos, chave inglesa, engrenagem pequena, cabo enrolado, lâmpada de chão (acesa âmbar), lata, tijolo de escória, pedaço de chapa, cano curto, rebites espalhados, placa de aviso de perigo (só para pôr onde há perigo de verdade), garrafa de vidro, pedra de ferrugem, tufo de capim seco.
- **Valores:** 3 tons por material, luma média 0,10–0,18 (mais claros que o fundo, mais escuros que o Autômato); âmbar só na lâmpada de chão; nada de listras de aviso decorativas.
- **Arquivos:** `DF206_media.png` (2.560 × 1.024, células de 512 × 512, 5 × 2) e `DF206_pequena.png` (1.792 × 512, células de 256 × 256, 7 × 2). Escala 2× do jogo. **Base de cada peça na borda de baixo da célula**, centralizada. Os dois montes de sucata respeitam a proporção dos tamanhos de jogo indicados.
- **Fundo:** transparente, sem sombra projetada e sem texto.
- **Confira:** `DF206_cena.png`: Dunas e Fábrica decoradas nas três escalas, Autômato a ~91 px.
- **Entrega:** `colaboracao/entregas/DF206/`. Regras do DF-BASE.
````

#### [DF207] Moldura: o que desce do alto

````markdown
**[DF207] Moldura: 8 peças que descem do alto**

Siga o [DF-BASE] e o quadro-chave aprovado. DA-03, C3: elementos que descem do teto (interior) e das gruas (exterior) e dão moldura à tela. Função igual aos cabos do Laboratório e às raízes penduradas de Verdâmia (`assets/verdamia/objetos/raiz_pendurada.png`).
- **Peças (8):** corrente simples longa; corrente com gancho de guindaste; feixe de cabos caídos; mangueira hidráulica em curva; lâmpada pendurada **apagada** (a acesa é a DF221); caçamba de guindaste pendurada; polia com corrente; viga solta pendurada por dois cabos.
- **Escala:** 1–3 D de comprimento (91–273 px de jogo).
- **Valores:** 2 tons, luma 0,05–0,10 (silhueta quase escura contra o fundo); sem âmbar.
- **Arquivo:** `DF207_moldura.png`, 2.048 × 1.536 px, células de 512 × 768 (4 × 2). Escala 2× do jogo. **Ponto de fixação no centro da borda de cima de cada célula**; o que continua acima pode sair da célula (o jogo estende com a corrente da peça 1).
- **Fundo:** transparente.
- **Confira:** `DF207_cena.png`: Fábrica e Salão com 3–4 peças descendo do alto, Autômato a ~91 px.
- **Entrega:** `colaboracao/entregas/DF207/`. Regras do DF-BASE.
````

#### [DF208] Primeiro plano

````markdown
**[DF208] Primeiro plano exterior e interior**

Siga o [DF-BASE] e o quadro-chave aprovado. Camada 5 da DA-03: silhuetas quase pretas na borda de baixo da tela, na frente do jogador. Altura, densidade e escurecimento como `assets/verdamia/fundo/fg_vegetacao.png`.
- **Exterior:** sucata, areia em montes, engrenagens e canos quebrados.
- **Interior:** vigas, tubos, correntes caídas e a borda de uma prensa desligada.
- **Valores:** luma ≤ 0,05, 1–2 tons (azul-marinho e ferrugem quase preta), sem âmbar e sem detalhe interno fino; borda superior recortada e variada.
- **Arquivos:** `DF208_primeiro_plano.png` e `DF208_primeiro_plano_interior.png`, 2.048 × 512 px cada, repetíveis na horizontal, base reta na borda de baixo. A silhueta ocupa no máximo os 384 px de baixo e só passa de 256 px em 2–3 picos por módulo (no jogo: até ~1/5 da altura da tela).
- **Fundo:** transparente acima da silhueta.
- **Confira:** `DF208_cena.png` com a camada na frente do jogo, o Autômato a ~91 px nunca coberto no chão.
- **Entrega:** `colaboracao/entregas/DF208/`. Regras do DF-BASE.
````

#### [DF209] Efeitos de ambiente

````markdown
**[DF209] Efeitos de ambiente**

Siga o [DF-BASE] e o quadro-chave aprovado. DA-03, C6: partículas e luzes que dão vida à cena. Substituem a DF86 (partículas de vento) e os brilhos desenhados por código.
- `DF209_poeira.png`: 8 grãos/fiapos de poeira de ferrugem e areia, **um por célula** (o jogo espalha e move pela tela nas Dunas); 4–14 px de jogo.
- `DF209_faiscas.png`: faíscas de solda e de máquina, 6 quadros (estouro e queda), âmbar e branco.
- `DF209_vapor.png`: nuvem de vapor ambiente saindo de uma fresta, 8 quadros em **loop**, ~1–2 D, branco-acinzentado translúcido.
- `DF209_brilho_lampada.png`: halo âmbar radial de lâmpada (1 quadro), gradiente suave, centro na célula; é o halo definido no quadro-chave.
- **Formato:** células de 256 × 256 px, uma folha por efeito, 4 colunas (2 linhas quando passar de 4 quadros); centro da célula como âncora. Escala 2× do jogo (o halo pode ocupar a célula inteira).
- **Fundo:** transparente.
- **Confira:** `DF209_cena.png` nas Dunas (poeira) e na Fábrica (faíscas, vapor, halos).
- **Entrega:** `colaboracao/entregas/DF209/`. Regras do DF-BASE.
````

---

### Etapa 3. Máquinas, marcos e objetos

> Todas as peças desta etapa estão na escala **2 px do arquivo = 1 px do jogo** (formato B do DF-BASE). A tabela de cada prompt dá o tamanho no jogo e o tamanho exato do arquivo. A posição no jogo serve para o GPT entender o contexto.

#### [DF220] Marcos do cenário

````markdown
**[DF220] Marcos do cenário: mastro, chaminé, porta da fábrica, engrenagem, abertura e torre do Núcleo**

Siga o [DF-BASE] e o quadro-chave aprovado. São os marcos que orientam o jogador na fase. Substituem DF31–DF36 (v0.8), com o mesmo tamanho no jogo e a mesma função.

| Arquivo | No jogo (px) | Arquivo (px) | Onde fica | Conteúdo e regras |
|---|---|---|---|---|
| `DF31_mastro_viga_v2.png` | 310 × 237 | 620 × 474 | Dunas, sobre o fosso (x 686–996, chão em y 700) | mastro enferrujado à esquerda, com sapata parafusada no chão; viga horizontal no topo apontando para a **direita**. Na ponta da viga, um **olhal** centrado em (578, 34) do arquivo, de onde o jogo pendura o ponto de gancho DF57. |
| `DF32_chamine_v2.png` | 72 × 128 | 144 × 256 | no telhado da fachada, x 1.530 | chaminé com boca escura no topo (o jogo põe a fumaça DF80 saindo do centro da boca); base reta na borda de baixo. |
| `DF33_porta_fabrica_v2.png` | 140 × 175 | 280 × 350 | entrada da Fábrica, x 1.550, chão em y 700 | portão escuro com moldura de chapa e uma **luz âmbar** em cima; base na borda de baixo. |
| `DF34_engrenagem_fundo_v2.png` | 320 × 320 | 640 × 640 | fundo da Fábrica (gira devagar) | engrenagem gigante de frente, eixo central parafusado, **tons recuados** (luma 0,06–0,10); correta em qualquer ângulo; centro exato da imagem = eixo. |
| `DF35_abertura_parede_v2.png` | 140 × 190 | 280 × 380 | parede direita da Fábrica, perto do teto (x 3.460, y 226) | vão retangular com batente de chapa e luz âmbar vindo de fora; é por onde o jogador sai para o Salão. |
| `DF36_torre_nucleo_v2.png` | 298 × 785 | 596 × 1.570 | Salão do Núcleo, x 4.700, base no chão em y 770 | torre alta com o **núcleo âmbar** no meio (o foco de luz do Salão); ponto de fixação dos cabos do corredor em (240, 174) do arquivo; base na borda de baixo. |

- **Valores:** marcos no plano do jogo (3 tons, luma média 0,10–0,18), exceto a engrenagem (recuada). Âmbar só nas luzes e no núcleo.
- **Fundo:** transparente.
- **Confira:** `DF220_cena.png`: Dunas (mastro e porta), Fábrica (engrenagem, abertura) e Salão (torre), Autômato a ~91 px.
- **Entrega:** `colaboracao/entregas/DF220/`. Regras do DF-BASE.
````

#### [DF221] Iluminação e enfeites de parede

````markdown
**[DF221] Lâmpada industrial (2 estados), painel de controle, canos e cabo de aço**

Siga o [DF-BASE] e o quadro-chave aprovado. Substituem DF37, DF37b, DF39, DF39b e DF28.

| Arquivo | No jogo (px) | Arquivo (px) | Conteúdo e regras |
|---|---|---|---|
| `DF37_lampada_v2.png` | 38 × 69 | 76 × 138 | lâmpada industrial pendurada, **acesa**: cúpula de chapa e bulbo âmbar; o fio entra pelo centro da borda de cima. O halo vem da DF209. |
| `DF37b_lampada_apagada_v2.png` | 38 × 69 | 76 × 138 | a mesma, apagada (bulbo escuro). Mesma silhueta, pixel a pixel. |
| `DF39_painel_v2.png` | 65 × 90 | 130 × 180 | painel de controle de parede com 3–4 luzes âmbar pequenas e um mostrador; placa de fixação visível. |
| `DF39b_canos_v2.png` | 240 × 120 | 480 × 240 | conjunto de canos horizontais com 2 válvulas de volante, presos na parede por braçadeiras. |
| `DF28_cabo_v2.png` | faixa de 8 px | 512 × 32 | cabo de aço trançado, **repetível na horizontal**; o jogo estica e gira entre dois pontos (fios das lâmpadas e cabos da torre). Dois tons, sem brilho. |

- **Fundo:** transparente.
- **Confira:** `DF221_cena.png`: corredor da Fábrica com 2 lâmpadas penduradas (uma apagada), painel e canos na parede.
- **Entrega:** `colaboracao/entregas/DF221/`. Regras do DF-BASE.
````

#### [DF222] Esteira e trilhos

````markdown
**[DF222] Esteira, pontas da esteira, trilho vertical e trilho horizontal**

Siga o [DF-BASE] e o quadro-chave aprovado. Substituem DF26, DF26b, DF26c, DF27 e DF55b. A esteira é o chão da Fábrica (x 1.700–2.780, topo em y 700); o jogo rola a textura para a direita.

| Arquivo | No jogo (px) | Arquivo (px) | Repete | Conteúdo e regras |
|---|---|---|---|---|
| `DF26_esteira_v2.png` | faixa de 60 px de altura | 1.024 × 120 | horizontal | lona escura com taliscas e **setas âmbar** apontando para a **direita** (máquina ativa = assinatura); rolos aparecendo por baixo. **Apoio na linha 0** (a borda de cima é o chão). Friso âmbar fino na aresta de cima, como a borda de apoio da DF205 v2. |
| `DF26b_esteira_ponta_esq_v2.png` | 60 × 60 | 120 × 120 | — | engrenagem/tambor da ponta esquerda, com o eixo no centro; encaixa na lona sem degrau. |
| `DF26c_esteira_ponta_dir_v2.png` | 60 × 60 | 120 × 120 | — | a da ponta direita (pode ser o espelho da esquerda). |
| `DF27_trilho_vertical_v2.png` | faixa de 74 px de largura | 148 × 512 | vertical | trilho do elevador do Salão: duas guias de aço com travessas, preso na parede. |
| `DF55b_trilho_horizontal_v2.png` | faixa de 16 px de altura | 512 × 32 | horizontal | trilho superior do carrinho do Salão e do carrinho dos braços da Forja: perfil em I visto de lado. |

- **Fundo:** transparente.
- **Confira:** `DF222_cena.png`: esteira inteira (1.080 px de jogo) com as duas pontas e uma prensa em cima; trilho vertical com o elevador; emendas sem costura.
- **Entrega:** `colaboracao/entregas/DF222/`. Regras do DF-BASE.
````

#### [DF223] Prensas e serra

````markdown
**[DF223] Prensa grande, prensa pequena e serra circular (peças animadas pelo jogo)**

Siga o [DF-BASE] e o quadro-chave aprovado. Substituem DF50a–c, DF51a–c, DF52 e DF52b. O jogo sobe e desce a cabeça da prensa (a haste estica) e gira a serra.

| Arquivo | No jogo (px) | Arquivo (px) | Conteúdo e regras |
|---|---|---|---|
| `DF50c_prensa_suporte_v2.png` | 106 × 35 | 212 × 70 | suporte de teto da prensa grande: a peça presa à viga de cima, com o furo da haste no centro da borda de baixo. |
| `DF50b_prensa_haste_v2.png` | 20 de largura | 40 × 256 | haste do pistão, **repetível na vertical**, cromo escurecido em 2 tons. |
| `DF50a_prensa_cabeca_v2.png` | 106 × 30 | 212 × 60 | cabeça pesada; a **face de baixo** (os 12 px de baixo do arquivo) tem as **faixas de perigo vermelho e cinza**: é a área de esmagamento. Luz âmbar pequena de "ativa" na lateral. |
| `DF51c_prensa_pequena_suporte_v2.png` | 70 × 35 | 140 × 70 | igual à grande, mais compacta (prensa do corredor do Salão). |
| `DF51b_prensa_pequena_haste_v2.png` | 20 de largura | 40 × 256 | repetível na vertical. |
| `DF51a_prensa_pequena_cabeca_v2.png` | 70 × 30 | 140 × 60 | face de baixo com as faixas de perigo. |
| `DF52_serra_v2.png` | 70 × 70 | 140 × 140 | disco de serra de frente, dentes em **vermelho-metálico** (perigo); centro exato = eixo; correto em qualquer ângulo. |
| `DF52b_serra_base_v2.png` | 80 × 32 | 160 × 64 | suporte fixo que prende o disco à esteira; o eixo do disco fica no centro da borda de cima. |

- **Leitura:** as faixas vermelhas e os dentes são o único vermelho da máquina; corpo em ferro e ferrugem escuros.
- **Fundo:** transparente.
- **Confira:** `DF223_cena.png`: prensa grande aberta e fechada sobre a esteira, serra na esteira, prensa pequena na passarela; Autômato a ~91 px.
- **Entrega:** `colaboracao/entregas/DF223/`. Regras do DF-BASE.
````

#### [DF224] Plataformas móveis, válvula e gancho

````markdown
**[DF224] Elevador, carrinho suspenso, válvula de vapor (2 estados) e ponto de gancho**

Siga o [DF-BASE] e o quadro-chave aprovado. Substituem DF54, DF55, DF56 (inativa e aviso) e DF57.

| Arquivo | No jogo (px) | Arquivo (px) | Conteúdo e regras |
|---|---|---|---|
| `DF54_elevador_v2.png` | 120 × 24 | 240 × 48 | piso do elevador que sobe pelo trilho DF27; guias laterais e uma luz âmbar de "em movimento". **Apoio na linha 0** com friso âmbar fino. |
| `DF55_carrinho_v2.png` | 120 × 132 | 240 × 264 | carrinho suspenso do Salão: rodinhas no trilho em cima (linha 16 do arquivo), duas hastes descendo e o piso embaixo, com o **apoio na linha 224** do arquivo (os últimos 40 px são a base do piso). |
| `DF56_valvula_inativa_v2.png` | 72 × 12 | 144 × 24 | grade de chão com bocal, luz apagada; base na borda de baixo. |
| `DF56_valvula_aviso_v2.png` | 72 × 12 | 144 × 24 | a mesma com a **luz vermelha** acesa (aviso antes do jato DF81). Mesma silhueta. |
| `DF57_ponto_gancho_v2.png` | 38 × 48 | 76 × 96 | argola metálica com **anel ciano** brilhando de leve, presa por um suporte curto em cima (o suporte encosta na borda de cima). **O objeto mais fácil de achar na tela.** |

- **Fundo:** transparente.
- **Confira:** `DF224_cena.png`: o elevador no trilho, o carrinho no trilho horizontal, duas válvulas (uma em aviso), o gancho pendurado na viga do mastro e no teto da Câmara; Autômato a ~91 px.
- **Entrega:** `colaboracao/entregas/DF224/`. Regras do DF-BASE.
````

#### [DF225] Portas da Câmara e da Saída

````markdown
**[DF225] Portas da Câmara da Forja e da Saída (fechada e aberta)**

Siga o [DF-BASE] e o quadro-chave aprovado. Substituem DF38. As portas ficam nas paredes de 60 px em x 6.990 e 8.490, de y 580 a 770; a verga de pedra/chapa da DF205 encaixa em cima.
- `DF38_porta_fechada_v2.png`: comporta de chapa grossa, travada, luz vermelha apagada; base no chão.
- `DF38_porta_aberta_v2.png`: a comporta recolhida para cima, passagem iluminada em âmbar.
- **No jogo:** 150 × 190 px (a colisão é a faixa central de 60 px). **Arquivo:** 300 × 380 px cada, mesma moldura nos dois estados (pixel a pixel fora da comporta).
- **Fundo:** transparente.
- **Confira:** `DF225_cena.png`: as duas portas na parede da DF205, abertas e fechadas, com a verga em cima.
- **Entrega:** `colaboracao/entregas/DF225/`. Regras do DF-BASE.
````

#### [DF210] Objetos do universo

> Anexe `colaboracao/entregas/GL04/GL04_prancha_objetos_v2.png` (como Nivária resolveu os mesmos objetos) e `assets/laboratorio/celula_suporte.png`.

````markdown
**[DF210] Estação de recarga, placa, Célula de Fase, Núcleo de Integridade e Registro do Deserto**

Siga o [DF-BASE] e o quadro-chave aprovado. Hoje o Deserto usa a estação, a placa holográfica e os coletáveis do Laboratório. Faça as versões do Ferrugrado **mantendo a forma que o jogador já conhece** (como a GL04 fez em Nivária): a Célula continua "célula", o Núcleo continua "núcleo".
- **Estação de recarga (checkpoint):** 0,9–1,2 D, base no chão; estados **apagada** e **ativa** (luz âmbar). Uma fornalha-relicário onde o traje recarrega.
- **Placa de dica:** 0,6 D, base no chão; marco de chapa com uma tela âmbar.
- **Célula de Fase:** 0,25 D, 6 quadros de brilho em loop; o cristal da célula mantém a cor do jogo (não vire âmbar), a moldura vira ferrugem.
- **Núcleo de Integridade:** 0,35 D, 6 quadros em loop.
- **Registro (log):** 0,35 D, 4 quadros em loop.
- **Arquivos:** duas folhas com células de 512 × 512 px, em ordem de leitura:
  - `DF210_objetos.png`, 2.048 × 1.024 (4 × 2): estação apagada, estação ativa, placa, célula vazia, registro 1–4;
  - `DF210_coletaveis.png`, 2.048 × 1.536 (4 × 3): célula 1–6, núcleo 1–6.
- **Escala:** D = 400 px (4,4 px do arquivo = 1 px do jogo). Estação e placa com a base na linha 472 da célula, centradas em x 256; coletáveis e registro centrados na célula.
- **Fundo:** transparente.
- **Confira:** `DF210_comparacao.png` ao lado dos equivalentes do Laboratório e de Nivária; `DF210_cena.png` com a estação acesa nas Dunas.
- **Entrega:** `colaboracao/entregas/DF210/`. Regras do DF-BASE.
````

---

### Etapa 4. Autômato (folhas de animação)

> Mande depois da DF02 v2 aprovada. **Formato A** do DF-BASE em todas. Anexe a DF02 v2.

#### [DF90–DF96 v2] Corpo do Autômato

````markdown
**[DF90–DF96 v2] Autômato: 7 folhas do corpo**

Siga o [DF-BASE] e a ficha **DF02 v2 aprovada** (desenho, cores e cota de altura). Sete PNGs no formato A (1536 × 1024, 4 × 2 células de 384 × 512).
- **Âncora (todas):** **pés na linha y = 472** da célula, **centro do corpo em x = 192**, iguais em todos os quadros. Altura na pose parada = a cota da DF02 v2, igual em todas as folhas.
- **O braço-ímã NÃO aparece** (é a DF97). Em cada quadro, informe no `ENTREGA_v2.md` a posição do **pivô do ombro** em pixels da célula.

| Arquivo | Quadros | Ação |
|---|---|---|
| `DF90_automato_parado_v2.png` | 6, loop | respiração mecânica: tronco sobe e desce 4 px; visor pisca de leve no quadro 4; o 6 volta ao 1 sem salto. |
| `DF91_automato_andar_v2.png` | 8, loop | passos curtos e pesados; contato do pé da frente nos quadros 1 e 5; o corpo desce 6 px nos contatos. |
| `DF92_automato_pulo_v2.png` | 4, sem loop | 1 agachamento (30 px mais baixo; também usado no pouso); 2 impulso; 3 subida (pernas recolhidas); 4 topo (o jogo segura). |
| `DF93_automato_queda_v2.png` | 3, sem loop | 1 começo da queda; 2 pernas se estendendo; 3 queda rápida, pronto para o impacto. |
| `DF94_automato_arranque_v2.png` | 4, sem loop | 1 inclina e solta o mecanismo de arranque; 2–3 desliza baixo e rápido, faísca pequena; 4 freia e volta à pose parada. |
| `DF95_automato_dano_v2.png` | 2, sem loop | 1 tranco (visor pisca branco); 2 volta, com 2 faíscas pequenas. Os pés não saem do lugar. |
| `DF96_automato_derrota_v2.png` | 6, sem loop | 1–2 perde força; 3–4 cai sentado, visor apaga; 5–6 tomba de lado com fumacinha; o 6 fica parado, ainda apoiado na linha 472. |

- **Confira:** sobreponha os quadros de todas as folhas em transparência: mesma escala e mesma linha dos pés; `DF90_comparacao.png` a ~91 px sobre o quadro-chave, ao lado do Lince e do Robô v2.
- **Entrega:** uma pasta por ID (`colaboracao/entregas/DF90/` … `DF96/`), `ENTREGA_v2.md` com os pivôs do ombro por quadro. Regras do DF-BASE.
````

#### [DF97 v2] Braço-ímã

````markdown
**[DF97 v2] Braço-ímã do Autômato (gira 360° para mirar)**

Siga o [DF-BASE] e a DF02 v2. Formato A.
- **Âncora:** centro do ombro (pivô) em **x = 60, y = 256** em todos os quadros; o braço aponta para **+x**. A ponta do ímã fica perto de x ≈ 280 (informe a posição exata: é de lá que saem o tiro e o feixe).
- **Escala:** a mesma da DF02 v2 (o braço da ficha, do pivô à ponta).
- **Quadros (4, sem loop):** 1 repouso; 2 disparo (recua 10 px para o ombro; o ímã brilha ciano); 3 volta (recuo de 4 px); 4 feixe ativo (garras abertas, brilho ciano mais forte).
- **Confira:** o braço montado no ombro de DF90 quadro 1, apontando em 8 direções (0°, 45°, …, 315°), sem a junta "quebrar".
- **Arquivo:** `DF97_automato_braco_v2.png`. **Entrega:** `colaboracao/entregas/DF97/`. Regras do DF-BASE.
````

#### [DF87, DF88, DF98, DF99 v2] Tiro e habilidades do Autômato

````markdown
**[DF87, DF88, DF98, DF99 v2] Rebite, clarão de disparo, feixe do Ímã e Pulso Magnético**

Siga o [DF-BASE] e a DF02 v2. **Tudo em ciano `#2EC7E6` e branco** (é o jogador); nada de âmbar nem vermelho.

| Arquivo | Formato e âncora | Quadros | Conteúdo |
|---|---|---|---|
| `DF87_rebite_v2.png` | A; centro do rebite em (192, 256); rebite de 0,1 D (40 px) | 4, loop | rebite de metal claro com cabeça arredondada girando, rastro ciano curto atrás. O jogo gira o sprite na direção do tiro. Legível a ~10 px. |
| `DF88_disparo_rebite_v2.png` | A; origem do clarão em (40, 256); até 0,3 D | 3, sem loop | 1 estouro ciano; 2 anel abrindo com 2–3 lascas; 3 apaga. Encaixa na ponta do ímã. |
| `DF98_feixe_ima_v2.png` | 1024 × 512: linhas 0–255 = segmento repetível (4 quadros de 256 × 256 lado a lado); linhas 256–511 = ponta (4 quadros); eixo em y 128 e y 384; contato da ponta em x 200 | 4 + 4, loop | linhas de força ciano e brancas com anéis magnéticos pequenos (não um laser liso); a ponta é uma garra de luz pulsando. 0,12 D (48 px) de espessura. |
| `DF99_pulso_magnetico_v2.png` | A; centro em (192, 256); no último quadro o anel ocupa a célula (Ø 360 px) | 6, sem loop | 1 o ponto de saída acende; 2–4 anel de **linhas de campo** (arcos entre polos, como num desenho de ímã) se expandindo; 5–6 se desfaz em fiapos. Diferente do clarão cheio do Lince. |

- **Confira:** os quatro montados no Autômato v2 a ~91 px sobre o quadro-chave interior.
- **Entrega:** uma pasta por ID. Regras do DF-BASE.
````

---

### Etapa 5. Inimigos

> Mande depois da DF01 v2 aprovada. **Formato A.** Anexe a DF01 v2.

#### [DF60–DF65 v2 + DF64b] Robô sentinela

````markdown
**[DF60–DF65 v2 + DF64b] Robô sentinela: 7 folhas**

Siga o [DF-BASE] e a ficha **DF01 v2 aprovada**. Formato A.
- **Âncora (todas):** **pés na linha y = 472**, **centro do corpo em x = 192**, iguais em todos os quadros. Altura 0,80 D (320 px) na pose parada.
- **Foco:** a lente vermelha aponta para a frente (direção do tiro) em todas as folhas.

| Arquivo | Quadros | Ação |
|---|---|---|
| `DF60_robo_idle_v2.png` | 4, loop | parado, balanço leve, lente pulsando fraco. |
| `DF61_robo_andar_v2.png` | 6, loop | patrulha com passos curtos e pesados. |
| `DF62_robo_aviso_v2.png` | 3, sem loop | **aviso de 0,5 s**: para, a lente acende forte, o canhão sobe e mira. Tem que ser muito claro. |
| `DF63_robo_tiro_v2.png` | 3, sem loop | disparo para a frente: recuo do corpo e clarão vermelho na boca do canhão. |
| `DF64_robo_dano_v2.png` | 2, sem loop | tranco para trás com faíscas pequenas. |
| `DF64b_robo_paralisado.png` (**NOVO**) | 4, loop | paralisado pelo Pulso Magnético (2 s): travado, arcos ciano curtos presos no corpo, lente piscando. O ciano aqui é o efeito do jogador, não o robô. |
| `DF65_robo_destruido_v2.png` | 6, sem loop | a lente apaga, peças se soltam e ele cai num monte com fumaça; o último quadro fica parado, apoiado na linha 472. |

- **Confira:** sobreposição dos quadros (mesma escala e pés); `DF60_comparacao.png` a ~91 px sobre a parede da Fábrica do quadro-chave (pior contraste): o corpo inteiro se lê.
- **Entrega:** uma pasta por ID. Regras do DF-BASE.
````

#### [DF66–DF69b v2 + DF69c] Drone do Deserto

````markdown
**[DF66–DF69b v2 + DF69c] Drone do Deserto: 6 folhas**

Siga o [DF-BASE] e a ficha **DF01 v2 aprovada**. Formato A.
- **Âncora (todas):** **centro do corpo no centro da célula (192, 256)**. Corpo com 0,60 D (240 px) de largura.
- **Foco:** lente vermelha embaixo (o tiro vai para baixo).

| Arquivo | Quadros | Ação |
|---|---|---|
| `DF66_drone_voo_v2.png` | 6, loop | hélices girando, corpo oscilando ±6 px. |
| `DF67_drone_aviso_v2.png` | 3, sem loop | **aviso**: a lente pisca forte e aponta para baixo. |
| `DF68_drone_tiro_v2.png` | 3, sem loop | disparo para baixo: recuo para cima e clarão vermelho sob a lente. |
| `DF69_drone_dano_v2.png` | 2, sem loop | tranco e faíscas. |
| `DF69b_drone_destruido_v2.png` | 6, sem loop | hélices param, gira e cai soltando fumaça; termina como sucata (pode descer até a linha 472 no último quadro). |
| `DF69c_drone_derrubado.png` (**NOVO**) | 4, loop | derrubado no chão pelo Pulso ou pelo feixe do ímã: de lado, hélices tortas tentando girar, lente fraca; **base na linha 472**. |

- **Confira:** sobreposição dos quadros; `DF66_comparacao.png` a ~91 px ao lado do Drone do Laboratório.
- **Entrega:** uma pasta por ID. Regras do DF-BASE.
````

#### [DF70, DF71 v2] Projéteis inimigos

````markdown
**[DF70, DF71 v2] Projéteis do Robô e do Drone**

Siga o [DF-BASE] e a DF01 v2. **Formato F** (escala 3 px do arquivo = 1 px do jogo), centro da célula.
- `DF70_projetil_robo_v2.png`: 4 quadros, loop. Bola de energia **vermelha** alongada na horizontal (perigo; não âmbar, que é o mundo), com núcleo claro. No jogo: caixa de 72 × 80 px com o projétil de ~14 px de comprimento no centro e o rastro ocupando o resto.
- `DF71_projetil_drone_v2.png`: 4 quadros, loop. Gota de energia vermelha alongada na vertical, apontando para baixo, ~11 px de altura no jogo, na mesma caixa.
- **Confira:** os dois contra o fundo da Fábrica e das Dunas a ~91 px: leem como perigo, diferentes do rebite ciano.
- **Entrega:** uma pasta por ID. Regras do DF-BASE.
````

---

### Etapa 6. Efeitos de máquina e de combate

````markdown
**[DF80–DF85 v2] Fumaça, jato de vapor, faíscas da prensa, poeira de areia, explosão de máquina e impacto**

Siga o [DF-BASE] e o quadro-chave aprovado. **Formato F** (1536 × 1024, 4 × 2 células de 384 × 512; escala 3 px do arquivo = 1 px do jogo). Desenhe cada efeito com a **proporção da caixa do jogo** indicada; o efeito fica dentro da célula, na âncora indicada. Formas chapadas em 2–3 tons, sem fumaça fotográfica nem partículas de ruído.

| Arquivo | Caixa no jogo (px) | Quadros | Âncora na célula | Conteúdo |
|---|---|---|---|---|
| `DF80_fumaca_chamine_v2.png` | 105 × 116 | 6, loop | boca da chaminé no centro da borda de baixo (192, 500) | fumaça em blocos arredondados cinza-ferrugem subindo e se abrindo. |
| `DF81_jato_vapor_v2.png` | 85 × 150 | 8, sem loop | bocal no centro da borda de baixo (192, 500) | jato de vapor: 1–2 nasce, 3–6 **coluna cheia** (é quando fere: a forma mostra com clareza a área de dano, 44 × 136 px de jogo), 7–8 dissipa. Branco-acinzentado, núcleo denso. |
| `DF82_faiscas_prensa_v2.png` | 110 × 74 | 6, sem loop | linha de impacto no centro, a 40 px da borda de baixo (192, 472) | faíscas âmbar e brancas e poeira quando a prensa bate (o jogo também usa no martelo da Forja, maior). |
| `DF83_poeira_areia_v2.png` | 92 × 74 | 6, sem loop | linha do chão a 40 px da borda de baixo (192, 472) | nuvem de areia de ferrugem do pouso e dos passos. |
| `DF84_explosao_maquina_v2.png` | 110 × 115 | 8, sem loop | centro (192, 256) | explosão de inimigo: clarão âmbar, fumaça escura em blocos e 3–4 peças voando. |
| `DF85_impacto_projetil_v2.png` | 75 × 75 | 4, sem loop | centro (192, 256) | estouro pequeno vermelho e âmbar de projétil inimigo na parede ou no chão. |

- **Confira:** `DF80_cena.png` com os seis efeitos nos seus lugares (chaminé, válvula, prensa, pouso do Autômato, robô explodindo, tiro na parede), a ~91 px.
- **Entrega:** uma pasta por ID. Regras do DF-BASE.
````

---

### Etapa 7. Forja-Mãe (peças do chefe)

> Mande depois da DF03 v2 e da DF203 aprovadas. Os encaixes e âncoras abaixo são os que o jogo usa (`scripts/forja.gd`): **não mude**.

#### [DF100–DF108 v2] Corpo e peças

````markdown
**[DF100–DF108 v2] Forja-Mãe: corpo, lente, peito, carrinho, segmento, martelo, núcleo do pistão, escotilha e grade**

Siga o [DF-BASE], a **DF03 v2 aprovada** e a DF203. Escala D = 400 px. As âncoras são exatas.

| Arquivo | Formato | Âncora e medidas | Quadros e estados (o jogo usa nesta ordem) |
|---|---|---|---|
| `DF100_forja_corpo_v2.png` | 2048 × 2048 | base da fornalha no chão, centro em (1024, 2008); corpo de 1.400 × 1.200 px; flanges laterais encostam na parede. **Encaixes vazios e transparentes:** lente Ø 360 com centro (1024, 900); peito 420 × 360 com centro (1024, 1330); escotilhas 240 × 160 com centros (640, 820) e (1408, 820); grade 700 × 240 com centro (1024, 1820) | 1 imagem |
| `DF101_forja_lente_v2.png` | A | centro (192, 256), Ø 340 nos 4 estados | 1 repouso (âmbar suave, íris aberta); 2 aviso de rajada (âmbar forte, íris meio fechada); 3 mira do feixe (**vermelha**, íris num ponto); 4 apagada |
| `DF102_forja_peito_v2.png` | A | centro (192, 256), câmara de 400 × 340 | 1 fechada (placas, fragmento visível pelas frestas); 2 aberta (fragmento exposto e brilhando); 3 danificada (rachada, fragmento piscando); 4, 5, 6 cada placa sozinha (esquerda, central, direita), na posição em que encaixa no quadro 1; 7–8 vazios |
| `DF103_forja_carrinho_v2.png` | 1024 × 512 | rodinhas apoiadas no trilho em y 120; pivô do braço em (512, 400); carrinho de 360 px | 1 imagem, motor com luz âmbar |
| `DF104_forja_segmento_v2.png` | 1024 × 512 | horizontal; pivô de entrada (112, 256), pivô de saída (912, 256); 140 px de espessura | 1 imagem: viga com pistão ao lado e articulações redondas |
| `DF105_forja_martelo_v2.png` | 2048 × 1024, 2 × 2 células de 1024 × 512 | encaixe no braço (512, 96); face de esmagamento em y 432; centro da placa de âncora (512, 150); bloco de 560 × 240 | 1 normal (faixas apagadas, âncora apagada, núcleo fraco); 2 aviso (faixas vermelhas acesas); 3 preso (âncora **ciano** acesa, núcleo forte e exposto, lascas de chão); 4 quebrado |
| `DF106_forja_nucleo_pistao_v2.png` | A | centro (192, 256), Ø 160 | 1 íntegro; 2 danificado; 3 destruído (esfera âmbar-fornalha numa gaiola de ferro) |
| `DF107_forja_escotilha_v2.png` | A | centro (192, 256), 240 × 160 | 1 fechada; 2 aviso (luz **vermelha**); 3 abrindo; 4 aberta (vão escuro de onde sai o drone) |
| `DF108_forja_grade_v2.png` | A | centro (192, 256), grade 340 × 120 (o jogo amplia para o encaixe de 700 × 240) | 1–6 fogo pulsando atrás das barras (loop); 7 grade aberta, fogo forte; 8 grade fria |

- **Confira:** a Forja montada inteira sobre a DF203, em repouso e em aviso (lente 2, martelo 2, escotilha 2), com o Autômato a ~91 px; sobreponha cada folha v2 à v1: âncoras no mesmo lugar.
- **Entrega:** uma pasta por ID. Regras do DF-BASE.
````

#### [DF110–DF112 v2] Efeitos da Forja

````markdown
**[DF110–DF112 v2] Feixe da lente, carga da lente e explosão de núcleo**

Siga o [DF-BASE] e a DF03 v2.

| Arquivo | Formato e âncora | Quadros | Conteúdo |
|---|---|---|---|
| `DF110_forja_feixe_v2.png` | 1024 × 512: linhas 0–255 = segmento repetível (4 quadros de 256 × 256); linhas 256–511 = impacto no chão (4 quadros); eixo do feixe em y 128; contato do impacto em (128, 480) | 4 + 4, loop | feixe **vermelho** com núcleo claro, 0,15 D (60 px) de espessura; no impacto, faíscas e chão incandescente. A forma mostra a área que fere. |
| `DF111_forja_carga_lente_v2.png` | A; centro (192, 256) | 6, sem loop | linhas de energia vermelha convergindo e um anel se fechando sobre a lente; o 6 é o instante do disparo. |
| `DF112_forja_explosao_nucleo_v2.png` | A; centro (192, 256) | 8, sem loop | 1 clarão; 2–4 anel de choque e lascas de ferro; 5–8 fumaça em blocos se desfazendo. Âmbar e branco; maior e mais limpa que a DF84. |

- **Entrega:** uma pasta por ID. Regras do DF-BASE.
````

---

### Etapa 8. Conferência final

````markdown
**[DF-UNIDADE] Prancha final: o Deserto inteiro na mão de um artista só**

Siga o [DF-BASE]. Com todas as peças aprovadas, monte duas pranchas para o João aprovar o pacote como um todo:
1. `DF_unidade_figuras.png`: na escala do jogo (Daymon a ~91 px), em fila e com os pés alinhados: Daymon, Lince, Autômato v2, Robô v2, Drone v2, Forja-Mãe v2, e os inimigos e o chefe do Laboratório e de Verdâmia (Rastejador, Drone, Turreta, Esporângio, Mariposa, Rainha Micélia). Depois, a mesma fila em silhueta.
2. `DF_unidade_cenas.png`: quatro telas de 1.280 × 720 do Deserto montadas com as peças novas (Dunas, Fábrica, Salão, Câmara), lado a lado com uma tela do Laboratório e uma de Verdâmia, com as medidas DA-03 de cada tela embaixo.

Liste no `ENTREGA.md` qualquer peça que ainda "pareça de outra mão" e por quê. **Entrega:** `colaboracao/entregas/DF_UNIDADE/`. Regras do DF-BASE.
````

---

## 4. O que o desenvolvimento faz depois de cada entrega

- Importa os PNGs (`tools/import_deserto.py`, `tools/import_fase2.py`, `tools/import_df205.py`, `tools/import_deserto_fundos.py`), sem tocar nos originais.
- Ajusta a integração onde este pacote muda o formato: **escala uniforme** das peças B (hoje algumas são esticadas para caber no retângulo) e dos efeitos F; as folhas novas **DF64b** e **DF69c**; o halo DF209; as peças DF204, DF206, DF207 e DF208.
- Mede a cena pela DA-03 (`tools/scene_metrics.gd`) e devolve capturas no lugar de cada peça.
- Roda os testes da fase (`test_deserto`, `test_forja`, `test_df205`, `test_portal`) para garantir que nada da jogabilidade mudou.
