# DF92 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF92_automato_pulo.png`

SHA-256: `05ae59effd7663ee63e66fe7caa62ff0eaac832dfea37184ea03a66135874d83`

Ombro estimado na célula por quadro (conferir com o DF97): (184, 322), (184, 285), (185, 305), (185, 307)


Alfa de fundo limpo. Registro original das células preservado.

## Especificação de referência

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
