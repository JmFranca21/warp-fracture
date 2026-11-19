# Pedido GL (lote 1): fichas e pranchas de Nivária

**Lote 1: fichas de referência.** Fase 3, universo de gelo ([proposta](../../docs/fases/nivaria/proposta_fase3.md)).
**Estado:** GL00 ABERTO. GL04 logo depois da GL00. GL01, GL02 e GL03 SUSPENSOS até o João Marcelo decidir D06–D08 da proposta e aprovar as fichas anteriores.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 19/11/2026
**Diretrizes obrigatórias:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) e [DA-02](../entregas/00_padrao_visual/DA-02_CONSISTENCIA.md), que prevalecem sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez**, nesta ordem: **GL00 → GL04 → GL01 → GL02 → GL03**. Mande cada um só depois de aprovar o anterior: as fichas seguintes usam a paleta e o traço aprovados nas primeiras. **Anexe ao GL00 o esboço de level design** (`docs/fases/nivaria/esboco_level_design.png`). A DA-02 e a proposta ainda não estão no `main`, por isso o essencial vai dentro de cada prompt.

As folhas de animação, cenário e efeitos (lotes 2 e 3) serão pedidas **depois** das fichas aprovadas, com as âncoras, cotas e cores medidas nelas.

---

## GL00: Prancha de referência do universo: Nivária

````markdown
**[GL00] Prancha de referência do universo: Nivária**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02**, que você revisou e o João aprovou (resumo abaixo; ela ainda não está no `main`). A peça precisa parecer desenhada pelo mesmo artista da ficha do Daymon, da Folha de Inimigos do Laboratório Hélix e das peças de Verdâmia. **O Deserto de Ferrugem foi rejeitado por inconsistência**; não use as peças DF como referência de estilo.

**Nivária (Fase 3, universo novo):** um mundo de picos sob uma noite polar sem fim, com auroras cor-de-rosa no céu. O fragmento da Máquina de Dobra caiu no cume e está sugando o calor do mundo. Restam estações de observação abandonadas de um povo que estudava as auroras. Nos poços, uma **névoa roxa** é a fratura vazando do fragmento. Tom: silêncio, solidão e beleza fria. Zonas: Cume Congelado, Caverna de Cristal, Encosta Nevada e Arena do Guardião. O João anexa o esboço de level design desta fase.

