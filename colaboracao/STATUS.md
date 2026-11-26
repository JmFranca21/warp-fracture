# Quadro de pedidos de arte

Atualizado pelos agentes. Leia `PROTOCOLO.md` e `FLUXO_AUTOMATICO.md` antes de começar. Estados: `SUSPENSO`, `ABERTO`, `ENTREGUE`, `AJUSTE`, `APROVADO`, `AGUARDA JOÃO` (fichas novas), `INTEGRADO`.

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| 00_padrao_visual | Diretriz oficial de arte DA-01 | APROVADO (diretriz) | — | [DA-01](entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) | — |
| DA-04 / DF-KEY | Quadros-chave do Deserto diurno e da Fábrica | ENTREGUE (v2) · APROVADO | — | [quadros e medidas](entregas/00_padrao_visual/DA04/ENTREGA.md) | João Marcelo, 25/11/2026 |
| A0_ficha_eco | Ficha de personagem do Eco (referência para A1–A5 e A9) | APROVADO (referência oficial) | [pedido](pedidos/A0_ficha_eco.md) | [entrega](entregas/A0_ficha_eco/) | [revisão](revisoes/A0_ficha_eco.md) |
| A1_eco_appear | Materialização do Eco, 8 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A1_eco_appear.md) | [entrega](entregas/A1_eco_appear/) | [revisão](revisoes/A1_eco_appear.md) |
| A2_eco_float | Eco pairando (loop), 6 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A2_eco_float.md) | [entrega](entregas/A2_eco_float/) | [revisão](revisoes/A2_eco_float.md) |
| A3_eco_avanco | Avanço flutuante agressivo (loop), 6 quadros. Substitui a A3_eco_run, que foi cancelada | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A3_eco_avanco.md) | [entrega](entregas/A3_eco_avanco/) | [revisão](revisoes/A3_eco_avanco.md) |
| A4_eco_grab | Agarrão no ar, 6 quadros (reescrito conforme a D01) | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A4_eco_grab.md) | [entrega](entregas/A4_eco_grab/) | [revisão](revisoes/A4_eco_grab.md) |
| A5_eco_vanish | Eco se desfazendo, 6 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A5_eco_vanish.md) | [entrega](entregas/A5_eco_vanish/) | [revisão](revisoes/A5_eco_vanish.md) |
| A9_fx_dobra_eco | Fenda da Dobra espectral (o Eco reaparece por ela), 8 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A9_fx_dobra_eco.md) | [entrega](entregas/A9_fx_dobra_eco/) | [revisão](revisoes/A9_fx_dobra_eco.md) |
| A6_entulho | 3 pedaços de teto do laboratório que caem | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A6_entulho.md) | [entrega](entregas/A6_entulho/) | [revisão](revisoes/A6_entulho.md) |
| A7_fx_poeira | Nuvem de poeira de impacto, 6 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A7_fx_poeira.md) | [entrega](entregas/A7_fx_poeira/) | [revisão](revisoes/A7_fx_poeira.md) |
| A8_fx_rachadura_teto | Rachadura se abrindo no teto, 4 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A8_fx_rachadura_teto.md) | [entrega](entregas/A8_fx_rachadura_teto/) | [revisão](revisoes/A8_fx_rachadura_teto.md) |

**Todos os pedidos seguem a DA-01.** Propostas anteriores e rejeitadas do Eco não são referência.

**Fuga do Eco integrada na v0.7 (13/11/2026):** A1–A9 estão em uso no jogo e verificadas por `tools/test_fuga.gd` e por capturas. Detalhes na seção 13 do `HANDOFF.md`.

**Decisões:** [D01: locomoção do Eco](decisoes/D01_locomocao_eco.md), **DECIDIDA**: avanço flutuante; o Eco contorna o cenário pelo rastro do jogador e usa a Dobra espectral (A5, depois A9, depois A1) em vez de atravessar paredes.

**Escala do Eco:** todas as animações do Eco usam a **mesma escala de desenho da A2** (figura de 380 px na pose de pairar). Veja a [revisão da A2](revisoes/A2_eco_float.md).

**Continuidade entre pedidos:** o quadro 8 da A1 e o quadro 1 da A5 são iguais ao quadro 1 da A2. A A3 sai da pose da A2, e a A4 começa e termina na pose da A3.

