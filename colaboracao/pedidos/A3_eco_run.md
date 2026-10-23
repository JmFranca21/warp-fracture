# Pedido A3_eco_run: Eco correndo (loop)

> **SUSPENSO, aguardando a decisão [D01](../decisoes/D01_locomocao_eco.md).** A locomoção do Eco (correr no chão × avançar flutuando) está em discussão. **Não comece este pedido.** Ele será reescrito ou reaberto depois da decisão.


**Etapa do jogo:** 7, Fuga do Eco
**Formato:** spritesheet com **8 quadros**
**Depende de:** A0_ficha_eco (direção artística aprovada; PNG precisa estar publicado)

## Uso no jogo

Usada durante toda a perseguição. O Eco corre no chão, mais rápido e mais "errado" que o Daymon: corpo inclinado para a frente e braços para trás. Velocidade: cerca de 13 quadros por segundo, igual à corrida do Daymon.

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

**Linha de apoio:** os **pés** tocam a mesma linha de chão, a **40 px da borda de baixo da célula**, como nas sheets do Daymon. O pé de apoio fica sempre exatamente nessa linha.

## Quadros

Faça um ciclo de corrida completo com 8 quadros, como o `run_v2_verde.png` do Daymon: contato, recuo, passagem e impulso, para cada perna.
- Tronco inclinado uns 15° para a frente.
- Braços estendidos para trás, como se fosse "puxado" para a frente.
- A cabeça fica estável e os olhos fixos no alvo.
- A barra do jaleco esvoaça para trás e se desfaz em 2 ou 3 pontas.
- 1 ou 2 fragmentos se soltando das costas em cada quadro.

O quadro 8 emenda no quadro 1.

## Antes de entregar

1. Compare lado a lado com a ficha A0 e com as sheets do Daymon (proporção, contorno e número de tons).
2. Reduza a imagem a cerca de 25% e confira se a silhueta e a pose leem bem.
3. Confira se a linha de apoio (pés ou flutuação) está na mesma altura em todos os quadros.
4. Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**.

## Entrega

- Pasta: `colaboracao/entregas/A3_eco_run/`
- Arquivo: `A3_eco_run.png`
- `ENTREGA.md` com a lista dos quadros (o que acontece em cada um), a confirmação da aprovação e o SHA-256 do PNG.
- Atualize o `STATUS.md` para `ENTREGUE`.

**Pré-requisito:** o PNG da A0 precisa estar publicado em `colaboracao/entregas/A0_ficha_eco/` antes de começar, porque é a referência obrigatória deste pedido.
