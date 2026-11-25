# Warp Fracture

Metroidvania 2D em visão lateral feito em **Godot 4.3**, com visual ilustrado inspirado em Hollow Knight (sem pixel art). Daymon Sagan, cientista do Projeto Hélix, atravessa realidades fraturadas para recuperar os fragmentos da Máquina de Dobra. Em cada universo, ele assume uma forma diferente.

**Versão atual:** protótipo v0.9. A v0.9 traz a **Fase 3, Nivária**: o fragmento do Deserto, instalado no Receptáculo, revela um sinal frio; Daymon calibra o Arco e atravessa para uma cordilheira sob a noite polar, ainda humano, com a **camada polar** (parca e cachecol), o **Pulso Térmico** e a regra da **Geada** (golpes de frio deixam mais lento e, na terceira camada, congelam). Nivária tem quatro zonas (Cume Congelado, Caverna de Cristal, Encosta Nevada e a Arena), gelo fino, estalactites, cristais ressonantes, bolas de neve rolando morro abaixo, três inimigos novos e o **Guardião Glacial**, chefe de três fases que guarda o fragmento 3/4. A arte de Nivária ainda é provisória: recortes das fichas aprovadas GL01–GL04 v2 até as folhas do lote 2. A v0.8 trouxe a **Fase 2, Deserto de Ferrugem**: o fragmento de Verdâmia abre uma fenda de volta ao Hélix, Daymon instala o fragmento no Receptáculo da Máquina, escolhe o destino no Arco de Dobra, calibra o sinal fraco do Deserto e atravessa como **Autômato** (Ímã de Fase, Rebitadeira, Pulso Magnético e Arranque). O Deserto tem três zonas, seis máquinas, três vãos de ímã e termina na **Forja-Mãe**, chefe de três fases que guarda o fragmento 2/4. Os portais ganharam a arte nova (Arco, Fenda, Receptáculo e membrana por destino) e o save passou para a versão 2. A v0.7 trouxe a **Fuga do Eco**: ao abrir a porta da Sala G, o Eco surge por uma fenda e persegue Daymon enquanto o laboratório desaba, até o portal, agora no fim da nova Galeria do Portal. A v0.6 trouxe Verdâmia com a arte oficial (Lince-Vagalume, inimigos, Rainha Micélia, cenário e efeitos). A v0.6.1 corrige o fragmento que reaparecia no altar ao continuar um save gravado depois da vitória. Laboratório Hélix e Verdâmia jogáveis, com chefe, Arpão de Fase, Bancada de Upgrades, Registros do Projeto, mapa, save e som.

## Estado do projeto (24/11/2026)

| Frente | Situação |
|---|---|
| Laboratório Hélix | Jogável: 9 salas (nova Galeria do Portal), Arpão de Fase, Bancada, Registros, Fuga do Eco e portal com calibração |
| Verdâmia | Jogável, com a arte oficial integrada e a Rainha Micélia; o fragmento 1/4 abre a fenda de retorno ao Hélix (D02) |
| Eco (Etapa 7, Fuga do Eco) | Jogável na v0.7. A1–A9 integradas: o Eco surge (A1, A9), observa (A2), avança pelo rastro (A3), agarra com aviso (A4), usa a Dobra (A5, A9, A1) e se desfaz no portal (A5); o teto cai (A6, A7, A8) |
| Passagem e portais (D02, D05) | Jogável na v0.8: fenda de retorno, Receptáculo, seletor de destino, calibração do Deserto com onda à deriva, Arco de Dobra e Fendas com a arte PT10–PT23, save versão 2 com migração |
| Deserto de Ferrugem (Fase 2, D03) | Jogável na v0.8 como Autômato (DF87–DF99): Dunas, Fábrica e Salão do Núcleo, com Robôs, Drones, prensas, serra, esteira, válvulas e plataformas (DF10–DF86) |
| Forja-Mãe (D04) | Jogável na v0.8 (DF100–DF112): três fases (pistão esquerdo, pistão direito com esteira e drones, núcleo central aberto pelo Pulso), fragmento 2/4 e fim da versão atual |
| Nivária (Fase 3, D07 e D08) | Jogável na v0.9 (branch `dev/neve`): Daymon de inverno, Geada, Pulso Térmico, quatro zonas, Gelinho, Drone Gélido, Morcego-de-Cristal e o Guardião Glacial (fragmento 3/4 e fim da versão). Arte provisória recortada das fichas GL01–GL04 v2; pedidos do lote 2 em `colaboracao/pedidos/GL_lote2_producao.md` |
| Arte nova da Fase 2 | Entregue em 13/11/2026 (pacote Revisão v2). As fichas DF02, DF03 e PT00 ainda aguardam a aprovação do João Marcelo; os lotes foram integrados como estão |

O catálogo de toda a arte, com o estado de cada item, está no [documento de arte](docs/DOCUMENTO_DE_ARTE.md). O que falta por fase, organizado pela receita de cena (DA-03), está no [inventário de arte](docs/INVENTARIO_DE_ARTE.md).

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
| `scripts/` | Todo o código em GDScript. O Laboratório e Verdâmia são cenas em `scenes/fases/` ([guia](docs/CENAS_DAS_FASES.md)); o Deserto e Nivária, em `desert.gd` e `nivaria.gd` |
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
tools/fluxo/godot.sh --script res://tools/test_portal.gd -- level=lab pos=6560,680 terminals god at=30
tools/fluxo/godot.sh --script res://tools/test_fuga.gd -- level=lab terminals arpao pos=4250,790 save at=999
tools/fluxo/godot.sh --script res://tools/test_passagem.gd -- save at=999
tools/fluxo/godot.sh --script res://tools/test_deserto.gd -- save at=999
tools/fluxo/godot.sh --script res://tools/test_forja.gd -- save at=999
tools/fluxo/godot.sh --script res://tools/test_nivaria.gd -- out=C:/caminho/capturas
```

`tools/shots_fase2.gd -- out=<pasta>` gera 15 capturas de conferência da Fase 2 (portais, Deserto e Forja-Mãe).

No Linux, use `GODOT=/caminho/do/godot tools/run.sh ...` com as mesmas flags.

## Próximos passos

A Fase 3 (Nivária) entrou na v0.9 com arte provisória. Próximo passo: as folhas do **lote 2 de Nivária** (`colaboracao/pedidos/GL_lote2_producao.md`) e a decisão D06 (lugar de Nivária na campanha). Também seguem pendentes a **Etapa 8, cena de abertura**, e a aprovação das fichas DF02, DF03 e PT00. Consulte o [roteiro de implementação](ROTEIRO.md), o [quadro de arte](colaboracao/STATUS.md) e o [GDD de dez páginas](docs/Caderno_de_10_paginas_Warp_Fracture_v2.docx).
