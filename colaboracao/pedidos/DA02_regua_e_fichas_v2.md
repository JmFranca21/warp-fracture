# Pedido DA-02: régua de consistência e fichas v2 do Deserto

**Lote 0: correção de estilo.** Saída da [auditoria de consistência do Deserto](../../docs/auditoria_deserto/) (17/11/2026).
**Estado:** prompt 1 RESPONDIDO pelo ChatGPT (17/11/2026) e consolidado na DA-02 final. Prompts 2 e 3 SUSPENSOS até o João aprovar a DA-02 final.
**Depende de:** [DA-02 (proposta)](../entregas/00_padrao_visual/DA-02_CONSISTENCIA.md).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 17/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) e, depois de aprovada, a DA-02. As duas prevalecem sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez**, na ordem. A DA-02 ainda não está no `main` do GitHub, por isso o texto essencial dela vai dentro de cada prompt. Os prompts 2 e 3 já usam a versão final (com R9–R11 e a tabela de evidência do ChatGPT).

---

## 1. DA-02: revisão pelo diretor de arte

````markdown
**[DA-02] Revisão da régua de consistência visual**

Você é o diretor de arte do Warp Fracture. A fase do Deserto de Ferrugem foi rejeitada pelo João Marcelo: os assets variam de estilo entre si e não combinam com o Laboratório e Verdâmia. A auditoria (pranchas lado a lado na escala do jogo) achou **três famílias visuais**:

