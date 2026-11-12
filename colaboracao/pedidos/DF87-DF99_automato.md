# Pedido DF87–DF99: Autômato (animações e efeitos)

**Lote 2: Autômato e portais.** Fase 2 (Deserto de Ferrugem) e passagem entre fases.
**Estado:** SUSPENSO até a aprovação das fichas DF02 e PT00.
**Depende de:** ficha DF02 aprovada.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 11/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), que prevalece sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez** para gerar a peça.

---

## DF90: Autômato parado (loop)

````markdown
**[DF90] Autômato parado (loop)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF90
- **Arquivo(s):** `DF90_automato_parado.png`
- **Finalidade no jogo:** pose padrão quando o jogador não se move. O braço-ímã (DF97) é desenhado por cima pelo jogo
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto).
- **Escala:** Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas
- **Orientação:** olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** do braço-ímã em cada quadro
- **Quadros (ordem, ação e loop):**
  1–6: respiração mecânica. O tronco sobe e desce 4 px, o visor pisca de leve no quadro 4. **Loop**: o quadro 6 volta ao 1 sem salto
- **Conteúdo e desenho:** Postura estável, pés afastados, peso no chão. Movimento mínimo e calmo.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência); corpo sem o braço-ímã; lido como o Autômato da DF02 a ~90 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF90/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF90 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF91: Autômato andando (loop)

````markdown
**[DF91] Autômato andando (loop)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF91
- **Arquivo(s):** `DF91_automato_andar.png`
- **Finalidade no jogo:** andar no chão (272 px/s, mais lento que Daymon humano)
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/VD_verdamia/D0_lince.png` (forma de Verdâmia; o Autômato precisa ser diferente dela).
- **Escala:** Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas
- **Orientação:** olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** do braço-ímã em cada quadro
- **Quadros (ordem, ação e loop):**
  1–8: ciclo de passos curtos e pesados. Contato do pé da frente nos quadros 1 e 5; o corpo desce 6 px nos contatos. **Loop** de 8 para 1
- **Conteúdo e desenho:** Passos curtos, pesados e ritmados, com o tronco quase rígido. Bem diferente da corrida felina do Lince.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência); corpo sem o braço-ímã; lido como o Autômato da DF02 a ~90 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF91/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF91 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF92: Autômato pulando (impulso e subida)

````markdown
**[DF92] Autômato pulando (impulso e subida)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF92
- **Arquivo(s):** `DF92_automato_pulo.png`
- **Finalidade no jogo:** início do pulo e subida. O quadro 1 também é usado como agachamento no pouso
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/VD_verdamia/D0_lince.png` (forma de Verdâmia; o Autômato precisa ser diferente dela).
- **Escala:** Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas
- **Orientação:** olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** do braço-ímã em cada quadro
- **Quadros (ordem, ação e loop):**
  1: agachamento (corpo 30 px mais baixo, pés no chão)
  2: impulso (pernas esticadas, pés deixando o chão)
  3: subida (pernas recolhidas)
  4: topo do pulo (pose neutra no ar). **Sem loop**; o jogo segura o quadro 4
- **Conteúdo e desenho:** Pulo curto e pesado: o corpo não estica muito. Nos quadros 2 a 4, a âncora (x = 192, y = 472) indica onde os pés estariam se tocassem o chão; o corpo pode subir dentro da célula.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência); corpo sem o braço-ímã; lido como o Autômato da DF02 a ~90 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF92/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF92 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF93: Autômato caindo

````markdown
**[DF93] Autômato caindo**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF93
- **Arquivo(s):** `DF93_automato_queda.png`
- **Finalidade no jogo:** queda depois do topo do pulo
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto).
- **Escala:** Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas
- **Orientação:** olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** do braço-ímã em cada quadro
- **Quadros (ordem, ação e loop):**
  1: começo da queda (braço livre para cima)
  2: queda (pernas se estendendo para o pouso)
  3: queda rápida (pés juntos, pronto para o impacto). **Sem loop**; o jogo escolhe o quadro pela velocidade
- **Conteúdo e desenho:** Queda de peso: sensação de bloco caindo, sem planar.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência); corpo sem o braço-ímã; lido como o Autômato da DF02 a ~90 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF93/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF93 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF94: Autômato: Arranque (esquiva)

