# Quadro de pedidos de arte

Atualizado pelos dois agentes. Leia `PROTOCOLO.md` antes de começar.

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| 00_padrao_visual | Diretriz oficial de arte DA-01 | APROVADO (diretriz) | — | [DA-01](entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) | — |
| A0_ficha_eco | Ficha de personagem do Eco (referência para A1–A5 e A9) | APROVADO (referência oficial) | [pedido](pedidos/A0_ficha_eco.md) | [entrega](entregas/A0_ficha_eco/) | [revisão](revisoes/A0_ficha_eco.md) |
| A1_eco_appear | Materialização do Eco, 8 quadros | ENTREGUE | [pedido](pedidos/A1_eco_appear.md) | [entrega](entregas/A1_eco_appear/) | — |
| A2_eco_float | Eco pairando (loop), 6 quadros | INTEGRADO (asset importado; entra no gameplay com a Fuga do Eco) | [pedido](pedidos/A2_eco_float.md) | [entrega](entregas/A2_eco_float/) | [revisão](revisoes/A2_eco_float.md) |
| A3_eco_avanco | Avanço flutuante agressivo (loop), 6 quadros. Substitui a A3_eco_run, que foi cancelada | ENTREGUE | [pedido](pedidos/A3_eco_avanco.md) | [entrega](entregas/A3_eco_avanco/) | — |
| A4_eco_grab | Agarrão no ar, 6 quadros (reescrito conforme a D01) | ENTREGUE (uso provisório) | [pedido](pedidos/A4_eco_grab.md) | [entrega](entregas/A4_eco_grab/) | — |
| A5_eco_vanish | Eco se desfazendo, 6 quadros | ENTREGUE | [pedido](pedidos/A5_eco_vanish.md) | [entrega](entregas/A5_eco_vanish/) | — |
| A9_fx_dobra_eco | Fenda da Dobra espectral (o Eco reaparece por ela), 8 quadros | ENTREGUE | [pedido](pedidos/A9_fx_dobra_eco.md) | [entrega](entregas/A9_fx_dobra_eco/) | — |
| A6_entulho | 3 pedaços de teto do laboratório que caem | ABERTO | [pedido](pedidos/A6_entulho.md) | — | — |
| A7_fx_poeira | Nuvem de poeira de impacto, 6 quadros | ABERTO | [pedido](pedidos/A7_fx_poeira.md) | — | — |
| A8_fx_rachadura_teto | Rachadura se abrindo no teto, 4 quadros | ABERTO | [pedido](pedidos/A8_fx_rachadura_teto.md) | — | — |

**Todos os pedidos seguem a DA-01.** Propostas anteriores e rejeitadas do Eco não são referência.

**Próximo trabalho:** produzir A6–A8 e revisar no motor as transições A2 → A3 → A4 e A5 → A9 → A1. A perseguição precisa do controlador de movimento, dos avisos de desabamento, do checkpoint e do teste de travessia até o portal.

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

## Fase Verdâmia

Pacote completo em [VD_verdamia](entregas/VD_verdamia/) (64 assets em 67 PNGs). **Integrado ao jogo na v0.6 (11/11/2026).** Revisão, medidas e destino de cada asset: [revisão VD_verdamia](revisoes/VD_verdamia.md).

| ID | O que é | Estado |
|---|---|---|
| D0 / E0 / VD00 | Referências do Lince, inimigos e ambiente | APROVADO (referência; não entra no jogo) |
| D | 11 animações do Lince-Vagalume (wall, claw e flash na versão `_v2`) | INTEGRADO |
| E | Esporângio (3), Mariposa (2), Rainha Micélia (16 folhas) e 7 objetos de cenário | INTEGRADO |
| VD | Terreno (7), parallax (3), efeitos (7), projéteis (2), checkpoint, barreira e fragmento | INTEGRADO |

**61 assets integrados e verificados no jogo, 3 referências, nenhum pendente.** A revisão lista 7 pedidos de ajuste que não bloqueiam (escala entre folhas do Lince, garras no ar, esquiva, fim da morte da Rainha, contorno de `esporos_3`, subsolo repetível e miolo da parede).
