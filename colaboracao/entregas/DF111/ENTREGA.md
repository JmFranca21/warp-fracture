# DF111 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF111_forja_carga_lente.png`

SHA-256: `888a3c0471d2c3983124dbd18095d0745af04cf4f2d4b4139d6244ccbc861d74`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[81, 146, 303, 365], [79, 148, 305, 363], [89, 143, 294, 368], [102, 164, 281, 347], [14, 166, 369, 345], [79, 255, 304, 256]]

## Especificação de referência

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
