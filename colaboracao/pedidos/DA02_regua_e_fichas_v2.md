# Pedido DA-02: régua de consistência e fichas v2 do Deserto

**Lote 0: correção de estilo.** Saída da [auditoria de consistência do Deserto](../../docs/auditoria_deserto/) (17/11/2026).
**Estado:** ABERTO para o prompt 1. Os prompts 2 e 3 ficam SUSPENSOS até o João Marcelo aprovar a DA-02 (com ou sem os ajustes do ChatGPT).
**Depende de:** [DA-02 (proposta)](../entregas/00_padrao_visual/DA-02_CONSISTENCIA.md).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 17/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) e, depois de aprovada, a DA-02. As duas prevalecem sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez**, na ordem. A DA-02 ainda não está no `main` do GitHub, por isso o texto essencial dela vai dentro de cada prompt.

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
- **R2 Formas do Daymon:** ~4,5–5 cabeças, ombros ~0,3 da altura; toda forma (Lince, Autômato, próximas) tem largura ≤ 0,45 da altura, mãos e pés ≤ 1,3× os do Daymon, e o rosto com os mesmos olhos ovais pretos e a franja.
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

> **Enviar só depois que o João aprovar a DA-02.** Se o ChatGPT ajustou números no prompt 1, troque os números abaixo pelos aprovados antes de enviar.

````markdown
**[DF02 v2] Ficha de personagem: Autômato (refeita na régua DA-02)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02** aprovada pelo João Marcelo (texto abaixo, caso ainda não esteja no `main`). A peça precisa parecer desenhada pelo mesmo artista da ficha do Daymon e do Lince-Vagalume. **A DF02 anterior foi rejeitada** por proporção de mascote (largura 0,76 da altura), contorno fechado preto-marrom e cor de material dominando o herói. Não a use como referência de estilo, só de ideia.

