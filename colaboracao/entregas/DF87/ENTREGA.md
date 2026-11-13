# DF87 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF87_rebite.png`

SHA-256: `3c88f0970292112e77cea8a72bda6f23d4fcd39dbd7e0ec9d3d6c9758ebe60d5`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[166, 243, 217, 268], [165, 243, 218, 269], [166, 240, 217, 271], [166, 240, 217, 271]]

## Especificação de referência

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
