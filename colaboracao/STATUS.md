# Quadro de pedidos de arte

Atualizado pelos dois agentes. Leia `PROTOCOLO.md` antes de começar.

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| 00_padrao_visual | Diretriz oficial de arte DA-01 | APROVADO (diretriz) | — | [DA-01](entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) | — |
| A0_ficha_eco | Ficha de personagem do Eco (referência para A1–A5 e A9) | APROVADO (referência oficial) | [pedido](pedidos/A0_ficha_eco.md) | [entrega](entregas/A0_ficha_eco/) | [revisão](revisoes/A0_ficha_eco.md) |
| A1_eco_appear | Materialização do Eco, 8 quadros | ENTREGUE | [pedido](pedidos/A1_eco_appear.md) | [entrega](entregas/A1_eco_appear/) | — |
| A2_eco_float | Eco pairando (loop), 6 quadros | INTEGRADO (asset importado; entra no gameplay com a Fuga do Eco) | [pedido](pedidos/A2_eco_float.md) | [entrega](entregas/A2_eco_float/) | [revisão](revisoes/A2_eco_float.md) |
| A3_eco_avanco | Avanço flutuante agressivo (loop), 6 quadros. Substitui a A3_eco_run, que foi cancelada | ENTREGUE | [pedido](pedidos/A3_eco_avanco.md) | — | — |
| A4_eco_grab | Agarrão no ar, 6 quadros (reescrito conforme a D01) | ENTREGUE (uso provisório) | [pedido](pedidos/A4_eco_grab.md) | [entrega](entregas/A4_eco_grab/) | — |
| A5_eco_vanish | Eco se desfazendo, 6 quadros | ENTREGUE | [pedido](pedidos/A5_eco_vanish.md) | [entrega](entregas/A5_eco_vanish/) | — |
| A9_fx_dobra_eco | Fenda da Dobra espectral (o Eco reaparece por ela), 8 quadros | ENTREGUE | [pedido](pedidos/A9_fx_dobra_eco.md) | [entrega](entregas/A9_fx_dobra_eco/) | — |
| A6_entulho | 3 pedaços de teto do laboratório que caem | ABERTO | [pedido](pedidos/A6_entulho.md) | — | — |
| A7_fx_poeira | Nuvem de poeira de impacto, 6 quadros | ABERTO | [pedido](pedidos/A7_fx_poeira.md) | — | — |
| A8_fx_rachadura_teto | Rachadura se abrindo no teto, 4 quadros | ABERTO | [pedido](pedidos/A8_fx_rachadura_teto.md) | — | — |

**Todos os pedidos seguem a DA-01.** Propostas anteriores e rejeitadas do Eco não são referência.

**Prioridade:**
1. **A3_eco_avanco**, a locomoção principal. É a próxima peça mais importante.
2. Depois A4, A1, A5 e A9.
3. A6, A7 e A8 não dependem da A0 e podem ser feitos em paralelo.

**Decisões:** [D01: locomoção do Eco](decisoes/D01_locomocao_eco.md), **DECIDIDA**: avanço flutuante; o Eco contorna o cenário pelo rastro do jogador e usa a Dobra espectral (A5, depois A9, depois A1) em vez de atravessar paredes.

**Escala do Eco:** todas as animações do Eco usam a **mesma escala de desenho da A2** (figura de 380 px na pose de pairar). Veja a [revisão da A2](revisoes/A2_eco_float.md).

**Continuidade entre pedidos:** o quadro 8 da A1 e o quadro 1 da A5 são iguais ao quadro 1 da A2. A A3 sai da pose da A2, e a A4 começa e termina na pose da A3.

## Fase Deserto de Ferrugem (pedido [DF](pedidos/DF_deserto_ferrugem.md))

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| DF00 | Prancha de referência do Deserto (paleta, materiais, amostras) | ENTREGUE (aprovado pelo responsável) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF01 | Ficha do Robô e do Drone do deserto | ENTREGUE (aprovado pelo responsável) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF10–DF12 | Fundos em parallax das Dunas (céu, fábricas distantes, dunas) | ABERTO, após aprovação de DF00 | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF20–DF28 | Terreno e paredes repetíveis (chão, espinhos, paredes, piso, esteira, trilho, cabo) | PARCIAL: DF20, DF21, DF25 e DF26 ENTREGUES (aprovados/autorizados); demais ABERTOS | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF30–DF39 | Objetos de cenário (sucata, mastro, chaminé, portas, engrenagem, torre, lâmpadas, painéis) | ABERTO, após aprovação de DF00 | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF50–DF57 | Mecanismos e perigos em peças (prensas, serra, plataformas, válvula, ponto de gancho) | PARCIAL: DF57, DF53, DF50 e DF52 ENTREGUES (aprovados; DF53b com escala de exportação aprovada); demais ABERTOS | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF60–DF71 | Animações do Robô e do Drone e projéteis | ENTREGUE (13 spritesheets, DF69b incluída; DF65/DF68 com transparência corrigida; SHA-256 conferidos; aguarda revisão técnica e integração) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF80–DF86 | Efeitos (fumaça, vapor, faíscas, poeira, explosão, impacto, vento) | ABERTO, após aprovação de DF00 | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |

Ordem de produção do Deserto: DF00 e DF01, depois o bloco jogável (DF20, DF21, DF25, DF57, DF53, DF50, DF52, DF26, DF60–DF71), depois fundos e paredes, e por último o restante.
