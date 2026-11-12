# Pedido DF100–DF112: Forja-Mãe (peças e efeitos)

**Lote 3: Forja-Mãe.** Fase 2 (Deserto de Ferrugem) e passagem entre fases.
**Estado:** SUSPENSO até a aprovação da ficha DF03.
**Depende de:** ficha DF03 aprovada.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 11/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), que prevalece sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez** para gerar a peça.

---

## DF100: Forja-Mãe: corpo fixo

````markdown
**[DF100] Forja-Mãe: corpo fixo**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF100
- **Arquivo(s):** `DF100_forja_corpo.png`
- **Finalidade no jogo:** corpo do chefe embutido na parede do fundo da Câmara da Forja. Lente, placas do peito, escotilhas e grade são peças separadas, desenhadas por cima
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** **3,5 D × 3 D (1400 × 1200 px)**
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **2048 × 2048 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** base plana da fornalha apoiada no chão, com o centro em **x = 1024, y = 2008**. Flanges parafusadas nas laterais encostam na parede
- **Conteúdo e desenho:** Forno de ferro com ombros largos, 3,5 D (1400 px) de altura e 3 D (1200 px) de largura. Deixe **vazios e transparentes** os encaixes da lente (círculo de 360 px, centro em x = 1024, y = 900), da câmara do peito (retângulo de 420 × 360, centro em x = 1024, y = 1330), das duas escotilhas dos ombros (240 × 160, centros em x = 640 e x = 1408, y = 820) e da grade da fornalha (700 × 240, centro em x = 1024, y = 1820). Informe no ENTREGA.md os encaixes reais, se precisar mudar.
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF100/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF100 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF101: Forja-Mãe: lente-olho (4 estados)

````markdown
**[DF101] Forja-Mãe: lente-olho (4 estados)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF101
- **Arquivo(s):** `DF101_forja_lente.png`
- **Finalidade no jogo:** olho do chefe. Os estados são os sinais de aviso dos golpes
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro da lente no centro da célula (192, 256), com **diâmetro de 340 px** nos quatro estados
- **Quadros (ordem, ação e loop):**
  1: **repouso** (âmbar suave, íris aberta)
  2: **aviso de rajada** (âmbar forte, íris contraída pela metade)
  3: **mira do feixe** (vermelha, íris fechada num ponto)
  4: **apagada** (vidro escuro, sem brilho)
- **Quadros e estados que o código usa:** quadro 2 = aviso da rajada de rebites (0,5 s); quadro 3 = aviso do feixe (1 s); quadro 4 = vitória e lente escura depois do feixe; quadro 1 = estado normal
- **Conteúdo e desenho:** Lente redonda com moldura de ferro e íris mecânica de lâminas.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF101/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF101 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF102: Forja-Mãe: câmara do núcleo (peito)

````markdown
**[DF102] Forja-Mãe: câmara do núcleo (peito)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF102
- **Arquivo(s):** `DF102_forja_peito.png`
- **Finalidade no jogo:** câmara do peito com o fragmento. As três placas são separadas para o jogo arrancá-las com o Pulso Magnético
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo); `colaboracao/entregas/VD_verdamia/VD_fragmento.png` (fragmento da Máquina de Dobra).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro da câmara no centro da célula (192, 256); câmara com **400 × 340 px** ocupando a célula (pode reduzir para caber, mantendo a proporção)
- **Quadros (ordem, ação e loop):**
  1: fechada
  2: aberta
  3: danificada
  4: placa esquerda
  5: placa central
  6: placa direita
- **Quadros e estados que o código usa:** quadro 1 = fases 1 e 2; quadro 2 = janela de dano da fase 3; quadro 3 = núcleo com menos da metade da vida; quadros 4–6 = placas arrancadas
- **Conteúdo e desenho:** Use as células assim. Quadro 1: **câmara fechada completa** (placas no lugar e o fragmento visível pelas frestas). Quadro 2: **câmara aberta** (sem placas, fragmento exposto e brilhando). Quadro 3: **câmara danificada** (rachada, com o fragmento piscando). Quadros 4, 5 e 6: cada uma das **três placas sozinha**, inteira, na posição em que encaixa no quadro 1 (o jogo as faz voar). Quadros 7 e 8 vazios.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF102/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF102 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF103: Forja-Mãe: carrinho do braço (no trilho do teto)

