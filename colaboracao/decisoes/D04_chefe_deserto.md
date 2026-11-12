# D04: Chefe do Deserto de Ferrugem

**Estado:** PROPOSTA. Aguarda decisão do João Marcelo.
**Autor:** Claude (design e desenvolvimento) · 11/11/2026
**Base:** GDD v2, pág. 8 ("Forja-Mãe (Ferrumgrado): IA da fábrica; luta em 3 fases, cada uma com um núcleo a destruir; quer usar o fragmento para invadir outras realidades"); detalhamento do Deserto (que termina na porta do Núcleo, sem chefe); D03 (Autômato).

O chefe é uma **ampliação** do percurso. As três zonas não mudam. A porta de saída do Salão (DF38) passa a levar à câmara do chefe, e não encerra mais a fase.

## Opção A (recomendada): Forja-Mãe

A IA da fábrica, fixa na parede da Câmara da Forja. O fragmento virou o seu núcleo (GDD pág. 5: "O fragmento virou o núcleo de uma fábrica de robôs").

**Por que recomendo:** já está no GDD, fecha a história do fragmento e usa tudo o que a fase ensinou: âncoras, esteira, prensas, válvulas e drones. Por ser **fixa e montada em peças**, o jogo anima braços, martelos, olho e placas por código, como já faz com as prensas (DF50). Isso custa muito menos arte do que um chefe que anda, cujos quadros precisam ser todos desenhados.

## Opção B: Sentinela de Esteira

Um robô-tanque gigante (2,5 D) sobre esteiras, que persegue o jogador pelo Salão do Núcleo. Ataca com um braço-prensa e tem o ponto fraco nas costas, alcançado passando por cima dele com as âncoras do teto.

**Contras:** precisa de folhas completas de andar, virar, atacar, dano e destruição. Não tem ligação com o fragmento e disputa espaço com o percurso do Salão, que já está pronto.

## Forja-Mãe em detalhe

### Arena e entrada

- **Estação nova** no Salão, logo antes da porta (x ≈ 6650). Ela é o checkpoint do chefe.
- A porta DF38 se abre quando o jogador se aproxima e leva à **Câmara da Forja**, uma sala nova de uma tela e meia (cerca de 1500 × 760 px, de x 6990 a 8490). Ao entrar, a porta se fecha atrás dele (DF38 fechada) e a câmera se abre para mostrar a sala inteira (como na arena da Rainha).
- O chão é de chapa (DF25). No centro, uma **faixa de esteira** de 600 px (DF26) fica desligada na fase 1. No alto, um **trilho de teto** atravessa a sala (DF55b), e nele correm os carrinhos dos dois braços. **Duas âncoras fixas** (DF57) ficam no teto, a 300 px do chão, em x 7400 e 8080.
- **Duas válvulas** (DF56) ficam no chão, junto às paredes laterais.
- A porta da direita (DF38, trancada) é a saída depois da vitória.

### Silhueta e escala

- **Corpo:** uma fornalha-cabeça embutida na parede do fundo, no centro da sala, com 3,5 D de altura (~300 px no jogo). Tem a forma de um forno de ferro com ombros largos, uma grade de fornalha brilhando embaixo e uma **única lente-olho** grande no alto (âmbar em repouso, vermelha no feixe).
- **No peito, a câmara do núcleo:** três placas blindadas fecham o fragmento ciano, visível pelas frestas.
- **Dois braços-guindaste** pendurados no trilho do teto. Cada um tem um carrinho, dois segmentos articulados e uma **cabeça de martelo** de 1,4 D de largura com faixas de perigo (a mesma linguagem da prensa DF50). Em cima de cada martelo há uma **placa de âncora ciano**.
- **Leitura:** fábrica viva, pesada e paciente. Nada de rosto humano. A "expressão" está toda na lente e na abertura da grade.

### Golpes e sinais

| Golpe | Fase | Aviso (forma, luz e movimento) | Como escapar | Janela de punição |
|---|---|---|---|---|
| **Martelo** | 1, 2 | O carrinho corre no trilho até ficar sobre o jogador, soltando faíscas (DF82). O martelo **sobe 40 px**, as faixas acendem em vermelho e uma marca vermelha tracejada aparece no chão (0,7 s) | Sair da marca ou usar o Arranque | Martelo preso no chão por 1,6 s, com a placa de âncora acesa em ciano |
| **Rajada de rebites** | 1, 2, 3 | A lente fica âmbar forte, a grade se abre e a cabeça recua (0,5 s, a mesma regra de aviso do robô) | Três projéteis DF70 em duas alturas: pular o baixo, usar o Arranque no alto, ou desviá-los com o Pulso | Grade aberta por 0,8 s: rebites na grade causam o dobro de dano |
| **Esteira** | 2, 3 | Setas no piso acendem em sequência na direção da fornalha (1 s) e a esteira começa a ranger | Andar contra ela ou pular para fora; a grade da fornalha fere | — |
| **Drones** | 2 | Duas escotilhas nos ombros acendem em vermelho e se abrem (1 s) | Pulso Magnético derruba os dois; o feixe do ímã os puxa até o chão | Drone derrubado: 1 rebite |
| **Feixe da lente** | 3 | A lente fecha em um ponto vermelho e uma linha fina de mira varre o chão (1 s) | O feixe varre o chão a 40 px de altura, da direita para a esquerda: pular por cima ou estar sobre um martelo | Lente fica escura por 1 s |
| **Sobrecarga** | início da 3 | A fornalha ruge e as válvulas laterais avisam (DF56 aviso) | Ficar longe das paredes | — |

