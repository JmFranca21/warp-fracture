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

## Entregas do diretor de arte (pelo canal `colaboracao/`)

Importadas com `tools/import_cells.py` (grade 4×2 transparente, âncora fixa por célula). Os PNGs das entregas não são alterados.

| Animação no jogo | Arquivo de origem | Quadros | fps | Gerado em |
|---|---|---|---|---|
| eco/float | colaboracao/entregas/A2_eco_float/A2_eco_float.png | 6 | 8 (loop) | assets/inimigos/eco/eco_frames.tres |
| eco/appear | colaboracao/entregas/A1_eco_appear/A1_eco_appear_v2.png | 8 | 14 | assets/inimigos/eco/eco_frames.tres |
| eco/advance | colaboracao/entregas/A3_eco_avanco/A3_eco_avanco.png | 6 | 12 (loop) | assets/inimigos/eco/eco_frames.tres |
| eco/grab | colaboracao/entregas/A4_eco_grab/A4_eco_grab.png | 6 | 12 (1–3 mais lentos no jogo) | assets/inimigos/eco/eco_frames.tres |
| eco/vanish | colaboracao/entregas/A5_eco_vanish/A5_eco_vanish_v2.png | 6 | 12 | assets/inimigos/eco/eco_frames.tres |
| eco_dobra/play | colaboracao/entregas/A9_fx_dobra_eco/A9_fx_dobra_eco.png | 8 | 14 | assets/inimigos/eco/eco_dobra_frames.tres |
| poeira_lab/play | colaboracao/entregas/A7_fx_poeira/A7_fx_poeira.png | 6 | 14 | assets/laboratorio/fx/poeira_lab_frames.tres |
| rachadura_teto/play | colaboracao/entregas/A8_fx_rachadura_teto/A8_fx_rachadura_teto.png | 4 | 10 | assets/laboratorio/fx/rachadura_teto_frames.tres |
| entulho 1–3 (estático) | colaboracao/entregas/A6_entulho/A6_entulho_1..3.png | 1 | — | assets/laboratorio/entulho_1..3.png (256 px) |

Referências aprovadas: `arte_original/referencias_aprovadas/A0_ficha_eco.png` (ficha do Eco).

## Verdâmia (v0.6)

Importada com `tools/import_verdamia.py` a partir de `colaboracao/entregas/VD_verdamia/`. Saída em `assets/verdamia/` e `scripts/sprite_meta_verd.gd`. O destino de cada um dos 64 assets está em `colaboracao/revisoes/VD_verdamia.md`.

| No jogo | Arquivos de origem | Quadros |
|---|---|---|
| lince (idle, run, jump, fall, doublejump, wall, claw, pogo, flash, hurt, death) | D_lince_* (wall, claw e flash na versão `_v2`) | 6, 8, 3, 3, 4, 3, 4, 4, 6, 2, 6 |
| esporangio (idle, attack, death) | E_esporangio_* | 6, 4, 6 |
| mariposa (fly, death) | E_mariposa_* | 6, 6 |
| rainha (idle, raizes, esporos, rugido, hurt, death) | 16 folhas E_rainha_* de 2 quadros | 6, 6, 6, 4, 2, 8 |
| efeitos (raiz, aviso_raiz, impacto_esporo, invocacao, poeira, garras, clarao) | VD_fx_* | 6, 4, 4, 6, 4, 4, 6 |
| objetos | E1_cogumelo_gigante, E1_grama, E1_raiz_pendurada, E1_pedra_musgo, E1_arco_templo, E1_altar, VD_checkpoint, VD_barreira_arena, VD_fragmento, VD_esporo_verde, VD_esporo_violeta | estáticos |
| terreno | VD_chao_musgo, VD_subsolo, VD_parede_escalada, VD_canto_esquerdo, VD_canto_direito, VD_espinhos, VD_plataforma_raizes, E1_tronco_plataforma | repetíveis |
| fundo | VD_bg_distante, VD_bg_intermediario, VD_fg_vegetacao | parallax |
