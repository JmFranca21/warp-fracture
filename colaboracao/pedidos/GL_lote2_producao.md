# Pedido GL (lotes 2 e 3): produção de Nivária

**Lote 2: folhas de produção** (e lote 3 do Guardião). Fase 3, Nivária ([proposta](../../docs/fases/nivaria/proposta_fase3.md)).
**Estado:** ABERTO. As fichas GL01–GL04 v2 estão aprovadas e publicadas na `main` (commit `22828aa`).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 24/11/2026
**Diretrizes obrigatórias:** DA-01, DA-02 e DA-03. As fichas v2 decidem desenho, cor e acabamento; estes pedidos só fixam o que o jogo precisa (escala, apoio, pivô, quadros, grade).

A fase já roda inteira com **placeholders**: recortes das fichas v2 (`tools/import_nivaria.py`), o corpo do Daymon do laboratório com o cachecol desenhado por código, e terreno e fundos desenhados por código com a paleta da GL00. Cada pedido abaixo substitui um desses placeholders. Ordem sugerida: **cenário primeiro** (é o que mais separa Nivária do Laboratório e de Verdâmia), **GL55 → GL50 → GL51 → GL54 → GL56 → GL57 → GL58 → GL52 → GL53 → GL59**, depois o Daymon (**GL10 → GL11 → GL12 → GL13 → GL14**), os inimigos (**GL30 → GL31 → GL32**), os objetos (**GL70 → GL71 → GL90**) e o Guardião (**GL100 → GL101 → GL102**).

**Os pedidos de cenário seguem a [DA-03, receita de cena](../entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md):** cinco camadas, valores escuros, estrutura e moldura em toda tela, decoração em três escalas, terreno com borda viva e nada flutuando sem motivo. Cada entrega de cenário traz a prancha de cena (`<ID>_cena.png`) ao lado do Laboratório e de Verdâmia.

Cada bloco é um prompt completo. Copie **um por vez** e mande o seguinte só depois de aprovar o anterior.

| ID | Peça | Substitui no jogo |
|---|---|---|
| GL10 | Daymon de inverno: folhas do corpo (7 animações) | corpo do laboratório em Nivária |
| GL11 | Daymon de inverno: braço armado com manga e luva | braço do laboratório |
| GL12 | Daymon de inverno: cachecol em peças | cachecol desenhado por código |
| GL13 | Geada e bloco de gelo | tinta azul na geada e recorte do bloco da GL01 |
| GL14 | Pulso Térmico (efeito) | anel desenhado por código |
| GL30 | Gelinho: folha de animação | recortes estáticos da GL02 |
| GL31 | Drone Gélido: folha de animação, esfera e gelo no chão | recortes estáticos da GL02 |
| GL32 | Morcego-de-Cristal: folha de animação | recortes estáticos da GL02 |
| GL100 | Guardião Glacial: poses de combate | frontal e poses pequenas ampliadas da GL03 |
| GL101 | Guardião Glacial: placas do peito e núcleo | recortes da blindagem da GL03 |
| GL102 | Guardião Glacial: efeitos da luta | estaca da GL04 e onda desenhada por código |
| GL50 | Fundo distante: céu da noite polar | céu desenhado por código |
| GL51 | Fundo intermediário: cordilheira, pinheiros e estações ao longe | cordilheiras desenhadas por código |
| GL52 | Fundos da Caverna de Cristal | retângulo escuro da Caverna |
| GL53 | Fundo da Arena do Guardião | retângulo escuro da Arena |
| GL54 | Estrutura de fundo no plano do jogo (peças grandes) | nada (falta estrutura de fundo) |
| GL55 | Terreno completo de Nivária | terreno desenhado por código |
| GL56 | Decoração média e pequena | nada (falta decoração) |
| GL57 | Moldura: o que desce do alto | nada (falta moldura) |
| GL58 | Primeiro plano | nada (falta primeiro plano) |
| GL59 | Efeitos de ambiente | partículas provisórias por código |
| GL70 | Objetos de Nivária animados (perigos) | recortes estáticos da GL04 |
| GL71 | Objetos de Nivária animados (interação e coletáveis) | recortes estáticos da GL04 e marco por código |
| GL90 | Glifo de Nivária no Arco e ícone de Geada | floco desenhado por código e ícone de geada por código |

**Fora da arte (pendente):** música de Nivária (hoje toca a do menu) e efeitos sonoros próprios (sopro, congelar, quebrar o gelo, Pulso Térmico, bola de neve rolando, estalactite). O jogo usa efeitos existentes por enquanto.

---

## GL10: Daymon de inverno: folhas do corpo (7 animações)

