# Pedido DF (refação): cena do Deserto de Ferrugem pela DA-03

**Refação do Deserto.** O João avaliou (24/11/2026) que o Deserto está bem abaixo do Laboratório e de Verdâmia; a [DA-03](../entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md) foi aprovada no mesmo dia, e a ordem aprovada é: receita, Nivária, depois o Deserto.
**Estado:** ABERTO. Comece pela **DF00 v2**; as outras peças usam a paleta e as faixas aprovadas nela.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 24/11/2026
**Diretrizes obrigatórias:** DA-01, DA-02 e DA-03.

**O que muda e o que fica:**
- **Cenário (este pedido):** refeito pela DA-03. Ordem: **DF00 v2 → DF205 → DF200 → DF201 → DF202 → DF204 → DF206 → DF207 → DF208 → DF203 → DF209 → DF210**, e por último o retoque da Forja (**DF03 v2**).
- **Autômato e inimigos:** dependem das fichas **DF02 v2** e **DF01 v2** ([pedido](DA02_regua_e_fichas_v2.md)); as folhas de animação (no lugar de DF60–DF71 e DF90–DF97) serão pedidas depois das fichas aprovadas, com as medidas delas.
- **Máquinas e perigos atuais** (prensas, serra, esteira, válvulas, carrinhos, portas, DF50–DF57): ficam, com ajuste de escala e valor na integração; se destoarem do cenário novo, entram num lote seguinte.

Cada bloco é um prompt completo. Copie **um por vez** e mande o seguinte só depois de aprovar o anterior.

| ID | Peça | Substitui no jogo |
|---|---|---|
| DF00 v2 | Prancha de referência do Deserto com a estrutura de valores da DA-03 | DF00 (paleta e valores) |
| DF200 | Fundo distante: céu do crepúsculo de tempestade | DF10 |
| DF201 | Fundo intermediário: dunas de sucata e a fábrica ao longe | DF11 e DF12 |
| DF202 | Fundos internos: Fábrica e Salão do Núcleo | DF22, DF23 e DF24 (painéis chapados) |
| DF203 | Fundo da Câmara da Forja | DF24 na Câmara |
| DF204 | Estrutura de fundo (peças grandes) | nada (falta estrutura de fundo) |
| DF205 | Terreno completo do Deserto | DF20, DF21 e DF25 |
| DF206 | Decoração média e pequena | nada (falta decoração) |
| DF207 | Moldura: o que desce do alto | nada (falta moldura) |
| DF208 | Primeiro plano | nada (falta primeiro plano) |
| DF209 | Efeitos de ambiente | DF86 (poeira) e brilhos por código |
| DF210 | Objetos do universo: placa, estação, célula, núcleo e registro | placa, estação e célula do Laboratório |
| DF03 v2 | Retoque da Forja-Mãe (DF03 e folhas DF100–DF108) | DF03 e DF100–DF108 v1 |

---

## DF00 v2: Prancha de referência do Deserto com a estrutura de valores da DA-03

> Primeiro pedido: as outras peças usam a paleta e as faixas aprovadas nesta prancha.

