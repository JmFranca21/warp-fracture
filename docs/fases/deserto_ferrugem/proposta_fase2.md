# Fase 2: proposta de campanha para o Deserto de Ferrugem

**Estado:** PROPOSTA (11/11/2026). Nada aqui está aprovado. As escolhas dependem do João Marcelo.
**Autor:** Claude (design e desenvolvimento)
**Ponto de partida:** `main` em `e731e1a`. O protótipo jogável continua separado na branch `prototipo/deserto-de-ferrugem` (`b753433`). Ele foi consultado para medidas, posições e testes, mas **não** foi mesclado.

## Recomendação conjunta

| Tema | Recomendação | Documento |
|---|---|---|
| Passagem entre fases | O fragmento abre uma fenda de volta ao Hélix. Daymon instala o fragmento no Receptáculo da Máquina, IRIS revela o sinal do Deserto e o jogador escolhe esse destino no portal, calibra e atravessa | [D02](../../../colaboracao/decisoes/D02_passagem_verdamia_deserto.md) |
| Transformação | **Autômato de Fase**: robô de sucata pesado. O Ímã de Fase substitui o Arpão nos três vãos, a Rebitadeira mantém o tiro mirado e o Pulso Magnético derruba drones. A fase inteira é jogada nessa forma | [D03](../../../colaboracao/decisoes/D03_forma_deserto.md) |
| Chefe | **Forja-Mãe**, a IA da fábrica fixa na Câmara da Forja, depois da porta do Salão. Tem três núcleos, braços-martelo com âncoras e o fragmento no peito | [D04](../../../colaboracao/decisoes/D04_chefe_deserto.md) |
| Portais | Dois tipos físicos (o **Arco de Dobra** no Hélix e a **Fenda** nos universos) com a mesma membrana. O destino se lê por cor, glifo e movimento | [D05](../../../colaboracao/decisoes/D05_portais.md) |

## Divergências encontradas (antes de consolidar)

1. **Ordem da campanha.** O GDD põe Hidrópolis em segundo e Ferrumgrado em terceiro. O pedido atual faz do Deserto a Fase 2. Proposta: o Deserto vira a primeira área de Ferrumgrado e a Fase 2. Hidrópolis passa para depois.
2. **Forma.** O GDD prevê o Autômato (lento, ímã, soco, pulo curto). O detalhamento do Deserto foi escrito para o Daymon humano com tiro e Arpão. A D03 concilia os dois: ímã no lugar do Arpão, tiro mantido e o soco adiado.
3. **Chefe.** O detalhamento termina na porta, "sem chefe nesta versão". O GDD prevê a Forja-Mãe, com 3 núcleos. A D04 amplia o percurso com uma câmara depois da porta.
4. **Fim do protótipo.** Hoje o fragmento de Verdâmia abre a tela de vitória. Pela D02, ele deixa de encerrar o jogo.
5. **Save (defeito confirmado em 11/11/2026).** Ao continuar um save feito depois da vitória, o fragmento reaparece no altar, e pegá-lo de novo leva o contador a 2/4. Verdâmia também não tem saída. A D02 corrige os dois e migra saves antigos.
6. **Protótipo × main.** O protótipo usava um arquivo de save separado para o Deserto, dava o Arpão automaticamente e abria a fase pelo menu. A integração oficial usa o save único, a forma Autômato e a entrada pelo portal.
7. **Escala do detalhamento.** O detalhamento fala em cerca de 1020 unidades; o protótipo montou a fase com 6990 px (cerca de 6,85 px por unidade). A integração oficial parte das posições do protótipo, que já foram testadas.

## Decisões que precisam de aprovação

1. **Ordem:** Deserto como Fase 2 e primeira área de Ferrumgrado (Hidrópolis depois).
2. **D02, passagem:** opção A (retorno ao Hélix e Receptáculo) ou B. Inclui: a tela de vitória sai do fragmento de Verdâmia; textos de IRIS; registro novo `log_09`.
3. **D03, forma:** Autômato (opção 1) ou Escaravelho (opção 2). Nome, escala de 1,05 D e o soco adiado.
4. **D04, chefe:** Forja-Mãe (A) ou Sentinela de Esteira (B). Câmara nova, recompensa (só o fragmento ou também um módulo) e vida dos núcleos.
5. **D05, portais:** dois tipos, cores, glifos e movimentos.
6. **Fichas do lote 1:** cada ficha (DF02, DF03 e PT00) precisa da aprovação visual antes dos lotes 2 e 3.