````markdown
**[GL10] Daymon de inverno: folhas do corpo (7 animações)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL10
- **Arquivo(s):** `GL10_idle.png`, `GL10_run.png`, `GL10_jump.png`, `GL10_fall.png`, `GL10_dash.png`, `GL10_hurt.png`, `GL10_death.png`
- **Finalidade no jogo:** substitui o corpo do laboratório usado hoje como placeholder em Nivária (forma `inverno`). O braço armado e o cachecol são peças separadas (GL11 e GL12) e **não** entram nestas folhas.
- **Ficha v2 de referência:** `colaboracao/entregas/GL01/GL01_ficha_daymon_inverno_v2.png` (parca, capuz baixo, luvas, botas com cravos, faixa ciano) e as folhas atuais do Daymon listadas em `arte_original/USADAS_NO_JOGO.md` (movimento e registro).
- **Escala:** D = 400 px, exatamente a altura do Daymon da ficha oficial; a parca soma no máximo ~15% de largura por lado.
- **Orientação:** de perfil, olhando para a **direita** (o jogo espelha).
- **Âncora e pivô:** centro da base entre os pés, no mesmo ponto de cada célula das folhas atuais; o ombro do braço armado no mesmo lugar das folhas atuais (o braço é montado ali).
- **Estados e quadros:** idle 6 quadros (loop) · run 8 (loop) · jump 3 · fall 3 (loop) · dash 4 · hurt 2 · death 6 — as mesmas quantidades e o mesmo ritmo das folhas atuais.
- **Dimensões e grade:** **igual às folhas usadas hoje no jogo** (ver `arte_original/USADAS_NO_JOGO.md`): idle, run, jump, fall e dash de `arte_original/01_Daymon_sem_braco/` (`idle_v1_fundo_escuro.png`, `run_v2_verde.png`, `jump_v1.png`, `fall_v1.png`, `dash.png`) e hurt e death de `arte_original/02_Daymon_com_bracos/` (`hurt_v1.png`, `death_v1.png`): mesma tela, mesma grade e mesma posição do corpo em cada célula, **sem o braço da frente**. O jogo troca a textura sem mexer no rig (offset −18,33/−71,50 px, escala 0,3 da textura).
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** sobreponha cada quadro ao quadro correspondente da folha atual: pés, quadril e ombro no mesmo lugar; o rosto idêntico ao da ficha oficial; cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL10/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL10 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL11: Daymon de inverno: braço armado com manga e luva

````markdown
**[GL11] Daymon de inverno: braço armado com manga e luva**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL11
- **Arquivo(s):** `GL11_braco_inverno.png` (repouso) e `GL11_braco_inverno_disparo.png` (recuo do disparo)
- **Finalidade no jogo:** o braço que gira para mirar em Nivária; o Estabilizador de Fase é o mesmo, só a manga da parca e a luva térmica mudam.
- **Ficha v2 de referência:** GL01 v2 (bloco “braço armado / perfil direito”) e `arte_original/03_Arma/braco_arma_v2.png` (formato e pivô).
- **Escala:** a mesma de `braco_arma_v2.png` (o jogo usa 0,35 da textura).
- **Orientação:** apontando para a **direita**, na horizontal.
- **Âncora e pivô:** pivô no ombro, no mesmo ponto de `braco_arma_v2.png` (offset 62,50/0,20 px no jogo); a boca do cano na mesma posição.
- **Estados e quadros:** repouso (1) e disparo (1, recuo de ~6 px).
- **Dimensões e grade:** mesma tela e mesma posição de `braco_arma_v2.png`.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL11/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL11 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL12: Daymon de inverno: cachecol em peças

````markdown
**[GL12] Daymon de inverno: cachecol em peças**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL12
- **Arquivo(s):** `GL12_cachecol_no.png`, `GL12_cachecol_seg1.png`, `GL12_cachecol_seg2.png`, `GL12_cachecol_ponta.png`
- **Finalidade no jogo:** o cachecol é simulado por código (5 pontos, segmentos de ~9,5 px no jogo) a partir da cruz “saída do cachecol”; cada peça é girada no ponto de articulação.
- **Ficha v2 de referência:** GL01 v2, bloco “cachecol / articulações” (nó + 3 segmentos, laranja `#EF9655` com faixas `#B67A51`).
- **Escala:** D = 400 px: cada segmento com ~42 px de comprimento e ~24 px de largura; o nó com ~30 × 26 px.
- **Orientação:** segmentos na horizontal, a ponta presa à **esquerda** e a extremidade livre à direita.
- **Âncora e pivô:** cruz de articulação na extremidade presa de cada segmento; o nó com a cruz no ponto onde sai do pescoço.
- **Estados e quadros:** uma imagem por peça; a ponta com as franjas de tricô.
- **Dimensões e grade:** cada peça em PNG próprio, recortado justo com 4 px de margem.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL12/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL12 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL13: Geada e bloco de gelo

