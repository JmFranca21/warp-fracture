# Warp Fracture

Metroidvania 2D em visão lateral feito em **Godot 4.3**, com visual ilustrado inspirado em Hollow Knight (sem pixel art). Daymon Sagan, cientista do Projeto Hélix, atravessa realidades fraturadas para recuperar os fragmentos da Máquina de Dobra. Em cada universo, ele assume uma forma diferente.

**Versão atual:** protótipo v0.5.1 (correção da interação com o portal). Laboratório Hélix e Verdâmia jogáveis, com chefe, Arpão de Fase, Bancada de Upgrades, Registros do Projeto, mapa, save e som.

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
| `docs/` | Caderno de 10 páginas (documento de design) e `GUIA_PROXIMOS_PASSOS_E_ASSETS.md` (próximas etapas e prompts de arte) |
| `colaboracao/` | Canal entre o desenvolvimento (Claude) e a arte (ChatGPT): protocolo, quadro de status, pedidos, entregas e revisões |
| `HANDOFF.md` | Contexto técnico completo para quem for continuar o projeto |
| `ROTEIRO.md` | Roteiro de melhorias: o que já foi feito e o que falta |
| `LEIA-ME.md` | Manual do jogador e novidades de cada versão |
| `PROMPT_SPRITESHEETS.md` | Prompt usado para gerar novas spritesheets |
| `PROMPT_PROXIMO_AGENTE.md` | Prompt para um agente de IA continuar o desenvolvimento |

## Testes automatizados

O jogo aceita argumentos de teste depois de `--`. Por exemplo:

```bash
GODOT=/caminho/do/godot tools/run.sh level=lab pos=645,790 at=1 shot=/tmp/teste.png
```

A lista completa de flags está no `HANDOFF.md`, seção 5.

## Próximos passos

O primeiro fragmento de Verdâmia encerra a v0.5.1. A Fuga do Eco é a próxima etapa de gameplay. As novas artes do Eco, de Verdâmia e de parte do Deserto já estão no repositório. Consulte o [roteiro de implementação](ROTEIRO.md), o [quadro de arte](colaboracao/STATUS.md) e o [GDD de dez páginas](docs/Caderno_de_10_paginas_Warp_Fracture_v2.docx).
