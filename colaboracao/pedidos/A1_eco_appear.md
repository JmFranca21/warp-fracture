# Pedido A1_eco_appear: Materialização do Eco

**Etapa do jogo:** 7, Fuga do Eco
**Formato:** spritesheet com **8 quadros**
**Depende de:** A0_ficha_eco (direção artística aprovada; PNG precisa estar publicado)

## Uso no jogo

Toca uma vez, quando o Eco surge na frente da porta de saída do laboratório e a fuga começa. Velocidade no jogo: cerca de 10 quadros por segundo (0,8 s).

## Regras visuais (DA-01)

- **Diretriz obrigatória:** `colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md` (DA-01).
- **Referência principal:** a ficha **A0 aprovada** (`colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png`). Copie dela o design, a paleta, a aura, os fragmentos, os olhos e a rachadura ciano, **exatamente como na ficha**.
- **Referência de proporção e de animação:** as spritesheets do Daymon usadas no jogo (veja `arte_original/USADAS_NO_JOGO.md`), por exemplo `arte_original/01_Daymon_sem_braco/run_v2_verde.png`. **Escala de desenho fixa do Eco:** use a **mesma escala da A2 entregue e integrada** (`colaboracao/entregas/A2_eco_float/A2_eco_float.png`). Na pose de pairar, a figura mede **380 px** do topo do cabelo à ponta dos pés. Todas as animações do Eco devem manter esse tamanho de cabeça e de corpo, para encaixar com a mesma escala de importação (a altura final no jogo é ajustada pelo `tools/import_cells.py`).
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

**Linha de apoio:** a mesma da animação A2 (float). A parte mais baixa do corpo ou do jaleco fica a **120 px da borda de baixo da célula**, porque o Eco paira cerca de 80 px acima do chão. O quadro 8 precisa ser **idêntico ao quadro 1 da A2**, para a transição não pular.

## Quadros

1. Uma rachadura ciano pequena se abre no ar, na altura do peito do Eco. Só a rachadura e 2 ou 3 fragmentos roxos.
2. A rachadura cresce, e fragmentos roxos escuros começam a se juntar em volta dela.
3. Os fragmentos formam a silhueta só em contorno escuro, quase sem preenchimento.
4. A silhueta se preenche de baixo para cima, até a cintura, com a cabeça ainda em contorno.
5. O corpo inteiro está preenchido, mas o jaleco ainda está curto e se formando.
6. O jaleco termina de se formar, e os olhos acendem pela primeira vez.
7. Pequena "assentada": o corpo encolhe levemente e a aura se contrai.
8. Pose final igual ao quadro 1 da A2.

Os quadros 1 a 3 podem ter mais fragmentos que o normal (até 8), porque é a materialização. A partir do 4, valem os limites de efeitos.

## Antes de entregar

1. Compare lado a lado com a ficha A0 e com as sheets do Daymon (proporção, contorno e número de tons).
2. Reduza a imagem a cerca de 25% e confira se a silhueta e a pose leem bem.
3. Confira se a linha de apoio (pés ou flutuação) está na mesma altura em todos os quadros.
4. Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**.

## Entrega

- Pasta: `colaboracao/entregas/A1_eco_appear/`
- Arquivo: `A1_eco_appear.png`
- `ENTREGA.md` com a lista dos quadros (o que acontece em cada um), a confirmação da aprovação e o SHA-256 do PNG.
- Atualize o `STATUS.md` para `ENTREGUE`.

**Pré-requisito:** o PNG da A0 precisa estar publicado em `colaboracao/entregas/A0_ficha_eco/` antes de começar, porque é a referência obrigatória deste pedido.