````markdown
**[GL13] Geada e bloco de gelo**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL13
- **Arquivo(s):** `GL13_geada_1.png`, `GL13_geada_2.png`, `GL13_geada_3.png`, `GL13_bloco.png` (folha)
- **Finalidade no jogo:** as camadas de geada aparecem sobre o corpo a cada golpe de frio; com três, o Daymon fica preso no bloco por 1,5 s e o jogador quebra o gelo batendo.
- **Ficha v2 de referência:** GL01 v2, bloco “acúmulo de geada” (01, 02, 03 e bloco) e GL04 v2 (gelo).
- **Escala:** D = 400 px; o bloco envolve o Daymon inteiro com ~1,15 D de altura (~460 px).
- **Orientação:** de perfil, olhando para a direita.
- **Âncora e pivô:** centro da base entre os pés (o mesmo do corpo GL10).
- **Estados e quadros:** geada: 3 sobreposições transparentes (só os cristais de gelo, para pôr por cima do corpo em qualquer quadro: ombros, braços, joelhos e cachecol) · bloco: inteiro, rachado 1, rachado 2 e estilhaçando em 4 quadros (7 quadros).
- **Dimensões e grade:** sobreposições em 512 × 512 px; bloco em grade de 4 × 2 células de 512 × 640 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL13/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL13 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL14: Pulso Térmico (efeito)

````markdown
**[GL14] Pulso Térmico (efeito)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL14
- **Arquivo(s):** `GL14_pulso_termico.png`
- **Finalidade no jogo:** anel de calor laranja que sai do traje (raio de 140 px no jogo, ~615 px na escala D) e derrete a geada, as placas de gelo e as placas do Guardião.
- **Ficha v2 de referência:** GL01 v2, bloco “pulso térmico” (linhas laranja sob a parca e anel no chão).
- **Escala:** o anel cresce de 0,2 D a 1,55 D de raio (diâmetro final ~1.230 px na escala D).
- **Orientação:** frontal, centrado no peito do Daymon.
- **Âncora e pivô:** centro da célula = centro do anel.
- **Estados e quadros:** 8 quadros: brilho nas linhas do traje (2), anel saindo (4), anel se desfazendo (2). Laranja `#EF9655`, sem branco puro.
- **Dimensões e grade:** 4 × 2 células de 640 × 640 px (o jogo reduz).
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL14/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL14 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL30: Gelinho: folha de animação

````markdown
**[GL30] Gelinho: folha de animação**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL30
- **Arquivo(s):** `GL30_gelinho.png` e `GL30_sopro.png` (efeito)
- **Finalidade no jogo:** inimigo terrestre do Cume, da Caverna e da Encosta: patrulha, infla por 0,5 s (aviso) e solta um sopro de geada curto à frente (~100 px no jogo).
- **Ficha v2 de referência:** `colaboracao/entregas/GL02/GL02_ficha_inimigos_nivaria_v2.png` (perfil, frontal, aviso e sopro).
- **Escala:** Gelinho com 229 × 240 px na escala D (0,6 D de altura; ~55 px no jogo), como na ENTREGA_v2 da GL02.
- **Orientação:** perfil olhando para a **direita** (o jogo espelha); o foco vermelho voltado para onde ele sopra.
- **Âncora e pivô:** centro da base (apoio no chão); boca do sopro marcada no `ENTREGA.md` em pixels.
- **Estados e quadros:** patrulha 6 (loop) · aviso 4 (inflando) · sopro 6 · dano 2 · morte 6 (desfaz em neve) — 24 quadros; efeito do sopro: 6 quadros em cone de ~440 × 160 px (escala D).
- **Dimensões e grade:** Gelinho: grade de 6 × 4 células de 320 × 320 px; sopro: 6 × 1 células de 480 × 200 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL30/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL30 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL31: Drone Gélido: folha de animação, esfera e gelo no chão

````markdown
**[GL31] Drone Gélido: folha de animação, esfera e gelo no chão**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL31
- **Arquivo(s):** `GL31_drone.png`, `GL31_esfera.png`, `GL31_gelo_chao.png`
- **Finalidade no jogo:** voador que patrulha, mira (foco aceso por 0,6 s) e solta uma esfera lenta de geada; onde ela cai fica uma mancha de gelo escorregadio por 3 s.
- **Ficha v2 de referência:** GL02 v2 (perfil, frontal, mira acesa, esfera e gelo no chão).
- **Escala:** Drone com 460 × 189 px na escala D (~105 × 43 px no jogo); esfera com ~130 px; mancha com ~400 × 60 px.
- **Orientação:** perfil olhando para a **direita**; a lente na frente.
- **Âncora e pivô:** Drone: centro do corpo; esfera: centro; mancha: centro da base (apoio no chão).
- **Estados e quadros:** Drone: voo 4 (loop, aletas) · mira 3 · disparo 3 · dano 1 · morte 6 (17 quadros). Esfera: 4 (girando). Mancha: formar 4 · derreter 4.
- **Dimensões e grade:** Drone: 6 × 3 células de 512 × 256 px; esfera: 4 × 1 de 160 × 160 px; mancha: 4 × 2 de 448 × 96 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL31/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL31 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL32: Morcego-de-Cristal: folha de animação

