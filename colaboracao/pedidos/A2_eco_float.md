# Pedido A2_eco_float: Eco pairando (loop)

**Etapa do jogo:** 7, Fuga do Eco
**Formato:** spritesheet com **6 quadros**
**Depende de:** A0_ficha_eco (direção artística aprovada; PNG precisa estar publicado)

## Uso no jogo

Usada quando o Eco está parado ou observando, antes de começar a perseguir. É um loop: o quadro 6 deve emendar suavemente no quadro 1. Velocidade: cerca de 8 quadros por segundo.

## Regras visuais (DA-01)

- **Diretriz obrigatória:** `colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md` (DA-01).
- **Referência principal:** a ficha **A0 aprovada** (`colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png`). Copie dela o design, a paleta, a aura, os fragmentos, os olhos e a rachadura ciano, **exatamente como na ficha**.
- **Referência de proporção e de animação:** as spritesheets do Daymon usadas no jogo (veja `arte_original/USADAS_NO_JOGO.md`), por exemplo `arte_original/01_Daymon_sem_braco/run_v2_verde.png`. O Eco tem **a mesma altura e a mesma escala do Daymon nessas sheets**: cerca de 400 px de altura dentro da célula, da cabeça aos pés.
- Mesmo traço cartunizado, contornos limpos e sombreamento econômico em **todos os quadros**.
- **Efeitos contidos:** no máximo 3 a 5 fragmentos soltos por quadro, e a aura não pode cobrir a silhueta. Nenhum quadro pode virar só uma mancha de partículas, exceto onde o pedido disser.
- Proibido: realismo, chamas, brilho em todos os contornos, anatomia alongada e mudança de estilo entre os quadros.
- **Não use** propostas do Eco rejeitadas antes como referência.

## Regras técnicas (recorte automático)

- **Um PNG de 1536 × 1024 px** com fundo **transparente**. Se não for possível, use verde chapado **#00FF00**, uniforme e sem gradiente. Como o Eco é roxo e preto, o verde não conflita.
- Grade **invisível** de **4 colunas × 2 linhas**, com células de **384 × 512 px**. Ordem de leitura: linha de cima da esquerda para a direita, depois a linha de baixo. Células que sobrarem ficam vazias.
- O Eco olha **para a DIREITA** em todos os quadros.
- **Eixo do corpo centralizado na horizontal** da célula (x ≈ 192 px), exceto quando o pedido disser outra coisa.
- Mesma escala em todos os quadros. Nada sai da célula nem invade a vizinha.
- Sem texto, números, grade desenhada, chão, sombra projetada ou cenário.
- Só a pose muda entre os quadros. Design, cores e tamanho continuam idênticos.

**Linha de apoio:** o Eco paira. A parte mais baixa do corpo ou do jaleco fica a **120 px da borda de baixo da célula** no quadro 1, e oscila no máximo ±8 px ao longo do loop.

## Quadros

1. Pose neutra pairando: corpo levemente inclinado para a frente, braços soltos e um pouco afastados do corpo, olhos fixos para a frente.
2. Sobe 4 px, e a barra do jaleco ondula para trás.
3. Sobe mais 4 px (o topo do ciclo), com a aura levemente expandida.
4. Desce 4 px, e a barra do jaleco ondula para o outro lado.
5. Volta à altura do quadro 1, com os dedos se fechando levemente.
6. Desce 4 px (o fundo do ciclo) e emenda no quadro 1.

A rachadura ciano pisca de leve no quadro 3, sem estourar o brilho.

## Antes de entregar

1. Compare lado a lado com a ficha A0 e com as sheets do Daymon (proporção, contorno e número de tons).
2. Reduza a imagem a cerca de 25% e confira se a silhueta e a pose leem bem.
3. Confira se a linha de apoio (pés ou flutuação) está na mesma altura em todos os quadros.
4. Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**.

## Entrega

- Pasta: `colaboracao/entregas/A2_eco_float/`
- Arquivo: `A2_eco_float.png`
- `ENTREGA.md` com a lista dos quadros (o que acontece em cada um), a confirmação da aprovação e o SHA-256 do PNG.
- Atualize o `STATUS.md` para `ENTREGUE`.

**Pré-requisito:** o PNG da A0 precisa estar publicado em `colaboracao/entregas/A0_ficha_eco/` antes de começar, porque é a referência obrigatória deste pedido.
