# Prompt para o próximo agente

Use a branch `main` do repositório JmFranca21/warp-fracture. No fluxo automático, o trabalho local acontece na branch `auto/fluxo`, e o João Marcelo faz o merge e o push. As entregas publicadas e o caderno atualizado estão na árvore do projeto.

Você vai continuar o desenvolvimento do jogo **Warp Fracture**, um metroidvania 2D em visão lateral feito em **Godot 4.3** (GDScript, renderizador GL Compatibility). A arte segue a DA-01: 2D cartunizado, simplificado e minimalista, sem pixel art. O projeto está na **v0.6.1**: Laboratório Hélix e Verdâmia jogáveis, com a arte oficial de Verdâmia, chefe, menu, save, mapa, Arpão de Fase, Bancada de Upgrades e Registros. A v0.6.1 corrigiu o fragmento que reaparecia no altar ao continuar o jogo.

**Decisões em vigor:** D01 (locomoção do Eco) e D02 a D05 (passagem Verdâmia → Hélix → Deserto com o Receptáculo, forma Autômato, chefe Forja-Mãe e portais), decididas em 12/11/2026 com as recomendações aceitas. Estão em `colaboracao/decisoes/`.

**Fluxo automático:** desde 12/11/2026, arte, desenvolvimento e revisão trabalham em ciclos, com papéis e permissões definidos em [colaboracao/FLUXO_AUTOMATICO.md](colaboracao/FLUXO_AUTOMATICO.md). Leia esse arquivo antes de alterar qualquer coisa: cada papel só escreve nas pastas dele, e só o gerente edita `colaboracao/STATUS.md`.

Antes de qualquer coisa:
1. Leia **`HANDOFF.md`** inteiro, e também `arte_original/USADAS_NO_JOGO.md` e `docs/DOCUMENTO_DE_ARTE.md`. O HANDOFF explica a arquitetura, onde ficam os dados das fases (`scripts/level_data.gd`), o harness de testes por linha de comando, como exportar e as decisões já tomadas.
2. Leia `ROTEIRO.md`, `colaboracao/STATUS.md` e `docs/Caderno_de_10_paginas_Warp_Fracture_v2.docx`. O caderno é a fonte de verdade do design.
3. Prepare o ambiente:
   - **Windows (máquina do fluxo automático):** Godot 4.3 em `C:/Users/joao.marcelo/AreaJM/Ferramentas/godot-4.3/`, com os export templates. Rode pelo Git Bash com `tools/fluxo/godot.sh` (mesmas flags do HANDOFF, seção 5). Há Python 3.13 com Pillow e numpy; o ffmpeg não está instalado.
   - **Linux:** Godot 4.3 stable com os export templates, `xvfb-run`, e Python com Pillow, numpy e ffmpeg; use `tools/run.sh`.
   - Rode uma vez a importação (`tools/fluxo/godot.sh --import`) e a regressão:
     ```bash
     tools/fluxo/godot.sh --script res://tools/test_verdamia.gd -- save at=999
     tools/fluxo/godot.sh --script res://tools/test_fragmento.gd -- save at=999
     tools/fluxo/godot.sh --script res://tools/test_portal.gd -- level=lab pos=4960,680 terminals god at=30
     ```

Regras de trabalho:
- Siga o roteiro etapa por etapa. A próxima é a **Etapa 7, Fuga do Eco**, descrita na seção 8 do HANDOFF e na D01. Depois vêm a cena de abertura, as Fendas Instáveis e Hidrópolis, além da campanha do Deserto conforme D02–D05.
- **Sempre verifique bugs e o posicionamento dos elementos com capturas de tela.** Nenhum elemento, nem os do cenário de fundo, pode parecer flutuando sem contexto (use correntes, suportes, apoio no chão ou no teto). A fase deve ser desafiadora, sem ficar aglomerada.
- Plataformas devem ser atravessáveis por baixo.
- Para cada caminho novo, faça testes de alcance com o harness (`act=...`), além da regressão: menu, portal, chefe, vitória, save e continuar.
- A cada marco, exporte e teste os builds de **Windows e Linux**. Entregue o zip do Windows, o tar.gz do Linux e o zip do projeto (sem `.godot`).
- Mantenha atualizados os documentos da tabela do `FLUXO_AUTOMATICO.md`: `README.md`, `HANDOFF.md`, este prompt, `ROTEIRO.md`, `LEIA-ME.md` (novidades da versão) e `docs/DOCUMENTO_DE_ARTE.md`.
- Quando uma mudança afetar o design, atualize também o caderno .docx, mantendo exatamente 10 páginas.
- Escreva tudo em português do Brasil e explique de forma direta o que mudou em cada entrega.

Comece confirmando que o projeto roda e que a regressão passa. Depois resuma o estado atual em poucas linhas e siga para a Etapa 7.