````markdown
**[DF00 v2] Prancha de referência do Deserto com a estrutura de valores da DA-03**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF00 v2
- **Arquivo(s):** `DF00_prancha_deserto_v2.png` e `DF00_v2_cena.png`
- **Finalidade no jogo:** redefine a paleta e os valores do Deserto. A DF00 v1 pôs o exterior claro e quente e a parede de fábrica como painel chapado; daí vieram os problemas medidos no jogo.
- **Referências obrigatórias do repositório:** `colaboracao/entregas/GL00/GL00_prancha_nivaria.png` (como a prancha de Nivária resolveu valores e faixas de cena), `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (só materiais), `docs/auditoria_cena/comparacao_cenas.png`.
- **Escala:** amostras de material e de plataforma na escala D = 400 px, com a silhueta do Autômato (ficha DF02 v2, quando aprovada) ou do Daymon.
- **Orientação:** cenas vistas de lado, como o jogo.
- **Âncora e pivô:** topo das plataformas de amostra alinhado com os pés da silhueta.
- **Estados e quadros:** (1) quatro faixas de cena (~700 × 160 px): Dunas no crepúsculo de tempestade, Fábrica, Salão do Núcleo e Câmara da Forja, cada uma com as cinco funções da DA-03; (2) materiais com 2–3 tons: areia de ferrugem, chapa, viga, cobre, vidro de lâmpada, fornalha; (3) cores de função: âmbar (energia do universo e lâmpadas), vermelho (perigo), ciano (gancho e Traje Âncora), azul-marinho comum (sombras); (4) uma faixa **em cinza** das quatro cenas para provar os valores.
- **Dimensões e grade:** PNG de 1.536 × 1.024 px, prancha com texto permitido.
- **Fundo:** azul-marinho escuro chapado nas áreas de amostra.
- **Antes de apresentar, confira:** cada faixa com luma média ≤ 0,18 e terço de cima ≤ 0,15; a silhueta do personagem se lê em todas; o âmbar só nas luzes e detalhes; nada de painel liso enorme;
- **Entrega:** Apresente ao João Marcelo (peças + `DF00 v2_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF00 v2/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF00 v2 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF200: Fundo distante: céu do crepúsculo de tempestade

````markdown
**[DF200] Fundo distante: céu do crepúsculo de tempestade**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF200
- **Arquivo(s):** `DF200_ceu.png`
- **Finalidade no jogo:** camada 1 das Dunas (parallax 0,06), no lugar de DF10.
- **Referências obrigatórias do repositório:** DF00 v2 aprovada; `assets/verdamia/fundo/bg_distante.png` (acabamento de um fundo distante aprovado).
- **Escala:** cobre a tela inteira (1.280 × 720 com zoom 1,1) com folga vertical de 1,5 tela.
- **Orientação:** paisagem lateral.
- **Âncora e pivô:** repetível na horizontal sem emenda.
- **Estados e quadros:** 1 imagem: céu ferrugem escuro, sol baixo e velado (sem disco claro grande), faixas de poeira; terço de cima escuro.
- **Dimensões e grade:** 2.560 × 1.440 px.
- **Fundo:** opaco.
- **Antes de apresentar, confira:** monte `DF200_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF200_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF200/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF200 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF201: Fundo intermediário: dunas de sucata e a fábrica ao longe

````markdown
**[DF201] Fundo intermediário: dunas de sucata e a fábrica ao longe**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF201
- **Arquivo(s):** `DF201_dunas_longe.png` (parallax 0,2) e `DF201_dunas_perto.png` (parallax 0,38)
- **Finalidade no jogo:** camada 2 das Dunas, no lugar de DF11 e DF12: dunas com carcaças enterradas, chaminés e a silhueta da fábrica no horizonte.
- **Referências obrigatórias do repositório:** DF00 v2 e `assets/verdamia/fundo/bg_intermediario.png`.
- **Escala:** carcaças e chaminés de 2–4 D na camada de 0,38; a fábrica no horizonte com a altura da tela.
- **Orientação:** paisagem lateral.
- **Âncora e pivô:** base reta para encaixar uma camada na outra; repetíveis na horizontal.
- **Estados e quadros:** 1 imagem por camada; quanto mais longe, menos contraste e saturação e mais próximo da cor do céu.
- **Dimensões e grade:** 2.560 × 1.024 px cada.
- **Fundo:** transparente acima do recorte.
- **Antes de apresentar, confira:** monte `DF201_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF201_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF201/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF201 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF202: Fundos internos: Fábrica e Salão do Núcleo

