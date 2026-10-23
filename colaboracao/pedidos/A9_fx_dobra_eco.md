# Pedido A9_fx_dobra_eco: Dobra espectral (atalho do Eco)

**Etapa do jogo:** 7, Fuga do Eco
**Formato:** spritesheet com **8 quadros** (efeito, sem o Eco)
**Depende de:** A0_ficha_eco (paleta e rachadura do Eco); pode ser feito em paralelo com A1 e A5
**Decisão de design:** [D01](../decisoes/D01_locomocao_eco.md). O Eco persegue **flutuando**, e não correndo.

## Uso no jogo

Quando o jogador abre muita distância usando o elevador ou os ganchos do Arpão, o Eco não atravessa a parede de forma seca. Ele **se dobra**:
1. toca os quadros 1 a 4 da A5 (se desfaz);
2. neste efeito, uma fenda se abre no ar, mais perto do jogador;
3. ele reaparece com os quadros 1 a 4 da A1.

Este efeito é a **fenda de saída**. Ela aparece no ar ou rente a uma parede. Velocidade: cerca de 14 quadros por segundo (0,6 s).

## Regras visuais (DA-01)

- **Diretriz obrigatória:** `colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md` (DA-01).
- **Referência principal:** a ficha **A0 aprovada** (`colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png`). Copie dela o design, a paleta, a aura, os fragmentos, os olhos e a rachadura ciano, **exatamente como na ficha**.
- **Referência de proporção e de animação:** as spritesheets do Daymon usadas no jogo (veja `arte_original/USADAS_NO_JOGO.md`), por exemplo `arte_original/01_Daymon_sem_braco/run_v2_verde.png`. A fenda deve ter mais ou menos a altura do Eco da A2 (cerca de 300 px no quadro de maior abertura).
- Mesmo traço cartunizado, contornos limpos e sombreamento econômico em **todos os quadros**.
- **Efeitos contidos:** no máximo 3 a 5 fragmentos soltos por quadro, e a aura não pode cobrir a silhueta. Nenhum quadro pode virar só uma mancha de partículas, exceto onde o pedido disser.
- Proibido: realismo, chamas, brilho em todos os contornos, anatomia alongada e mudança de estilo entre os quadros.
- **Não use** propostas do Eco rejeitadas antes como referência.

## Regras técnicas (recorte automático)

- **Um PNG de 1536 × 1024 px** com fundo **transparente**. Se não for possível, use verde chapado **#00FF00**, uniforme e sem gradiente. Como o Eco é roxo e preto, o verde não conflita.
- Grade **invisível** de **4 colunas × 2 linhas**, com células de **384 × 512 px**. Ordem de leitura: linha de cima da esquerda para a direita, depois a linha de baixo. Células que sobrarem ficam vazias.
- Mesma escala em todos os quadros. Nada sai da célula nem invade a vizinha.
- Sem texto, números, grade desenhada, chão, sombra projetada ou cenário.
- Só a pose muda entre os quadros. Design, cores e tamanho continuam idênticos.

**Linha de apoio:** o Eco paira. A parte mais baixa do corpo ou do jaleco fica a **120 px da borda de baixo da célula** no quadro 1, e oscila no máximo ±8 px ao longo do loop.

**Ponto de referência (âncora):** o **centro da fenda** fica no **centro da célula (192, 256)** em todos os quadros. A fenda é **vertical**, com no máximo 300 px de altura e 120 px de largura no quadro de maior abertura.

## Quadros

1. Um ponto de luz ciano pequeno.
2. O ponto vira uma risca vertical fina e escura, com borda ciano.
3. A risca se abre num rasgo estreito, com interior preto-arroxeado e 2 faíscas ciano.
4. O rasgo se abre mais, com bordas irregulares como vidro quebrado, no mesmo traço das rachaduras da prancha do laboratório.
5. Abertura máxima, com brilho roxo contido no interior e 3 ou 4 fragmentos saindo para os lados. É o momento em que o Eco sai.
6. O rasgo começa a fechar.
7. Sobra uma risca fina.
8. Some, deixando 1 ou 2 faíscas finais.

O efeito deve combinar com a rachadura ciano do peito do Eco: mesma cor de borda e o mesmo tipo de quebra. Isso deixa claro para o jogador que **a fenda é do Eco**.

## Antes de entregar

1. Compare lado a lado com a rachadura do peito na ficha A0 e com as rachaduras da Prancha de Elementos do Laboratório.
2. Reduza a imagem a cerca de 25% e confira se a silhueta e a pose leem bem.
3. Confira se o ponto de referência (âncora) está exatamente na mesma posição em todos os quadros.
4. Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**.

## Entrega

- Pasta: `colaboracao/entregas/A9_fx_dobra_eco/`
- Arquivo: `A9_fx_dobra_eco.png`
- `ENTREGA.md` com a lista dos quadros (o que acontece em cada um), a confirmação da aprovação e o SHA-256 do PNG.
- Atualize o `STATUS.md` para `ENTREGUE`.

**Pré-requisito:** o PNG da A0 precisa estar publicado em `colaboracao/entregas/A0_ficha_eco/` antes de começar, porque é a referência obrigatória deste pedido.