## Fase Deserto de Ferrugem (pedido [DF](pedidos/DF_deserto_ferrugem.md))

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| DF00 | Prancha de referência do Deserto (paleta, materiais, amostras) | ENTREGUE (aprovado pelo responsável) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF00 v2 | Prancha de referência do Deserto pela DA-03 | ENTREGUE | [DF](pedidos/DF_deserto_ferrugem.md) | — | [Prancha, comparação e aferição](entregas/DF00/ENTREGA_v2.md) |
| DF205 | Terreno do Deserto de Ferrugem · 22 peças | APROVADO (Pacote 3, 25/11/2026) | [DF](pedidos/DF_refacao_cena.md) | [Peças e encaixes](entregas/DF205/ENTREGA_v2.md) | — |
| DF200 | Céu do crepúsculo de tempestade | ENTREGUE | [DF](pedidos/DF_refacao_cena.md) | — | [Céu, comparação e aferição](entregas/DF200/ENTREGA.md) |
| DF200 diurno | Céu aprovado das Dunas | APROVADO (Pacote 3) | [DF](pedidos/DF_refacao_cena.md) | [Céu diurno](entregas/DF200/DF200_ceu_diurno.png) | — |
| DF202 | Fundos da Fábrica e do Salão | APROVADO (Pacote 4, 25/11/2026) | — | [Entrega](entregas/DF202/ENTREGA.md) | — |
| DF207 | Peças suspensas | APROVADO (Pacote 7, 25/11/2026) | — | [Entrega](entregas/DF207/ENTREGA_v2.md) | — |
| DF225 | Comportas da Câmara e da Saída | APROVADO (Pacote 14) | — | [Entrega](entregas/DF225/ENTREGA_v2.md) | — |
| DF210 | Estação, placa e coletáveis | ENTREGUE (Pacote 15) | — | [Entrega](entregas/DF210/ENTREGA_v2.md) | — |
| DF87–DF99 v2 | Autômato, braço-ímã e habilidades | ENTREGUE (Pacote 16) | — | [Corpo](entregas/DF90/ENTREGA_v2.md) · [Braço](entregas/DF97/ENTREGA_v2.md) · [Pulso](entregas/DF99/ENTREGA_v2.md) | — |
| DF60–DF71 v2 | Sentinela, drone e projéteis | ENTREGUE (Pacote 17) | — | [Sentinela](entregas/DF60/ENTREGA_v2.md) · [Drone](entregas/DF66/ENTREGA_v2.md) | — |
| DF224 | Plataformas móveis, válvula e gancho | APROVADO (Pacote 13) | — | [Entrega](entregas/DF224/ENTREGA_v2.md) | — |
| DF223 | Prensas e serra | APROVADO (Pacote 12) | — | [Entrega](entregas/DF223/ENTREGA_v2.md) | — |
| DF222 | Esteira e trilhos | APROVADO (Pacote 11) | — | [Entrega](entregas/DF222/ENTREGA_v2.md) | — |
| DF221 | Iluminação e enfeites de parede (5 peças) | APROVADO (Pacote 10) | — | [Peças e cenas](entregas/DF221/ENTREGA_v2.md) | — |
| DF220 | Marcos do cenário (6 peças) | APROVADO (Pacote 9) | — | [Peças e cenas](entregas/DF220/ENTREGA_v2.md) | — |
| DF209 | Efeitos de ambiente | APROVADO (Pacote 8 refeito) | — | [Folhas e animações](entregas/DF209/ENTREGA_v2.md) | — |
| DF208 | Primeiro plano exterior e interior | APROVADO (Pacote 7, 25/11/2026) | — | [Entrega](entregas/DF208/ENTREGA_v2.md) | — |
| DF206 | Decoração das Dunas e da Fábrica (24 peças) | APROVADO (Pacote 6, 25/11/2026) | — | [Pranchas e cenas](entregas/DF206/ENTREGA_v2.md) | — |
| DF204 | Estruturas de fundo do Deserto (10 peças) | APROVADO (Pacote 5, 25/11/2026) | — | [Atlas e cenas](entregas/DF204/ENTREGA_v2.md) | — |
| DF203 | Fundo da Câmara da Forja | APROVADO (Pacote 4, 25/11/2026) | — | [Entrega](entregas/DF203/ENTREGA.md) | — |
| DF201 | Dunas de Sucata · fundo intermediário diurno | APROVADO (Pacote 3, 25/11/2026) | [DF](pedidos/DF_refacao_cena.md) | [Camadas e parallax](entregas/DF201/ENTREGA_v2.md) | — |
| DF01 | Ficha do Robô e do Drone do deserto | ENTREGUE (v2) · APROVADO | [DF](pedidos/DF_deserto_ferrugem.md) | [ficha e conferências](entregas/DF01/ENTREGA_v2.md) | João Marcelo, 25/11/2026 |
| DF10–DF12 | Fundos das Dunas em parallax | ENTREGUE | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF20–DF28 | Terreno, paredes, piso, esteira, trilho e cabo | ENTREGUE | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF30–DF39 | Objetos de cenário e portas | ENTREGUE | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF50–DF57 | Prensas, serra, plataformas, válvulas e gancho | ENTREGUE | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF60–DF71 | Robôs, drones e seus projéteis | ENTREGUE | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF80–DF86 | Efeitos de máquinas, areia, impacto e vento | ENTREGUE | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |

