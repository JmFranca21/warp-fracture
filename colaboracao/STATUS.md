# Quadro de pedidos de arte

Atualizado pelos agentes. Leia `PROTOCOLO.md` e `FLUXO_AUTOMATICO.md` antes de começar. Estados: `SUSPENSO`, `ABERTO`, `ENTREGUE`, `AJUSTE`, `APROVADO`, `AGUARDA JOÃO` (fichas novas), `INTEGRADO`.

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| 00_padrao_visual | Diretriz oficial de arte DA-01 | APROVADO (diretriz) | — | [DA-01](entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) | — |
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
| DF01 | Ficha do Robô e do Drone do deserto | ENTREGUE (aprovado pelo responsável) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
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
| DF02 | Ficha do Autômato (lote 1) | ABERTO (ficha: aprovação final do João) | [pedido](pedidos/DF02_ficha_automato.md) | — | — |
| DF03 | Ficha da Forja-Mãe e esquema da arena (lote 1) | ABERTO (ficha: aprovação final do João) | [pedido](pedidos/DF03_ficha_forja_mae.md) | — | — |
| PT00 | Ficha dos portais e do Receptáculo (lote 1) | ABERTO (ficha: aprovação final do João) | [pedido](pedidos/PT00_ficha_portais.md) | — | — |
| DF87–DF99 | Autômato: 7 folhas do corpo, braço, rebite, disparo, feixe e pulso (lote 2) | SUSPENSO (aguarda DF02) | [pedido](pedidos/DF87-DF99_automato.md) | — | — |
| PT10–PT23 | Arco de Dobra, glifos, Receptáculo, membrana e Fenda (lote 2) | SUSPENSO (aguarda PT00) | [pedido](pedidos/PT10-PT23_portais.md) | — | — |
| DF100–DF112 | Forja-Mãe: corpo, lente, peito, braço, martelo, núcleo, escotilha, grade e efeitos (lote 3) | SUSPENSO (aguarda DF03) | [pedido](pedidos/DF100-DF112_forja_mae.md) | — | — |

## Fase Verdâmia

Pacote completo em [VD_verdamia](entregas/VD_verdamia/) (64 assets em 67 PNGs). **Integrado ao jogo na v0.6 (11/11/2026).** Revisão, medidas e destino de cada asset: [revisão VD_verdamia](revisoes/VD_verdamia.md).

| ID | O que é | Estado |
|---|---|---|
| D0 / E0 / VD00 | Referências do Lince, inimigos e ambiente | APROVADO (referência; não entra no jogo) |
| D | 11 animações do Lince-Vagalume (wall, claw e flash na versão `_v2`) | INTEGRADO |
| E | Esporângio (3), Mariposa (2), Rainha Micélia (16 folhas) e 7 objetos de cenário | INTEGRADO |
| VD | Terreno (7), parallax (3), efeitos (7), projéteis (2), checkpoint, barreira e fragmento | INTEGRADO |

**61 assets integrados e verificados no jogo, 3 referências, nenhum pendente.** A revisão lista 7 pedidos de ajuste que não bloqueiam (escala entre folhas do Lince, garras no ar, esquiva, fim da morte da Rainha, contorno de `esporos_3`, subsolo repetível e miolo da parede).