Régua DA-02 que esta peça precisa cumprir: altura 1,0–1,1 D (D = 400 px = altura do Daymon); largura ≤ 0,45 da altura sem o braço; mãos e pés ≤ 1,3× os do Daymon; contorno escuro em no máximo metade da borda, sempre frio (azul-marinho #1d2a3c a #253045), nunca preto nem marrom; 2–3 tons por superfície, sem ruído nem degradê; até 12 cores efetivas; saturação média 0,20–0,55, picos só no ciano do Traje Âncora (≤ 10% da área); sombras frias mesmo na ferrugem.

- **ID:** DF02 v2
- **Arquivo(s):** `DF02_ficha_automato_v2.png` e `DF02_comparacao.png`
- **Finalidade no jogo:** referência oficial da forma de Daymon no Deserto de Ferrugem. As 7 folhas do Autômato (DF90–DF97) serão redesenhadas a partir dela. Não entra no jogo.
- **Referências obrigatórias do repositório:** `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (proporção, rosto, traço: **a referência principal**); `colaboracao/entregas/VD_verdamia/D0_lince.png` (a outra forma de Daymon: mesmo nível de detalhe e mesmo tipo de contorno); `colaboracao/entregas/DF57/DF57_ponto_gancho.png` (argola com anel ciano, que o ímã puxa); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (só os materiais: cobre, chapa, rebite).
- **Escala:** D = 400 px. O Autômato mede **420 px de altura** e no máximo **190 px de largura** no corpo (sem o braço-ímã). O braço-ímã estendido pode passar disso.
- **Orientação:** vista frontal e vista lateral olhando para a **direita**.
- **Paleta:** traje azul-marinho #1B2340 como **cor principal do corpo** (é o Traje Âncora que se adaptou), com placas de cobre #B8743A nos ombros, antebraços e canelas, sombra fria do cobre #5a3a3c (puxada para o violeta, nunca marrom-preto); chapa clara #C9C2B4 em detalhes; faixa e energia **ciano #2EC7E6**; visor #9FE3F0 com os olhos ovais pretos e a franja do Daymon. Contorno #1d2a3c onde houver. Sem âmbar ou vermelho no rosto.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido, no layout da ficha do Daymon.
- **Fundo:** azul-marinho escuro chapado, como as fichas A0 e DF01.
- **Âncora e apoio:** pés numa linha de chão comum em todas as vistas. Cruz pequena no **ombro do braço-ímã** na vista lateral (pivô do braço no jogo) e na base entre os pés (âncora do sprite).
- **Conteúdo e desenho:** o Traje Âncora cobriu Daymon com **placas de sucata magnetizadas**, mas ele continua sendo o mesmo garoto esguio por baixo: pense em **Daymon de armadura leve**, não em um robô novo. Cabeça com capacete arredondado do tamanho da cabeça do Daymon e visor que mostra o rosto dele. Tronco do traje justo, placa de peito pequena com a **faixa ciano diagonal**. Pernas da largura das do Daymon, canelas com placa e **uma rodinha no calcanhar** (Arranque). Braço de trás simples. **Braço da frente = braço-ímã**: antebraço um pouco mais grosso, terminando num eletroímã em ferradura com as pontas ciano. Monte: (1) vista frontal; (2) vista lateral; (3) o braço-ímã sozinho, de lado; (4) detalhe do visor; (5) pose de ação, braço estendido com feixe ciano curto; (6) paleta com hex; (7) faixa de escala com Daymon em silhueta (400 px) ao lado (420 px), igual à DF01. **Leitura:** firme e pesado pelo andar, não pelo volume. Diferente do Lince (baixo, felino) e dos robôs inimigos (atarracados, de olho vermelho).
- **Antes de apresentar, confira:** monte a `DF02_comparacao.png` com o Autômato entre a ficha do Daymon e o D0_lince, todos em D = 400 px, e embaixo a mesma linha reduzida para ~90 px de altura sobre uma faixa da cena do Deserto. Confira: largura ≤ 0,45 da altura; contorno nunca mais escuro nem mais quente que o do Lince; o rosto do Daymon se reconhece a 90 px; a cor dominante é o azul do traje, não a ferrugem.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF02/` (o v1 continua lá como histórico), com o `ENTREGA.md` atualizado contendo: vistas, âncoras medidas em pixels, cores usadas, **a tabela da régua DA-02 preenchida** (altura em D, largura/altura, cor do contorno, parte da borda com contorno, tons por superfície, saturação dos acentos), confirmação da aprovação, SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF02 do `colaboracao/STATUS.md` para `ENTREGUE (v2)`. Commit com prefixo `[arte]`.
````

---

## 3. DF01 v2: ficha do Robô e do Drone refeita na régua

> **Enviar só depois que o João aprovar a DA-02** (e, de preferência, a DF02 v2, para os inimigos não se parecerem com o herói).

````markdown
**[DF01 v2] Ficha de inimigos: Robô e Drone do Deserto (refeita na régua DA-02)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e a régua **DA-02** aprovada pelo João Marcelo. A peça precisa parecer desenhada pelo mesmo artista da Folha de Inimigos do Laboratório Hélix e dos inimigos de Verdâmia. **A DF01 anterior foi rejeitada**: contorno fechado preto-marrom (#221513), corpo escuro e marrom que some no fundo do deserto, sem ponto de leitura, e o Drone pequeno demais (0,30 D).

Régua DA-02 que esta peça precisa cumprir: Robô com 0,7–0,9 D de altura; Drone com pelo menos 0,55 D de altura ou 0,7 D de largura; contorno escuro em no máximo metade da borda, sempre frio (azul-marinho #1d2a3c a #253045), nunca preto nem marrom; 2–3 tons por superfície; até 12 cores efetivas; saturação média 0,20–0,55; **ponto de leitura** (olho ou núcleo) de 4–10% da silhueta em **vermelho de perigo**, nunca âmbar nem laranja (são as cores do fundo do Deserto).

- **ID:** DF01 v2
- **Arquivo(s):** `DF01_ficha_inimigos_deserto_v2.png` e `DF01_comparacao.png`
- **Finalidade no jogo:** referência dos dois inimigos comuns do Deserto. As folhas de animação (DF60–DF71) serão redesenhadas a partir dela. Não entra no jogo.
- **Referências obrigatórias do repositório:** `arte_original/00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png` (traço e linguagem de robô do jogo: **a referência principal**); `colaboracao/entregas/VD_verdamia/E0_inimigos.png` (nível de detalhe e contorno dos inimigos aprovados); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala); `colaboracao/entregas/DF02/` (a forma do herói no Deserto, que os inimigos **não** podem lembrar).
- **Escala:** D = 400 px. **Robô: 320 px de altura** (0,8 D). **Drone: 240 px de largura** e cerca de 200 px de altura com as hélices.
- **Orientação:** vista lateral olhando para a **direita** (o jogo espelha) e uma vista frontal de cada.
- **Paleta:** ferro oxidado claro #9a6a4e e #6e4a3e com sombra fria #3a3346; chapa cinza-azulada #7c7f86 e #4a5060; juntas #2a2f40; **olho/núcleo vermelho #e0303a** com brilho #ff8a80. Contorno #1d2a3c onde houver. A ferrugem do inimigo é **mais clara e mais cinza** que o fundo laranja, para destacar.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido, no layout da DF01 anterior.
- **Fundo:** azul-marinho escuro chapado.
- **Âncora e apoio:** Robô com os pés numa linha de chão comum; cruz na base entre os pés. Drone com cruz no centro do corpo (âncora de voo) e marcação do **ponto onde o ímã puxa** (uma argola ou placa magnética visível no topo).
- **Conteúdo e desenho:** **Robô** sentinela de sucata da fábrica: corpo de chapa em forma de sino ou de lata inclinada, duas pernas curtas e articuladas, um olho vermelho grande e horizontal. No jogo o pulso magnético do Autômato o **derruba de costas**, então mostre também (4) a pose **caído** de lado. Silhueta diferente do Autômato (o herói é esguio e azul; o Robô é atarracado e de ferro claro). **Drone** de patrulha: corpo redondo de chapa, duas hélices laterais, núcleo vermelho embaixo, argola magnética no topo (o ímã do Autômato puxa por ela). Monte: (1) Robô lateral; (2) Robô frontal; (3) olho do Robô em detalhe, aberto e apagado; (4) Robô caído; (5) Drone lateral; (6) Drone frontal; (7) paleta com hex; (8) faixa de escala com Daymon em silhueta (400 px), o Robô (320 px) e o Drone (240 px de largura).
- **Antes de apresentar, confira:** monte a `DF01_comparacao.png` com Daymon, o Esporângio de Verdâmia e os dois inimigos novos em D = 400 px, e embaixo a mesma linha reduzida para ~90 px de Daymon **sobre um recorte da cena do Deserto**. Confira: o olho vermelho aparece a 90 px; o Robô se destaca do fundo laranja; contorno nunca mais escuro nem mais quente que o do Esporângio; o Drone não fica menor que a cabeça e o tronco do Daymon juntos.
- **Entrega:** Apresente ao João Marcelo (ficha + comparação) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF01/` (o v1 continua lá como histórico), com o `ENTREGA.md` atualizado contendo: vistas, âncoras medidas em pixels, cores usadas, **a tabela da régua DA-02 preenchida** para cada inimigo (altura em D, largura/altura, cor do contorno, parte da borda com contorno, tons por superfície, área do ponto de leitura), confirmação da aprovação, SHA-256 de cada PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF01 do `colaboracao/STATUS.md` para `ENTREGUE (v2)`. Commit com prefixo `[arte]`.
````