````markdown
**[DF202] Fundos internos: Fábrica e Salão do Núcleo**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF202
- **Arquivo(s):** `DF202_fabrica.png` e `DF202_salao.png`
- **Finalidade no jogo:** substituem os painéis chapados DF22–DF24: paredes de fundo com **estrutura** (vigas, pilares, tubulações, janelas altas com luz âmbar, engrenagens grandes **escuras** atrás, passarelas ao longe). Fábrica: x 1.700–3.580, cerca de 1.000 px de altura; Salão do Núcleo: galeria alta, x 3.580–6.990, com pontes e correntes ao fundo.
- **Referências obrigatórias do repositório:** DF00 v2; as paredes do Laboratório (colunas, janelas e painéis escuros) como referência de função: estrutura escura e quieta que dá ritmo sem competir.
- **Escala:** pilares e vigas de 3–6 D; janelas de 1–2 D; entregue a 2× da escala do jogo.
- **Orientação:** lateral.
- **Âncora e pivô:** repetíveis na horizontal; o chão no pé da imagem.
- **Estados e quadros:** 1 imagem por ambiente, com variação a cada ~1.000 px de jogo (duas variantes de módulo em cada imagem). Luzes âmbar pontuais, nunca grandes áreas claras.
- **Dimensões e grade:** 2.048 × 2.048 px cada (2×).
- **Fundo:** opaco.
- **Antes de apresentar, confira:** monte `DF202_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF202_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF202/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF202 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF203: Fundo da Câmara da Forja

````markdown
**[DF203] Fundo da Câmara da Forja**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF203
- **Arquivo(s):** `DF203_camara.png`
- **Finalidade no jogo:** o salão do chefe (1.440 × 620 px de jogo, x 7.050–8.490, teto em y 150 e chão em y 770): fornalha ao fundo, trilho dos braços no teto, tubulações, mais escuro que a Forja-Mãe para ela se destacar.
- **Referências obrigatórias do repositório:** DF00 v2, `colaboracao/entregas/DF03/` (a Forja) e `docs/auditoria_deserto/5_chefes.png`.
- **Escala:** na escala do jogo, entregue a 2× (2.880 × 1.240 px).
- **Orientação:** lateral, chão no pé da imagem.
- **Âncora e pivô:** as portas da esquerda e da direita nas bordas (60 × 190 px de jogo cada).
- **Estados e quadros:** 1 imagem; o brilho da fornalha contido, sem tirar o destaque da lente e do núcleo da Forja.
- **Dimensões e grade:** 2.880 × 1.240 px.
- **Fundo:** opaco.
- **Antes de apresentar, confira:** monte `DF203_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF203_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF203/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF203 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF204: Estrutura de fundo (peças grandes)

````markdown
**[DF204] Estrutura de fundo (peças grandes)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF204
- **Arquivo(s):** `DF204_estrutura.png` (folha de peças)
- **Finalidade no jogo:** camada 3 da DA-03 no plano do jogo: guindastes, chaminés, tanques, carcaças de máquinas gigantes, colunas de aço e esqueletos de galpão, atrás do jogador.
- **Referências obrigatórias do repositório:** DF00 v2; `assets/verdamia/objetos/cogumelo_gigante.png` e `arco_templo.png` (função de peça grande de fundo aprovada).
- **Escala:** faixa grande da DA-03: 3–6 D de altura. Peças da mesma família na mesma escala.
- **Orientação:** lateral.
- **Âncora e pivô:** base no chão de cada peça.
- **Estados e quadros:** 10 peças: 2 guindastes, 2 chaminés, tanque, carcaça de escavadeira, carcaça de robô gigante tombado, coluna de aço com vigas, esqueleto de galpão, engrenagem gigante enterrada. Mais escuras que o plano do jogo.
- **Dimensões e grade:** células de 1.024 × 1.536 px, 5 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** monte `DF204_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF204_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF204/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF204 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF205: Terreno completo do Deserto

````markdown
**[DF205] Terreno completo do Deserto**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF205
- **Arquivo(s):** `DF205_terreno.png` (folha de peças)
- **Finalidade no jogo:** substitui DF20, DF21 e DF25: dunas de sucata com topo irregular (areia de ferrugem e peças aparecendo), piso de fábrica (chapa com topo reto e rebites só nas uniões), subsolo, cantos, borda de parede, teto com vigas, passarela suspensa **com tirantes** e plataforma de engrenagem.
- **Referências obrigatórias do repositório:** DF00 v2 e o conjunto de terreno de Verdâmia (`assets/verdamia/terreno/`).
- **Escala:** no jogo, a faixa de topo tem 18–30 px; entregue a 2×.
- **Orientação:** lateral.
- **Âncora e pivô:** linha do topo marcada em cada peça; cantos com o ponto de encontro marcado.
- **Estados e quadros:** 10 peças, repetíveis onde fizer sentido. Subsolo mais escuro que o topo e com planos de material.
- **Dimensões e grade:** tiles de 512 × 256 px (chão, teto), 512 × 512 px (subsolo, borda); cantos e plataformas em células de 512 × 384 px.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** a costura dos tiles não aparece a ~91 px de personagem; nenhuma dune ou piso vira uma faixa lisa;
- **Entrega:** Apresente ao João Marcelo (peças + `DF205_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF205/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF205 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF206: Decoração média e pequena

