# DF101 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF101_forja_lente.png`

SHA-256: `4729eb58d10df1ec25f4d1edfb3d86b64899a88d005e04f117e5b6f9da83505d`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[22, 86, 362, 426], [22, 86, 362, 426], [22, 86, 362, 426], [22, 86, 362, 426]]

## Especificação de referência

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
