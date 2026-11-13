# DF102 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF102_forja_peito.png`

SHA-256: `ff1a457289e6dddaf068f44d666ad946a9c9096f3b8c806cd7c61b394c6e4e03`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[14, 150, 369, 361], [15, 150, 369, 361], [15, 150, 369, 362], [114, 139, 269, 373], [110, 141, 274, 371], [114, 139, 269, 372]]

## Especificação de referência

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
