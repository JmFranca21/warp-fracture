# Arte original: o que entrou no jogo

As pastas abaixo são as pranchas enviadas pelo usuário, guardadas sem alteração. `00_Referencias_oficiais` é a referência OFICIAL de design: siga esses desenhos para criar qualquer sprite nova.

| Pasta | Conteúdo |
|---|---|
| 00_Referencias_oficiais | Ficha do Daymon Sagan, Folha de Inimigos do Laboratório Hélix, Prancha de Elementos do Laboratório e GIF do Rastejador (aranha robótica roxa) |
| 01_Daymon_sem_braco | Animações do corpo sem o braço da arma (o braço é uma peça separada que gira no jogo) |
| 02_Daymon_com_bracos | Versões com os braços (hurt e death usadas daqui) |
| 03_Arma | Braço com o Estabilizador de Fase e o efeito de disparo |
| 04_Drone, 05_Rastejador, 06_Efeitos | Animações de inimigos e efeitos |
| 07_Tentativas_remocao_fundo | Tentativa descartada |

## Arquivos usados (definidos em `projeto_godot/tools/extract.py`)

| Animação no jogo | Arquivo de origem | Quadros |
|---|---|---|
| daymon/idle | 01_Daymon_sem_braco/idle_v1_fundo_escuro.png | 6 |
| daymon/run | 01_Daymon_sem_braco/run_v2_verde.png | 8 |
| daymon/jump | 01_Daymon_sem_braco/jump_v1.png | 3 |
| daymon/fall | 01_Daymon_sem_braco/fall_v1.png | 3 |
| daymon/dash | 01_Daymon_sem_braco/dash.png | 4 |
| daymon/hurt | 02_Daymon_com_bracos/hurt_v1.png | 2 |
| daymon/death | 02_Daymon_com_bracos/death_v1.png | 6 |
| arma/braco | 03_Arma/braco_arma_v2.png | 1 |
| arma/disparo | 03_Arma/disparo.png | 3 |
| drone/fly, charge, shoot, hurt, death | 04_Drone/fly, charge, shoot_v2, hurt, death | 6, 4, 3, 2, 6 |
| rastejador/death | 05_Rastejador/death.png | 6 |
| rastejador idle/walk/attack/hurt | GIF em 00_Referencias_oficiais | do GIF |
| fx explosao, caixa, impacto, campo | 06_Efeitos/explosao_barril, caixa_quebrando, impacto_tiro, campo_energia | 8, 6, 4, 6 |
| Objetos do laboratório (caixa, barril, alavanca, janela, tanque, câmera, turreta etc.) | Recortados das pranchas de Elementos e de Inimigos | estáticos |

Para gerar sprites novas, use `projeto_godot/PROMPT_SPRITESHEETS.md`. Depois:
1. Adicione o arquivo ao dicionário `SPECS` de `extract.py`.
2. Rode `python extract.py <pasta_das_pranchas> <saida>`.
3. Rode `build_sheets.py` para gerar os `*_frames.tres` e o `sprite_meta.gd`.
4. Rode `godot --headless --import`.

O LEIA-ME.txt desta pasta lista os defeitos conhecidos das pranchas.