Régua DA-02 (resumo):
- **Escala (R1):** D = 400 px = altura do Daymon. Inimigos terrestres 0,55–1,00 D; voadores com A ≥ 0,55 D ou L ≥ 0,70 D (corpo e superfícies visíveis); chefes 2,5–3,5 D; interativos 0,5–1,5 D.
- **Contorno (R3, R9):** em personagens e inimigos, traço escuro em no máximo 50% do perímetro externo, cedendo à luz de recorte; objetos inertes podem fechar a borda com traço fino. Só as amostras frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`, nunca preto. Espessura mediana ≤ 4 px e P90 ≤ 6 px na escala D = 400; detalhes internos não são fechados por linha escura.
- **Tons e saturação (R4, R5):** 2–3 tons por material dominante, 1 em detalhes; até 12 cores efetivas por figura; volume por planos chapados, sem textura espalhada nem degradê; S médio 0,20–0,55; S > 0,80 em até 10% da área sólida, só em energia e perigo.
- **Cena (R6):** fundo jogável com luma média ≤ 0,20; figura com ≥ 0,10 de diferença de luma em ⅔ do contorno; **num mundo de neve, a neve dos planos de fundo fica em azul de noite; o branco só aparece no topo das superfícies jogáveis e em pequenos brilhos**.
- **Foco dos inimigos (R7):** região focal de 4–10% da silhueta, ≥ 0,20 de luma acima do entorno, ≥ 2 px a ~90 px de Daymon, em **vermelho de perigo**, indicando para onde o inimigo ataca.
- **Construção (R10) e montagem (R11):** planos grandes, detalhe só onde há função, luz de recorte numa direção só; a peça é aprovada como entra no jogo.

Paleta-base proposta para Nivária (ajuste na GL00 e use a aprovada depois): céu #0E1630 → #1B2A52; neve na sombra #4F6386, neve #9FB3CF, topo de neve #E6EEF7; gelo #6FA6C4 / #3D6E8E; rocha #2E3550 / #1E2338; cristal da caverna lavanda #7A6FC9; névoa da fratura #6B2FA8 → #B26CEB; aurora e energia do universo **rosa #FF8FD0**; perigo dos inimigos **vermelho #E0303A**; marca do Traje Âncora **ciano #39E6FF** (só no Daymon). Evite o ciano do traje no gelo do cenário: o gelo é azul-acinzentado, menos saturado.

- **ID:** GL00
- **Arquivo(s):** `GL00_prancha_nivaria.png` e `GL00_comparacao.png`
- **Finalidade no jogo:** define a paleta, os materiais e a estrutura de valores de Nivária. Todas as peças da fase (forma, inimigos, chefe, cenário e objetos) seguem esta prancha. Não entra no jogo.
- **Referências obrigatórias do repositório:** `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` e `colaboracao/entregas/VD_verdamia/E1_pedra_musgo.png` (acabamento de objetos aprovados); `colaboracao/entregas/VD_verdamia/E1_cogumelo_gigante.png`, `E1_arco_templo.png` e `E1_tronco_plataforma.png` (como um universo aprovado foi resolvido em formas simples); o esboço de level design anexado pelo João (posição das zonas e dos elementos).
- **Escala:** amostras de material e de plataforma na escala D = 400 px, com a silhueta do Daymon (400 px) ao lado de uma plataforma e de uma parede.
- **Orientação:** cenas vistas de lado, como o jogo.
- **Paleta:** a proposta acima, refinada. Entregue os hex finais por material e função.
- **Dimensões e formato:** PNG de 1536 × 1024 px, prancha com texto permitido (títulos, hex e nomes).
- **Fundo:** azul-marinho escuro chapado nas áreas de amostra; as faixas de cena usam o próprio céu.
- **Âncora e apoio:** a linha do topo das plataformas de amostra fica alinhada com os pés da silhueta do Daymon.
- **Conteúdo e desenho:** (1) **quatro faixas de cena** (cerca de 700 × 160 px cada), uma por zona, só com fundo e chão: **Cume Congelado** (picos ao longe sob a aurora rosa, lua, neve na sombra azul), **Caverna de Cristal** (cristais lavanda nas paredes, poço com a névoa roxa), **Encosta Nevada** (ladeira com o platô no alto, céu aberto) e **Arena do Guardião** (salão de gelo com estalactites, mais escuro, com um brilho frio no centro); (2) **materiais**: neve (topo, face e sombra), gelo (opaco e translúcido), rocha, cristal, madeira e metal das estações antigas, névoa da fratura; para cada um, os 2–3 tons; (3) **plataformas de amostra**: chão de neve, plataforma suspensa de gelo, plataforma de pedra, borda de parede, com a silhueta do Daymon; (4) **cores de função**: aurora/energia do universo (rosa), perigo (vermelho), névoa da fratura (roxo), calor (laranja de brasa, só em fogueiras e na forma do herói), marca do Traje Âncora (ciano); (5) uma faixa **em cinza** das quatro cenas para provar a estrutura de valores.
- **Antes de apresentar, confira:** monte a `GL00_comparacao.png` com uma faixa de cena de Verdâmia ao lado de cada faixa de Nivária, as duas com a silhueta do Daymon a ~90 px; a luma média de cada fundo ≤ 0,20; a silhueta se lê em todas as faixas; o branco da neve só aparece no topo das superfícies jogáveis; o gelo do cenário não usa o ciano do traje; parece o mesmo jogo de Verdâmia e do Laboratório.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL00/`, com um `ENTREGA.md` contendo: lista de vistas ou peças, âncoras medidas em pixels, cores usadas por material e função, a pose e a referência usadas na comparação, e **a tabela da DA-02** com meta e resultado (luma média de cada camada de fundo; contraste local de uma figura de teste (silhueta de Daymon) sobre cada camada; tons por material; S médio e área com S > 0,80; hex do contorno dos objetos). Inclua a confirmação da aprovação, o SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir, com justificativa. Mude a linha GL00 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## GL01: Ficha de personagem: Coruja-de-Geada (forma de Daymon em Nivária)

````markdown
**[GL01] Ficha de personagem: Coruja-de-Geada (forma de Daymon em Nivária)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02**, que você revisou e o João aprovou (resumo abaixo; ela ainda não está no `main`). A peça precisa parecer desenhada pelo mesmo artista da ficha do Daymon, da Folha de Inimigos do Laboratório Hélix e das peças de Verdâmia. **O Deserto de Ferrugem foi rejeitado por inconsistência**; não use as peças DF como referência de estilo.

**Nivária (Fase 3, universo novo):** um mundo de picos sob uma noite polar sem fim, com auroras cor-de-rosa no céu. O fragmento da Máquina de Dobra caiu no cume e está sugando o calor do mundo. Restam estações de observação abandonadas de um povo que estudava as auroras. Nos poços, uma **névoa roxa** é a fratura vazando do fragmento. Tom: silêncio, solidão e beleza fria. Zonas: Cume Congelado, Caverna de Cristal, Encosta Nevada e Arena do Guardião. O João anexa o esboço de level design desta fase.