````markdown
**[DF206] Decoração média e pequena**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF206
- **Arquivo(s):** `DF206_media.png` e `DF206_pequena.png`
- **Finalidade no jogo:** as faixas média e pequena da DA-03, que o Deserto nunca teve: ferramentas, tambores, caixas, carrinhos, painéis de controle, parafusos, porcas, cabos soltos, lâmpadas de chão, placas de aviso (só onde há perigo de verdade).
- **Referências obrigatórias do repositório:** DF00 v2; `assets/laboratorio/` (barril, caixa, cabos, alerta) e `assets/verdamia/objetos/` como referência de acabamento e densidade.
- **Escala:** médias 1–2 D; pequenas 0,15–0,5 D.
- **Orientação:** lateral.
- **Âncora e pivô:** base no chão de cada peça.
- **Estados e quadros:** médias (10) e pequenas (14), sem listras de aviso decorativas.
- **Dimensões e grade:** médias em células de 512 × 512 px, 5 colunas; pequenas em 256 × 256 px, 7 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** monte `DF206_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF206_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF206/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF206 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF207: Moldura: o que desce do alto

````markdown
**[DF207] Moldura: o que desce do alto**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF207
- **Arquivo(s):** `DF207_moldura.png`
- **Finalidade no jogo:** DA-03, C3: correntes, ganchos de guindaste, cabos, mangueiras e lâmpadas penduradas descendo do teto (interior) e das gruas (exterior).
- **Referências obrigatórias do repositório:** DF00 v2; os cabos do Laboratório e `assets/verdamia/objetos/raiz_pendurada.png` (função).
- **Escala:** 1–3 D de comprimento.
- **Orientação:** penduradas, de frente.
- **Âncora e pivô:** ponto de fixação no topo da célula.
- **Estados e quadros:** 8 peças.
- **Dimensões e grade:** células de 512 × 768 px, 4 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** monte `DF207_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF207_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF207/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF207 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF208: Primeiro plano

````markdown
**[DF208] Primeiro plano**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF208
- **Arquivo(s):** `DF208_primeiro_plano.png` e `DF208_primeiro_plano_interior.png`
- **Finalidade no jogo:** camada 5 da DA-03, que o Deserto nunca teve: silhuetas de sucata, areia e engrenagens na borda de baixo da tela, quase pretas.
- **Referências obrigatórias do repositório:** `assets/verdamia/fundo/fg_vegetacao.png` (altura, densidade e escurecimento).
- **Escala:** até 1/5 da altura da tela no jogo.
- **Orientação:** lateral.
- **Âncora e pivô:** base reta; repetível na horizontal.
- **Estados e quadros:** exterior e interior.
- **Dimensões e grade:** 2.048 × 512 px cada.
- **Fundo:** transparente acima da silhueta.
- **Antes de apresentar, confira:** monte `DF208_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF208_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF208/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF208 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF209: Efeitos de ambiente

````markdown
**[DF209] Efeitos de ambiente**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF209
- **Arquivo(s):** `DF209_poeira.png`, `DF209_faiscas.png`, `DF209_vapor.png`, `DF209_brilho_lampada.png`
- **Finalidade no jogo:** DA-03, C6: poeira de ferrugem (partícula) no exterior, faíscas e vapor no interior e o brilho âmbar das lâmpadas no entorno.
- **Referências obrigatórias do repositório:** DF00 v2 e os efeitos de Verdâmia em `assets/verdamia/efeitos/`.
- **Escala:** poeira e faíscas de 4–14 px no jogo; vapor com ~1–2 D; brilho em gradiente radial.
- **Orientação:** lateral.
- **Âncora e pivô:** centro da célula.
- **Estados e quadros:** poeira 4 grãos · faíscas 6 quadros · vapor 8 quadros (loop) · brilho 1.
- **Dimensões e grade:** células de 256 × 256 px, uma folha por efeito.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** monte `DF209_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF209_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF209/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF209 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF210: Objetos do universo: placa, estação, célula, núcleo e registro