````markdown
**[GL32] Morcego-de-Cristal: folha de animação**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL32
- **Arquivo(s):** `GL32_morcego.png`
- **Finalidade no jogo:** dorme pendurado no teto da Caverna parecendo uma estalactite (só um brilho vermelho o denuncia), se solta e dá um rasante em arco de ~1,1 s.
- **Ficha v2 de referência:** GL02 v2 (repouso no teto, rasante em arco, frontal) e a estalactite da GL04 v2 (para o disfarce).
- **Escala:** envergadura de 352 px na escala D aberto (~80 px no jogo); pendurado com ~0,5 D de altura.
- **Orientação:** rasante de perfil olhando para a **direita**; pendurado de cabeça para baixo.
- **Âncora e pivô:** pendurado: o ponto preso ao teto (topo da célula); em voo: centro do corpo.
- **Estados e quadros:** pendurado 4 (loop, respiração quase parada) · soltar 3 · rasante 6 (loop) · dano 1 · morte 6 — 20 quadros.
- **Dimensões e grade:** 5 × 4 células de 400 × 320 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL32/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL32 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL100: Guardião Glacial: poses de combate

> Lote 3. Pode ir junto com o lote 2 se o João preferir.

````markdown
**[GL100] Guardião Glacial: poses de combate**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL100
- **Arquivo(s):** `GL100_guardiao_frontal.png`, `GL100_aviso.png`, `GL100_investida.png`, `GL100_atordoado.png`, `GL100_estacas.png`, `GL100_onda.png`, `GL100_derrota.png`
- **Finalidade no jogo:** o chefe de Nivária (D08). Hoje o jogo usa a frontal e as seis poses pequenas da ficha, ampliadas; estas folhas substituem tudo na escala certa.
- **Ficha v2 de referência:** `colaboracao/entregas/GL03/GL03_ficha_guardiao_v2.png` e `GL03_esquema_arena_v2.png`.
- **Escala:** 3,0 D = 1.200 px de altura de pé (273 px no jogo). Todas as poses na **mesma escala** da frontal (as poses curvadas ficam mais baixas, não menores).
- **Orientação:** frontal para idle, aviso, atordoado e derrota; perfil olhando para a **esquerda** na investida, nas estacas e na onda (o jogo espelha).
- **Âncora e pivô:** centro da base entre os pés, no mesmo ponto de todas as células; o centro do peito marcado (as placas GL101 são montadas ali, a −0,57 D da base no jogo).
- **Estados e quadros:** frontal 4 (respiração, loop) · aviso 4 (bate os pés, 0,6 s) · investida 6 (loop de corrida curvado) · atordoado 4 (loop, cabeça baixa, estilhaços) · estacas 6 (crava o punho) · onda 6 (sopro rente ao chão) · derrota 8 (racha e desaba em neve, sobra o fragmento flutuando).
- **Dimensões e grade:** uma folha por pose, células de 1.280 × 1.280 px, 4 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** o peito sem placas desenhadas (as placas são a GL101); olhos vermelhos com 4–10% da silhueta; o perfil legível; cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL100/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL100 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL101: Guardião Glacial: placas do peito e núcleo

````markdown
**[GL101] Guardião Glacial: placas do peito e núcleo**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL101
- **Arquivo(s):** `GL101_placa_1.png`, `GL101_placa_2.png`, `GL101_placa_3.png`, `GL101_nucleo.png`, `GL101_derreter.png`
- **Finalidade no jogo:** as três placas de gelo que cobrem o fragmento; o Pulso Térmico no atordoamento derrete uma e o núcleo fica exposto por 3 s (4 tiros).
- **Ficha v2 de referência:** GL03 v2, bloco “blindagem do peito” (3, 2, 1 placas e exposto).
- **Escala:** o conjunto das três placas com ~0,55 D de largura (~220 px na escala D; ~123 px no jogo).
- **Orientação:** frontal.
- **Âncora e pivô:** todas as peças com o mesmo centro (o centro do peito marcado na GL100).
- **Estados e quadros:** cada placa sozinha (3 imagens, empilháveis) · núcleo exposto: 4 quadros (pulsa, o fragmento com brilho frio) · derretendo: 6 quadros (uma placa vira água e vapor laranja do calor).
- **Dimensões e grade:** placas e núcleo em 320 × 320 px; derreter em 6 × 1 células de 320 × 320 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL101/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL101 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL102: Guardião Glacial: efeitos da luta

````markdown
**[GL102] Guardião Glacial: efeitos da luta**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL102
- **Arquivo(s):** `GL102_estaca.png`, `GL102_onda.png`, `GL102_impacto.png`
- **Finalidade no jogo:** Estacas de Gelo (rachadura vermelha de aviso por 0,45 s, depois sobem por 0,5 s), Onda de Gelo (sopro rente ao chão, ~60 px de altura no jogo, congela na hora) e o impacto da Investida na parede.
- **Ficha v2 de referência:** GL03 v2 (poses de estacas e onda), GL04 v2 (estaca de gelo do chefe) e `GL03_esquema_arena_v2.png` (alturas).
- **Escala:** estaca com ~110 px no jogo (~480 px na escala D) e 70 px de base; onda com ~260 px de altura e ~300 px de largura na escala D; impacto com ~1,2 D.
- **Orientação:** estaca de frente; onda andando para a **esquerda** (o jogo espelha); impacto com a parede à esquerda.
- **Âncora e pivô:** estaca e onda: centro da base (chão); impacto: ponto de contato com a parede.
- **Estados e quadros:** estaca: rachadura 2 (piscando) · subindo 3 · parada 1 · afundando 2 (8) · onda: 6 (loop) · impacto: 6.
- **Dimensões e grade:** estaca 8 × 1 células de 320 × 520 px; onda 6 × 1 de 360 × 300 px; impacto 6 × 1 de 560 × 560 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL102/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL102 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL50: Fundo distante: céu da noite polar