Régua DA-02 (resumo):
- **Escala (R1):** D = 400 px = altura do Daymon. Inimigos terrestres 0,55–1,00 D; voadores com A ≥ 0,55 D ou L ≥ 0,70 D (corpo e superfícies visíveis); chefes 2,5–3,5 D; interativos 0,5–1,5 D.
- **Contorno (R3, R9):** em personagens e inimigos, traço escuro em no máximo 50% do perímetro externo, cedendo à luz de recorte; objetos inertes podem fechar a borda com traço fino. Só as amostras frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`, nunca preto. Espessura mediana ≤ 4 px e P90 ≤ 6 px na escala D = 400; detalhes internos não são fechados por linha escura.
- **Tons e saturação (R4, R5):** 2–3 tons por material dominante, 1 em detalhes; até 12 cores efetivas por figura; volume por planos chapados, sem textura espalhada nem degradê; S médio 0,20–0,55; S > 0,80 em até 10% da área sólida, só em energia e perigo.
- **Cena (R6):** fundo jogável com luma média ≤ 0,20; figura com ≥ 0,10 de diferença de luma em ⅔ do contorno; **num mundo de neve, a neve dos planos de fundo fica em azul de noite; o branco só aparece no topo das superfícies jogáveis e em pequenos brilhos**.
- **Foco dos inimigos (R7):** região focal de 4–10% da silhueta, ≥ 0,20 de luma acima do entorno, ≥ 2 px a ~90 px de Daymon, em **vermelho de perigo**, indicando para onde o inimigo ataca.
- **Construção (R10) e montagem (R11):** planos grandes, detalhe só onde há função, luz de recorte numa direção só; a peça é aprovada como entra no jogo.

Paleta-base proposta para Nivária (ajuste na GL00 e use a aprovada depois): céu #0E1630 → #1B2A52; neve na sombra #4F6386, neve #9FB3CF, topo de neve #E6EEF7; gelo #6FA6C4 / #3D6E8E; rocha #2E3550 / #1E2338; cristal da caverna lavanda #7A6FC9; névoa da fratura #6B2FA8 → #B26CEB; aurora e energia do universo **rosa #FF8FD0**; perigo dos inimigos **vermelho #E0303A**; marca do Traje Âncora **ciano #39E6FF** (só no Daymon). Evite o ciano do traje no gelo do cenário: o gelo é azul-acinzentado, menos saturado.

> Depende da GL00 aprovada e da decisão D07.

**Forma (DA-02, R2):** a forma não segue a estética do Daymon, e sim a de **Nivária**: é a ave de rapina que caça nos picos. Em Verdâmia, o Lince-Vagalume é muito diferente do Daymon e funciona porque combina com a floresta; aqui vale o mesmo princípio, com outro resultado. O Lince **não** é modelo. Forma e proporção livres, sem proporção de mascote. Regra do GDD: uma **marca ciano do Traje Âncora** continua visível em qualquer forma.

- **ID:** GL01
- **Arquivo(s):** `GL01_ficha_coruja.png` e `GL01_comparacao.png`
- **Finalidade no jogo:** referência oficial da forma de Daymon em Nivária. As folhas de animação (idle, corrida, pulo, queda, planagem, mergulho até o gancho, agarrada no gancho, rajada em três direções, Sacudida Térmica, dano, morte, estados de geada e congelada) serão desenhadas a partir dela. Não entra no jogo.
- **Referências obrigatórias do repositório:** `colaboracao/entregas/GL00/` (paleta e materiais aprovados); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e qualidade de traço); `colaboracao/entregas/VD_verdamia/D0_lince.png` (exemplo de acabamento e de layout de ficha, não de forma).
- **Escala:** D = 400 px. De pé, entre 0,60 D e 1,00 D de altura (240–400 px); asas abertas na planagem com envergadura de 1,6 D a 2,2 D. Indique as cotas na faixa de escala.
- **Orientação:** lateral olhando para a **direita**, frontal e 3/4, de pé; mais uma lateral **planando**, asas abertas.
- **Paleta:** penas de **valor claro** (para ler sobre o céu escuro de Nivária) com sombras frias; **acento quente de brasa** (laranja, de GL00) no interior das asas ou no peito, que mostra o calor interno; a **marca ciano** do traje num lugar fixo (por exemplo, uma faixa na asa ou no peito); olhos sem vermelho (vermelho é dos inimigos). Use os hex da GL00.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido.
- **Fundo:** azul-marinho escuro chapado, como as outras fichas.
- **Âncora e apoio:** garras numa linha de chão comum; cruz na base (âncora do sprite); cruz no **ponto de agarre das garras** (no jogo, é esse ponto que se prende ao gancho); cruz no **ponto de saída da rajada** de penas.
- **Conteúdo e desenho:** as mecânicas que a forma precisa mostrar: (a) **planar**, segurando o pulo, asas bem abertas; (b) **Garra-Gancho**: mergulho até um ponto de gancho e agarrada nele, pendurada pelas garras; (c) **Rajada de Penas**: três penas de gelo em leque curto à frente, para cima ou para baixo; (d) **Sacudida Térmica**: eriça as penas e solta um anel de calor laranja em volta do corpo; (e) a **geada**: o mesmo corpo com 1, 2 e 3 camadas de gelo crescendo nas penas, e **congelada** dentro de um bloco de gelo. Monte: (1) lateral; (2) frontal; (3) 3/4; (4) planando; (5) pendurada no gancho; (6) a Sacudida; (7) os quatro estados de geada lado a lado, pequenos; (8) detalhes: garras, cabeça e a marca ciano; (9) paleta com hex por material e função; (10) faixa de escala com o Daymon em silhueta. **Leitura:** leve, alerta e precisa; uma caçadora, não um bichinho fofo.
- **Antes de apresentar, confira:** monte a `GL01_comparacao.png` com o Daymon a 400 px e o Lince (forma jogável aprovada), apoio alinhado; embaixo, a mesma linha com o Daymon a ~90 px sobre as quatro faixas de cena da GL00, e outra linha só em silhueta. Confira: mesmo artista das peças aprovadas; nativa de Nivária; diferente do Lince em silhueta; a marca ciano aparece a 90 px; a planagem se lê como planagem; os estados de geada se distinguem entre si em tamanho de jogo.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL01/`, com um `ENTREGA.md` contendo: lista de vistas ou peças, âncoras medidas em pixels, cores usadas por material e função, a pose e a referência usadas na comparação, e **a tabela da DA-02** com meta e resultado (A/D, L/D, L/A; hex do contorno; % do perímetro com contorno; espessura mediana e P90; tons por material e cores efetivas; S médio, S dos acentos e área com S > 0,80; contraste local sobre o fundo de Nivária; resultado em jogo). Inclua a confirmação da aprovação, o SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir, com justificativa. Mude a linha GL01 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## GL02: Ficha de inimigos: Gelinho, Drone Gélido e Morcego-de-Cristal

