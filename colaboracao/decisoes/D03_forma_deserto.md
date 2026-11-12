# D03: Forma de Daymon no Deserto de Ferrugem

**Estado:** PROPOSTA. Aguarda decisão do João Marcelo.
**Autor:** Claude (design e desenvolvimento) · 11/11/2026
**Base:** GDD v2, pág. 4 (formas) e pág. 5 (Ferrumgrado); `docs/fases/deserto_ferrugem/detalhamento_da_fase.md`; protótipo da branch `prototipo/deserto-de-ferrugem` (`b753433`).

## Divergência a resolver primeiro

- O **GDD** prevê para Ferrumgrado o **Autômato**: lento, não é empurrado, soco que quebra paredes e ímã. Como fraquezas, pulo curto e afundar na escória.
- O **detalhamento do Deserto** foi escrito para **Daymon humano**, com tiro e o Arpão em três vãos.
- O **GDD** também põe Hidrópolis antes de Ferrumgrado. O pedido atual faz do Deserto a Fase 2.

Proponho que o Deserto seja a **primeira área de Ferrumgrado** e a Fase 2 da campanha. Hidrópolis passa para depois. A forma abaixo concilia o Autômato do GDD com o percurso já desenhado e testado.

## Opção 1 (recomendada): Autômato de Fase

Ao atravessar, o Traje Âncora reveste Daymon com placas de sucata magnetizadas e o converte em uma máquina da mesma "língua" da fábrica. O cristal da cabeça do traje continua a mostrar os olhos de Daymon, e a faixa ciano do traje atravessa o peito.

| Item | Proposta |
|---|---|
| **Relação com o Deserto** | Ferrumgrado é um mundo de ímã, ferrugem e fábricas. O Autômato é feito de sucata do próprio deserto. As argolas ciano da fase (DF57) passam a ser **âncoras magnéticas** |
| **Silhueta** | Robô compacto e arredondado: cúpula de cabeça grande (mesma proporção de cabeça de Daymon, DA-01), visor de vidro com os olhos de Daymon, tronco em barril com a faixa ciano, pernas curtas e grossas, um **braço-ímã** separado do corpo (gira para mirar, como o braço armado humano). Lê-se como "pesado e amigável", nunca como os robôs inimigos (que são escuros, quadrados e de olho âmbar único) |
| **Escala** | 1,05 D de altura (Daymon = 1 D = 400 px no desenho; ~90 px no jogo) e 0,8 D de largura. Colisão de 30 × 62 px (humano: 24 × 62), então nenhuma passagem do percurso muda |
| **Habilidade principal** | **Ímã de Fase** (tecla F, a mesma do Arpão): um feixe magnético puxa o Autômato até uma âncora ciano ao alcance (380 px). Usa a mesma física do Arpão, já testada no protótipo, e o salto no meio da puxada solta com impulso. Sem âncora ao alcance, o feixe puxa **drones** até o chão à frente dele, atordoados por 1,5 s |
| **Ataque** | **Rebitadeira**: tiro mirado em 360°, como o Estabilizador. Cadência 20% menor, com o mesmo dano por tiro (robô: 3 tiros; drone: 2) |
| **Habilidade da forma (1/3 da energia)** | **Pulso Magnético**: onda de 150 px de raio. Derruba drones, para robôs por 2 s e desvia projéteis inimigos. Também derruba as peças imantadas do chefe (D04) |
| **Movimento** | Andar 0,85× o humano (272 px/s), **um pulo** com 90% da altura humana (~130 px), sem pulo duplo nem salto de parede. A esquiva vira **Arranque**: avanço curto sobre as rodas dos pés, com invulnerabilidade |
| **Peso** | **Não sofre recuo** ao levar dano (vantagem nas plataformas sobre espinhos). A esteira o empurra normalmente, porque ele está apoiado nela |
| **Quando assume o controle** | Na chegada às Dunas, depois do banner "NOVA FORMA: AUTÔMATO". **A fase inteira é jogada nessa forma.** Não há troca no meio da fase |