1. **Laboratório e Verdâmia (aprovadas):** figuras esguias, feitas por blocos de cor, contorno escuro só em parte da borda (19% a 46%) e sempre **frio** (azul-marinho ou violeta, ex.: #253045, #302389, #372e4c), fundo de cena escuro (luminosidade média 0,10–0,16).
2. **DF00/DF01 (Robô, Drone, cenário):** marrom barrento, contorno fechado preto-marrom (#221513), robô sem ponto de leitura e escuro sobre fundo marrom.
3. **DF02/DF03 e lotes 2–3 (Autômato, Forja-Mãe):** proporção de brinquedo (Autômato com largura 0,76 da altura), contorno grosso e fechado em 95% da borda, preto-marrom quente (#23191a), listras de aviso decorativas.

Também havia culpa nos pedidos (a DF02 pedia tronco em barril e 0,8 D de largura) e na integração (peças esticadas). Para não repetir, propus a **DA-02**, uma régua numérica que complementa a DA-01. O resumo:

- **R1 Escala:** D = 400 px = altura do Daymon. Inimigos comuns 0,55–1,0 D; voadores ≥ 0,55 D de altura ou ≥ 0,7 D de largura; chefes 2,5–3,5 D; objetos interativos 0,5–1,5 D. Escala sempre uniforme no jogo.
- **R2 Formas do Daymon:** a forma não precisa seguir a estética do Daymon; ela segue a estética do universo em que aparece, como um ser nativo dali. O Lince-Vagalume é o exemplo: muito diferente do Daymon, e funciona porque combina com Verdâmia. Ele é exemplo do princípio, não modelo para as outras formas. Vale para todas o resto da régua e a leitura de jogo (a forma se distingue dos inimigos da fase).
- **R3 Contorno:** personagens e inimigos sem traço preto em volta; contorno escuro em no máximo metade da borda, sumindo na luz de recorte. Cor do contorno sempre fria (#1d2a3c a #372e4c, azul ≥ vermelho), **nunca preto puro nem marrom-preto**, nem em ferrugem. Objetos de cenário podem ter contorno fechado, fino e frio.
- **R4 Tons:** 2–3 tons por superfície, sem degradê nem ruído; até 12 cores efetivas por figura.
- **R5 Saturação:** média 0,20–0,55; picos acima de 0,8 só em acentos de energia, até 10% da área. Listras de aviso só em perigo real.
- **R6 Valores da cena:** fundo de jogo escuro (luminosidade média ≤ 0,20); figuras mais claras ou de matiz diferente do fundo; universo quente usa fundo quente escuro e personagens com sombras frias.
- **R7 Ponto de leitura:** todo inimigo tem um ponto de alto contraste (olho, núcleo) de 4–10% da silhueta, em vermelho de perigo ou energia própria, nunca da cor do fundo.
- **R8 Paleta comum:** uma família de material por universo + o azul-marinho comum do jogo (#0f1422 a #253045) nas sombras e contornos.
- **Verificação nova:** toda entrega traz `<ID>_comparacao.png` (a peça ao lado do Daymon e de uma peça aprovada do mesmo tipo, em D = 400 px, e a mesma linha reduzida à escala do jogo, Daymon com ~90 px, sobre o fundo da fase) e, no `ENTREGA.md`, a tabela da régua preenchida (altura em D, largura/altura, cor do contorno em hex, parte da borda com contorno, tons por superfície, saturação dos acentos, ponto de leitura).

Peças aprovadas usadas como base (estão no `main`): `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png`, `colaboracao/entregas/VD_verdamia/D0_lince.png`, `E0_inimigos.png`, `E_esporangio_idle.png`, `E_mariposa_fly.png`, `E_rainha_idle_1.png`, `E1_pedra_musgo.png`, `colaboracao/entregas/A0_ficha_eco/`, e `colaboracao/entregas/PT10/` (arco do portal, aprovado como objeto).

**O que preciso de você (só texto, nenhuma imagem):**

- Olhe as peças aprovadas e as do Deserto (`colaboracao/entregas/DF01/`, `DF02/`, `DF90/`, `DF100/`) e diga se concorda com o diagnóstico das três famílias.
- Revise cada regra R1–R8: **manter**, **ajustar** (diga o número novo e por quê) ou **retirar**. Aponte qualquer regra que, cumprida à risca, ainda deixaria passar a inconsistência.
- Diga se falta alguma regra (por exemplo, espessura de traço, forma dos olhos dos inimigos, linguagem de rebites e chapas).
- Diga como você vai medir cada número antes de apresentar uma peça (o que dá para conferir a olho e o que precisa de ferramenta).
- Responda num bloco Markdown que eu possa colar no documento. **Não mude nenhum arquivo do repositório** nem gere arte agora: o João decide primeiro, e as fichas novas (DF02 v2 e DF01 v2) vêm em seguida.
````

---

## 2. DF02 v2: ficha do Autômato refeita na régua

> **Enviar depois que o João aprovar a DA-02 final.** Já está com os números revisados pelo ChatGPT.

````markdown
**[DF02 v2] Ficha de personagem: Autômato (redesenho na régua DA-02)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02**, que você revisou e o João aprovou (resumo abaixo). **A DF02 anterior foi rejeitada** pelo João: proporção de brinquedo, tronco em barril, contorno fechado preto-marrom e excesso de chapas, rebites e chanfros. Não a use como referência. O conceito continua: no Deserto de Ferrugem, o Traje Âncora transforma Daymon numa **máquina magnetizada**. O desenho é novo.

**Forma (R2):** a forma não precisa seguir a estética do Daymon, e sim a do **Deserto de Ferrugem**, como uma máquina nativa daquele mundo de fábricas abandonadas, sucata e ímãs. Em Verdâmia, o Lince-Vagalume é muito diferente do Daymon e funciona porque combina com a floresta; aqui vale o mesmo princípio, com outro resultado. O Lince **não** é modelo para esta forma. A silhueta é livre (bípede, quadrúpede, aracnídea, sobre rodas...). A ficha não fixa largura, mas a proporção de brinquedo (cabeça enorme, tronco em barril, pernas curtas e grossas, pés gigantes) não volta. A forma se distingue dos robôs inimigos pelo conjunto de silhueta, postura e ação, **em silhueta, a ~90 px e sem depender do rosto**.

Régua DA-02 (resumo da versão aprovada):
- **Contorno (R3, R9):** traço escuro em no máximo 50% do perímetro externo, cedendo à luz de recorte; só as amostras frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`, nunca preto nem marrom-preto, mesmo na ferrugem; espessura mediana ≤ 4 px e P90 ≤ 6 px na ficha; **rebites e placas não são fechados por linha escura** (uma junta pode ter linha).
- **Tons e saturação (R4, R5):** 2–3 tons por material dominante, 1 em detalhes; até 12 cores efetivas no corpo; volume por planos chapados, desgaste em manchas localizadas; S médio 0,20–0,55 e S > 0,80 em até 10% da área sólida, só em energia e perigo; listras só em perigo real.
- **Construção (R10):** chapas em planos grandes; rebite só onde há união; reduzir aros concêntricos, chanfros repetidos e molduras em volta de cada placa; luz de recorte numa direção só.
- **Cena (R6):** a figura precisa de ≥ 0,10 de diferença de luma em pelo menos ⅔ do contorno sobre o fundo do Deserto, que é quente; sombras frias na figura.
- **Montagem (R11):** a peça é aprovada como entra no jogo, com pivôs e encaixes conferidos.

- **ID:** DF02 v2
- **Arquivo(s):** `DF02_ficha_automato_v2.png` e `DF02_comparacao.png`
- **Finalidade no jogo:** referência oficial da forma de Daymon no Deserto de Ferrugem. As folhas do Autômato (DF90–DF97) serão redesenhadas a partir dela. Não entra no jogo.
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (materiais e clima do Deserto); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e qualidade de traço); `colaboracao/entregas/VD_verdamia/D0_lince.png` (exemplo de acabamento e de layout de ficha, não de forma); `colaboracao/entregas/DF01/DF01_ficha_inimigos_deserto.png` (o Robô, para o teste de distinção); `colaboracao/entregas/DF57/DF57_ponto_gancho.png` (argola com anel ciano, que o ímã puxa).
- **Escala:** D = 400 px. Altura entre 0,60 D e 1,10 D (240–440 px); escolha a que servir à silhueta e indique a cota na faixa de escala.
- **Orientação:** vista lateral olhando para a **direita**, vista frontal e vista 3/4.
- **Paleta:** livre dentro do Deserto e da régua. Sombras frias, nunca marrom-preto. Sem vermelho nos olhos ou luzes principais: vermelho é a cor de perigo dos inimigos. O visor ou os olhos se distinguem da lente dos inimigos mesmo em cinza.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido.
- **Fundo:** azul-marinho escuro chapado, como as outras fichas.
- **Âncora e apoio:** pés (ou rodas) numa linha de chão comum em todas as vistas; cruz na base (âncora do sprite) e cruz no **pivô do ímã** (no jogo o ímã gira em torno desse ponto para mirar em 8 direções).
- **Conteúdo e desenho:** as mecânicas que a forma precisa mostrar: (a) um **ímã** que dispara um feixe e puxa drones e argolas, e que precisa poder girar e mirar; (b) um **pulso magnético** em volta do corpo, que derruba os drones e paralisa os robôs por 2 s (indique de onde ele sai); (c) o **Arranque**, uma investida rápida no chão. Monte: (1) lateral; (2) frontal; (3) 3/4; (4) detalhes do ímã e de um ou dois elementos marcantes; (5) paleta com hex por material e função; (6) faixa de escala com Daymon em silhueta ao lado.
- **Antes de apresentar, confira:** monte a `DF02_comparacao.png` com Daymon a 400 px, o Lince (forma jogável aprovada) e o Robô da DF01 (teste de distinção), apoio alinhado; embaixo, a mesma linha com Daymon a ~90 px sobre um recorte da cena do Deserto, e outra linha só em silhueta. Confira: parece desenhado pelo mesmo artista das peças aprovadas; parece nativo do Deserto; nenhuma parte lembra o Autômato antigo; se distingue do Robô em silhueta; o ímã fica no pivô marcado em espera e em ação.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF02/` (o v1 continua lá como histórico), com o `ENTREGA.md` atualizado contendo: vistas, âncoras medidas em pixels, cores usadas, a pose e a referência usadas na comparação, e **a tabela da DA-02** com meta e resultado para: A/D, L/D, L/A; hex do contorno; % do perímetro com contorno; espessura mediana e P90; tons por material e cores efetivas; S médio, S dos acentos e área com S > 0,80; contraste local sobre o fundo do Deserto; resultado em jogo (silhueta e distinção). Inclua a confirmação da aprovação, o SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir, com justificativa. Mude a linha DF02 do `colaboracao/STATUS.md` para `ENTREGUE (v2)`. Commit com prefixo `[arte]`.
````

---

## 3. DF01 v2: ficha do Robô e do Drone refeita na régua

> **Enviar depois que a DF02 v2 for aprovada** (os inimigos são desenhados para se distinguir do herói novo).

````markdown
**[DF01 v2] Ficha de inimigos: Robô e Drone do Deserto (refeita na régua DA-02)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02**, que você revisou e o João aprovou (resumo abaixo). A peça precisa parecer desenhada pelo mesmo artista da Folha de Inimigos do Laboratório Hélix e dos inimigos de Verdâmia. **A DF01 anterior foi rejeitada**: contorno fechado preto-marrom (#221513), carcaça do Robô na mesma faixa de cor e valor da parede do Deserto (a lente aparece, o corpo some), e o Drone pequeno demais (0,35 D × 0,60 D).

Régua DA-02 (resumo da versão aprovada):
- **Contorno (R3, R9):** traço escuro em no máximo 50% do perímetro externo, cedendo à luz de recorte; só as amostras frias `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C`, nunca preto nem marrom-preto, mesmo na ferrugem; espessura mediana ≤ 4 px e P90 ≤ 6 px na ficha; **rebites e placas não são fechados por linha escura** (uma junta pode ter linha).
- **Tons e saturação (R4, R5):** 2–3 tons por material dominante, 1 em detalhes; até 12 cores efetivas no corpo; volume por planos chapados, desgaste em manchas localizadas; S médio 0,20–0,55 e S > 0,80 em até 10% da área sólida, só em energia e perigo; listras só em perigo real.
- **Construção (R10):** chapas em planos grandes; rebite só onde há união; reduzir aros concêntricos, chanfros repetidos e molduras em volta de cada placa; luz de recorte numa direção só.
- **Cena (R6):** a figura precisa de ≥ 0,10 de diferença de luma em pelo menos ⅔ do contorno sobre o fundo do Deserto, que é quente; sombras frias na figura.
- **Montagem (R11):** a peça é aprovada como entra no jogo, com pivôs e encaixes conferidos.
- **Escala (R1):** voador com A ≥ 0,55 D ou L ≥ 0,70 D, medindo o corpo e as superfícies visíveis, não a hélice solta.
- **Foco (R7):** cada inimigo tem uma região focal de 4–10% da silhueta sólida, com ≥ 0,20 de diferença de luma para o entorno e ≥ 2 px no eixo menor a ~90 px de Daymon. O foco indica a ameaça: canhão e lente frontais no Robô (tiro horizontal), lente embaixo no Drone (tiro para baixo). **Não use laranja nem âmbar no foco** (é a cor do fundo do Deserto); use vermelho de perigo.

- **ID:** DF01 v2
- **Arquivo(s):** `DF01_ficha_inimigos_deserto_v2.png` e `DF01_comparacao.png`
- **Finalidade no jogo:** referência dos dois inimigos comuns do Deserto. As folhas de animação (DF60–DF71) serão redesenhadas a partir dela. Não entra no jogo.
- **Referências obrigatórias do repositório:** `arte_original/00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png` (traço e linguagem de robô do jogo: **a referência principal**; a Turreta para leitura de arma, o Drone para o voador); `colaboracao/entregas/VD_verdamia/E0_inimigos.png` (nível de detalhe e contorno dos inimigos aprovados); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala); `colaboracao/entregas/DF02/` (a forma do herói no Deserto, versão v2: os inimigos **não** podem lembrá-la).
- **Escala:** D = 400 px. **Robô: 0,80 D (320 px) de altura.** **Drone: 0,60 D (240 px) de largura** e cerca de 0,50 D de altura, sem contar as hélices.
- **Orientação:** vista lateral olhando para a **direita** (o jogo espelha) e uma vista frontal de cada.
- **Paleta (R8):** ferrugem na face exposta das chapas, **mais clara e mais cinza** que a parede do Deserto (por exemplo #9a6a4e e #6e4a3e); ferro frio nas juntas e cavidades (#4a5060, #2a2f40); sombra fria #3a3346; foco **vermelho #e0303a** com brilho #ff8a80. Contorno só nas amostras frias aprovadas.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido, no layout da DF01 anterior.
- **Fundo:** azul-marinho escuro chapado.
- **Âncora e apoio:** Robô com os pés numa linha de chão comum; cruz na base entre os pés e cruz na **boca do canhão**. Drone com cruz no centro do corpo (âncora de voo), na **lente de tiro** e no **ponto onde o ímã puxa** (uma argola ou placa magnética no topo).
- **Conteúdo e desenho:** **Robô:** sentinela de sucata da fábrica que patrulha e atira na horizontal, com aviso de 0,5 s antes de cada tiro. Corpo atarracado de chapa em planos grandes, duas pernas curtas e articuladas, canhão frontal e lente vermelha. Mostre: (1) lateral; (2) frontal; (3) a lente em detalhe nos estados normal, **aviso de tiro** (acesa) e apagada; (4) a pose **paralisada** pelo pulso magnético do herói (2 s, faíscas contidas, lente piscando). **Drone:** patrulha no alto e atira para baixo. Corpo redondo de chapa, duas hélices laterais, lente vermelha embaixo, argola magnética no topo. Mostre: (5) lateral; (6) frontal; (7) a pose **derrubado no chão**, atordoado (o pulso e o feixe do ímã o derrubam). Ainda: (8) paleta com hex por material e função; (9) faixa de escala com Daymon em silhueta (400 px), o Robô e o Drone. Silhueta diferente do Autômato v2.
- **Antes de apresentar, confira:** monte a `DF01_comparacao.png` com Daymon a 400 px, a Turreta do Laboratório ao lado do Robô e o Drone do Laboratório ao lado do Drone novo, apoio alinhado; embaixo, a mesma linha com Daymon a ~90 px **sobre o recorte da cena do Deserto de pior contraste** (parede de ferrugem). Confira: o corpo inteiro do Robô se lê sobre a parede, não só a lente; o foco aparece a 90 px e aponta a direção do tiro; o Drone não fica menor que a cabeça e o tronco do Daymon juntos; nenhum rebite ou placa fechado por linha escura.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF01/` (o v1 continua lá como histórico), com o `ENTREGA.md` atualizado contendo: vistas, âncoras medidas em pixels, cores usadas, a pose e a referência usadas na comparação, e **a tabela da DA-02** com meta e resultado para: A/D, L/D, L/A; hex do contorno; % do perímetro com contorno; espessura mediana e P90; tons por material e cores efetivas; S médio, S dos acentos e área com S > 0,80; contraste local sobre o fundo do Deserto; área e tamanho do foco de cada inimigo; resultado em jogo (silhueta e distinção). Inclua a confirmação da aprovação, o SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir, com justificativa. Mude a linha DF01 do `colaboracao/STATUS.md` para `ENTREGUE (v2)`. Commit com prefixo `[arte]`.
````
