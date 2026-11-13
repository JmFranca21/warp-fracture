# DF88 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF88_disparo_rebite.png`

SHA-256: `5ef442a6db884cce5a35b4f16e4081506ca62212b63ab42814ae785ee00ce14b`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[40, 215, 159, 296], [40, 218, 136, 294], [40, 237, 95, 275]]

## Especificação de referência

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