Todos os assets do pedido DF estão entregues. A versão jogável está na [branch do protótipo](https://github.com/JmFranca21/warp-fracture/tree/prototipo/deserto-de-ferrugem). A integração na campanha principal está pendente.

## Fase 2: Deserto de Ferrugem (proposta de campanha, 11/11/2026)

Visão geral, divergências e plano: [proposta da Fase 2](../docs/fases/deserto_ferrugem/proposta_fase2.md). **D02–D05 decididas em 12/11/2026 (recomendações aceitas).** Fichas novas (DF02, DF03, PT00) só viram referência depois da aprovação do João Marcelo; os lotes 2 e 3 esperam a ficha correspondente.

| Decisão | Tema | Estado |
|---|---|---|
| [D02](decisoes/D02_passagem_verdamia_deserto.md) | Passagem entre Verdâmia e o Deserto, e save | DECIDIDA (12/11/2026) |
| [D03](decisoes/D03_forma_deserto.md) | Forma de Daymon no Deserto (Autômato recomendado) | DECIDIDA (12/11/2026) |
| [D04](decisoes/D04_chefe_deserto.md) | Chefe do Deserto (Forja-Mãe recomendada) | DECIDIDA (12/11/2026) |
| [D05](decisoes/D05_portais.md) | Portais: linguagem, peças e integração | DECIDIDA (12/11/2026) |

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| DF02 | Ficha do Autômato (lote 1) | ENTREGUE (v2) · APROVADO | [pedido](pedidos/DF02_ficha_automato.md) | [ficha e conferências](entregas/DF02/ENTREGA_v2.md) | João Marcelo, 25/11/2026 |
| DF03 | Ficha da Forja-Mãe e esquema da arena (lote 1) | ENTREGUE (v2) · APROVADO | [pedido](pedidos/DF03_ficha_forja_mae.md) | [ficha e conferências](entregas/DF03/ENTREGA_v2.md) | João Marcelo, 25/11/2026 |
| PT00 | Ficha dos portais e do Receptáculo (lote 1) | ENTREGUE (AGUARDA JOÃO; pacote Revisão v2 de 13/11/2026) | [pedido](pedidos/PT00_ficha_portais.md) | [entrega](entregas/PT00/) | — |
| DF87–DF99 | Autômato: 7 folhas do corpo, braço, rebite, disparo, feixe e pulso (lote 2) | ENTREGUE (AGUARDA JOÃO; pacote Revisão v2 de 13/11/2026); produzido antes da aprovação da DF02 | [pedido](pedidos/DF87-DF99_automato.md) | entregas DF87, DF88, DF90–DF99 | — |
| PT10–PT23 | Arco de Dobra, glifos, Receptáculo, membrana e Fenda (lote 2) | ENTREGUE (AGUARDA JOÃO; pacote Revisão v2 de 13/11/2026); produzido antes da aprovação da PT00 | [pedido](pedidos/PT10-PT23_portais.md) | entregas PT10–PT13, PT15, PT20–PT23 | — |
| DF100–DF112 | Forja-Mãe: corpo, lente, peito, braço, martelo, núcleo, escotilha, grade e efeitos (lote 3) | ENTREGUE (AGUARDA JOÃO; pacote Revisão v2 de 13/11/2026); produzido antes da aprovação da DF03 | [pedido](pedidos/DF100-DF112_forja_mae.md) | entregas DF100–DF108, DF110–DF112 | — |

## Fase Verdâmia

Pacote completo em [VD_verdamia](entregas/VD_verdamia/) (64 assets em 67 PNGs). **Integrado ao jogo na v0.6 (11/11/2026).** Revisão, medidas e destino de cada asset: [revisão VD_verdamia](revisoes/VD_verdamia.md).

| ID | O que é | Estado |
|---|---|---|
| D0 / E0 / VD00 | Referências do Lince, inimigos e ambiente | APROVADO (referência; não entra no jogo) |
| D | 11 animações do Lince-Vagalume (wall, claw e flash na versão `_v2`) | INTEGRADO |
| E | Esporângio (3), Mariposa (2), Rainha Micélia (16 folhas) e 7 objetos de cenário | INTEGRADO |
| VD | Terreno (7), parallax (3), efeitos (7), projéteis (2), checkpoint, barreira e fragmento | INTEGRADO |

**61 assets integrados e verificados no jogo, 3 referências, nenhum pendente.** A revisão lista 7 pedidos de ajuste que não bloqueiam (escala entre folhas do Lince, garras no ar, esquiva, fim da morte da Rainha, contorno de `esporos_3`, subsolo repetível e miolo da parede).

## Nivária

| ID | O que é | Estado | Entrega |
|---|---|---|---|
| GL00 | Prancha de Nivária | ENTREGUE | [Prancha e aferição](entregas/GL00/ENTREGA.md) |
| GL01 | Daymon de inverno | ENTREGUE (v2) | [Ficha e comparação](entregas/GL01/ENTREGA_v2.md) |
| GL02 | Ficha do Gelinho, Drone Gélido e Morcego-de-Cristal | ENTREGUE (v2) | [Ficha, comparação e aferição DA-02](entregas/GL02/ENTREGA_v2.md) |
| GL03 | Guardião Glacial e esquema da arena | ENTREGUE (v2) | [Ficha, arena e comparação](entregas/GL03/ENTREGA_v2.md) |
| GL04 | Objetos, perigos e coletáveis de Nivária | ENTREGUE (v2) | [Prancha e comparação](entregas/GL04/ENTREGA_v2.md) |