````markdown
**[GL50] Fundo distante: céu da noite polar**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL50
- **Arquivo(s):** `GL50_ceu.png` e `GL50_aurora.png`
- **Finalidade no jogo:** camada 1 da DA-03 (parallax 0,02) no Cume e na Encosta: céu, lua, estrelas e a aurora rosa, que ondula por código. Substitui o céu desenhado por código, hoje um vazio azul.
- **Ficha v2 de referência:** `colaboracao/entregas/GL00/GL00_prancha_nivaria.png` (faixa do Cume Congelado e paleta) e, como referência de acabamento de fundo, `assets/verdamia/fundo/bg_distante.png`.
- **Escala:** a tela do jogo tem 1.280 × 720 com zoom 1,1; o céu cobre a tela inteira com folga vertical de 1,5 tela.
- **Orientação:** paisagem lateral.
- **Âncora e pivô:** repetível na horizontal sem emenda; a aurora em camada separada com transparência.
- **Estados e quadros:** 1 imagem cada. Céu do topo `#13182C` ao horizonte `#1B2943`; a aurora em faixas suaves, com saturação contida (DA-03, C2: terço de cima da tela com luma até 0,15).
- **Dimensões e grade:** céu 2.560 × 1.440 px; aurora 2.560 × 720 px.
- **Fundo:** céu opaco; aurora transparente.
- **Antes de apresentar, confira:** monte a `GL50_cena.png` (DA-03): tela de 1.280 × 720 com o céu, as camadas GL51 se já existirem e o Daymon a ~91 px, ao lado de capturas do Laboratório e de Verdâmia (`colaboracao/entregas/00_padrao_visual/` tem a régua); luma do terço de cima ≤ 0,15; cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL50/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL50 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL51: Fundo intermediário: cordilheira, pinheiros e estações ao longe

````markdown
**[GL51] Fundo intermediário: cordilheira, pinheiros e estações ao longe**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL51
- **Arquivo(s):** `GL51_cordilheira.png` (parallax 0,12) e `GL51_encostas.png` (parallax 0,3)
- **Finalidade no jogo:** camada 2 da DA-03: as massas grandes de Nivária, preenchendo a altura da tela abaixo do céu. Picos nevados, encostas com pinheiros e as cúpulas das estações de observação abandonadas, pequenas e distantes.
- **Ficha v2 de referência:** GL00 (faixas do Cume e da Encosta; materiais neve, rocha e metal das estações) e `assets/verdamia/fundo/bg_intermediario.png` (como uma camada intermediária aprovada fecha a tela).
- **Escala:** picos com 2 a 3 vezes a altura da tela no horizonte; pinheiros das encostas com 1–2 D na camada de 0,3.
- **Orientação:** paisagem lateral.
- **Âncora e pivô:** base reta para encaixar uma camada na outra; repetível na horizontal.
- **Estados e quadros:** 1 imagem por camada. Quanto mais longe, mais escura e mais próxima da cor do céu (DA-03, C2); a neve dos fundos em azul de noite, nunca branca.
- **Dimensões e grade:** 2.560 × 1.024 px cada, repetíveis.
- **Fundo:** transparente acima do recorte.
- **Antes de apresentar, confira:** monte a `GL51_cena.png` com GL50 + GL51 + o terreno provisório e o Daymon a ~91 px; nenhum pedaço de céu vazio maior que um terço da tela; cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL51/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL51 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL52: Fundos da Caverna de Cristal

````markdown
**[GL52] Fundos da Caverna de Cristal**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL52
- **Arquivo(s):** `GL52_caverna_distante.png` e `GL52_caverna_parede.png`
- **Finalidade no jogo:** camadas 1 a 3 da DA-03 na Caverna (x 2.400–4.700, 320 px de altura jogável): fundo distante escuro com veios de cristal lavanda e a parede próxima com colunas de gelo, nichos e cristais grandes atrás do plano do jogo.
- **Ficha v2 de referência:** GL00 (faixa da Caverna de Cristal) e GL04 v2 (cristais ressonantes, para a parede não competir com eles).
- **Escala:** parede próxima com colunas de 2–4 D; cristais grandes de 1–2 D.
- **Orientação:** lateral.
- **Âncora e pivô:** repetíveis na horizontal; a parede com o chão no pé da imagem.
- **Estados e quadros:** 1 imagem cada. Brilho próprio dos cristais contido (os cristais ressonantes e o perigo têm de ser mais claros).
- **Dimensões e grade:** distante 2.048 × 1.024 px; parede 2.048 × 768 px, repetíveis.
- **Fundo:** distante opaco; parede com transparência acima.
- **Antes de apresentar, confira:** monte a `GL52_cena.png` com a Caverna, um poço de névoa e o Daymon a ~91 px; contraste do Daymon ≥ +0,07 (DA-03, C2); cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL52/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL52 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL53: Fundo da Arena do Guardião

