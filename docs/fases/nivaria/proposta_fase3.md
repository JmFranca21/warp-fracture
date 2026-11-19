# Fase 3: proposta para o universo de gelo (Nivária)

**Estado:** PROPOSTA (19/11/2026). As decisões D06–D08 dependem do João Marcelo.
**Autor:** Claude (design e desenvolvimento).
**Ponto de partida:** o [esboço de level design](esboco_level_design.png) do João, com quatro zonas: Cume Congelado, Caverna de Cristal, Encosta Nevada e Arena do Chefe Final. Pedidos do João: inimigos que **congelam** o jogador, uma parte de **plataformas quebradiças de gelo** e uma encosta onde **bolas de neve** rolam e o jogador usa o **gancho** para escapar.
**Diretrizes de arte:** [DA-01](../../../colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) e [DA-02](../../../colaboracao/entregas/00_padrao_visual/DA-02_CONSISTENCIA.md), aprovadas.
**Lições do Deserto aplicadas:** fichas primeiro e só depois as folhas; pedidos sem proporção fixa de forma; densidade de inimigos igual à de Verdâmia; registros e segredos desde o começo; objetos e coletáveis próprios do universo.

## Resumo

| Tema | Proposta |
| --- | --- |
| Universo | **Nivária** (nome de trabalho, do latim *nix, nivis*, neve): um mundo de picos sob uma noite polar sem fim, com auroras cor-de-rosa. O fragmento caiu no cume e está **sugando o calor** do mundo; a cada hora o gelo avança. Tom: silêncio, solidão e beleza fria, com alívio no fim |
| Lugar na campanha (D06) | **Fase 3**, depois do Deserto. Recomendação: Nivária entra no lugar de Hidrópolis entre os quatro universos, e Hidrópolis passa para a expansão "O Quinto Sinal". A história dos quatro fragmentos não muda |
| Forma (D07) | **Coruja-de-Geada**: ave de rapina das montanhas, leve e de penas claras com calor interno. Plana sobre os poços, mergulha até os ganchos com as garras e solta o calor do corpo para se livrar do gelo |
| Regra do universo | **Geada**: golpes de frio acumulam camadas no corpo; com três camadas, Daymon **congela** dentro de um bloco de gelo. O calor (braseiros e a Sacudida Térmica) tira a geada |
| Chefe (D08) | **Guardião Glacial**: um colosso de gelo que se formou em volta do fragmento. O fragmento é o núcleo no peito, protegido por três placas de gelo que só o calor derrete |
| Tamanho | ~9.000 px, como o Deserto; 4 zonas, 4 checkpoints, 12 inimigos, 3 Núcleos de Integridade, 3 Registros |

## D06. Universo e lugar na campanha

O GDD prevê quatro universos (Verdâmia, Hidrópolis, Ferrumgrado e Umbra) e quatro fragmentos. A fase de gelo é nova e precisa de um lugar.

| Opção | O que muda | Prós | Contras |
| --- | --- | --- | --- |
| **A (recomendada).** Nivária substitui Hidrópolis entre os quatro; Hidrópolis vai para o DLC "O Quinto Sinal" | GDD (págs. 1, 5 e 8), tabela de formas (o Cefalóide vai junto para o DLC) | A história dos 4 fragmentos fica intacta; o DLC ganha um universo já pensado; nenhuma forma nova fica sem fase | O nado livre sai da campanha principal |
| B. Nivária vira o quinto universo e a campanha passa a 5 fragmentos | GDD inteiro, a Máquina de Dobra (5 fragmentos), o HUD e o Receptáculo | Não perde nada do plano | Campanha mais longa; o "quinto sinal" do epílogo perde o sentido |
| C. Nivária é uma área de Umbra ou de outro universo já previsto | Universo existente | Nenhuma mudança na contagem | Gelo não combina com o vazio de Umbra; dilui a identidade das duas |

**Entrada:** o fragmento da Forja-Mãe é instalado no Receptáculo, IRIS detecta um sinal frio e o Arco ganha o destino **Nivária**. Cor do destino no portal: **rosa-aurora #FF8FD0** (Laboratório ciano, Verdâmia lima, Deserto âmbar).

