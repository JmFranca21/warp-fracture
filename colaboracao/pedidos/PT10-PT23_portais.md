# Pedido PT10–PT23: portais e Receptáculo

**Lote 2: Autômato e portais.** Fase 2 (Deserto de Ferrugem) e passagem entre fases.
**Estado:** SUSPENSO até a aprovação das fichas DF02 e PT00.
**Depende de:** ficha PT00 aprovada.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 11/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), que prevalece sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez** para gerar a peça.

---

## PT10: Arco de Dobra: traseira

````markdown
**[PT10] Arco de Dobra: traseira**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT10
- **Arquivo(s):** `PT10_arco_traseira.png`
- **Finalidade no jogo:** parte do Arco desenhada **atrás** da membrana e do personagem: anel externo, base completa e painel de destino (sem glifos)
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** arco de **1,7 D × 2,3 D (680 × 920 px)**, base de 2,0 D (800 px) e abertura útil de 400 × 600 px
- **Orientação:** de frente
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1024 × 1024 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **mesmo registro em PT10, PT11 e PT12**: centro da base em **x = 512, y = 984** (40 px acima da borda de baixo) e **centro da abertura em x = 512, y = 640**. O código só sobrepõe as peças. Base plana apoiada no chão em toda a largura
- **Conteúdo e desenho:** Anel grosso de metal do Hélix, com o **interior vazio e transparente** (a membrana e as lâminas entram ali), base em degrau e, no topo, o **painel de destino** com três encaixes vazios. Os pilares da frente **não** entram (são a peça PT11). Luzes ciano apagadas, porque o código acende.
- **Antes de apresentar, confira:** abertura transparente; base plana em y = 984; nada dos pilares da frente.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT10/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT10 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT11: Arco de Dobra: frente

````markdown
**[PT11] Arco de Dobra: frente**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT11
- **Arquivo(s):** `PT11_arco_frente.png`
- **Finalidade no jogo:** parte do Arco desenhada **na frente** do personagem: os dois pilares e a borda da base. Quando Daymon entra, ele fica entre a membrana e estes pilares
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** na mesma escala da PT10
- **Orientação:** de frente
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1024 × 1024 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **mesmo registro em PT10, PT11 e PT12**: centro da base em **x = 512, y = 984** (40 px acima da borda de baixo) e **centro da abertura em x = 512, y = 640**. O código só sobrepõe as peças
- **Repetição e encaixe:** sobreponha PT11 à PT10 em 100%: as duas precisam formar o Arco da ficha PT00 sem frestas nem duplicação
- **Conteúdo e desenho:** Só os dois pilares frontais (que cobrem as laterais do anel) e a borda dianteira da base, com no máximo **40 px de altura** sobre a linha do chão. O resto é transparente. Encaixa exatamente sobre a PT10.
- **Antes de apresentar, confira:** sobreposição perfeita com PT10; a borda da base não passa de 40 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT11/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT11 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT12: Lâmina do diafragma do Arco

````markdown
**[PT12] Lâmina do diafragma do Arco**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT12
- **Arquivo(s):** `PT12_lamina_diafragma.png`
- **Finalidade no jogo:** uma única lâmina. O jogo desenha 8 cópias giradas a cada 45° em torno do centro da abertura e as abre, fecha e faz tremer
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** 8 lâminas fechadas cobrem um disco de **640 px de diâmetro** (cobre a abertura de 400 × 600)
- **Orientação:** lâmina apontando para **cima**, com o pivô embaixo
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **512 × 512 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pivô de rotação em x = 256, y = 448**, que no jogo coincide com o centro da abertura do Arco
- **Repetição e encaixe:** teste girando 8 cópias em torno de (256, 448): o disco precisa fechar sem buracos
- **Conteúdo e desenho:** Lâmina curva de metal, como a íris de uma câmera, com uma linha ciano na borda. Desenhe-a de modo que 8 cópias giradas a 45° em torno do pivô formem um disco fechado, com pequena sobreposição.
- **Antes de apresentar, confira:** disco fechado com 8 cópias; pivô exato.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT12/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT12 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT13: Glifos de destino (apagados e acesos)