````markdown
**[GL53] Fundo da Arena do Guardião**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL53
- **Arquivo(s):** `GL53_arena.png`
- **Finalidade no jogo:** o salão de gelo do chefe (1.400 × 520 px no jogo): paredes de gelo glacial em blocos, colunas, o brilho frio no centro e a abertura do elevador à esquerda.
- **Ficha v2 de referência:** GL00 (faixa da Arena), `GL03_esquema_arena_v2.png` (medidas) e GL03 v2 (o Guardião tem de se destacar do salão).
- **Escala:** na escala do jogo, entregue a 2× (2.800 × 1.040 px).
- **Orientação:** lateral, chão no pé da imagem.
- **Âncora e pivô:** o canto de baixo à esquerda é a borda do poço do elevador (x 7.620 no jogo).
- **Estados e quadros:** 1 imagem. O salão mais escuro que o corpo do Guardião.
- **Dimensões e grade:** 2.800 × 1.040 px.
- **Fundo:** opaco.
- **Antes de apresentar, confira:** monte a `GL53_cena.png` com o Guardião (GL03 v2) e o Daymon na escala do jogo; cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL53/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL53 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL54: Estrutura de fundo no plano do jogo (peças grandes)

````markdown
**[GL54] Estrutura de fundo no plano do jogo (peças grandes)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL54
- **Arquivo(s):** `GL54_estrutura.png` (folha de peças)
- **Finalidade no jogo:** camada 3 da DA-03: o que dá escala e ritmo atrás do jogador, como os troncos e cogumelos gigantes de Verdâmia e as colunas do Laboratório.
- **Ficha v2 de referência:** GL00 e GL04 v2 (observatório). Referência de função: `assets/verdamia/objetos/cogumelo_gigante.png` e `arco_templo.png`.
- **Escala:** faixa grande da DA-03, C4: 3–6 D de altura.
- **Orientação:** lateral.
- **Âncora e pivô:** base no chão de cada peça (cruz no `ENTREGA.md`).
- **Estados e quadros:** 10 peças: 3 pinheiros nevados (alturas diferentes), 2 paredões de rocha com gelo, ruína de estação (colunas e arco), torre de antena caída, 2 pilares de gelo da caverna, coluna da arena. Mais escuras que o plano do jogo (ficam atrás).
- **Dimensões e grade:** células de 1.024 × 1.536 px, 5 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL54/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL54 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL55: Terreno completo de Nivária

````markdown
**[GL55] Terreno completo de Nivária**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL55
- **Arquivo(s):** `GL55_terreno.png` (folha de peças)
- **Finalidade no jogo:** substitui o terreno desenhado por código, que hoje são retângulos com uma faixa de neve (DA-03, C5). É o equivalente ao conjunto de oito peças de Verdâmia (`assets/verdamia/terreno/`).
- **Ficha v2 de referência:** GL00 v2 (superfícies de apoio, materiais e paleta) e o conjunto de Verdâmia (chão com borda viva, subsolo, cantos, borda de parede, plataforma).
- **Escala:** no jogo, a neve do topo tem 18–30 px de espessura e é irregular (montes, rastros, pedras aparecendo). Entregue a 2× da escala do jogo.
- **Orientação:** lateral.
- **Âncora e pivô:** linha do topo marcada em cada peça; peças de canto com o ponto de encontro marcado.
- **Estados e quadros:** chão de neve (topo irregular + face), subsolo de rocha escura, canto esquerdo e direito, borda de parede (lado de um bloco), teto de caverna com pingentes, rampa da Encosta (sobe 400 px em 2.050), plataforma de rocha **com correntes ou suportes de metal das estações** (nada flutua sem motivo), laje de gelo presa na rocha. 10 peças, repetíveis onde fizer sentido.
- **Dimensões e grade:** tiles de 512 × 256 px (chão, teto), 512 × 512 px (subsolo, borda), 1.024 × 256 px (rampa); cantos e plataformas em células de 512 × 384 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** a costura dos tiles não aparece a ~91 px de Daymon; nenhum topo de chão é uma linha reta; cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL55/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL55 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL56: Decoração média e pequena