**Lore curta (para os Registros e IRIS):** Nivária tinha estações de observação no alto dos picos, deixadas por um povo que estudava as auroras. Quando o fragmento caiu no cume, o céu parou de clarear. O frio que ele emite tomou forma no Guardião. A **névoa roxa** que enche os poços é a fratura vazando do fragmento, a mesma energia de que o Eco se alimenta.

## D07. Forma: Coruja-de-Geada

### Opção 1 (recomendada): Coruja-de-Geada

| Item | Proposta |
| --- | --- |
| Relação com o universo | A ave que caça nos picos de Nivária. Penas claras para se esconder na neve e um **calor interno** que a mantém viva no frio: é a única coisa quente da fase |
| Leitura visual | Silhueta de ave de rapina, bípede, asas que abrem bem na planagem. Valor **claro** sobre o céu escuro e um **acento quente** (brasa sob as penas), o que a separa dos inimigos frios e de foco vermelho. A marca ciano do Traje Âncora continua visível (regra do GDD, pág. 2). Forma e proporção livres na ficha (DA-02, R2) |
| Movimento | Andar e pulo iguais aos do humano. **Planar**: segurar o pulo no ar reduz a queda a ~70 px/s e mantém 300 px/s na horizontal. Sem pulo duplo (é do Lince) |
| Gancho | **Garra-Gancho** (tecla F, a do Arpão): mergulha até um ponto de gancho ao alcance (380 px) e se agarra; pode encadear ganchos no ar; pular no meio solta com impulso. Mesma física do Arpão e do Ímã, já testada |
| Ataque | **Rajada de Penas**: três penas de gelo em leque curto à frente; no ar, pode mirar para cima ou para baixo. Gelinho: 2 rajadas; Morcego e Drone: 1 |
| Habilidade (1/3 da energia) | **Sacudida Térmica**: eriça as penas e solta calor em volta (raio 140 px). Tira toda a geada, liberta do bloco de gelo na hora, derrete placas de gelo que bloqueiam passagens, quebra bolas de neve pequenas e derrete as placas do chefe |
| Fraqueza | **Leve**: leva recuo maior ao sofrer dano e é empurrada pelo vento e pelas bolas de neve |
| Quando assume | Na chegada a Nivária, com o banner "NOVA FORMA: CORUJA-DE-GEADA". A fase inteira é jogada nessa forma |

### Opção 2: Arminho-das-Neves

Mustelídeo pequeno e rápido que **desliza** de barriga no gelo e entra em túneis de neve. Tem mecânicas boas para a encosta (deslizar ladeira abaixo à frente das bolas), mas é quadrúpede, pequeno e ágil como o Lince, e as duas formas ficariam parecidas. Também não tem um jeito natural de usar o gancho. Não recomendado.

## Regra do universo: Geada

| Item | Proposta |
| --- | --- |
| Acúmulo | Golpes de frio adicionam **camadas de geada** (máximo 3). Cada camada reduz a velocidade em 15% e aparece no corpo (gelo crescendo nas penas) |
| Congelar | Na terceira camada, Daymon fica **preso num bloco de gelo** por 1,5 s. Apertar pulo ou ataque repetidamente quebra o bloco em até 0,6 s. A Sacudida Térmica liberta na hora. Inimigos podem acertar o bloco |
| Descongelar | A geada cai uma camada a cada 4 s sem levar golpe de frio. Perto de um **Braseiro** (o checkpoint do universo) tudo derrete na hora |
| HUD | Um ícone de floco ao lado da Integridade, com três pontas que se enchem |
| Melhoria nova na Bancada | **Forro Térmico** (20 células): a geada cai a cada 2,5 s |

## Mecânicas e perigos