### Diferença em relação ao Lince-Vagalume

| | Lince (Verdâmia) | Autômato (Deserto) |
|---|---|---|
| Ritmo | Rápido e leve | Lento e pesado |
| Ar | Pulo duplo e salto de parede | Um pulo; mobilidade aérea vem do ímã |
| Combate | Corpo a corpo (garras, golpe para baixo que quica) | À distância (rebites mirados), mais controle de área (pulso) |
| Dano | Recua ao ser atingido | Não recua |
| Especial | Clarão que atordoa | Pulso que derruba drones e desvia tiros |

### O que continua, o que muda

| Ação humana | No Autômato |
|---|---|
| Andar, pular, descer de plataforma (S + Espaço) | **Continuam**, com andar mais lento e pulo um pouco mais baixo |
| Atirar com mira 360° | **Continua** como Rebitadeira |
| Tiro carregado (habilidade da forma) | **Muda** para Pulso Magnético |
| Esquiva | **Muda** para Arranque (mesma tecla e recarga) |
| Arpão até ganchos | **Muda** para Ímã de Fase (mesma tecla e alcance). O Arpão humano continua sendo o módulo da arma no Laboratório |

### Três situações concretas

1. **Dunas de Sucata: drone sobre o fosso.** Da plataforma larga, o jogador mira para cima e derruba o drone com dois rebites. Ou espera o drone passar por cima e usa o Pulso Magnético: o drone cai no fosso e explode. Depois pula na beira, aperta F perto da argola do mastro, é puxado e salta no fim da puxada para a margem direita, pegando as três células do arco. Ao pousar, o robô da margem não o empurra de volta para os espinhos, porque o Autômato não recua.
2. **Fábrica Autônoma: esteira e plataformas.** A esteira leva o Autômato, que é lento, na direção das prensas. Ele espera a prensa subir e anda junto com a esteira. Pula a serra no tempo certo: o pulo de 130 px passa os 70 px da serra com folga. No fim da esteira faz dois pulos curtos (75 e 80 px de subida, já medidos no protótipo) até a plataforma grande. Ali usa o Pulso para parar o robô e o derruba com rebites. Depois aperta F na âncora da abertura da parede e é puxado até o corredor.
3. **Salão do Núcleo: válvulas e drone.** O drone patrulha sobre as duas válvulas. O jogador usa o **feixe do ímã no drone**: puxa-o para baixo, na frente da válvula, e o jato de vapor o destrói. Ou atira entre os jatos. Na plataforma móvel sobre os espinhos, o peso do Autômato não muda nada no embarque: o desafio continua sendo o tempo.

**Os três vãos de gancho:** sobre o fosso das Dunas (mastro), na abertura da parede da Fábrica e no teto do corredor suspenso. Os três são atravessados com o **Ímã de Fase**, nas mesmas posições do protótipo: (975, 510), (3510, 345) e (4205, 230). As argolas DF57 continuam valendo: já são metálicas, com anel ciano.

## Opção 2: Escaravelho de Sucata

Um besouro pequeno de carapaça de chapa (0,6 D), que **plana** com os élitros, **se enterra na areia** para escapar de tiros e ataca com uma **investida de chifre**.

**Contras:** os três vãos de gancho viram vãos de planar, e é preciso refazer o layout e as distâncias. Sem tiro, os drones precisam de outra regra. O corpo a corpo fica próximo do Lince. E diverge do Autômato do GDD. É mais retrabalho para uma fase cuja arte já está entregue.

## O que precisa de aprovação

1. Opção 1 ou 2, e o nome: "Autômato de Fase" ou apenas "Autômato".
2. Deserto como primeira área de Ferrumgrado e Fase 2 da campanha (Hidrópolis depois).
3. Escala de 1,05 D, com colisão 30 × 62.
4. O soco que quebra paredes do GDD fica para as próximas áreas de Ferrumgrado (não é necessário neste percurso).
