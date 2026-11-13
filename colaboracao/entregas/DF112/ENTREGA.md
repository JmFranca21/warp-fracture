# DF112 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF112_forja_explosao_nucleo.png`

SHA-256: `838e872e3a1d5a249d2aae39090835c8af1aa49aadd6348ed27e063534a6f9a2`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[48, 117, 336, 394], [52, 118, 331, 393], [39, 105, 345, 406], [21, 85, 363, 426], [14, 78, 369, 434], [33, 97, 351, 415], [43, 111, 341, 401], [64, 127, 319, 385]]

## Especificação de referência

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