````markdown
**[DF103] Forja-Mãe: carrinho do braço (no trilho do teto)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF103
- **Arquivo(s):** `DF103_forja_carrinho.png`
- **Finalidade no jogo:** carrinho que corre no trilho de teto e segura o braço
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1024 × 512 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** as rodinhas apoiam no trilho em **y = 120** (o trilho DF55b passa por ali). O pivô do braço fica embaixo do carrinho, em **x = 512, y = 400**
- **Conteúdo e desenho:** Carrinho de 0,9 D (360 px) de largura, com quatro rodinhas em cima, motor com luz âmbar e um olhal embaixo, de onde pende o braço.
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF103/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF103 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF104: Forja-Mãe: segmento do braço

````markdown
**[DF104] Forja-Mãe: segmento do braço**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF104
- **Arquivo(s):** `DF104_forja_segmento.png`
- **Finalidade no jogo:** segmento articulado do braço. O jogo usa duas cópias (braço e antebraço) e as gira nos pivôs
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** na horizontal, apontando para a **direita**
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1024 × 512 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** segmento na horizontal, com **pivô de entrada em x = 112, y = 256** e **pivô de saída em x = 912, y = 256** (800 px entre as articulações)
- **Conteúdo e desenho:** Viga de ferro com pistão hidráulico ao lado e articulações redondas com rebite grande nas pontas. 0,35 D (140 px) de espessura.
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF104/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF104 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF105: Forja-Mãe: cabeça de martelo com placa de âncora (4 estados)

````markdown
**[DF105] Forja-Mãe: cabeça de martelo com placa de âncora (4 estados)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF105
- **Arquivo(s):** `DF105_forja_martelo.png`
- **Finalidade no jogo:** martelo de cada braço. Os estados são aviso, impacto e preso, e a placa de âncora em cima é onde o Autômato se prende com o ímã
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo); `colaboracao/entregas/DF57/DF57_ponto_gancho.png` (argola com anel ciano).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **2048 × 1024 px**, grade **invisível** de 2 × 2 (células de 1024 × 512 px), estados em ordem de leitura.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** em cada célula, **ponto de encaixe no braço em x = 512, y = 96** e **face de baixo (linha de esmagamento) em y = 432**, iguais nos quatro estados. **Centro da placa de âncora** em x = 512, y = 150
- **Quadros (ordem, ação e loop):**
  1: **normal** (faixas apagadas, âncora apagada, núcleo laranja fraco)
  2: **aviso** (faixas acesas em vermelho)
  3: **preso** (âncora acesa em ciano, núcleo laranja forte e exposto, lascas de chão na face de baixo)
  4: **quebrado** (núcleo destruído e escuro, rachaduras, âncora apagada)
- **Quadros e estados que o código usa:** estado 2 = aviso do Martelo (0,7 s na fase 1; 0,55 s na fase 2); a batida usa o estado 2 e o efeito DF82; estado 3 = janela de punição (1,6 s); volta ao estado 1 na recuperação; estado 4 = núcleo destruído (fim das fases 1 e 2)
- **Conteúdo e desenho:** Bloco de 1,4 D × 0,6 D (560 × 240 px), com faixas de perigo vermelho e cinza na face de baixo (como a DF50), a **placa de âncora ciano** redonda em cima (como a DF57) e o **núcleo do pistão** laranja na junta de cima, protegido por baixo.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF105/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF105 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF106: Forja-Mãe: núcleo do pistão (3 estados, sobreposição)

````markdown
**[DF106] Forja-Mãe: núcleo do pistão (3 estados, sobreposição)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF106
- **Arquivo(s):** `DF106_forja_nucleo_pistao.png`
- **Finalidade no jogo:** núcleo laranja que o jogador acerta em cima do martelo. Fica por cima do DF105 para piscar e mostrar dano
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro do núcleo no centro da célula (192, 256), com **diâmetro de 160 px**
- **Quadros (ordem, ação e loop):**
  1: **íntegro**
  2: **danificado** (rachado, luz falhando)
  3: **destruído** (escuro, gaiola torta)
- **Quadros e estados que o código usa:** quadro 1 = vida acima de 50%; quadro 2 = abaixo de 50%; quadro 3 = destruído
- **Conteúdo e desenho:** Esfera laranja dentro de uma gaiola de ferro.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF106/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF106 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF107: Forja-Mãe: escotilha dos ombros

