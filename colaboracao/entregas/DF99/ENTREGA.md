# DF99 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF99_pulso_magnetico.png`

SHA-256: `15d4839972604faf6d5d47ece909af803dcf524e96e92c5f8c55ea3b007c6687`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[128, 206, 256, 305], [62, 165, 322, 346], [119, 186, 264, 325], [99, 165, 285, 346], [15, 167, 369, 345], [100, 167, 283, 345]]

## Especificação de referência

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
