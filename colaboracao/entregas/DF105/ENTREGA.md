# DF105 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF105_forja_martelo.png`

SHA-256: `5327344b220c9c5eaf708f2c80a5eb4db9aa34b9717e6858ffbe17c92156d0dd`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[232, 96, 792, 433], [232, 96, 792, 433], [232, 96, 792, 433], [232, 96, 792, 433]]

## Especificação de referência

- **Escala:** D = 400 px, nas medidas da ficha DF03 aprovada
- **Orientação:** de frente
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de **2048 × 1024 px**, grade **invisível** de 2 × 2 (células de 1024 × 512 px), estados em ordem de leitura.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** em cada célula, **ponto de encaixe no braço em x = 512, y = 96** e **face de baixo (linha de esmagamento) em y = 432**, iguais nos quatro estados. **Centro da placa de âncora** em x = 512, y = 150
- **Quadros (ordem, ação e loop):**
  1: **normal** (faixas apagadas, âncora apagada, núcleo laranja fraco)
  2: **aviso** (faixas acesas em vermelho)
  3: **preso** (âncora acesa em ciano, núcleo laranja forte e exposto, lascas de chão na face de baixo)
  4: **quebrado** (núcleo destruído e escuro, rachaduras, âncora apagada)
- **Quadros e estados que o código usa:** estado 2 = aviso do Martelo (0,7 s na fase 1; 0,55 s na fase 2); a batida usa o estado 2 e o efeito DF82; estado 3 = janela de punição (1,6 s); volta ao estado 1 na recuperação; estado 4 = núcleo destruído (fim das fases 1 e 2)
- **Conteúdo e desenho:** Bloco de 1,4 D × 0,6 D (560 × 240 px), com faixas de perigo vermelho e cinza na face de baixo (como a DF50), a **placa de âncora ciano** redonda em cima (como a DF57) e o **núcleo do pistão** laranja na junta de cima, protegido por baixo.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** igual à ficha DF03; legível na escala do jogo (corpo com ~300 px de altura).
