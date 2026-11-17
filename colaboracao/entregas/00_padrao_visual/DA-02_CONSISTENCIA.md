# Warp Fracture — Régua de consistência visual (DA-02)

**Status:** PROPOSTA, aguardando a aprovação do João Marcelo. Depois de aprovada, vale para toda arte nova, junto com a [DA-01](PADRAO_VISUAL_OFICIAL.md).
**Origem:** [auditoria de consistência do Deserto](../../../docs/auditoria_deserto/) (17/11/2026).
**Autoria:** Claude (desenvolvimento), com revisão pedida ao ChatGPT (direção de arte).

## Por que existe

A DA-01 descreve o estilo em palavras. No Deserto isso não bastou: as fichas DF00/DF01 e DF02/DF03 seguiram a DA-01 ao pé da letra e mesmo assim criaram duas famílias visuais que não combinam entre si nem com o Laboratório e Verdâmia. A DA-02 transforma o estilo das peças aprovadas em **números conferíveis** e acrescenta uma **prancha de comparação obrigatória** em toda entrega.

Parte do problema veio também do pedido: a ficha DF02 pedia 0,8 D de largura, tronco em barril e pés largos. Os pedidos de agora em diante também seguem esta régua.

## Base de medição

Medido nas peças aprovadas, na escala de ficha **D = 400 px = altura do Daymon** (no jogo, D ≈ 91 px de tela):

| Peça aprovada | Altura | Contorno escuro na borda | Cor do contorno | Saturação média | Cores efetivas |
| --- | --- | --- | --- | --- | --- |
| Daymon (ficha oficial) | 1,00 D | parcial (jaleco sem traço) | azul-marinho | baixa | ~8 |
| Eco (A3) | 0,70 D (flutuando) | 26% | #302389 violeta | 0,85 (aura) | 10 |
| Lince-Vagalume | 0,67 D | 36% | #253045 azul-marinho | 0,52 | 8 |
| Mariposa | 0,58 D | 75% | #2e3035 | 0,22 | 10 |
| Esporângio | 0,86 D | 46% | #1d3d3e verde-escuro frio | 0,54 | 11 |
| Rainha Micélia | 3,14 D | 19% | #372e4c violeta | 0,43 | 13 |
| Pedra com musgo, Altar (objetos) | 0,96–1,43 D | 83–93% | #102027–#142426 | 0,49–0,54 | 8–10 |
| Arco de Dobra PT10 (objeto) | 2,36 D | 97% | #0f1422 | 0,38 | 12 |

Para comparação, o que saiu da régua no Deserto:

| Peça | Altura | Contorno escuro na borda | Cor do contorno | Problema |
| --- | --- | --- | --- | --- |
| Autômato (DF90) | 1,08 D, largura 0,76 da altura | 96% | #23191a preto-marrom | Contorno fechado e quente, proporção de mascote, ferrugem dominando o herói |
| Robô (DF60) | 0,77 D | 87% | #221513 preto-marrom | Contorno fechado e quente, sem ponto de leitura |
| Drone (DF66) | 0,30 D | 88% | #2c2323 | Pequeno demais |
| Forja-Mãe (DF100) | 3,62 D | 95% | #2c1c1b | Contorno fechado e quente; listras de aviso como enfeite |

## As regras

### R1. Escala única
- D = 400 px no desenho original é a altura do Daymon humano. Toda peça é desenhada nessa régua, e a ficha mostra a faixa de escala com o Daymon em silhueta.
- Inimigos comuns: **0,55 D a 1,0 D** de altura. Voadores: no mínimo **0,55 D** de altura ou **0,7 D** de largura.
- Chefes: **2,5 D a 3,5 D**. Objetos interativos: **0,5 D a 1,5 D**.
- No jogo a escala é sempre **uniforme**: nenhuma peça é esticada só na largura ou só na altura (regra do código, conferida pelo desenvolvimento).

