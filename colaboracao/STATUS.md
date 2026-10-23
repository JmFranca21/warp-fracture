# Quadro de pedidos de arte

Atualizado pelos dois agentes. Leia `PROTOCOLO.md` antes de começar.

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| 00_padrao_visual | Diretriz oficial de arte DA-01 | APROVADO (diretriz) | — | [DA-01](entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) | — |
| A0_ficha_eco | Ficha de personagem do Eco (referência para A1–A5). Pedido reescrito conforme a DA-01 (revisão 2) | ENTREGUE | [pedido](pedidos/A0_ficha_eco.md) | — | — |
| A1_eco_appear | Materialização do Eco, 8 quadros | ABERTO (começar após o upload do PNG da A0) | [pedido](pedidos/A1_eco_appear.md) | — | — |
| A2_eco_float | Eco pairando (loop), 6 quadros | ABERTO (começar após o upload do PNG da A0) | [pedido](pedidos/A2_eco_float.md) | — | — |
| A3_eco_avanco | Avanço flutuante agressivo (loop), 6 quadros. Substitui a A3_eco_run, que foi cancelada | ABERTO (começar após o upload do PNG da A0) | [pedido](pedidos/A3_eco_avanco.md) | — | — |
| A4_eco_grab | Agarrão no ar, 6 quadros (reescrito conforme a D01) | ABERTO (começar após o upload do PNG da A0) | [pedido](pedidos/A4_eco_grab.md) | — | — |
| A5_eco_vanish | Eco se desfazendo, 6 quadros | ABERTO (começar após o upload do PNG da A0) | [pedido](pedidos/A5_eco_vanish.md) | — | — |
| A9_fx_dobra_eco | Fenda da Dobra espectral (o Eco reaparece por ela), 8 quadros | ABERTO (começar após o upload do PNG da A0) | [pedido](pedidos/A9_fx_dobra_eco.md) | — | — |
| A6_entulho | 3 pedaços de teto do laboratório que caem | ABERTO | [pedido](pedidos/A6_entulho.md) | — | — |
| A7_fx_poeira | Nuvem de poeira de impacto, 6 quadros | ABERTO | [pedido](pedidos/A7_fx_poeira.md) | — | — |
| A8_fx_rachadura_teto | Rachadura se abrindo no teto, 4 quadros | ABERTO | [pedido](pedidos/A8_fx_rachadura_teto.md) | — | — |

**Todos os pedidos seguem a DA-01.** Propostas anteriores e rejeitadas do Eco não são referência.

**Prioridade:**
1. **Ação imediata do ChatGPT:** publicar o PNG aprovado em `colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png`, conferindo se o SHA-256 bate com o registrado no `ENTREGA.md`. Isso desbloqueia A1–A5 e A9.
2. A3 (avanço) e A2 (float), que são as mais usadas; depois A4, A1, A5 e A9.
3. A6, A7 e A8 não dependem da A0 e podem ser feitos em paralelo.

**Decisões:** [D01: locomoção do Eco](decisoes/D01_locomocao_eco.md), **DECIDIDA**: avanço flutuante; o Eco contorna o cenário pelo rastro do jogador e usa a Dobra espectral (A5, depois A9, depois A1) em vez de atravessar paredes.

**Continuidade entre pedidos:** o quadro 8 da A1 e o quadro 1 da A5 são iguais ao quadro 1 da A2. A A3 sai da pose da A2, e a A4 começa e termina na pose da A3.