````markdown
**[GL02] Ficha de inimigos: Gelinho, Drone Gélido e Morcego-de-Cristal**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02**, que você revisou e o João aprovou (resumo abaixo; ela ainda não está no `main`). A peça precisa parecer desenhada pelo mesmo artista da ficha do Daymon, da Folha de Inimigos do Laboratório Hélix e das peças de Verdâmia. **O Deserto de Ferrugem foi rejeitado por inconsistência**; não use as peças DF como referência de estilo.

**Nivária (Fase 3, universo novo):** um mundo de picos sob uma noite polar sem fim, com auroras cor-de-rosa no céu. O fragmento da Máquina de Dobra caiu no cume e está sugando o calor do mundo. Restam estações de observação abandonadas de um povo que estudava as auroras. Nos poços, uma **névoa roxa** é a fratura vazando do fragmento. Tom: silêncio, solidão e beleza fria. Zonas: Cume Congelado, Caverna de Cristal, Encosta Nevada e Arena do Guardião. O João anexa o esboço de level design desta fase.

Régua DA-02 (resumo):
- **Escala (R1):** D = 400 px = altura do Daymon. Inimigos terrestres 0,55–1,00 D; voadores com A ≥ 0,55 D ou L ≥ 0,70 D (corpo e superfícies visíveis); chefes 2,5–3,5 D; interativos 0,5–1,5 D.
- **Contorno (R3, R9):** em personagens e inimigos, traço escuro em no máximo 50% do perímetro externo, cedendo à luz de recorte; objetos inertes podem fechar a borda com traço fino. Só as amostras frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`, nunca preto. Espessura mediana ≤ 4 px e P90 ≤ 6 px na escala D = 400; detalhes internos não são fechados por linha escura.
- **Tons e saturação (R4, R5):** 2–3 tons por material dominante, 1 em detalhes; até 12 cores efetivas por figura; volume por planos chapados, sem textura espalhada nem degradê; S médio 0,20–0,55; S > 0,80 em até 10% da área sólida, só em energia e perigo.
- **Cena (R6):** fundo jogável com luma média ≤ 0,20; figura com ≥ 0,10 de diferença de luma em ⅔ do contorno; **num mundo de neve, a neve dos planos de fundo fica em azul de noite; o branco só aparece no topo das superfícies jogáveis e em pequenos brilhos**.
- **Foco dos inimigos (R7):** região focal de 4–10% da silhueta, ≥ 0,20 de luma acima do entorno, ≥ 2 px a ~90 px de Daymon, em **vermelho de perigo**, indicando para onde o inimigo ataca.
- **Construção (R10) e montagem (R11):** planos grandes, detalhe só onde há função, luz de recorte numa direção só; a peça é aprovada como entra no jogo.

Paleta-base proposta para Nivária (ajuste na GL00 e use a aprovada depois): céu #0E1630 → #1B2A52; neve na sombra #4F6386, neve #9FB3CF, topo de neve #E6EEF7; gelo #6FA6C4 / #3D6E8E; rocha #2E3550 / #1E2338; cristal da caverna lavanda #7A6FC9; névoa da fratura #6B2FA8 → #B26CEB; aurora e energia do universo **rosa #FF8FD0**; perigo dos inimigos **vermelho #E0303A**; marca do Traje Âncora **ciano #39E6FF** (só no Daymon). Evite o ciano do traje no gelo do cenário: o gelo é azul-acinzentado, menos saturado.

> Depende da GL01 aprovada: os inimigos são desenhados para se distinguir da Coruja.

- **ID:** GL02
- **Arquivo(s):** `GL02_ficha_inimigos_nivaria.png` e `GL02_comparacao.png`
- **Finalidade no jogo:** referência dos três inimigos comuns de Nivária. As folhas de animação serão redesenhadas a partir dela. Não entra no jogo.
- **Referências obrigatórias do repositório:** `arte_original/00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png` (traço e linguagem de inimigo do jogo: **a referência principal**); `colaboracao/entregas/VD_verdamia/E0_inimigos.png` (nível de detalhe e contorno de inimigos aprovados); `colaboracao/entregas/GL00/` (paleta); `colaboracao/entregas/GL01/` (a Coruja, que os inimigos **não** podem lembrar).
- **Escala:** D = 400 px. **Gelinho:** 0,55–0,65 D de altura. **Drone Gélido:** corpo com L ≥ 0,70 D. **Morcego-de-Cristal:** envergadura ≥ 0,70 D aberto; pendurado, cerca de 0,5 D de altura.
- **Orientação:** lateral olhando para a **direita** (o jogo espelha) e frontal de cada; o Morcego também pendurado de cabeça para baixo.
- **Paleta:** materiais frios de GL00 (neve, gelo, cristal), **mais escuros ou mais claros que o fundo da zona onde vivem**, para separar do cenário; foco **vermelho #E0303A**; a geada que eles soltam em azul-gelo claro, sem o ciano do traje.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido.
- **Fundo:** azul-marinho escuro chapado.
- **Âncora e apoio:** Gelinho com a base numa linha de chão comum (cruz na base e na **boca** do sopro). Drone com cruz no centro do corpo e na **saída da esfera**. Morcego com cruz no **ponto em que se prende ao teto** e no centro do corpo em voo.
- **Conteúdo e desenho:** **Gelinho** (Cume, Caverna, Encosta): bolinha de neve viva com espinhos de gelo, que patrulha o chão. Quando vê Daymon, para e **infla** por 0,5 s (aviso: incha, o foco vermelho acende) e solta um **sopro de geada** em cone curto à frente. Mostre: (1) lateral; (2) frontal; (3) inflado no aviso; (4) soprando. **Drone Gélido** (Cume, Caverna, Encosta): construto de cristal e metal das estações antigas de observação, que ainda patrulha no ar. Ao ver Daymon, o foco vermelho mira e ele solta uma **esfera de geada** lenta, que deixa uma mancha de gelo escorregadio no chão. Mostre: (5) lateral; (6) frontal; (7) mirando com o foco aceso; (8) a esfera e a mancha de gelo. **Morcego-de-Cristal** (Caverna): dorme pendurado no teto e **parece uma estalactite** (só um brilho vermelho pequeno denuncia); quando Daymon passa embaixo, se solta e dá um **rasante em arco**. Mostre: (9) pendurado, ao lado de uma estalactite de verdade da GL04 para comparar; (10) asas abertas no rasante; (11) frontal. Ainda: (12) paleta com hex por material e função; (13) faixa de escala com o Daymon em silhueta e a Coruja.
- **Antes de apresentar, confira:** monte a `GL02_comparacao.png` com o Daymon a 400 px, a Coruja (GL01) e o Rastejador e o Drone da Folha de Inimigos do Laboratório ao lado dos inimigos novos, apoio alinhado; embaixo, a mesma linha com o Daymon a ~90 px sobre a faixa de cena de pior contraste da GL00. Confira: o foco vermelho aparece a 90 px e aponta o ataque; os três se distinguem entre si e da Coruja em silhueta; o Morcego pendurado engana, mas o brilho vermelho se vê; o Drone não fica menor que a cabeça e o tronco do Daymon juntos.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL02/`, com um `ENTREGA.md` contendo: lista de vistas ou peças, âncoras medidas em pixels, cores usadas por material e função, a pose e a referência usadas na comparação, e **a tabela da DA-02** com meta e resultado (A/D, L/D, L/A; hex do contorno; % do perímetro com contorno; espessura mediana e P90; tons por material e cores efetivas; S médio, S dos acentos e área com S > 0,80; contraste local sobre o fundo de Nivária; área, luma e tamanho do foco; resultado em jogo, para cada inimigo). Inclua a confirmação da aprovação, o SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir, com justificativa. Mude a linha GL02 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## GL03: Ficha do chefe: Guardião Glacial, e esquema da arena

