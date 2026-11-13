# DF110 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF110_forja_feixe.png`

SHA-256: `0ab7e7438cc9e4358a30ae2dfef143df85c9c4e48efc01addebb039ceffee178`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[0, 98, 256, 158], [0, 98, 256, 158], [0, 98, 256, 158], [0, 98, 256, 158], [52, 135, 204, 224], [52, 119, 204, 224], [52, 116, 204, 224], [52, 135, 204, 224]]

## Especificação de referência

- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** na horizontal, indo para a **direita**
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **1024 × 512 px**: linhas 0–255 = **segmento repetível** (4 quadros de 256 × 256 lado a lado, em loop); linhas 256–511 = **ponto de impacto no chão** (4 quadros de 256 × 256, em loop).
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** eixo do feixe em **y = 128** na faixa de cima; no impacto, o ponto de contato com o chão fica em **x = 128, y = 480**
- **Quadros (ordem, ação e loop):**
  segmento 1–4: energia correndo. **Loop**
  impacto 1–4: faíscas e chão incandescente. **Loop**
- **Repetição e encaixe:** o segmento **repete na horizontal**. Teste com três cópias lado a lado
- **Conteúdo e desenho:** Feixe vermelho #C8402F com núcleo claro, de 0,15 D (60 px) de espessura, e faíscas no ponto de impacto. A forma precisa mostrar com clareza a área que fere.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