````markdown
**[DF107] Forja-Mãe: escotilha dos ombros**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF107
- **Arquivo(s):** `DF107_forja_escotilha.png`
- **Finalidade no jogo:** escotilha que solta os drones na fase 2
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro da escotilha no centro da célula (192, 256), com **240 × 160 px**
- **Quadros (ordem, ação e loop):**
  1: fechada
  2: aviso (luz vermelha acesa)
  3: abrindo
  4: aberta (vão escuro, de onde o drone sai)
- **Quadros e estados que o código usa:** quadro 2 = aviso de 1 s antes dos drones; quadro 4 = momento em que o drone surge
- **Conteúdo e desenho:** Escotilha com luz vermelha de aviso.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF107/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF107 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF108: Forja-Mãe: grade da fornalha (loop)

````markdown
**[DF108] Forja-Mãe: grade da fornalha (loop)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF108
- **Arquivo(s):** `DF108_forja_grade.png`
- **Finalidade no jogo:** grade da fornalha, embaixo do corpo. A luz do fogo indica o estado de ânimo do chefe
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** grade com **340 × 120 px**, centro em (192, 256)
- **Quadros (ordem, ação e loop):**
  1–6: fogo pulsando atrás das barras. **Loop**
  7: grade **aberta** (barras recolhidas, fogo forte) para a janela da rajada
  8: grade **fria** (fogo apagado) para a vitória
- **Quadros e estados que o código usa:** 1–6 = normal; 7 = janela de punição da rajada (0,8 s); 8 = vitória
- **Conteúdo e desenho:** Barras de ferro com fogo laranja atrás. O jogo amplia para o encaixe de 700 × 240 do DF100.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF108/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF108 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF110: Forja-Mãe: feixe da lente

````markdown
**[DF110] Forja-Mãe: feixe da lente**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF110
- **Arquivo(s):** `DF110_forja_feixe.png`
- **Finalidade no jogo:** feixe vermelho que varre o chão na fase 3. O jogo estica o segmento e aponta a origem para a lente
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** na horizontal, indo para a **direita**
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1024 × 512 px**: linhas 0–255 = **segmento repetível** (4 quadros de 256 × 256 lado a lado, em loop); linhas 256–511 = **ponto de impacto no chão** (4 quadros de 256 × 256, em loop).
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** eixo do feixe em **y = 128** na faixa de cima; no impacto, o ponto de contato com o chão fica em **x = 128, y = 480**
- **Quadros (ordem, ação e loop):**
  segmento 1–4: energia correndo. **Loop**
  impacto 1–4: faíscas e chão incandescente. **Loop**
- **Repetição e encaixe:** o segmento **repete na horizontal**. Teste com três cópias lado a lado
- **Conteúdo e desenho:** Feixe vermelho #C8402F com núcleo claro, de 0,15 D (60 px) de espessura, e faíscas no ponto de impacto. A forma precisa mostrar com clareza a área que fere.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF110/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF110 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF111: Forja-Mãe: carga da lente

````markdown
**[DF111] Forja-Mãe: carga da lente**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF111
- **Arquivo(s):** `DF111_forja_carga_lente.png`
- **Finalidade no jogo:** aviso de 1 s antes do feixe, sobre a lente
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro no centro da célula (192, 256)
- **Quadros (ordem, ação e loop):**
  1–6: as linhas convergem e o anel se fecha. **Sem loop**; o quadro 6 é o instante do disparo
- **Quadros e estados que o código usa:** quadros 1–6 tocados durante o aviso de 1 s; o feixe DF110 começa depois do quadro 6
- **Conteúdo e desenho:** Linhas de energia vermelha convergindo para o centro e um anel se fechando.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF111/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF111 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF112: Forja-Mãe: explosão de núcleo

````markdown
**[DF112] Forja-Mãe: explosão de núcleo**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF112
- **Arquivo(s):** `DF112_forja_explosao_nucleo.png`
- **Finalidade no jogo:** explosão quando um núcleo é destruído (pistões e núcleo central)
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo).
- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro no centro da célula (192, 256)
- **Quadros (ordem, ação e loop):**
  1: clarão
  2–4: anel e lascas
  5–8: fumaça se desfazendo. **Sem loop**
- **Quadros e estados que o código usa:** toca no instante em que o núcleo é destruído; o estado 4 do DF105 entra no quadro 3
- **Conteúdo e desenho:** Estouro laranja e ciano, com anel de choque, lascas de ferro e um fiapo de fumaça. Maior e mais limpo que a DF84.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF112/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF112 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````