````markdown
**[PT13] Glifos de destino (apagados e acesos)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT13
- **Arquivo(s):** `PT13_glifos.png`
- **Finalidade no jogo:** os glifos que acendem no painel do Arco e no seletor de destino
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** glifo de **0,3 D (120 px)**
- **Orientação:** de frente
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro de cada glifo no centro da sua célula (192, 256)
- **Quadros (ordem, ação e loop):**
  linha 1: Hélix, Verdâmia e Deserto **apagados** (metal escuro em relevo, sem brilho); 4ª célula vazia
  linha 2: os mesmos **acesos** (ciano #2EC7E6, verde-lima #A6E05A e âmbar #F2B24C, com brilho contido); 4ª célula vazia
- **Conteúdo e desenho:** Hexágono com ponto central (Hélix), folha-cogumelo com chapéu sobre um caule (Verdâmia) e engrenagem de seis dentes (Deserto), iguais à ficha PT00. Formas simples e grossas.
- **Antes de apresentar, confira:** os três se distinguem em tons de cinza; acesos e apagados com o mesmo contorno.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT13/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT13 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT15: Receptáculo da Máquina de Dobra

````markdown
**[PT15] Receptáculo da Máquina de Dobra**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT15
- **Arquivo(s):** `PT15_receptaculo.png`
- **Finalidade no jogo:** objeto interativo da Sala G do Laboratório, onde o jogador instala os fragmentos. Funciona também como estação de save
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`; `colaboracao/entregas/VD_verdamia/VD_fragmento.png` (fragmento da Máquina de Dobra).
- **Escala:** **1,2 D (480 px) de altura × 1,0 D (400 px) de largura**
- **Orientação:** de frente
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1024 × 1024 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** base plana apoiada no chão, com o centro em **x = 512, y = 984**. O cabo sai pela **borda direita** da imagem em y ≈ 900 (o jogo prolonga o cabo até o Arco)
- **Conteúdo e desenho:** Pedestal de laboratório com **quatro soquetes vazios** em losango (o jogo desenha os fragmentos encaixados). Os soquetes têm anéis ciano apagados. Informe no ENTREGA.md o centro de cada soquete, em pixels.
- **Antes de apresentar, confira:** quatro soquetes vazios e iguais; cabo saindo pela borda direita; base apoiada.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT15/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT15 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT20: Membrana do portal (loop neutro)

````markdown
**[PT20] Membrana do portal (loop neutro)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT20
- **Arquivo(s):** `PT20_membrana.png`
- **Finalidade no jogo:** interior de todos os portais (Arco e Fenda). O jogo tinge na cor do destino e muda o movimento (pulso, espiral ou ondulação)
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** oval de **1,0 D × 1,5 D (400 × 600 px)**; na célula de 384 × 512, desenhe-o em **320 × 480 px** (o jogo amplia)
- **Orientação:** de frente
- **Paleta:** tons claros e neutros, para o jogo tingir: branco #F4FAFF, azul muito claro #BFE8F5 e lavanda clara #D9CCFF. Nada saturado.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro do oval no centro da célula (192, 256)
- **Quadros (ordem, ação e loop):**
  1–8: superfície translúcida com véus de luz girando devagar, mais clara no centro. **Loop** de 8 para 1
- **Conteúdo e desenho:** Superfície de luz translúcida, com bordas suaves e alfa crescendo para o centro. **Tons claros e neutros**, sem cor de destino. Nada de estrelas nem galáxias.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** loop sem salto; tingível: sem cores saturadas.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT20/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT20 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT21: Fenda: borda aberta (loop)

````markdown
**[PT21] Fenda: borda aberta (loop)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT21
- **Arquivo(s):** `PT21_fenda_borda.png`
- **Finalidade no jogo:** contorno rasgado da Fenda aberta nos universos (retorno em Verdâmia e no Deserto, chegada no Deserto). A membrana PT20 fica atrás
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** oval de **1,1 D × 1,6 D**; na célula, **340 × 490 px**
- **Orientação:** de frente
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **base da fenda em x = 192, y = 500** (onde ela toca a base PT22), igual em todos os quadros
- **Quadros (ordem, ação e loop):**
  1–8: bordas rasgadas com lascas de cristal roxo e ciano tremendo de leve. **Loop**
- **Conteúdo e desenho:** Só a borda: o interior é transparente. Rasgo vertical no espaço, com bordas irregulares e lascas de cristal roxo #7A5CFF e ciano #2EC7E6.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** interior transparente; base fixa nos 8 quadros.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT21/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT21 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT22: Fenda: base no chão

````markdown
**[PT22] Fenda: base no chão**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT22
- **Arquivo(s):** `PT22_fenda_base.png`
- **Finalidade no jogo:** apoio da Fenda: chão rachado de onde ela nasce. Fica sobre o terreno de qualquer universo
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** **1,6 D (640 px)** de largura
- **Orientação:** de frente, levemente vista de cima
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1024 × 512 px**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **linha do chão em y = 380**; ponto onde a fenda nasce em **x = 512, y = 380**
- **Conteúdo e desenho:** Rachaduras irradiando no chão, com 4 a 6 lascas de cristal roxo e ciano saindo do solo. Abaixo de y = 380, só as raízes das rachaduras, desvanecendo. Sem cor de terreno (precisa servir para musgo e areia).
- **Antes de apresentar, confira:** neutra sobre o chão de Verdâmia e sobre a areia do Deserto.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT22/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT22 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## PT23: Fenda: abrindo

````markdown
**[PT23] Fenda: abrindo**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT23
- **Arquivo(s):** `PT23_fenda_abrindo.png`
- **Finalidade no jogo:** a Fenda se abre (depois do fragmento e na chegada ao Deserto). O jogo toca de trás para a frente para fechá-la. O quadro 1, parado, é a rachadura dormente
- **Referências obrigatórias do repositório:** `colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `colaboracao/decisoes/D05_portais.md`.
- **Escala:** como a PT21
- **Orientação:** de frente
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** base em **x = 192, y = 500**, igual à PT21
- **Quadros (ordem, ação e loop):**
  1: rachadura dormente (linha fina vertical de ~200 px, saindo do chão, brilho fraco)
  2–3: a linha se alarga e solta lascas
  4–6: rasga em oval
  7: oval quase completo
  8: igual ao quadro 1 da PT21. **Sem loop**
- **Conteúdo e desenho:** Abertura em ~0,7 s no jogo. As lascas voam para fora no quadro 3 e voltam a orbitar no 7.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** o quadro 8 encaixa no quadro 1 da PT21; base fixa.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT23/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT23 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````