### R2. Formas do Daymon pertencem ao universo
- A forma **não precisa seguir a estética do Daymon**. Ela segue a estética do universo em que aparece, como um ser nativo dali: o Lince-Vagalume é muito diferente do Daymon e funciona porque combina com Verdâmia (observação do João, 17/11/2026).
- O Lince é exemplo desse princípio, **não modelo** para as outras formas: cada forma tem a linguagem do seu próprio universo.
- O que vale para todas é o resto desta régua (escala, contorno, tons, saturação, valores) e a leitura de jogo: a forma se distingue dos inimigos da mesma fase à primeira vista. Como marcar isso fica a critério da direção de arte.

### R3. Contorno (a regra que mais mudou)
- **Personagens e inimigos não têm traço preto em volta.** A forma é feita por blocos de cor; o contorno escuro aparece em **no máximo metade da borda** (aprovados: 19% a 46%) e some onde bate luz de recorte, no jaleco claro ou na energia.
- **Cor do contorno sempre fria:** azul-marinho, violeta ou verde-escuro frio, com azul maior ou igual ao vermelho (faixa aprovada #1d2a3c a #372e4c). **Nunca preto puro nem marrom-preto**, nem em materiais quentes como ferrugem: a sombra mais escura da ferrugem é azul-marinho, não marrom.
- **Objetos de cenário** podem ter contorno fechado, fino e frio (a cor mais escura do próprio material puxada para o azul).

### R4. Tons
- **2 a 3 tons por superfície** (base, sombra, luz). Nada de degradê pintado nem ruído de textura.
- Até **12 cores efetivas** por figura (cores que ocupam mais de 2% da área).

### R5. Saturação e acentos
- Saturação média da figura entre **0,20 e 0,55**.
- Cores acima de 0,8 de saturação só nos **acentos de energia** (ciano do Traje Âncora, lima de Verdâmia, âmbar do destino Deserto, vermelho de perigo) e no máximo **10% da área** da figura.
- **Listras de aviso** (amarelo e preto, vermelho e branco) só onde há perigo de verdade no jogo, nunca como enfeite.

### R6. Estrutura de valores da cena
- O fundo de jogo fica **escuro**: luminosidade média da cena até **0,20** (Laboratório 0,10–0,13; Verdâmia 0,15–0,16).
- Personagem, inimigos e perigos ficam **mais claros ou de matiz diferente** do fundo atrás deles. Um universo de cor quente (Deserto) usa fundo quente **escuro** e personagens com sombras frias.
- A cor de material de um universo nunca é a cor principal do herói daquele universo.

### R7. Ponto de leitura dos inimigos
- Todo inimigo tem **um ponto de alto contraste** (olho, núcleo, luz) ocupando **4% a 10%** da silhueta, na cor de perigo (vermelho) ou na energia própria, nunca da cor do fundo.
- A silhueta do inimigo é diferente da do herói da fase à primeira vista, em tamanho reduzido.

### R8. Paleta comum
- Cada universo tem **uma família de material** (Laboratório: aço azulado; Verdâmia: verde-azulado e musgo; Deserto: ferrugem e cobre) **mais o azul-marinho comum do jogo** (#0f1422 a #253045) nas sombras e contornos. É esse azul-marinho que amarra os universos.

## Verificação obrigatória em cada entrega (prancha de comparação)

Além do checklist da DA-01, toda ficha e toda folha entregue vem com uma **prancha de comparação** (PNG separado, `<ID>_comparacao.png`):

1. A peça nova **ao lado do Daymon** (ficha oficial) e de **uma peça aprovada do mesmo tipo** (personagem com personagem, inimigo com inimigo, objeto com objeto), todos na escala D = 400 px.
2. A mesma linha **reduzida à escala do jogo** (Daymon com ~90 px de altura) sobre o fundo da fase.
3. No `ENTREGA.md`, a tabela da régua preenchida: altura em D, largura/altura, cor do contorno (hex), parte da borda com contorno escuro (estimada), tons por superfície, saturação dos acentos e o ponto de leitura (inimigos).

Se algum número ficar fora da régua, a entrega diz qual e por quê, e o João decide antes do upload.

## Do lado do desenvolvimento

- Escala uniforme sempre; nada de esticar peça para caber num retângulo.
- Antes de cada entrega de fase: prancha das figuras na escala do jogo (`tools/lineup.gd`) e capturas de cena, conferidas contra R1, R6 e R7.
- Nada de preencher parede, teto ou peça faltando com cor chapada: se falta arte, o desenvolvimento pede.
