# DF108 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF108_forja_grade.png`

SHA-256: `d2dd852f499de9a214b00357e887e203a5b2c5362342bad793e4729308ba1f72`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[22, 196, 362, 316], [22, 196, 362, 316], [22, 196, 362, 316], [22, 196, 362, 316], [22, 196, 362, 316], [22, 196, 362, 316], [22, 196, 362, 316], [22, 196, 362, 316]]

## Especificação de referência

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
