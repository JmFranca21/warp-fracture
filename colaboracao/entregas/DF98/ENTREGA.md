# DF98 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF98_feixe_ima.png`

SHA-256: `b5283c4b281794afd7c8ccf18c55e63a8b1d4641d9fd13ac288248ff302fc200`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[0, 104, 256, 152], [0, 104, 256, 152], [0, 104, 256, 152], [0, 104, 256, 152], [52, 103, 204, 152], [52, 95, 204, 160], [52, 89, 204, 167], [52, 98, 204, 158]]

## Especificação de referência

- **Escala:** feixe com **0,12 D (48 px) de espessura**
- **Orientação:** na horizontal, indo para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1024 × 512 px** com duas faixas: linhas 0–255 = **segmento repetível** (4 quadros de 256 × 256 px lado a lado, em loop); linhas 256–511 = **ponta** (4 quadros de 256 × 256 px: o feixe se fecha numa garra de luz).
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** eixo do feixe em **y = 128** (faixa de cima) e **y = 384** (faixa de baixo) em todos os quadros. Na ponta, o ponto de contato fica em x = 200 de cada quadro
- **Quadros (ordem, ação e loop):**
  segmento 1–4: ondas de energia correndo para a direita. **Loop**
  ponta 1–4: garra de luz pulsando. **Loop**
- **Repetição e encaixe:** o **segmento repete na horizontal**: a borda esquerda de cada quadro do segmento continua exatamente a direita. Teste com três cópias lado a lado: a emenda não pode aparecer
- **Conteúdo e desenho:** Linhas de força ciano e brancas, com pequenos anéis magnéticos, e não um laser liso. Contido (DA-01).
- **Regras técnicas:** Sem texto nem grade. Fundo transparente.
- **Antes de apresentar, confira:** emenda invisível com três cópias lado a lado; eixo na mesma altura em todos os quadros.
