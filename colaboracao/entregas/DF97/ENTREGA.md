# DF97 — revisão de arte

Aguardando aprovação de João Marcelo.

Arquivo: `DF97_automato_braco.png`

SHA-256: `f8916393b2e395db3cd4b94596c3d0808b9169fdf5fd40969179add2bab93c36`




Pivô (60, 256). Saída do disparo no eixo y = 256. Coordenada x na extremidade visível por estado: 288, 269, 279, 288.

## Especificação de referência

- **Escala:** na mesma escala da DF02: braço com cerca de **0,55 D (220 px)** do ombro à ponta do ímã
- **Orientação:** braço **na horizontal, apontando para a direita**, com o ombro à esquerda
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**.
- **Fundo:** **transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 uniforme, e avise no ENTREGA.md.
- **Âncora e apoio:** **centro do ombro (pivô) em x = 60, y = 256** em todos os quadros. O braço vai na direção +x
- **Quadros (ordem, ação e loop):**
  1: braço em repouso
  2: disparo (recua 10 px para o ombro; o ímã brilha ciano)
  3: volta (recuo de 4 px)
  4: feixe magnético ativo (garras da ferradura abertas, brilho ciano mais forte). **Sem loop**
- **Conteúdo e desenho:** Eletroímã em forma de ferradura na ponta, faixa ciano no antebraço e cotovelo rebitado. É a mesma peça da ficha DF02. A ponta do ímã deve ficar em x ≈ 280; informe a posição exata no ENTREGA.md, porque é de lá que saem o tiro e o feixe.
- **Regras técnicas:** Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima de 12 px). Sem texto, grade, chão ou sombra projetada
- **Antes de apresentar, confira:** pivô idêntico nos 4 quadros; a ponta da ferradura fica bem visível.
