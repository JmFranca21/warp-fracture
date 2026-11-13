# PT23 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `PT23_fenda_abrindo.png`

SHA-256: `68e3c57536d07ea194bbe0e462b81832d0b22adf7603dc8541ee3296af5a35c1`



Limites de colocação (x0,y0,x1,y1, coordenadas locais): [[56, 151, 328, 500], [54, 93, 329, 500], [52, 50, 332, 500], [42, 32, 341, 500], [30, 10, 354, 500], [26, 10, 357, 500], [23, 10, 360, 500], [22, 10, 362, 500]]

## Especificação de referência

- **Escala:** como a PT21
- **Orientação:** de frente
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** base em **x = 192, y = 500**, igual à PT21
- **Quadros (ordem, ação e loop):**
  1: rachadura dormente (linha fina vertical de ~200 px, saindo do chão, brilho fraco)
  2–3: a linha se alarga e solta lascas
  4–6: rasga em oval
  7: oval quase completo
  8: igual ao quadro 1 da PT21. **Sem loop**
- **Conteúdo e desenho:** Abertura em ~0,7 s no jogo. As lascas voam para fora no quadro 3 e voltam a orbitar no 7.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** o quadro 8 encaixa no quadro 1 da PT21; base fixa.