````markdown
**[GL56] Decoração média e pequena**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL56
- **Arquivo(s):** `GL56_media.png` e `GL56_pequena.png`
- **Finalidade no jogo:** as faixas média e pequena da DA-03, C4: 2–4 peças médias e 6–12 pequenas por tela, como cogumelos, grama e pedras em Verdâmia.
- **Ficha v2 de referência:** GL00 e GL04 v2 (observatório, telescópio, painel), `assets/verdamia/objetos/` (pedra_musgo, grama) como referência de acabamento.
- **Escala:** médias com 1–2 D; pequenas com 0,15–0,5 D.
- **Orientação:** lateral.
- **Âncora e pivô:** base no chão de cada peça.
- **Estados e quadros:** médias (10): rocha nevada grande, monte de neve, pinheiro jovem, telescópio quebrado, poste de sinal da estação, caixa de equipamento coberta de neve, cristal lavanda grande, trenó abandonado, antena, fogueira apagada. Pequenas (14): tufos de capim congelado (3), pedras (3), cristais pequenos (2), pingentes de chão (2), lanterna da estação, placa torta, cabo com neve, pegadas de animal.
- **Dimensões e grade:** médias em células de 512 × 512 px, 5 colunas; pequenas em células de 256 × 256 px, 7 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL56/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL56 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL57: Moldura: o que desce do alto

````markdown
**[GL57] Moldura: o que desce do alto**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL57
- **Arquivo(s):** `GL57_moldura.png`
- **Finalidade no jogo:** DA-03, C3: toda tela tem algo descendo do alto (em Verdâmia, os cipós e raízes penduradas). Em Nivária: galhos de pinheiro com neve, correntes e cabos das estações com gelo, cortinas de pingentes, raízes congeladas na caverna.
- **Ficha v2 de referência:** GL00, GL04 v2 (gancho de teto e corrente) e `assets/verdamia/objetos/raiz_pendurada.png`.
- **Escala:** de 1 a 3 D de comprimento.
- **Orientação:** penduradas, de frente.
- **Âncora e pivô:** ponto de fixação no topo da célula.
- **Estados e quadros:** 8 peças: 2 galhos de pinheiro, 2 correntes com gelo, 2 cortinas de pingentes, cabo partido com lanterna, raiz congelada.
- **Dimensões e grade:** células de 512 × 768 px, 4 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL57/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL57 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL58: Primeiro plano

````markdown
**[GL58] Primeiro plano**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL58
- **Arquivo(s):** `GL58_primeiro_plano.png` e `GL58_primeiro_plano_caverna.png`
- **Finalidade no jogo:** camada 5 da DA-03 (parallax 1,0–1,2): silhuetas escuras na borda de baixo da tela, na frente do jogador, como `assets/verdamia/fundo/fg_vegetacao.png`.
- **Ficha v2 de referência:** GL00 e `assets/verdamia/fundo/fg_vegetacao.png` (altura, densidade e escurecimento).
- **Escala:** faixa de até 1/5 da altura da tela no jogo.
- **Orientação:** lateral.
- **Âncora e pivô:** base reta; repetível na horizontal (o jogo espelha as cópias vizinhas).
- **Estados e quadros:** exterior: montes de neve, rochas e galhos de pinheiro em silhueta azul-marinho quase preta; caverna: rochas e cristais em silhueta. Nunca mais claro que o plano do jogo.
- **Dimensões e grade:** 2.048 × 512 px cada.
- **Fundo:** transparente acima da silhueta.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL58/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL58 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL59: Efeitos de ambiente

````markdown
**[GL59] Efeitos de ambiente**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL59
- **Arquivo(s):** `GL59_neve.png`, `GL59_brilho_cristal.png`, `GL59_poeira_neve.png`, `GL59_rajada.png`
- **Finalidade no jogo:** DA-03, C6: flocos de neve caindo (partícula), o brilho que os cristais lançam no entorno, a poeira de neve ao pousar e correr, e rajadas de vento que passam na Encosta.
- **Ficha v2 de referência:** GL00 e os efeitos de Verdâmia em `assets/verdamia/efeitos/` (poeira).
- **Escala:** flocos de 6–16 px no jogo; poeira de pouso com ~0,8 D de largura; rajada com 2–3 D.
- **Orientação:** lateral.
- **Âncora e pivô:** centro da célula (poeira: centro da base).
- **Estados e quadros:** neve: 4 flocos diferentes · brilho: 1 (gradiente radial lavanda) · poeira: 6 quadros · rajada: 6 quadros (loop).
- **Dimensões e grade:** células de 256 × 256 px, uma folha por efeito.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL59/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL59 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL70: Objetos de Nivária animados (perigos)

````markdown
**[GL70] Objetos de Nivária animados (perigos)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL70
- **Arquivo(s):** `GL70_gelo_fino.png`, `GL70_estalactite.png`, `GL70_cristais.png`, `GL70_nevoa.png`, `GL70_espinhos.png`
- **Finalidade no jogo:** perigos da fase, hoje recortados da GL04: gelo fino (100–110 px de largura no jogo), estalactite (64 px), cristais ressonantes em par chão/teto com arco vertical de 320 px, névoa da fratura no fundo dos poços e espinhos de gelo.
- **Ficha v2 de referência:** `colaboracao/entregas/GL04/GL04_prancha_objetos_v2.png`.
- **Escala:** D = 400 px (o jogo reduz a 0,2275).
- **Orientação:** lateral; cristal de teto é o de chão de cabeça para baixo (pode ser a mesma peça).
- **Âncora e pivô:** gelo fino: topo da placa; estalactite: ponto preso ao teto; cristais: base; névoa: linha de cima; espinhos: base.
- **Estados e quadros:** gelo fino: íntegro, trincas, crítico, rompido + 4 quadros de queda dos cacos · estalactite: parada, tremendo 3, caindo 1, quebrando 4 · cristais: apagado, aviso 2, ativo 2 + arco vertical 6 quadros (loop) · névoa: 8 quadros em loop repetível na horizontal · espinhos: 1 tile repetível.
- **Dimensões e grade:** uma folha por objeto, células de 512 × 512 px (névoa 512 × 256 px), 4 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL70/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL70 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL71: Objetos de Nivária animados (interação e coletáveis)

