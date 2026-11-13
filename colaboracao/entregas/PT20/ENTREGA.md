# PT20 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `PT20_membrana.png`

SHA-256: `407c3f5a2f1833bd5e140b3aaee6b2da56f849a3372244662fc3e59c8bba7e83`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[32, 16, 352, 496], [32, 16, 352, 496], [32, 16, 352, 496], [32, 16, 352, 496], [32, 16, 352, 496], [32, 16, 352, 496], [32, 16, 352, 496], [32, 16, 352, 496]]

## Especificação de referência

- **Escala:** oval de **1,0 D × 1,5 D (400 × 600 px)**; na célula de 384 × 512, desenhe-o em **320 × 480 px** (o jogo amplia)
- **Orientação:** de frente
- **Paleta:** tons claros e neutros, para o jogo tingir: branco #F4FAFF, azul muito claro #BFE8F5 e lavanda clara #D9CCFF. Nada saturado.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** centro do oval no centro da célula (192, 256)
- **Quadros (ordem, ação e loop):**
  1–8: superfície translúcida com véus de luz girando devagar, mais clara no centro. **Loop** de 8 para 1
- **Conteúdo e desenho:** Superfície de luz translúcida, com bordas suaves e alfa crescendo para o centro. **Tons claros e neutros**, sem cor de destino. Nada de estrelas nem galáxias.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** loop sem salto; tingível: sem cores saturadas.