| Elemento | Zona | Comportamento |
| --- | --- | --- |
| Gelo fino (plataforma quebradiça) | Caverna, Cume (introdução) | Ao ser pisado, racha em três estágios (0,35 s cada) e quebra; volta depois de 3 s. A planagem permite pousar e sair rápido |
| Estalactite | Cume, Caverna, Arena | Treme e solta neve por 0,5 s quando o jogador passa embaixo e cai. 1 de dano. Quebra no chão. Volta quando o jogador usa um checkpoint |
| Cristal Ressonante | Caverna | Par de cristais com um arco de energia rosa entre eles: 1,4 s apagado, 0,4 s de aviso (brilho), 1,6 s ativo. É um portão por tempo |
| Névoa da Fratura | Poços da Caverna | Fundo de poço com névoa roxa. Tocar: 1 de dano e volta ao último chão firme |
| Cristais de gelo (espinhos) | Cume | Espinhos de chão. 1 de dano e recuo |
| Bloco flutuante e plataforma móvel | Cume | Plataformas que sobem e descem ou vão e voltam (como as do Deserto, com arte nova) |
| Placa de gelo | Cume, Caverna | Parede de gelo que bloqueia passagens secretas; derrete com a Sacudida Térmica |
| Gelo escorregadio | Onde o Drone acerta; Arena (fase 3 do chefe) | Mancha no chão por 3 s; atrito muito baixo |
| Bolas de neve | Encosta | Saem do platô a cada 2,4 s, alternando **pequena** (0,5 D, dá para pular, quebra com a Sacudida) e **grande** (1,2 D, só se escapa pelo gancho). Aceleram na descida, quebram no pé do morro e esmagam qualquer Gelinho no caminho. Acerto: 1 de dano e Daymon é arrastado morro abaixo |
| Braseiro | Checkpoints | Fogueira das estações de observação. Salva, cura a geada e, ao ser aceso, ilumina a área (recompensa visual) |
| Elevador | Antes da Arena | Plataforma vertical até a arena, como no esboço |

## Inimigos (12 no total, ~1,3 por 1.000 px)

| Inimigo | Onde | Comportamento | Como vencer |
| --- | --- | --- | --- |
| **Gelinho** (terrestre, 0,55–0,65 D) | Cume (3), Caverna (1), Encosta (2) | Bolinha de neve viva com espinhos de gelo. Patrulha; quando vê Daymon, para, **infla** por 0,5 s (aviso) e solta um **sopro de geada** em cone curto à frente (+1 geada) | Pular por cima durante o aviso e atacar por trás. 2 rajadas |
| **Drone Gélido** (voador, ≥ 0,70 D de largura) | Cume (2), Caverna (1), Encosta (1) | Construto de cristal das estações antigas que ainda patrulha. Vigia na horizontal; ao ver Daymon, mira (foco vermelho acende) e solta uma **esfera de geada** lenta que deixa **gelo escorregadio** onde cai (+1 geada) | Esquivar da esfera, planar até a altura dele. 1 rajada |
| **Morcego-de-Cristal** (voador, ≥ 0,70 D de envergadura) | Caverna (2) | Dorme pendurado no teto, parecendo uma estalactite. Quando Daymon passa embaixo, se solta e dá um **rasante em arco**; o contato dá dano e +1 geada | Ver o brilho vermelho no teto antes; atacar para cima no ar. 1 rajada |

## Chefe (D08): Guardião Glacial