### Um ataque completo: Martelo (fase 1)

| Tempo | O que acontece | O jogador |
|---|---|---|
| 0,0–0,6 s | O carrinho do braço esquerdo corre no trilho e para sobre o jogador. Faíscas no trilho e rangido | Vê o braço vindo |
| 0,6–1,3 s | **Aviso:** o martelo sobe 40 px e para. As faixas acendem em vermelho, a marca tracejada aparece no chão e toca o som de carga | Sai da marca ou se prepara para o Arranque |
| 1,3–1,45 s | **Impacto:** o martelo bate. Faíscas DF82, tremor de câmera e uma onda de 40 px de cada lado no chão | Se estiver na marca, leva dano (sem recuo) |
| 1,45–3,05 s | **Preso:** o martelo fica cravado. A placa de âncora em cima dele acende em ciano. O **núcleo do pistão**, laranja e exposto, fica visível **só por cima**, na junta do braço | Aperta F, é puxado pelo ímã até o martelo, fica de pé sobre o braço e atira no núcleo, quase à queima-roupa (2 ou 3 rebites por janela) |
| 3,05–3,55 s | **Recuperação:** o martelo se solta e volta a subir. Quem estiver em cima cai sem dano | Pousa e se reposiciona |

### Mudança ao longo da luta (os três núcleos do GDD)

| Fase | Núcleo a destruir | O que muda |
|---|---|---|
| **1** | Pistão do braço esquerdo (6 rebites) | Só o braço esquerdo ataca, alternando com rajadas de rebites. Ensina a ler o martelo e a usar o ímã no braço |
| **2** | Pistão do braço direito (6 rebites) | O braço esquerdo destruído fica pendurado e sem força. O direito ataca mais rápido (aviso de 0,55 s). A esteira liga e as escotilhas soltam drones. Combina esteira e drones, como na Fábrica e no Salão |
| **3** | Núcleo central, a câmara do fragmento (8 rebites) | Os dois braços caem. As placas do peito são magnéticas e só se abrem com o **Pulso Magnético a menos de 150 px**: o jogador sobe por uma das âncoras do teto, salta perto do peito e solta o pulso no ar. As placas voam por 3 s e o fragmento fica exposto. Entram o feixe da lente e a sobrecarga das válvulas |

**O que a fase ensinou e a luta cobra:** o ímã em âncoras (os três vãos) vira a forma de subir no martelo e de chegar ao peito. O ritmo das prensas vira a leitura do martelo. A esteira e as válvulas voltam como pressão de espaço. O Pulso contra drones e o feixe do ímã voltam contra os drones das escotilhas.

### Checkpoint, nova tentativa e recompensa

- **Ao morrer:** o jogador volta à estação antes da porta com a vida cheia. A Forja-Mãe volta inteira. A abertura (porta fechando e a lente acendendo) dura 2 s e não se repete depois da primeira vez.
- **Ao vencer:** a lente apaga, os braços caem (DF84), a fornalha esfria e a câmara do peito se abre. O **fragmento 2/4** sobe da câmara e o jogador o pega, com a mesma sequência de Verdâmia (D02): letreiro, IRIS e save.
- **A porta de saída** (direita) se abre e mostra a **fenda de retorno** ao Hélix (D05). A porta de entrada também reabre, para o jogador voltar a explorar a fase. Depois da vitória, as duas ficam abertas para sempre (`boss_done`).
- **Recompensa extra:** proponho **só o fragmento** nesta etapa. Um módulo novo da arma (o GDD lista o Dispersor, o Canhão de Carga e a Lança de Fase) pode ser decidido junto com a volta ao Laboratório.

### Peças: o que já existe e o que é inédito

| Já entregue e reaproveitado | Arte inédita (lote 3) |
|---|---|
| DF24 parede do salão (fundo da câmara), DF25 piso, DF26 esteira, DF55b trilho (teto), DF57 âncoras, DF56 válvulas e DF81 jato, DF66–DF69 drones, DF70 projétil, DF82 faíscas, DF84 explosão, DF85 impacto, DF37 lâmpadas e DF38 portas | Corpo fixo (DF100), lente em 4 estados (DF101), placas e câmara do núcleo (DF102), carrinho do braço (DF103), segmento do braço (DF104), martelo com âncora em 4 estados (DF105), núcleo do pistão em 3 estados (DF106), escotilha (DF107), grade da fornalha em loop (DF108), feixe da lente (DF110), carga da lente (DF111), explosão de núcleo (DF112) |

**Feito por código, sem arte:** a marca de aviso no chão, as setas da esteira, o tremor de câmera, o clarão de dano, os movimentos dos braços, as placas voando e a queda dos braços.

## O que precisa de aprovação

1. Opção A ou B.
2. Nome "Forja-Mãe" e o fragmento como núcleo da IA.
3. Câmara nova depois da porta do Salão, com uma estação antes.
4. Recompensa: só o fragmento, ou fragmento mais um módulo.
5. Vida de cada núcleo (6, 6 e 8 rebites) como ponto de partida para teste.
