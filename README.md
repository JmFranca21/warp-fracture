# Warp Fracture

Metroidvania 2D em visão lateral feito em **Godot 4.3**, com visual ilustrado inspirado em Hollow Knight (sem pixel art). Daymon Sagan, cientista do Projeto Hélix, atravessa realidades fraturadas para recuperar os fragmentos da Máquina de Dobra. Em cada universo, ele assume uma forma diferente.

**Versão atual:** protótipo v0.6.1. A v0.6 trouxe Verdâmia com a arte oficial (Lince-Vagalume, inimigos, Rainha Micélia, cenário e efeitos). A v0.6.1 corrige o fragmento que reaparecia no altar ao continuar um save gravado depois da vitória. Laboratório Hélix e Verdâmia jogáveis, com chefe, Arpão de Fase, Bancada de Upgrades, Registros do Projeto, mapa, save e som.

## Estado do projeto (12/11/2026)

| Frente | Situação |
|---|---|
| Laboratório Hélix | Jogável: 8 salas, Arpão de Fase, Bancada, Registros e portal com calibração |
| Verdâmia | Jogável, com a arte oficial integrada e a Rainha Micélia; o fragmento 1/4 encerra o protótipo |
| Eco (Etapa 7, Fuga do Eco) | Próxima etapa. Ficha A0 aprovada, A2 importada, A1/A3/A4/A5/A9 entregues, A6–A8 pedidas |
| Deserto de Ferrugem (Fase 2) | Arte da fase entregue; protótipo só na branch `prototipo/deserto-de-ferrugem`. As decisões [D02](colaboracao/decisoes/D02_passagem_verdamia_deserto.md) a [D05](colaboracao/decisoes/D05_portais.md) foram tomadas em 12/11/2026, com as recomendações aceitas: retorno ao Hélix com o Receptáculo, forma Autômato, chefe Forja-Mãe e a nova linguagem dos portais. As fichas DF02, DF03 e PT00 estão em produção |

O catálogo de toda a arte, com o estado de cada item, está no [documento de arte](docs/DOCUMENTO_DE_ARTE.md).

## Fluxo automático

Desde 12/11/2026, arte, desenvolvimento e revisão trabalham em ciclos automáticos: gerente de projeto (Claude Code), especialista em artes (Codex), especialista técnico (Claude Code) e revisão cruzada: o Claude Sonnet revisa a arte e o Codex revisa o código. As regras estão em [colaboracao/FLUXO_AUTOMATICO.md](colaboracao/FLUXO_AUTOMATICO.md). O João Marcelo decide o design e aprova as fichas novas de personagem.

## Como abrir

1. Instale o [Godot 4.3 stable](https://godotengine.org/download/archive/4.3-stable/).
2. Clone este repositório, abra o Godot, clique em **Importar** e escolha `project.godot`.
3. Aperte **F5** para jogar.

Para gerar os executáveis, use **Projeto → Exportar** (presets "Windows Desktop" e "Linux"). Os builds prontos devem ser publicados em **Releases**, não no repositório.

## Estrutura

| Caminho | Conteúdo |
|---|---|
| `scripts/` | Todo o código em GDScript. Os dados das fases ficam em `level_data.gd` |
| `assets/` | Sprites, efeitos e áudio já importados no jogo |
| `tools/` | Scripts Python para recortar as spritesheets e gerar áudio, mais o `run.sh` de testes |
| `arte_original/` | Pranchas originais e referências oficiais de arte (veja `USADAS_NO_JOGO.md`) |
| `docs/` | Caderno de 10 páginas (documento de design), `DOCUMENTO_DE_ARTE.md` (catálogo da arte) e `GUIA_PROXIMOS_PASSOS_E_ASSETS.md` (próximas etapas e prompts de arte) |
| `colaboracao/` | Canal entre os agentes (fluxo automático): protocolo, quadro de status, pedidos, entregas, revisões, decisões e ciclos |
| `HANDOFF.md` | Contexto técnico completo para quem for continuar o projeto |
| `ROTEIRO.md` | Roteiro de melhorias: o que já foi feito e o que falta |
| `LEIA-ME.md` | Manual do jogador e novidades de cada versão |
| `PROMPT_SPRITESHEETS.md` | Prompt usado para gerar novas spritesheets |
| `PROMPT_PROXIMO_AGENTE.md` | Prompt para um agente de IA continuar o desenvolvimento |

## Testes automatizados

O jogo aceita argumentos de teste depois de `--`. A lista completa de flags está no `HANDOFF.md`, seção 5.

No Windows (Git Bash), use `tools/fluxo/godot.sh`, que já aponta para o Godot 4.3 desta máquina (defina `GODOT` para usar outro executável):

```bash
tools/fluxo/godot.sh level=verdamia pos=4100,790 god at=3 shot=C:/caminho/x.png
tools/fluxo/godot.sh --script res://tools/test_verdamia.gd -- save at=999
tools/fluxo/godot.sh --script res://tools/test_fragmento.gd -- save at=999
tools/fluxo/godot.sh --script res://tools/test_portal.gd -- level=lab pos=4960,680 terminals god at=30
```

No Linux, use `GODOT=/caminho/do/godot tools/run.sh ...` com as mesmas flags.

## Próximos passos

A próxima etapa é a **7, Fuga do Eco**: o Eco persegue Daymon enquanto o laboratório desmorona (veja a seção 8 do `HANDOFF.md` e a [D01](colaboracao/decisoes/D01_locomocao_eco.md)). As artes do Eco e do Deserto já estão no repositório e ainda não entraram no jogo. A campanha do Deserto segue as decisões D02 a D05. Consulte o [roteiro de implementação](ROTEIRO.md), o [quadro de arte](colaboracao/STATUS.md) e o [GDD de dez páginas](docs/Caderno_de_10_paginas_Warp_Fracture_v2.docx).