````markdown
**[DF210] Objetos do universo: placa, estação, célula, núcleo e registro**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF210
- **Arquivo(s):** `DF210_objetos.png`
- **Finalidade no jogo:** hoje o Deserto usa a placa holográfica, a estação de recarga e o kit/célula do Laboratório. Pedido da auditoria: versões próprias de Ferrumgrado, mantendo a forma que o jogador já conhece (como a GL04 fez em Nivária).
- **Referências obrigatórias do repositório:** `colaboracao/entregas/GL04/GL04_prancha_objetos_v2.png` (como Nivária resolveu célula, núcleo e registro), `assets/laboratorio/celula_suporte.png` e DF00 v2.
- **Escala:** estação 0,9–1,2 D; placa 0,6 D; célula 0,25 D; núcleo e registro 0,35 D.
- **Orientação:** lateral.
- **Âncora e pivô:** base no chão (estação e placa); centro (coletáveis).
- **Estados e quadros:** estação apagada e ativa (luz âmbar), placa, célula (6 quadros de brilho), núcleo (6), registro (4).
- **Dimensões e grade:** células de 512 × 512 px, 4 colunas.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** monte `DF210_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;
- **Entrega:** Apresente ao João Marcelo (peças + `DF210_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF210/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF210 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````

---

## DF03 v2: Retoque da Forja-Mãe (DF03 e folhas DF100–DF108)

> Último do lote: depende da DF203 (o fundo da Câmara) para conferir o contraste.

````markdown
**[DF03 v2] Retoque da Forja-Mãe (DF03 e folhas DF100–DF108)**

Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 (limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em `docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como referência de materiais.

**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: **Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, 3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: **âmbar**; sombras profundas no azul-marinho comum do jogo.

Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço (algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto nem marrom-preto).

- **ID:** DF03 v2
- **Arquivo(s):** `DF03_ficha_forja_v2.png` e as folhas DF100–DF108 com sufixo `_v2`, mesma grade e mesmas âncoras
- **Finalidade no jogo:** a auditoria pediu retoque, não redesenho: contorno escuro em no máximo metade da borda e só nas cores frias (hoje é fechado e preto-marrom, #2c1c1b), menos chanfros, aros e rebites repetidos (DA-02, R9 e R10), listras de aviso só onde há perigo (as dos ombros saem), e o corpo mais escuro que a lente e o núcleo.
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/` e `DF100`–`DF108` (v1), `colaboracao/entregas/GL03/GL03_ficha_guardiao_v2.png` (o chefe de Nivária aprovado: acabamento e leitura), `docs/auditoria_deserto/5_chefes.png`.
- **Escala:** a mesma das folhas v1 (o jogo monta as peças pelas âncoras atuais; nada muda de lugar).
- **Orientação:** a mesma das folhas v1.
- **Âncora e pivô:** as âncoras das folhas v1, sem mudança.
- **Estados e quadros:** os mesmos quadros das folhas v1.
- **Dimensões e grade:** a mesma das folhas v1.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** sobreponha cada folha v2 à v1: âncoras e silhueta no mesmo lugar; monte a Forja inteira sobre a DF203 com o Autômato a ~91 px;
- **Entrega:** Apresente ao João Marcelo (peças + `DF03 v2_cena.png`) e **só suba depois da aprovação explícita dele**. Coloque os PNGs em `colaboracao/entregas/DF03 v2/` com um `ENTREGA.md` (lista de peças e quadros, âncoras em pixels, faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não conseguiu cumprir). Atualize a linha DF03 v2 do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`.
````