````markdown
**[GL03] Ficha do chefe: Guardião Glacial, e esquema da arena**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02**, que você revisou e o João aprovou (resumo abaixo; ela ainda não está no `main`). A peça precisa parecer desenhada pelo mesmo artista da ficha do Daymon, da Folha de Inimigos do Laboratório Hélix e das peças de Verdâmia. **O Deserto de Ferrugem foi rejeitado por inconsistência**; não use as peças DF como referência de estilo.

**Nivária (Fase 3, universo novo):** um mundo de picos sob uma noite polar sem fim, com auroras cor-de-rosa no céu. O fragmento da Máquina de Dobra caiu no cume e está sugando o calor do mundo. Restam estações de observação abandonadas de um povo que estudava as auroras. Nos poços, uma **névoa roxa** é a fratura vazando do fragmento. Tom: silêncio, solidão e beleza fria. Zonas: Cume Congelado, Caverna de Cristal, Encosta Nevada e Arena do Guardião. O João anexa o esboço de level design desta fase.

Régua DA-02 (resumo):
- **Escala (R1):** D = 400 px = altura do Daymon. Inimigos terrestres 0,55–1,00 D; voadores com A ≥ 0,55 D ou L ≥ 0,70 D (corpo e superfícies visíveis); chefes 2,5–3,5 D; interativos 0,5–1,5 D.
- **Contorno (R3, R9):** em personagens e inimigos, traço escuro em no máximo 50% do perímetro externo, cedendo à luz de recorte; objetos inertes podem fechar a borda com traço fino. Só as amostras frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`, nunca preto. Espessura mediana ≤ 4 px e P90 ≤ 6 px na escala D = 400; detalhes internos não são fechados por linha escura.
- **Tons e saturação (R4, R5):** 2–3 tons por material dominante, 1 em detalhes; até 12 cores efetivas por figura; volume por planos chapados, sem textura espalhada nem degradê; S médio 0,20–0,55; S > 0,80 em até 10% da área sólida, só em energia e perigo.
- **Cena (R6):** fundo jogável com luma média ≤ 0,20; figura com ≥ 0,10 de diferença de luma em ⅔ do contorno; **num mundo de neve, a neve dos planos de fundo fica em azul de noite; o branco só aparece no topo das superfícies jogáveis e em pequenos brilhos**.
- **Foco dos inimigos (R7):** região focal de 4–10% da silhueta, ≥ 0,20 de luma acima do entorno, ≥ 2 px a ~90 px de Daymon, em **vermelho de perigo**, indicando para onde o inimigo ataca.
- **Construção (R10) e montagem (R11):** planos grandes, detalhe só onde há função, luz de recorte numa direção só; a peça é aprovada como entra no jogo.

Paleta-base proposta para Nivária (ajuste na GL00 e use a aprovada depois): céu #0E1630 → #1B2A52; neve na sombra #4F6386, neve #9FB3CF, topo de neve #E6EEF7; gelo #6FA6C4 / #3D6E8E; rocha #2E3550 / #1E2338; cristal da caverna lavanda #7A6FC9; névoa da fratura #6B2FA8 → #B26CEB; aurora e energia do universo **rosa #FF8FD0**; perigo dos inimigos **vermelho #E0303A**; marca do Traje Âncora **ciano #39E6FF** (só no Daymon). Evite o ciano do traje no gelo do cenário: o gelo é azul-acinzentado, menos saturado.

> Depende da GL01 e da GL02 aprovadas e da decisão D08.

- **ID:** GL03
- **Arquivo(s):** `GL03_ficha_guardiao.png`, `GL03_esquema_arena.png` e `GL03_comparacao.png`
- **Finalidade no jogo:** referência do chefe de Nivária e da sua arena. As peças do chefe (corpo, braços, placas, núcleo, efeitos de investida, estacas e onda) serão pedidas a partir dela, como peças separadas para montagem. Não entra no jogo.
- **Referências obrigatórias do repositório:** `colaboracao/entregas/VD_verdamia/E_rainha_idle_1.png` (o chefe aprovado: escala, contorno e acabamento); `colaboracao/entregas/VD_verdamia/VD_fragmento.png` (o fragmento, que fica no peito do Guardião); `colaboracao/entregas/GL00/`, `GL01/` e `GL02/`.
- **Escala:** D = 400 px. O Guardião mede **3,0 D** de altura (1.200 px). Na ficha, desenhe em **meia escala** (D = 200 px, Guardião com 600 px) e escreva as cotas reais. A arena mede ~1.400 px de largura no jogo (~15 D).
- **Orientação:** frontal (como ele fica a maior parte da luta) e lateral olhando para a **esquerda** (de onde Daymon entra).
- **Paleta:** gelo glacial de GL00 em blocos grandes e **mais escuro que o salão** no corpo, para o chefe não sumir no fundo; olhos em **vermelho de perigo**; o fragmento no peito com a cor dele e um brilho frio; as três **placas de gelo** sobre o peito um pouco mais claras, para o jogador saber onde mirar.
- **Dimensões e formato:** `GL03_ficha_guardiao.png` em 1536 × 1024 px; `GL03_esquema_arena.png` em 1536 × 768 px. Texto permitido.
- **Fundo:** azul-marinho escuro chapado na ficha; o esquema usa a cena da Arena da GL00.
- **Âncora e apoio:** pés numa linha de chão comum; cruzes na base, nos **ombros** (os braços são peças separadas) e no **centro do peito** (núcleo e placas).
- **Conteúdo e desenho:** o Guardião é o inverno de Nivária tomando forma em volta do fragmento: um colosso de gelo glacial em blocos grandes, pesado e antigo, **sem ser vilão**. Ele protege o cume por instinto. Mostre na ficha: (1) frontal; (2) lateral; (3) o peito em detalhe com as **três placas** e o núcleo exposto depois de derreter uma, duas e três placas; (4) poses de **Investida** (aviso: bate os pés; corrida curvado), **Estacas de Gelo** (crava o punho no chão) e **Onda de Gelo** (sopro rente ao chão); (5) **atordoado** depois de bater na parede; (6) a derrota: o gelo racha e se desfaz em neve, deixando o fragmento flutuando; (7) paleta com hex por material e função; (8) faixa de escala com o Daymon em silhueta e a Coruja. No **esquema da arena**: chão plano entre duas paredes, o elevador de chegada, o Braseiro no canto, **dois pontos de gancho no teto**, a fileira de estalactites, o percurso da Investida, uma fileira de estacas com as rachaduras de aviso e a altura da Onda de Gelo em relação à Coruja planando.
- **Antes de apresentar, confira:** monte a `GL03_comparacao.png` com o Daymon a 400 px, a Rainha Micélia e o Guardião na mesma escala, apoio alinhado; embaixo, a mesma linha com o Daymon a ~90 px sobre a cena da Arena. Confira: mesmo artista da Rainha; o corpo se separa do salão; as placas do peito chamam o olhar sem competir com os olhos; nenhuma faixa de aviso decorativa; o Guardião fica entre 2,5 D e 3,5 D.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL03/`, com um `ENTREGA.md` contendo: lista de vistas ou peças, âncoras medidas em pixels, cores usadas por material e função, a pose e a referência usadas na comparação, e **a tabela da DA-02** com meta e resultado (A/D, L/D, L/A; hex do contorno; % do perímetro com contorno; espessura mediana e P90; tons por material e cores efetivas; S médio, S dos acentos e área com S > 0,80; contraste local sobre o fundo de Nivária; área, luma e tamanho do foco; resultado em jogo). Inclua a confirmação da aprovação, o SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir, com justificativa. Mude a linha GL03 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## GL04: Prancha de objetos, perigos e coletáveis de Nivária

