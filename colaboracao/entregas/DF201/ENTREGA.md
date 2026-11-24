# DF201 — Fundo intermediário das Dunas de Sucata

Arte aprovada por João Marcelo em 24/11/2026. O teste do parallax e da leitura em movimento fica para a integração.

| Peça | Dimensão | Função e âncora |
|---|---:|---|
| DF201_distante.png | 2.560 × 840 RGBA | Plano intermediário distante, 0,20, faixa única. Origem da camada no pixel (686, 490). |
| DF201_proximo.png | 2.560 × 840 RGBA | Plano intermediário próximo, 0,38, repetição horizontal de 2.560 px sem espelhamento. Origem da repetição em x 0, linha de base y 490. |
| DF201_cena.png | 2.560 × 2.389 | Três painéis de 1.280 × 720, um teste de emenda e capturas de referência de Hélix e Verdâmia. |

Um quadro por camada. Escala 1 px de arquivo por px de mundo, projeção 1,1 na tela. Os pontos mais altos com alpha visível estão em y 261 e y 220, ou 229 e 270 px acima da base. Acima de y 190 o alpha é zero e de y 490 a y 839 é 255. Para a camada próxima, as colunas 0 e 2.559 são idênticas em RGBA, inclusive ao longo do chão opaco. A quarta janela mostra a emenda no centro da tela.

A **distante** reúne duas lumas de silhueta, dunas suaves, fábrica e chaminés em névoa. A **próxima** traz guindastes, escavadeira, robô tombado, vagão e torres em ferrugem escura, com desenho vazado nas vigas para separar os planos. Metais com sombras frias, sem focos âmbar próprios. Paleta de direção: ferrugem #3A2929 / #59403A / #493736, vigas #1D2A3C / #3B3237, sombras comuns #253045 / #0F1422. O PNG utiliza misturas dessas famílias, graduadas para as metas.

## Aferição das camadas

| Camada | Y′ média acima da base | Desvio Y′ | Saturação HSV média | Y′ média abaixo da base | Y′ média ao pé | Y′ pico |
|---|---:|---:|---:|---:|---:|---:|
| Distante | 0,120 | 0,006 | 0,141 | 0,095 | 0,094 | 0,122 |
| Próxima | 0,087 | 0,041 | 0,356 | 0,081 | 0,063 | 0,192 |

Y′ em sRGB. A média de silhueta mede pixels com alpha acima de 95% nas linhas acima da base (y 0–489). A medida ao pé usa as últimas dez linhas. Densidade de bordas da camada próxima: **0,077** nos pixels internos opacos e **0,051** ao contar o PNG inteiro sobre uma luma neutra de 0,115, incluindo a área vazia. Ambos usam Sobel > 0,25.

## Montagens sem camada de primeiro plano adicional

As silhuetas novas foram compostas a 1,1 px de tela por px de arquivo sobre o céu DF200, usando os pares de capturas com plano jogável DF205 e céu isolado da auditoria da `dev/deserto`. São imagens estáticas com o Autômato na escala da captura. As origens horizontais são posições de montagem, a validar contra a câmera em execução.

| Câmera | y da base na tela | x inicial distante/próxima | Luma média | Terço superior | Densidade de bordas | Área lisa |
|---|---:|---:|---:|---:|---:|---:|
| Dunas · câmera normal | 496 | 310 / 170 | 0,111 | 0,089 | 0,091 | 0,350 |
| Dunas · câmera baixa no fosso | 432 | 470 / 475 | 0,103 | 0,113 | 0,070 | 0,336 |
| Vão do Salão · câmera alta | 589 | 1010 / 1820 | 0,118 | 0,096 | 0,087 | 0,355 |

Critérios nas Dunas: média 0,08–0,18, terço superior ≤ 0,15, bordas ≥ 0,04 e área lisa ≤ 0,60. A área lisa usa blocos de 40 px conforme DA-03. A integração do parallax, a leitura do Autômato em movimento e as bordas nos extremos da câmera ultrawide ficam para validação no Godot.

## SHA-256

- `DF201_cena.png` — `b3cae53c24bdb6a16214863e56a61d8bc722cb86bea22778a3c82a5cc1fef866`
- `DF201_distante.png` — `0873dd2ac23464e1ed6d119f335ccc492e04657d72d9cef63fc011c51ffc21d9`
- `DF201_proximo.png` — `1c6fd6a701f21ba81a32513809d164b0fbbc1675149bc1cf0f046f463fffd3ed`
