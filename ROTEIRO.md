# Warp Fracture — Roteiro de melhorias

Ordem escolhida: primeiro o que todo jogador sente (som, salvamento, orientação), depois o que transforma o protótipo num metroidvania (habilidades que abrem áreas, upgrades), depois conteúdo e polimento.

## Fase 1 — Base (v0.4) ✅ entregue
1. **Som e música**: efeitos para todas as ações e um tema ambiente por área (laboratório e Verdâmia), com volumes separados.
2. **Salvamento**: salva nas Estações de Recarga e ao trocar de área. Menu com Continuar / Novo jogo.
3. **Mapa e Opções**: mapa no Tab que se revela conforme a exploração, com ícones de estação, terminal, porta e portal. Opções: volumes, tela cheia e tremor de tela.

## Fase 2 — Metroidvania (v0.5) ✅ entregue
4. **Arpão de Fase** (1º módulo da arma): puxa o Daymon até ganchos e puxa caixas. Abre uma ala secreta do laboratório que antes era inalcançável.
5. **Bancada de Upgrades**: gasta Células de Fase em +Integridade, energia mais rápida, esquiva com menos recarga e tiro mais rápido.
6. **Registros do Projeto**: diários espalhados que contam o que aconteceu antes da explosão.

## Fase 3 — Conteúdo (v0.6+)
7. ✅ **Fuga do Eco** (v0.7, 13/11/2026): o Eco persegue Daymon da Sala G ao portal, agora no fim da nova Galeria do Portal, enquanto o laboratório desaba. Veja a seção 13 do `HANDOFF.md`.
8. **Cena de abertura**: a explosão da Máquina de Dobra.
9. **Fendas Instáveis**: salas-desafio cronometradas e escondidas.
10. ✅ **Integração das artes de Verdâmia** (v0.6, 11/11/2026): Lince, inimigos, chefe, cenário e efeitos no jogo. Destino de cada asset em `colaboracao/revisoes/VD_verdamia.md`.
11. **Hidrópolis** (Cefalóide, nado livre).
12. ✅ **Fase 2: Deserto de Ferrugem e Forja-Mãe** (v0.8, 17/11/2026): passagem pelo Receptáculo e pelo Arco (D02), Autômato (D03), Forja-Mãe (D04) e portais com arte (D05). Veja a seção 14 do `HANDOFF.md`.
13. **Fase de neve** (nova, em planejamento): o João Marcelo vai enviar o primeiro plano; a partir dele, planejar a fase por completo e gerar os pedidos de arte. A ordem das próximas etapas depende do plano revisto.

## Fase 4 — Polimento contínuo
- Inimigos mais táticos (grupo, reforço, turreta que gira), transições entre áreas e acessibilidade (remapear teclas).

## v0.8 — 17/11/2026
- Fase 2 concluída: Deserto de Ferrugem jogável como Autômato, Forja-Mãe com três fases e fragmento 2/4, passagem entre universos (fenda de retorno, Receptáculo, seletor e calibração do Deserto), portais com a arte PT, save versão 2. Testes novos: `test_passagem.gd`, `test_deserto.gd` e `test_forja.gd`. Próximo passo: o plano da fase de neve.

## v0.7 — 13/11/2026
- Etapa 7 concluída: Fuga do Eco com a arte A1–A9, Galeria do Portal (portal em x 6560), entulho com aviso, piso que desaba, alarme, trilha `fuga`, ponto de retorno no início e evento `fuga_lab` no save. Teste novo: `tools/test_fuga.gd`. A próxima é a Etapa 8 (cena de abertura).

## Correção v0.6.1 — 12/11/2026
- O fragmento de Verdâmia não reaparece no altar depois de "Continuar" (defeito registrado na [D02](colaboracao/decisoes/D02_passagem_verdamia_deserto.md)). O save ganhou o campo `frags`, e os saves antigos são migrados. Teste novo: `tools/test_fragmento.gd`. A Etapa 7 (Fuga do Eco) continua sendo a próxima.

## v0.6 — 11/11/2026
- Verdâmia passou a usar a arte entregue pelo diretor de arte (61 assets integrados, 3 pranchas de referência). Nenhuma mecânica nova. A Etapa 7 (Fuga do Eco) continua sendo a próxima.

## Correção v0.5.1 — 10/11/2026
- Corrigida a interação com o portal do laboratório: E abre a calibração, Esc cancela e concluir as ondas leva a Verdâmia. A Etapa 7 continua pendente.

## Situação das entregas em 17/11/2026

| Frente | Publicado | Próximo trabalho |
|---|---|---|
| Eco | A0 aprovada, A2 importada, A1/A3/A4/A5/A9 entregues. A4 tem uso provisório. | Produzir entulho, poeira e rachadura (A6–A8). Revisar as transições, programar o rastro e a Dobra conforme D01, o desabamento, o checkpoint e o som. Testar a chegada ao portal. |
| Verdâmia | Arte integrada na v0.6 (61 assets). Fragmento corrigido na v0.6.1. | Ajustes não bloqueantes da [revisão VD_verdamia](colaboracao/revisoes/VD_verdamia.md). |
| Deserto de Ferrugem | v0.8: fase, Autômato, Forja-Mãe e portais jogáveis com a arte DF/PT (pacote Revisão v2 integrado). | Aprovação das fichas DF02, DF03 e PT00 pelo João Marcelo; revisão cruzada das entregas DF e PT. |

Os [pedidos de arte por ID](colaboracao/STATUS.md) e a [especificação do Deserto](docs/fases/deserto_ferrugem/detalhamento_da_fase.md) orientam a produção. A abertura, as Fendas Instáveis, Hidrópolis e os demais universos continuam no planejamento.