````markdown
**[DF94] Autômato: Arranque (esquiva)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF94
- **Arquivo(s):** `DF94_automato_arranque.png`
- **Finalidade no jogo:** esquiva curta com invulnerabilidade, sobre as rodinhas dos calcanhares
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto).
- **Escala:** Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas
- **Orientação:** olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** do braço-ímã em cada quadro
- **Quadros (ordem, ação e loop):**
  1: inclina para a frente e as rodinhas descem
  2–3: desliza (corpo baixo e inclinado, faísca pequena nas rodinhas)
  4: freia e volta à pose parada. **Sem loop**
- **Conteúdo e desenho:** Avanço rápido e baixo, sem sair do chão. As rodinhas dos calcanhares aparecem.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência); corpo sem o braço-ímã; lido como o Autômato da DF02 a ~90 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF94/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF94 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF95: Autômato levando dano

````markdown
**[DF95] Autômato levando dano**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF95
- **Arquivo(s):** `DF95_automato_dano.png`
- **Finalidade no jogo:** reação ao dano. O Autômato **não recua**, então o tranco é só visual
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto).
- **Escala:** Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas
- **Orientação:** olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** do braço-ímã em cada quadro
- **Quadros (ordem, ação e loop):**
  1: tranco (corpo vibra, visor pisca em branco)
  2: volta (2 faíscas pequenas saindo de uma placa). **Sem loop**
- **Conteúdo e desenho:** Os pés não saem do lugar.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência); corpo sem o braço-ímã; lido como o Autômato da DF02 a ~90 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF95/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF95 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF96: Autômato derrotado

````markdown
**[DF96] Autômato derrotado**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF96
- **Arquivo(s):** `DF96_automato_derrota.png`
- **Finalidade no jogo:** morte do jogador nesta forma, antes de voltar à estação
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto).
- **Escala:** Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas
- **Orientação:** olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** do braço-ímã em cada quadro
- **Quadros (ordem, ação e loop):**
  1–2: perde força, joelhos dobram
  3–4: cai sentado, o visor apaga
  5–6: tomba de lado, com uma fumacinha. **O quadro 6 fica parado**
- **Conteúdo e desenho:** Desliga como uma máquina, sem desmontar e sem violência. No quadro 6 os pés (ou o corpo caído) continuam na linha y = 472.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência); corpo sem o braço-ímã; lido como o Autômato da DF02 a ~90 px de altura.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF96/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF96 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF97: Braço-ímã do Autômato (gira para mirar)

````markdown
**[DF97] Braço-ímã do Autômato (gira para mirar)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF97
- **Arquivo(s):** `DF97_automato_braco.png`
- **Finalidade no jogo:** braço separado que o jogo gira em 360° para mirar a Rebitadeira e o Ímã. Encaixa no ombro marcado nas folhas DF90–DF96
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem).
- **Escala:** na mesma escala da DF02: braço com cerca de **0,55 D (220 px)** do ombro à ponta do ímã
- **Orientação:** braço **na horizontal, apontando para a direita**, com o ombro à esquerda
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **centro do ombro (pivô) em x = 60, y = 256** em todos os quadros. O braço vai na direção +x
- **Quadros (ordem, ação e loop):**
  1: braço em repouso
  2: disparo (recua 10 px para o ombro; o ímã brilha ciano)
  3: volta (recuo de 4 px)
  4: feixe magnético ativo (garras da ferradura abertas, brilho ciano mais forte). **Sem loop**
- **Conteúdo e desenho:** Eletroímã em forma de ferradura na ponta, faixa ciano no antebraço e cotovelo rebitado. É a mesma peça da ficha DF02. A ponta do ímã deve ficar em x ≈ 280; informe a posição exata no ENTREGA.md, porque é de lá que saem o tiro e o feixe.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** pivô idêntico nos 4 quadros; a ponta da ferradura fica bem visível.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF97/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF97 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF87: Rebite (projétil do jogador no Deserto)

````markdown
**[DF87] Rebite (projétil do jogador no Deserto)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF87
- **Arquivo(s):** `DF87_rebite.png`
- **Finalidade no jogo:** projétil da Rebitadeira. O jogo gira o sprite na direção do tiro
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `colaboracao/entregas/DF70/` (projétil do robô, para **não** ser confundido com ele).
- **Escala:** rebite de **0,1 D (40 px)** de comprimento
- **Orientação:** apontando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro do rebite no centro da célula (192, 256)
- **Quadros (ordem, ação e loop):**
  1–4: rebite metálico girando, com rastro ciano curto atrás. **Loop**