````markdown
**[GL04] Prancha de objetos, perigos e coletáveis de Nivária**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02**, que você revisou e o João aprovou (resumo abaixo; ela ainda não está no `main`). A peça precisa parecer desenhada pelo mesmo artista da ficha do Daymon, da Folha de Inimigos do Laboratório Hélix e das peças de Verdâmia. **O Deserto de Ferrugem foi rejeitado por inconsistência**; não use as peças DF como referência de estilo.

**Nivária (Fase 3, universo novo):** um mundo de picos sob uma noite polar sem fim, com auroras cor-de-rosa no céu. O fragmento da Máquina de Dobra caiu no cume e está sugando o calor do mundo. Restam estações de observação abandonadas de um povo que estudava as auroras. Nos poços, uma **névoa roxa** é a fratura vazando do fragmento. Tom: silêncio, solidão e beleza fria. Zonas: Cume Congelado, Caverna de Cristal, Encosta Nevada e Arena do Guardião. O João anexa o esboço de level design desta fase.

Régua DA-02 (resumo):
- **Escala (R1):** D = 400 px = altura do Daymon. Inimigos terrestres 0,55–1,00 D; voadores com A ≥ 0,55 D ou L ≥ 0,70 D (corpo e superfícies visíveis); chefes 2,5–3,5 D; interativos 0,5–1,5 D.
- **Contorno (R3, R9):** em personagens e inimigos, traço escuro em no máximo 50% do perímetro externo, cedendo à luz de recorte; objetos inertes podem fechar a borda com traço fino. Só as amostras frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`, nunca preto. Espessura mediana ≤ 4 px e P90 ≤ 6 px na escala D = 400; detalhes internos não são fechados por linha escura.
- **Tons e saturação (R4, R5):** 2–3 tons por material dominante, 1 em detalhes; até 12 cores efetivas por figura; volume por planos chapados, sem textura espalhada nem degradê; S médio 0,20–0,55; S > 0,80 em até 10% da área sólida, só em energia e perigo.
- **Cena (R6):** fundo jogável com luma média ≤ 0,20; figura com ≥ 0,10 de diferença de luma em ⅔ do contorno; **num mundo de neve, a neve dos planos de fundo fica em azul de noite; o branco só aparece no topo das superfícies jogáveis e em pequenos brilhos**.
- **Foco dos inimigos (R7):** região focal de 4–10% da silhueta, ≥ 0,20 de luma acima do entorno, ≥ 2 px a ~90 px de Daymon, em **vermelho de perigo**, indicando para onde o inimigo ataca.
- **Construção (R10) e montagem (R11):** planos grandes, detalhe só onde há função, luz de recorte numa direção só; a peça é aprovada como entra no jogo.

Paleta-base proposta para Nivária (ajuste na GL00 e use a aprovada depois): céu #0E1630 → #1B2A52; neve na sombra #4F6386, neve #9FB3CF, topo de neve #E6EEF7; gelo #6FA6C4 / #3D6E8E; rocha #2E3550 / #1E2338; cristal da caverna lavanda #7A6FC9; névoa da fratura #6B2FA8 → #B26CEB; aurora e energia do universo **rosa #FF8FD0**; perigo dos inimigos **vermelho #E0303A**; marca do Traje Âncora **ciano #39E6FF** (só no Daymon). Evite o ciano do traje no gelo do cenário: o gelo é azul-acinzentado, menos saturado.

> Depende da GL00 aprovada. Vem antes da GL01: a GL02 compara o Morcego com a estalactite desta prancha.

- **ID:** GL04
- **Arquivo(s):** `GL04_prancha_objetos.png` e `GL04_comparacao.png`
- **Finalidade no jogo:** referência de todos os objetos interativos e perigos da fase. As folhas e peças finais serão pedidas a partir dela. **No Deserto, placas, estações e coletáveis acabaram com o visual do Laboratório; aqui tudo é próprio de Nivária.** Não entra no jogo.
- **Referências obrigatórias do repositório:** `colaboracao/entregas/GL00/` (paleta e materiais); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` e `colaboracao/entregas/VD_verdamia/E1_pedra_musgo.png` (acabamento de objetos aprovados); `colaboracao/entregas/VD_verdamia/E1_altar.png` (um objeto interativo aprovado).
- **Escala:** D = 400 px, com a silhueta do Daymon ao lado. Interativos entre 0,5 D e 1,5 D.
- **Orientação:** vista lateral, como no jogo.
- **Paleta:** a da GL00. Perigos com vermelho ou roxo da fratura; energia do universo em rosa; calor em laranja de brasa.
- **Dimensões e formato:** PNG de 1536 × 1024 px, prancha com texto permitido.
- **Fundo:** azul-marinho escuro chapado.
- **Âncora e apoio:** cada peça com a cruz da âncora marcada (base para peças de chão, ponto de fixação para peças de teto).
- **Conteúdo e desenho:** (1) **Gelo fino**, plataforma quebradiça em quatro estados: inteira, rachadura 1, rachadura 2 e quebrando; (2) **Estalactite** parada, tremendo e quebrada no chão; (3) **Cristal Ressonante**: par de cristais lavanda nos estados apagado, aviso e ativo, com o arco de energia rosa entre eles; (4) **Névoa da Fratura**: amostra da névoa roxa no fundo de um poço; (5) **Cristais de gelo** (espinhos de chão); (6) **Bloco flutuante** e **plataforma móvel** de gelo e pedra; (7) **Placa de gelo** que bloqueia passagens, inteira e derretendo; (8) **mancha de gelo escorregadio** no chão; (9) **Bolas de neve** pequena (0,5 D) e grande (1,2 D), rolando e se desfazendo; (10) **Ponto de gancho** de Nivária: uma argola ou cristal preso na rocha, com o anel **ciano** que já marca os ganchos no jogo; (11) **Braseiro**, o checkpoint do universo: fogueira de pedra e metal das estações antigas, apagado e aceso; (12) **Elevador** de gelo e metal até a arena; (13) **Estação de observação** abandonada (painel e telescópio quebrados), onde ficam os Registros; (14) **Célula de Fase**, **Núcleo de Integridade** e **Registro** com o visual de Nivária, mantendo a forma que o jogador já conhece; (15) **Estacas de gelo** do chefe saindo do chão, com a rachadura de aviso.
- **Antes de apresentar, confira:** monte a `GL04_comparacao.png` com o Daymon a 400 px, a pedra de musgo e o altar de Verdâmia ao lado das peças novas; embaixo, a mesma linha com o Daymon a ~90 px sobre a faixa de cena de pior contraste da GL00. Confira: cada perigo se lê como perigo; o gelo fino se distingue do chão firme; a estalactite que cai se distingue da decorativa só pelo tremor; o ponto de gancho se acha a 90 px; nada lembra o Laboratório nem o Deserto.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/GL04/`, com um `ENTREGA.md` contendo: lista de vistas ou peças, âncoras medidas em pixels, cores usadas por material e função, a pose e a referência usadas na comparação, e **a tabela da DA-02** com meta e resultado (contraste local de uma figura de teste (silhueta de Daymon) sobre as faixas de cena; tons por material; S médio e área com S > 0,80; hex do contorno dos objetos). Inclua a confirmação da aprovação, o SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir, com justificativa. Mude a linha GL04 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````
