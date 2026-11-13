# DF106 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF106_forja_nucleo_pistao.png`

SHA-256: `4646c53322ac4f13e5c132dcda4f4086c165bfc095291e11a2c33e7002eb707b`




3 estados centralizados em (192, 256), com 160 × 160 px por peça.

## Especificação de referência

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