- **Conteúdo e desenho:** Rebite de metal claro com cabeça arredondada e um contorno de energia ciano. Precisa ser lido como tiro do jogador (ciano) e nunca como o projétil âmbar do robô.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** ciano, sem âmbar nem vermelho; legível a ~10 px no jogo.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF87/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF87 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF88: Clarão de disparo da Rebitadeira

````markdown
**[DF88] Clarão de disparo da Rebitadeira**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF88
- **Arquivo(s):** `DF88_disparo_rebite.png`
- **Finalidade no jogo:** clarão na ponta do braço-ímã quando o rebite sai
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `arte_original/USADAS_NO_JOGO.md` (o efeito `arma/disparo` do Daymon humano).
- **Escala:** clarão com até **0,3 D (120 px)**
- **Orientação:** saindo para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** origem do clarão em **x = 40, y = 256** em todos os quadros (encaixa na ponta do ímã)
- **Quadros (ordem, ação e loop):**
  1: estouro ciano
  2: anel se abrindo
  3: se apaga. **Sem loop**
- **Conteúdo e desenho:** Estouro curto, ciano e branco, com 2 ou 3 lascas metálicas pequenas.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** origem fixa nos 3 quadros.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF88/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF88 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF98: Feixe do Ímã de Fase (segmento repetível e ponta)

````markdown
**[DF98] Feixe do Ímã de Fase (segmento repetível e ponta)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF98
- **Arquivo(s):** `DF98_feixe_ima.png`
- **Finalidade no jogo:** feixe magnético entre o braço do Autômato e a âncora ou o drone. O jogo estica o segmento até a distância certa e gira tudo na direção do alvo
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `colaboracao/entregas/DF57/DF57_ponto_gancho.png` (argola com anel ciano).
- **Escala:** feixe com **0,12 D (48 px) de espessura**
- **Orientação:** na horizontal, indo para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1024 × 512 px** com duas faixas: linhas 0–255 = **segmento repetível** (4 quadros de 256 × 256 px lado a lado, em loop); linhas 256–511 = **ponta** (4 quadros de 256 × 256 px: o feixe se fecha numa garra de luz).
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** eixo do feixe em **y = 128** (faixa de cima) e **y = 384** (faixa de baixo) em todos os quadros. Na ponta, o ponto de contato fica em x = 200 de cada quadro
- **Quadros (ordem, ação e loop):**
  segmento 1–4: ondas de energia correndo para a direita. **Loop**
  ponta 1–4: garra de luz pulsando. **Loop**
- **Repetição e encaixe:** o **segmento repete na horizontal**: a borda esquerda de cada quadro do segmento continua exatamente a direita. Teste com três cópias lado a lado: a emenda não pode aparecer
- **Conteúdo e desenho:** Linhas de força ciano e brancas, com pequenos anéis magnéticos, e não um laser liso. Contido (DA-01).
- **Regras técnicas:** Sem texto nem grade. Fundo transparente.
- **Antes de apresentar, confira:** emenda invisível com três cópias lado a lado; eixo na mesma altura em todos os quadros.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF98/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF98 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````

---

## DF99: Pulso Magnético (habilidade da forma)

````markdown
**[DF99] Pulso Magnético (habilidade da forma)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF99
- **Arquivo(s):** `DF99_pulso_magnetico.png`
- **Finalidade no jogo:** onda do Pulso Magnético. O jogo escala o efeito para o alcance de 150 px de raio
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada); `colaboracao/entregas/VD_verdamia/VD_fx_clarao.png` (clarão do Lince, para não repetir a forma).
- **Escala:** no último quadro, o anel ocupa a célula inteira (diâmetro de 360 px)
- **Orientação:** radial
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro da onda no centro da célula (192, 256)
- **Quadros (ordem, ação e loop):**
  1: o peito acende (ponto ciano)
  2–4: anel de linhas de força se expandindo, com pequenos arcos de ímã
  5–6: o anel se desfaz em fiapos. **Sem loop**
- **Conteúdo e desenho:** Anel de **linhas de campo magnético** (arcos entre dois polos, como num desenho de ímã), ciano e branco. Diferente do clarão do Lince, que é um anel de luz cheio.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** anel centrado em todos os quadros; não se confunde com o VD_fx_clarao.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF99/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF99 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````
