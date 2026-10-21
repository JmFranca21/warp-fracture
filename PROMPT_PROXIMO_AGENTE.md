# Prompt para o próximo agente

Cole o texto abaixo na nova conversa e anexe os arquivos indicados.

**Anexar:** `WarpFracture_Handoff.zip`. Ele contém:
- `projeto_godot/`: projeto completo, com `HANDOFF.md`, `ROTEIRO.md`, `LEIA-ME.md` e `PROMPT_SPRITESHEETS.md`
- `Caderno_de_10_paginas_Warp_Fracture_v2.docx`: documento de design atualizado
- `arte_original/`: pranchas originais e referências oficiais de arte, com `USADAS_NO_JOGO.md`

---

Você vai continuar o desenvolvimento do jogo **Warp Fracture**, um metroidvania 2D em visão lateral feito em **Godot 4.3** (GDScript, renderizador GL Compatibility). O visual é inspirado em Hollow Knight, sem pixel art. O projeto já está na versão v0.5, com o Laboratório Hélix e Verdâmia jogáveis, chefe, menu, save, mapa, Arpão de Fase, Bancada de Upgrades e Registros.

Antes de qualquer coisa:
1. Extraia o zip e leia **`HANDOFF.md`** inteiro, e também `arte_original/USADAS_NO_JOGO.md`. Ele explica a arquitetura, onde ficam os dados das fases (`scripts/level_data.gd`), o harness de testes por linha de comando, como exportar e as decisões já tomadas.
2. Leia `ROTEIRO.md` e o caderno de 10 páginas. O caderno é a fonte de verdade do design.
3. Prepare o ambiente: Godot 4.3 stable com os export templates, `xvfb-run` para testar sem tela, e Python com Pillow, numpy e ffmpeg. Rode uma vez `godot --headless --import --path .` e um teste do harness para confirmar que tudo funciona.

Regras de trabalho:
- Siga o roteiro etapa por etapa. A próxima é a **Etapa 7, Fuga do Eco**, descrita na seção 8 do HANDOFF. Depois vêm a cena de abertura, as Fendas Instáveis, as sprites do Lince e Hidrópolis.
- **Sempre verifique bugs e o posicionamento dos elementos com capturas de tela.** Nenhum elemento, nem os do cenário de fundo, pode parecer flutuando sem contexto (use correntes, suportes, apoio no chão ou no teto). A fase deve ser desafiadora, sem ficar aglomerada.
- Plataformas devem ser atravessáveis por baixo.
- Para cada caminho novo, faça testes de alcance com o harness (`act=...`), além da regressão: menu, portal, chefe, vitória, save e continuar.
- A cada marco, exporte e teste os builds de **Windows e Linux**. Entregue o zip do Windows, o tar.gz do Linux e o zip do projeto (sem `.godot`). Atualize `LEIA-ME.md` (seção de novidades da versão), `ROTEIRO.md` e `HANDOFF.md`.
- Quando uma mudança afetar o design, atualize também o caderno .docx, mantendo exatamente 10 páginas.
- Escreva tudo em português do Brasil e explique de forma direta o que mudou em cada entrega.

Comece confirmando que o projeto roda, resuma o que entendeu do estado atual em poucas linhas e siga para a Etapa 7.