````markdown
**[GL71] Objetos de Nivária animados (interação e coletáveis)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL71
- **Arquivo(s):** `GL71_braseiro.png`, `GL71_placa_gelo.png`, `GL71_bolas.png`, `GL71_gancho.png`, `GL71_plataformas.png`, `GL71_coletaveis.png`, `GL71_marco.png`
- **Finalidade no jogo:** braseiro (checkpoint de Nivária), placa de gelo que derrete com o Pulso (**alta e estreita**: 70 × 120 px no jogo), bolas de neve (0,5 D e 1,2 D de diâmetro), gancho de teto com suporte e corrente + gancho de rocha solta (Encosta), elevador, plataforma móvel, bloco flutuante, célula/núcleo/registro e o marco de madeira das dicas.
- **Ficha v2 de referência:** GL04 v2 (todas as famílias) e GL00 (madeira e metal das estações).
- **Escala:** D = 400 px. Bola pequena 200 px e grande 480 px de diâmetro; braseiro 0,57 D de altura aceso; gancho com o aro de ~0,28 D.
- **Orientação:** lateral.
- **Âncora e pivô:** peças de chão pela base; gancho pelo centro do aro (é o ponto que o Arpão puxa) e pelo ponto de fixação no teto; bolas pelo centro (giram por código).
- **Estados e quadros:** braseiro: apagado, acendendo 4, aceso 6 (loop) · placa: inteira + derretendo 6 · bolas: inteira, trincando 2, explodindo 6 (cada tamanho) · gancho: aceso/apagado · elevador, plataforma e bloco: 1 cada · célula 6, núcleo 6 e registro 4 (loop, brilho) · marco: 1.
- **Dimensões e grade:** uma folha por família, células de 512 × 512 px, 4 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL71/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL71 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````

---

## GL90: Glifo de Nivária no Arco e ícone de Geada

````markdown
**[GL90] Glifo de Nivária no Arco e ícone de Geada**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a régua **DA-02** (`colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md`), a receita de cena **DA-03** (`colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`; as duas na branch `dev/neve`) e a ficha v2 aprovada indicada abaixo. Esta é uma peça de **produção**: vai direto para o jogo, então o desenho, as cores e o acabamento são os da ficha v2, com bordas suaves e pintadas como a ficha oficial do Daymon (nada de polígono serrilhado nem pixel art).

Régua (resumo): D = 400 px = altura do Daymon; no jogo o Daymon tem ~91 px (fator 0,2275), sempre em escala uniforme. Contorno escuro em no máximo metade da borda, só nas cores frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`. 2–3 tons por material; saturação média 0,20–0,55; S > 0,80 só em energia e perigo, até 10% da área. Foco dos inimigos em vermelho `#E0303A`, 4–10% da silhueta. Paleta de Nivária: a da GL00.

- **ID:** GL90
- **Arquivo(s):** `GL90_glifo.png` e `GL90_geada_hud.png`
- **Finalidade no jogo:** a folha PT13 só tem os glifos do Laboratório, de Verdâmia e do Deserto: o glifo de Nivária (hoje um floco desenhado por código) aparece no painel do Arco e na escolha de destino. O ícone de Geada fica no HUD, ao lado da Integridade.
- **Ficha v2 de referência:** `colaboracao/entregas/PT13/` (estilo dos glifos) e GL01 v2 (geada).
- **Escala:** glifo na célula de 192 × 256 px da PT13, do mesmo tamanho dos outros; ícone de geada com 48 × 48 px.
- **Orientação:** frontal.
- **Âncora e pivô:** centro da célula.
- **Estados e quadros:** glifo apagado (cinza-azulado) e aceso (rosa `#FF8FD0`) · geada: 0, 1, 2 e 3 camadas e congelado (5).
- **Dimensões e grade:** glifo em 384 × 256 px (2 células lado a lado: apagado, aceso); geada em 5 × 1 células de 64 × 64 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:**  cada quadro com a mesma escala e o mesmo ponto de apoio; nada cortado na borda da célula; a sequência lida em loop (quando for loop) sem salto; a mesma peça reduzida a ~91 px de Daymon continua legível sobre a faixa de cena de pior contraste da GL00.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL90/` com um `ENTREGA.md` (lista de quadros, âncoras medidas em pixels, cores por material, a tabela da DA-02 com meta e resultado, confirmação da aprovação, SHA-256 de cada PNG e o que não conseguiu cumprir). Atualize a linha GL90 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit com prefixo `[arte]` na `main`.
````
