# Pedido A3_eco_avanco: Avanço flutuante agressivo (loop)

**Etapa do jogo:** 7, Fuga do Eco
**Formato:** spritesheet com **6 quadros**
**Depende de:** A0_ficha_eco (direção artística aprovada; PNG precisa estar publicado)
**Decisão de design:** [D01](../decisoes/D01_locomocao_eco.md). O Eco persegue **flutuando**, e não correndo.

## Uso no jogo

É a locomoção principal da perseguição. O Eco mergulha pelo ar em direção ao jogador, na altura do tronco dele. É um loop, a cerca de 12 quadros por segundo. O jogo vira o sprite quando o Eco muda de direção.

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
- Mesma escala em todos os quadros. Nada sai da célula nem invade a vizinha.
- Sem texto, números, grade desenhada, chão, sombra projetada ou cenário.
- Só a pose muda entre os quadros. Design, cores e tamanho continuam idênticos.

**Linha de apoio:** o Eco paira. A parte mais baixa do corpo ou do jaleco fica a **120 px da borda de baixo da célula** no quadro 1, e oscila no máximo ±8 px ao longo do loop.

**Ponto de referência (âncora):** o **centro do tronco** fica em **(x 200, y 280)** da célula, exatamente igual em todos os quadros. Nada fica abaixo da linha a 40 px da borda de baixo.

## Pose base (todos os quadros)

- Corpo inclinado uns **35° para a frente**, como se mergulhasse em direção ao alvo, com a cabeça à frente.
- Braços estendidos **para trás**, ao lado do corpo, com os dedos abertos.
- **Pernas juntas, arrastadas para trás** e levemente dobradas. **Sem passos e sem contato com o chão.**
- A barra do jaleco espectral se estica para trás e se desfaz em 2 ou 3 pontas.
- Olhos fixos à frente, com a rachadura ciano visível.

## Quadros (ondulação do loop)

1. Pose base, com o tronco na altura de referência.
2. O tronco sobe 3 px e o jaleco ondula para cima.
3. O tronco sobe mais 3 px (topo), com 1 fragmento se soltando das costas.
4. O tronco volta à altura de referência e o jaleco ondula para baixo.
5. O tronco desce 3 px, e os braços abrem um pouco mais para trás.
6. O tronco desce mais 3 px (fundo) e emenda no quadro 1. Um fragmento se solta.

Efeitos contidos: no máximo 1 ou 2 fragmentos novos por quadro, e um rastro curto (até 40 px) de 2 traços roxos atrás do jaleco. O rastro não pode cobrir a silhueta.

**Continuidade:** a pose deve sair naturalmente do quadro 1 da A2 (float). O jogo faz uma transição curta entre as duas.

## Antes de entregar

1. Compare lado a lado com a ficha A0 e com as sheets do Daymon (proporção, contorno e número de tons).
2. Reduza a imagem a cerca de 25% e confira se a silhueta e a pose leem bem.
3. Confira se o ponto de referência (âncora) está exatamente na mesma posição em todos os quadros.
4. Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**.

## Entrega

- Pasta: `colaboracao/entregas/A3_eco_avanco/`
- Arquivo: `A3_eco_avanco.png`
- `ENTREGA.md` com a lista dos quadros (o que acontece em cada um), a confirmação da aprovação e o SHA-256 do PNG.
- Atualize o `STATUS.md` para `ENTREGUE`.

**Pré-requisito:** o PNG da A0 precisa estar publicado em `colaboracao/entregas/A0_ficha_eco/` antes de começar, porque é a referência obrigatória deste pedido.