## Ordem de produção da arte

| Lote | Pedido | Peças | Começa quando |
|---|---|---|---|
| **1. Fichas** | [DF02](../../../colaboracao/pedidos/DF02_ficha_automato.md), [DF03](../../../colaboracao/pedidos/DF03_ficha_forja_mae.md), [PT00](../../../colaboracao/pedidos/PT00_ficha_portais.md) | 3 fichas | O João Marcelo aprova D03, D04 e D05 |
| **2a. Autômato** | [DF87–DF99](../../../colaboracao/pedidos/DF87-DF99_automato.md) | 7 folhas do corpo, braço, rebite, disparo, feixe e pulso (12) | DF02 aprovada |
| **2b. Portais** | [PT10–PT23](../../../colaboracao/pedidos/PT10-PT23_portais.md) | Arco (traseira, frente, lâmina, glifos), Receptáculo, membrana e Fenda (borda, base, abertura) (9) | PT00 aprovada |
| **3. Forja-Mãe** | [DF100–DF112](../../../colaboracao/pedidos/DF100-DF112_forja_mae.md) | Corpo, lente, peito, carrinho, segmento, martelo, núcleo, escotilha, grade, feixe, carga e explosão (12) | DF03 aprovada |

**IDs novos e sem colisão:** DF02 e DF03 completam as fichas (DF00 e DF01 já existem). DF87–DF99 ficam entre os efeitos (DF80–DF86) e as peças do chefe. DF100–DF112 são do chefe. PT00–PT23 é um prefixo novo para portais, que servem a todas as fases. Os assets já entregues (DF10–DF86, VD_fragmento e as fichas) são reaproveitados.

Os prompts são gerados por `tools/gen_pedidos_fase2.py`. Para mudar um prompt, edite o script e rode `python tools/gen_pedidos_fase2.py .`.

## Plano de implementação (fica comigo)

Cada etapa termina com teste por input real e build Windows e Linux.

| Etapa | O que entra | Depende de | Testes |
|---|---|---|---|
| **1. Passagem e save** | Fragmento sem tela de vitória; fenda de retorno em Verdâmia; chegada à Sala G; Receptáculo; seletor de destino; calibração com padrão do Deserto; save `version: 2` com migração | D02 aprovada (usa peças provisórias por código até os portais ficarem prontos) | `test_portal.gd` sem mudança; `test_verdamia.gd` atualizado; teste novo de save cobrindo os cinco estados e os saves antigos |
| **2. Fase oficial do Deserto** | Layout e máquinas do protótipo reescritos na estrutura da `main` (`level_data` e scripts próprios), sem merge; inimigos Robô e Drone com DF60–DF71; save único | Etapa 1 | `test_deserto.gd` do protótipo adaptado: 3 vãos, esteira, prensas, válvulas, plataformas, 6 inimigos e 12 células |
| **3. Autômato** | Forma nova: rig com braço, Ímã de Fase, Rebitadeira, Pulso e Arranque; arte DF87–DF99 | D03 e lote 2a | Animação por estado (como o Lince); travessia dos 3 vãos com o ímã; drones derrubados pelo pulso |
| **4. Portais com arte** | Arco, Fenda, Receptáculo e membrana com tingimento e movimento por destino | D05 e lote 2b | Capturas dos estados; personagem entre a membrana e os pilares |
| **5. Forja-Mãe** | Câmara, estação, três fases, golpes, sinais, recompensa e portas | D04 e lote 3 | Teste de luta completo (janelas de punição, nova tentativa e vitória) e retorno ao Hélix com 2/4 |
| **6. Documentos e entrega** | GDD, STATUS, USADAS_NO_JOGO, HANDOFF e ROTEIRO; executáveis | Todas | Fluxo completo: Laboratório → Verdâmia → Hélix → Deserto → Forja-Mãe |

A etapa 1 não precisa de arte nova e pode começar assim que a D02 for aprovada.
