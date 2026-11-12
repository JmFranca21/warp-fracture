# D05: Portais (linguagem visual, peças e integração)

**Estado:** DECIDIDA em 12/11/2026.
**Autor:** Claude (design e desenvolvimento) · 11/11/2026

## O portal atual

`scripts/portal.gd` desenha tudo por código: nove arcos coloridos girando, um núcleo claro e uma base trapezoidal escura (120 × 14 px). Não há arte. Os estados existentes são "inativo" (arcos tremendo, brilho em 35%) e "ativo" (depois da calibração). Ele só existe no Laboratório (Sala G, x 4960, y 690) e só leva a Verdâmia. Não há portal em Verdâmia.

## Portais que precisam existir

| # | Portal | Onde | Função |
|---|---|---|---|
| 1 | **Arco de Dobra** (máquina) | Laboratório, Sala G (x 4960, chão y 690) | Hub: escolhe o destino, calibra e atravessa |
| 2 | **Fenda de retorno** | Verdâmia, no fundo da arena, atrás do altar (x ≈ 4480, chão y 804) | Volta ao Hélix depois do fragmento |
| 3 | **Fenda de chegada** | Deserto, início das Dunas (x ≈ 150, chão y 700) | Chegada. Fecha-se atrás do jogador e fica como rachadura dormente |
| 4 | **Fenda de retorno** | Deserto, atrás da porta direita da Câmara da Forja | Volta ao Hélix depois do fragmento 2 |
| 5 | Rachadura dormente (opcional) | Verdâmia, ponto de chegada | Marca de onde o jogador veio, para coerência com o Deserto |

São **dois tipos físicos**: o **Arco** (máquina construída no Hélix) e a **Fenda** (rasgo no tecido do universo, aberto pela energia de um fragmento ou do portal). Os dois compartilham a **membrana** do interior, as cores de destino e as regras de movimento.

## Linguagem comum

- A **membrana** é sempre a mesma peça: uma superfície oval clara e translúcida. O jogo a tinge e anima conforme o destino.
- O **destino** é lido por três canais, para não depender só da cor:

| Destino | Cor | Forma (glifo) | Movimento da membrana |
|---|---|---|---|
| Laboratório Hélix | ciano #2EC7E6 | hexágono com um ponto no centro | pulsos concêntricos para dentro |
| Verdâmia | verde-lima #A6E05A | folha-cogumelo (chapéu sobre um caule) | espiral lenta no sentido anti-horário |
| Deserto de Ferrugem | âmbar #F2B24C | engrenagem de seis dentes | ondulação horizontal tremida, como ar quente |

- **Estados**, lidos pela forma e pelo movimento:

| Estado | Arco de Dobra | Fenda |
|---|---|---|
| **Bloqueado** | Diafragma **fechado** (8 lâminas formam um disco), glifo apagado, sem membrana | Rachadura fina e dormente, quase sem brilho |
| **Sinal detectado** | Diafragma fechado, glifo **pisca** | — |
| **Calibrando** | Lâminas **meio abertas, tremendo**; membrana instável e cortada | Bordas tremendo (abertura) |
| **Pode atravessar** | Lâminas **recolhidas**; membrana estável no movimento do destino; partículas **puxadas para dentro**; faixa de luz no chão até a base | Oval aberto, bordas estáveis, partículas puxadas para dentro |

Ou seja: **para dentro é aberto, tremor é instável, fechado é parado**. Quem não distingue as cores ainda lê o glifo e o movimento.

## Peças (o que é imagem e o que é código)

| Peça | ID | Imagem | Código, shader ou partículas |
|---|---|---|---|
| Arco: traseira (anel, base, painel de destino) | PT10 | sim | — |
| Arco: frente (pilares e borda da base) | PT11 | sim | — |
| Lâmina do diafragma | PT12 | sim (1 lâmina) | 8 cópias giradas; abrir, fechar e tremer |
| Glifos de destino | PT13 | sim (3 glifos × aceso e apagado) | piscar e acender |
| Receptáculo da Máquina | PT15 | sim | fragmentos encaixados (VD_fragmento reduzido), brilho e feixe no cabo |
| Membrana | PT20 | sim (loop de 8 quadros, clara e neutra) | tingimento, rotação, ondulação e tremor |
| Fenda: borda | PT21 | sim (loop de 8 quadros) | tingimento do brilho |
| Fenda: base no chão | PT22 | sim | brilho pulsando |
| Fenda: abrindo | PT23 | sim (8 quadros) | o fechamento é a mesma animação ao contrário |
| Travessia (Daymon some na luz) | — | não | já existe (`start_warp`): clarão e fade |
| Faixa de luz no chão, partículas, halo | — | não | código (`Art.glow`, `Fx`) |

## Encaixe e camadas

- **Arco:** a base é plana e apoia no chão, em toda a largura (2,0 D). A **abertura útil** é de 1,0 D de largura por 1,5 D de altura (cerca de 85 × 128 px no jogo), maior que o humano e o Autômato (1,05 D) e que o Lince.
- **Ordem de desenho:** PT10 (traseira) → membrana PT20 → lâminas PT12 → **personagem** → PT11 (frente). Ao entrar, Daymon fica entre a membrana e os pilares da frente, então parece estar *dentro* do arco, não na frente dele.
- **Fenda:** a base PT22 se apoia no chão (nada flutua). A borda PT21 nasce dessa base. A membrana fica atrás da borda, e o personagem entra entre a membrana e a borda.
- **Mesmo registro:** PT10, PT11 e PT12 usam o mesmo canvas e o mesmo ponto de apoio, para o código só sobrepor as peças.

## O que precisa de aprovação

1. Dois tipos (Arco e Fenda) com membrana comum.
2. Cores, glifos e movimentos por destino.
3. Receptáculo da Máquina como peça separada do Arco, ligada a ele por um cabo.

## Decisão final (12/11/2026)

**a linguagem, as peças e a integração propostas neste documento**, conforme a recomendação acima. O João Marcelo aceitou as recomendações de D02 a D05 em 12/11/2026. Os pedidos que dependiam desta decisão foram liberados.
