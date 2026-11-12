# Fluxo automático entre os agentes

Em vigor desde 12/11/2026. Complementa o [PROTOCOLO.md](PROTOCOLO.md); onde os dois divergirem, vale este arquivo. O objetivo é que arte, desenvolvimento e revisão andem sozinhos, em ciclos, sem o João Marcelo precisar repassar mensagens.

## Papéis

| Papel | Quem executa | Pode alterar |
|---|---|---|
| **Gerente de projeto** | Sessão principal do Claude Code (Opus) | Planeja cada ciclo, distribui as tarefas, confere o estado real, faz os commits locais e corrige documentos esquecidos |
| **Especialista em artes** | Codex CLI (ChatGPT) com geração de imagens | Apenas `colaboracao/entregas/<ID>/` |
| **Especialista técnico** | Claude Code (worker programador) | Código, assets do jogo, pedidos, documentos (`HANDOFF`, `ROTEIRO`, `LEIA-ME`, `README`, GDD, documento de arte) |
| **Revisor** | Sempre o fornecedor que não fez a entrega: **Claude Sonnet** revisa a arte (feita pelo Codex) e o **Codex** revisa o código e os documentos (feitos pelo Claude Opus). O Antigravity revisou o ciclo 1 e foi retirado em 12/11/2026 | Apenas `colaboracao/revisoes/` |
| **João Marcelo** | Pessoa responsável | Decisões de design e aprovação final de **fichas novas de personagem** |

Como os agentes trabalham ao mesmo tempo, **só o gerente edita o `STATUS.md`**, a partir do `ENTREGA.md` e das revisões. Nenhum agente faz push. O gerente faz commits locais na branch `auto/fluxo`, com o prefixo do papel (`[arte]`, `[dev]`, `[rev]`, `[gp]`); o João faz merge e push.

## Ciclo

Cada ciclo roda nesta ordem. Um passo sem trabalho pendente é pulado.

1. **Estado real (gerente).** Compara `STATUS.md`, entregas, revisões, código e documentos. Corrige diferenças, mesmo as deixadas por outro agente.
2. **Arte.** Produz até 2 pedidos `ABERTO` por ciclo, em ordem de prioridade (abaixo). Correções (`AJUSTE`) têm prioridade sobre pedidos novos.
3. **Revisão de arte.** Cada entrega `ENTREGUE` recebe `revisoes/<ID>.md` com `APROVADO` ou `AJUSTE`.
4. **Desenvolvimento.** Integra o que foi aprovado, avança a etapa atual do roteiro, testa no Godot 4.3, atualiza os documentos e abre os próximos pedidos de arte.
5. **Revisão do desenvolvimento.** O revisor confere o diff, os testes, as capturas e se os documentos batem com o que foi entregue. O resultado vai para `revisoes/ciclos/<data>_cNN.md`. Correções pedidas viram a primeira tarefa do desenvolvimento no ciclo seguinte.
6. **Fechamento (gerente).** Confere as alegações de cada agente nos arquivos, faz os commits e registra o ciclo em [ciclos/](ciclos/).

## Estados

`SUSPENSO` → `ABERTO` → `ENTREGUE` → `APROVADO` → `INTEGRADO`. `AJUSTE` volta para `ABERTO`.

- **Fichas novas de personagem ou de referência** (por exemplo DF02, DF03 e PT00): o revisor faz a verificação técnica e de estilo e marca `AGUARDA JOÃO`. Só viram referência oficial, e só liberam os lotes que dependem delas, depois da aprovação explícita do João Marcelo, registrada na revisão.
- **Os demais assets** (folhas de animação, objetos, efeitos, terreno e UI) dependem só da aprovação do revisor. Esta regra substitui, para o fluxo automático, o passo 6 da DA-01, por decisão do João Marcelo em 12/11/2026.
- Depois de **3 ciclos de `AJUSTE`** no mesmo pedido, ele vai para `AGUARDA JOÃO`, com o histórico.

## Prioridade

1. Correções pedidas pelo revisor.
2. Etapa 7, Fuga do Eco: A6, A7 e A8, e revisão de A1, A3, A4, A5 e A9.
3. Fichas do lote 1 da Fase 2 (DF02, DF03 e PT00), que depois param em `AGUARDA JOÃO`.
4. Ajustes não bloqueantes de Verdâmia (veja `revisoes/VD_verdamia.md`).
5. Lotes 2 e 3 da Fase 2, quando as fichas forem aprovadas.

## Regras de arte

- Siga a DA-01 (`entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`) e as referências de `arte_original/00_Referencias_oficiais/`.
- A imagem gerada quase nunca sai no formato do pedido. O artista monta o arquivo final com Python e Pillow: recorte, remoção do fundo, grade, escala e linha dos pés. Antes de entregar, ele roda `python tools/fluxo/check_art.py` com as medidas do pedido.
- O `ENTREGA.md` traz a lista de quadros, as medidas, a saída do `check_art.py` e as regras que não foi possível cumprir.
- Nunca sobrescreva uma entrega. Versões novas usam `_v2`, `_v3`.

## Regras de revisão

- Uma revisão é objetiva e verificável: cada problema indica o quadro ou arquivo, o que está errado, a medida e como corrigir.
- Para arte, confira o `check_art.py`, o estilo contra a DA-01 e as fichas, a continuidade entre pedidos (por exemplo, A1 quadro 8 = A2 quadro 1) e a escala do Eco (A2 = 380 px).
- Para desenvolvimento, confira se os testes rodaram (com a saída do harness), as capturas (nada flutuando, sobreposto ou cortado), a regressão e se cada documento abaixo foi atualizado quando devia.

## Documentos que precisam acompanhar cada entrega

| Documento | O que manter |
|---|---|
| `README.md` | Estado atual do jogo, das fases, das decisões e do fluxo automático |
| `HANDOFF.md`, `PROMPT_PROXIMO_AGENTE.md` | Versão e próximos passos atuais |
| `ROTEIRO.md`, `LEIA-ME.md` | Etapas concluídas e novidades da versão |
| `docs/Caderno_de_10_paginas_Warp_Fracture_v2.docx` | GDD. Sempre atualizado, com **exatamente 10 páginas** enquanto o João não mudar essa regra |
| `docs/DOCUMENTO_DE_ARTE.md` | Catálogo de personagens, inimigos, chefes, cenários, objetos, efeitos e UI: para cada item, a ficha de referência, o estado, os arquivos e onde aparece no jogo |
| `colaboracao/STATUS.md`, `decisoes/`, `arte_original/USADAS_NO_JOGO.md` | Estado de cada pedido, decisões e destino de cada asset |

Se o revisor encontrar um documento que não bate com a entrega, a entrega volta para correção.

## Ambiente nesta máquina (Windows)

- Godot 4.3: `C:/Users/joao.marcelo/AreaJM/Ferramentas/godot-4.3/`, com os export templates instalados. Harness: `tools/fluxo/godot.sh` (mesmas flags do `HANDOFF.md`, seção 5).
- Python 3.13 com Pillow e numpy. O ffmpeg ainda não está instalado, então o `gen_audio.py` não converte OGG.
- Capturas de revisão: `colaboracao/revisoes/img/`.