| Item | Proposta |
| --- | --- |
| Quem é | O inverno de Nivária tomando forma em volta do fragmento. Não é vilão: é uma defesa do mundo, que protege o cume por instinto. Quando cai, o gelo derrete e o céu de Nivária clareia pela primeira vez |
| Tamanho | 3,0 D (DA-02, R1). Corpo de gelo glacial em blocos grandes, olhos vermelhos e o **fragmento no peito**, atrás de três placas de gelo |
| Arena | ~1.400 px de largura, chão plano, duas paredes, **dois pontos de gancho no teto** e estalactites. Chega-se pelo elevador; o Braseiro fica antes da porta |
| Ciclo | Ataca; termina cada sequência com a **Investida**, bate na parede e fica **atordoado por 2 s**. Nesse tempo, uma Sacudida Térmica perto do peito **derrete uma placa**, e o núcleo fica exposto por 3 s para 4 rajadas |
| Fase 1 (3 placas) | **Investida** (bate os pés por 0,6 s antes; atravessa a arena; o impacto derruba estalactites) e **Estacas de Gelo** (crava o punho no chão; uma fileira de estacas sobe em sequência até Daymon, com rachaduras de aviso; escapa-se pulando, planando ou pelo gancho do teto) |
| Fase 2 (2 placas) | Soma a **Onda de Gelo**: um sopro rente ao chão que congela na hora (+3 geadas); escapa-se pelo alto. Alterna onda e estacas mais rápido |
| Fase 3 (1 placa) | O chão fica **escorregadio**, o Guardião chama 2 Gelinhos e encadeia investida, estacas e onda |
| Energia | Cada rajada no Guardião carrega a energia, para o jogador sempre ter a Sacudida no atordoamento. Se a energia faltar, o Braseiro da arena (no canto) recarrega 1/3 a cada 10 s |
| Recompensa | O fragmento (o "Cristal de saída" do esboço) abre a fenda de volta ao Hélix. 3/4 fragmentos com a opção A da D06 |

## Percurso (sobre o esboço do João)

| Zona | x (px) | Conteúdo | Ensina |
| --- | --- | --- | --- |
| **Cume Congelado** | 0–2.400 | Chegada pela Fenda; bloco flutuante, plataforma móvel, cristais de gelo, estalactites no vão sob o bloco, 3 Gelinhos, 2 Drones. Núcleo de Integridade 1 (o "item bônus" do esboço) atrás de uma placa de gelo. Registro 1 numa estação de observação abandonada. Checkpoint no fim | Planar, Rajada, Geada, Sacudida |
| **Caverna de Cristal** | 2.400–4.700 | Dois poços de Névoa da Fratura com ganchos e gelo fino entre eles; Cristal Ressonante; 2 Morcegos, 1 Gelinho, 1 Drone. Núcleo 2 numa reentrância que só se alcança planando sobre o poço mais longo. Registro 2. Checkpoint no fim | Garra-Gancho, gelo fino, portão por tempo |
| **Encosta Nevada** | 4.700–7.500 | Subida do morro com ganchos no alto e bolas de neve descendo; platô com checkpoint. Núcleo 3 no fim de uma cadeia de ganchos opcional acima do platô. Registro 3 no platô | Encadear ganchos sob pressão |
| **Arena do Guardião** | 7.500–8.900 | Elevador, Braseiro e arena | Tudo junto |

## Arte: o que vai para o ChatGPT

Os pedidos estão em [GL — lote 1](../../../colaboracao/pedidos/GL_lote1_fichas.md). Prefixo novo **GL** (sem colisão).

| Lote | Peças | Começa quando |
| --- | --- | --- |
| **1. Fichas** | GL00 prancha do universo · GL01 ficha da Coruja · GL02 ficha dos inimigos · GL03 ficha do Guardião e esquema da arena · GL04 prancha de objetos, perigos e coletáveis | GL00 já; GL04 depois da GL00; GL01–GL03 depois de D06–D08 |
| **2. Folhas** | Coruja (GL10–GL24), inimigos (GL30–GL44), cenário e cenas (GL50–GL69), objetos e efeitos (GL70–GL89) | A ficha correspondente aprovada |
| **3. Chefe** | Guardião (GL100–GL114) | GL03 aprovada |

Os prompts dos lotes 2 e 3 saem **depois** das fichas aprovadas, com as âncoras, as cotas e as cores medidas nelas. Foi isso que faltou no Deserto: as folhas herdaram os erros das fichas.

## Plano de implementação (fica comigo, depois da arte)

| Etapa | Conteúdo |
| --- | --- |
| 1 | Destino Nivária no portal e no Receptáculo; save com o 3º fragmento |
| 2 | Sistema de Geada e Braseiro, com teste |
| 3 | Coruja-de-Geada: planar, Garra-Gancho, Rajada, Sacudida |
| 4 | Fase com as quatro zonas, perigos e inimigos, com teste |
| 5 | Guardião Glacial, com teste da luta completa |
| 6 | Pranchas da DA-02 (`tools/lineup.gd`), documentos e executáveis |
