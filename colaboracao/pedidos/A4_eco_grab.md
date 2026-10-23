# Pedido A4_eco_grab: Eco agarrando

**Etapa do jogo:** 7, Fuga do Eco
**Formato:** spritesheet com **6 quadros**
**Depende de:** A0_ficha_eco (direção artística aprovada; PNG precisa estar publicado)

## Uso no jogo

Toca quando o Eco alcança o jogador. Depois do quadro 4, o jogo aplica o dano e empurra o jogador. Velocidade: cerca de 12 quadros por segundo.

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

**Linha de apoio:** os **pés** na linha de chão, a **40 px da borda de baixo da célula**, igual à A3. **Exceção à centralização:** neste pedido, o eixo do corpo fica em **x ≈ 150 px**, para sobrar espaço para o braço esticado à frente. Nada passa de x = 376 px.

## Quadros

1. Saindo da corrida: o corpo se inclina mais e o braço da frente começa a subir.
2. Avanço: o braço da frente estica para a frente na altura do peito, com a mão aberta.
3. Os dedos viram garras curtas de energia roxa escura, no formato mostrado no detalhe da ficha A0. A rachadura ciano brilha mais.
4. Golpe: as garras se fecham à frente (é o momento do dano). Pode haver um pequeno arco de 2 ou 3 traços roxos.
5. Recolhe o braço, e as garras voltam a ser dedos.
6. Pose de transição de volta para a corrida, parecida com o quadro 1 da A3.

## Antes de entregar

1. Compare lado a lado com a ficha A0 e com as sheets do Daymon (proporção, contorno e número de tons).
2. Reduza a imagem a cerca de 25% e confira se a silhueta e a pose leem bem.
3. Confira se a linha de apoio (pés ou flutuação) está na mesma altura em todos os quadros.
4. Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**.

## Entrega

- Pasta: `colaboracao/entregas/A4_eco_grab/`
- Arquivo: `A4_eco_grab.png`
- `ENTREGA.md` com a lista dos quadros (o que acontece em cada um), a confirmação da aprovação e o SHA-256 do PNG.
- Atualize o `STATUS.md` para `ENTREGUE`.

**Pré-requisito:** o PNG da A0 precisa estar publicado em `colaboracao/entregas/A0_ficha_eco/` antes de começar, porque é a referência obrigatória deste pedido.
