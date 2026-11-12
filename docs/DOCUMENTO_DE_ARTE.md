# Warp Fracture: documento de arte

> **Mantido pelo fluxo automático** ([colaboracao/FLUXO_AUTOMATICO.md](../colaboracao/FLUXO_AUTOMATICO.md)). O especialista técnico atualiza este arquivo a cada entrega. Quem decide o estado de cada pedido é o [quadro de pedidos](../colaboracao/STATUS.md), que só o gerente edita; se este documento divergir do quadro, vale o quadro, e a diferença deve ser corrigida no ciclo seguinte.
>
> Situação em 12/11/2026, jogo na v0.6.1.

## Como ler

- **Diretriz de estilo:** [DA-01](../colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) (2D cartunizado, simplificado e minimalista, no traço das referências oficiais). Vale para tudo abaixo.
- **Ficha de referência:** o desenho que define a aparência do item. Referências oficiais ficam em `arte_original/00_Referencias_oficiais/` e `arte_original/referencias_aprovadas/`.
- **Estado:** um dos estados do fluxo (`pedido`/`ABERTO`, `entregue`, `aprovado`, `integrado`, `suspenso`), copiado das fontes citadas. Sem evidência nas fontes, o estado aparece como **sem registro**.
- **Arquivos:** origem (entrega ou prancha) → arquivo importado no jogo, quando existe.
- **Onde aparece:** script e fase em que o asset é usado. "Desenhado por código" quer dizer que não há arte ilustrada no jogo para o item.

Fontes usadas: DA-01; [STATUS.md](../colaboracao/STATUS.md); [USADAS_NO_JOGO.md](../arte_original/USADAS_NO_JOGO.md); revisões [A0](../colaboracao/revisoes/A0_ficha_eco.md), [A2](../colaboracao/revisoes/A2_eco_float.md) e [VD_verdamia](../colaboracao/revisoes/VD_verdamia.md); pedidos em `colaboracao/pedidos/`; e o código em `scripts/`, conferido em 12/11/2026.

---

## 1. Laboratório Hélix

As pranchas são do próprio projeto (enviadas pelo João Marcelo) e foram recortadas por `tools/extract.py` e `tools/build_sheets.py`. Não passaram pelo canal `colaboracao/`, então **não há revisão registrada**: o estado "integrado" vem de `USADAS_NO_JOGO.md` e do código.

### Personagem

| Item | Ficha de referência | Estado | Arquivos | Onde aparece |
|---|---|---|---|---|
| Daymon Sagan, forma humana (idle, run, jump, fall, dash, hurt, death) | `00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` | integrado | `arte_original/01_Daymon_sem_braco/*`, `02_Daymon_com_bracos/hurt_v1, death_v1` → `assets/personagens/daymon/daymon_sheet.png` + `daymon_frames.tres` | `player.gd` (forma `human`), Laboratório |
| Braço com o Estabilizador de Fase | mesma ficha | integrado | `03_Arma/braco_arma_v2.png` → `braco_sheet.png` | `player.gd` (braço que gira com a mira) |
| Disparo do Estabilizador | mesma ficha | integrado | `03_Arma/disparo.png` → `disparo_sheet.png` | `player.gd` |
| Arpão de Fase (gancho e cabo) | sem registro | sem registro (desenhado por código) | — | `grapple_hook.gd` |

### Inimigos

| Item | Ficha de referência | Estado | Arquivos | Onde aparece |
|---|---|---|---|---|
| Rastejador (idle, walk, attack, hurt, death) | `00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png` e GIF do Rastejador | integrado | GIF oficial + `05_Rastejador/death.png` → `assets/inimigos/rastejador/rastejador_sheet.png`, `rastejador_morte_sheet.png` | `crawler.gd`, Laboratório |
| Drone (fly, charge, shoot, hurt, death) | Folha de Inimigos do Laboratório | integrado | `04_Drone/*` → `assets/inimigos/drone/drone_sheet.png` | `drone.gd`, Laboratório |
| Turreta Sentinela | Folha de Inimigos do Laboratório | integrado (estática) | recorte da folha → `assets/inimigos/turreta/turreta.png` | `turret.gd`, Sala C |
| Câmera de segurança | Prancha de Elementos do Laboratório | integrado (estática) | → `assets/laboratorio/camera_corpo.png`, `camera.png` | `security_cam.gd`, `level.gd` |

### Objetos e cenário

Ficha de referência de todos: `00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png`. Origem: recortes dessa prancha e da Folha de Inimigos (`USADAS_NO_JOGO.md`). Destino: `assets/laboratorio/`.

| Item | Estado | Arquivo no jogo | Onde aparece |
|---|---|---|---|
| Caixa, caixa pesada, barril explosivo | integrado | `caixa.png`, `caixa_pesada.png`, `barril.png` | `crate.gd`, `level_data.gd` (`crates`) |
| Alavanca | integrado | `alavanca.png` | `switches.gd` |
| Terminal | integrado | `terminal.png` | `terminal.gd` |
| Porta de emergência | integrado | `porta.png` | `door.gd` |
| Emissor de laser | integrado | `laser_emissor.png` | `laser_gate.gd` |
| Trava de energia | integrado | `trava.png` | `energy_lock.gd` |
| Plataformas suspensa, móvel e quebradiça | integrado | `plat_suspensa.png`, `plat_movel.png`, `plat_quebravel.png` | `platforms.gd` |
| Estação de Recarga (suporte de célula) | integrado | `celula_suporte.png` | `checkpoint.gd` (Laboratório) |
| Célula de energia, kit de reparo | integrado | `celula_energia.png`, `kit_reparo.png` | `pickup.gd` |
| Janela, tanque, tubulação, bandeira, cabos, alerta | integrado | `janela.png`, `tanque.png`, `tubulacao.png`, `bandeira.png`, `cabos.png`, `alerta.png` | `level_data.gd` (`decor`), `level.gd` |
| Plataforma sólida, campo de energia (estáticos) | sem registro de uso | `plat_solida.png`, `campo_energia.png` | Nenhuma referência no código em 12/11/2026 (o campo usa a animação `fx_campo`) |
| Bancada de Upgrades, Portal do Hélix, parede de fundo, terreno | sem registro (desenhados por código) | — | `bench.gd`, `portal.gd`, `back_wall.gd`, `terrain.gd` |

### Efeitos

| Item | Ficha de referência | Estado | Arquivos | Onde aparece |
|---|---|---|---|---|
| Explosão de barril, caixa quebrando, impacto de tiro, campo de energia | Prancha de Elementos | integrado | `06_Efeitos/explosao_barril, caixa_quebrando, impacto_tiro, campo_energia` → `assets/efeitos/fx_*_sheet.png` | `fx_anim.gd`, `energy_field.gd` |

### Eco (vilão; Etapa 7, Fuga do Eco)

Ficha de referência: **A0_ficha_eco**, aprovada como referência oficial ([revisão](../colaboracao/revisoes/A0_ficha_eco.md)) e copiada para `arte_original/referencias_aprovadas/A0_ficha_eco.png`. Escala obrigatória: figura de 380 px na pose da A2. Locomoção definida na [D01](../colaboracao/decisoes/D01_locomocao_eco.md).

| ID | Item | Estado | Arquivos | Onde aparece |
|---|---|---|---|---|
| A0 | Ficha do Eco | aprovado (referência; não entra no jogo) | `colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png` | — |
| A1 | Materialização, 8 quadros | entregue (sem revisão) | `entregas/A1_eco_appear/A1_eco_appear.png` | Ainda não usado (Fuga do Eco) |
| A2 | Pairando (loop), 6 quadros | integrado como asset; fora do gameplay | `entregas/A2_eco_float/A2_eco_float.png` → `assets/inimigos/eco/eco_sheet.png`, `eco_frames.tres` (`tools/import_cells.py`) | `sprite_meta_cells.gd` (`ECO_FRAMES`). Nenhum script de gameplay usa ainda |
| A3 | Avanço flutuante (loop), 6 quadros | entregue (sem revisão) | `entregas/A3_eco_avanco/A3_eco_avanco.png` | Ainda não usado |
| A3_eco_run | Corrida (versão antiga) | cancelado (substituído pela A3_eco_avanco) | [pedido](../colaboracao/pedidos/A3_eco_run.md) | — |
| A4 | Agarrão no ar, 6 quadros | entregue (uso provisório) | `entregas/A4_eco_grab/A4_eco_grab.png` | Ainda não usado |
| A5 | Eco se desfazendo, 6 quadros | entregue (sem revisão) | `entregas/A5_eco_vanish/A5_eco_vanish.png` | Ainda não usado |
| A9 | Fenda da Dobra espectral, 8 quadros | entregue (sem revisão) | `entregas/A9_fx_dobra_eco/A9_fx_dobra_eco.png` | Ainda não usado |

### Desabamento da Fuga do Eco

Ficha de referência: Prancha de Elementos do Laboratório (pedidos A6–A8).

| ID | Item | Estado | Arquivos | Onde aparece |
|---|---|---|---|---|
| A6 | 3 pedaços de teto que caem | pedido (ABERTO) | [pedido](../colaboracao/pedidos/A6_entulho.md) | Fuga do Eco (a implementar) |
| A7 | Poeira de impacto, 6 quadros | pedido (ABERTO) | [pedido](../colaboracao/pedidos/A7_fx_poeira.md) | Fuga do Eco (a implementar) |
| A8 | Rachadura no teto, 4 quadros | pedido (ABERTO) | [pedido](../colaboracao/pedidos/A8_fx_rachadura_teto.md) | Fuga do Eco (a implementar) |

---

## 2. Verdâmia

Pacote `colaboracao/entregas/VD_verdamia/` (64 assets em 67 PNGs), importado por `tools/import_verdamia.py` para `assets/verdamia/` e `scripts/sprite_meta_verd.gd`. **Estado: integrado na v0.6 (11/11/2026)**, com 61 assets em uso e 3 pranchas de referência ([revisão VD_verdamia](../colaboracao/revisoes/VD_verdamia.md), que também lista 7 ajustes não bloqueantes). A revisão tem a tabela asset por asset; abaixo, o resumo por grupo.

### Fichas de referência

| ID | Item | Estado | Arquivo |
|---|---|---|---|
| D0_lince | Lince-Vagalume | aprovado (referência; não entra no jogo) | `entregas/VD_verdamia/D0_lince.png` |
| E0_inimigos | Esporângio, Mariposa e Rainha Micélia | aprovado (referência; não entra no jogo) | `entregas/VD_verdamia/E0_inimigos.png` |
| VD00_ambiente | Ambiente de Verdâmia | aprovado (referência; não entra no jogo) | `entregas/VD_verdamia/VD00_ambiente.png` |

### Personagem, inimigos e chefe

| Item | Ficha | Estado | Arquivos | Onde aparece |
|---|---|---|---|---|
| Lince-Vagalume: idle, run, jump, fall, doublejump, wall, claw, pogo, flash, hurt, death | D0_lince | integrado | `D_lince_*.png` (wall, claw e flash em `_v2`) → `assets/verdamia/lince/lince_sheet.png` | `player.gd` (`_build_lynx`, `_update_lynx`) |
| Esporângio: idle, attack, death | E0_inimigos | integrado | `E_esporangio_*.png` → `assets/verdamia/inimigos/esporangio_sheet.png` | `spore_plant.gd` |
| Mariposa: fly, death | E0_inimigos | integrado | `E_mariposa_*.png` → `mariposa_sheet.png` | `moth.gd` |
| Rainha Micélia: idle, raizes, esporos, rugido, hurt, death (16 folhas) | E0_inimigos | integrado | `E_rainha_*.png` → `rainha_sheet.png` | `queen.gd`, arena do templo |

### Cenário, terreno e objetos

| Item | Ficha | Estado | Arquivos (`assets/verdamia/`) | Onde aparece |
|---|---|---|---|---|
| Cogumelo gigante, grama, raiz pendurada, pedra com musgo, arco do templo, altar | VD00_ambiente | integrado | `objetos/cogumelo_gigante, grama, raiz_pendurada, pedra_musgo, arco_templo, altar.png` | `level_data.gd` (`decor`) |
| Tronco-plataforma, plataforma de raízes | VD00_ambiente | integrado | `terreno/tronco_plataforma.png`, `plataforma_raizes.png` | `level_data.gd`, `platforms.gd` |
| Chão de musgo, subsolo, borda de parede, quinas, espinhos | VD00_ambiente | integrado | `terreno/chao_musgo, subsolo, parede_borda, canto_esquerdo, canto_direito, espinhos.png` | `terrain.gd` (`_verd_all`), `hazard.gd` |
| Parallax distante, intermediário e primeiro plano | VD00_ambiente | integrado | `fundo/bg_distante, bg_intermediario, fg_vegetacao.png` | `verd_bg.gd`, `fg_layer.gd` |
| Santuário (checkpoint) | VD00_ambiente | integrado | `objetos/checkpoint.png` | `checkpoint.gd` (x 2570) |
| Barreira da arena | VD00_ambiente | integrado | `objetos/barreira_arena.png` | `gate.gd` |
| Fragmento da Máquina de Dobra | VD00_ambiente | integrado | `objetos/fragmento.png` | `fragment.gd`, altar da arena |
| Esporo verde e esporo violeta | E0_inimigos | integrado | `objetos/esporo_verde.png`, `esporo_violeta.png` | `enemy_bullet.gd` |

### Efeitos

| Item | Estado | Arquivos (`assets/verdamia/efeitos/`) | Onde aparece |
|---|---|---|---|
| Raiz e aviso de raiz | integrado | `fx_raiz_sheet.png`, `fx_aviso_raiz_sheet.png` | `spike.gd` (ataque da Rainha) |
| Impacto de esporo, invocação, poeira de pouso, clarão | integrado | `fx_impacto_esporo, fx_invocacao, fx_poeira, fx_clarao_sheet.png` | `fx_anim.gd` (`FxAnim.verd`) |
| Garras | integrado | `fx_garras_sheet.png` | `slash.gd` |

### Ajustes pedidos (não bloqueiam)

Registrados na revisão VD_verdamia: escala entre as folhas do Lince, garras no ar (`D_lince_claw_air`), esquiva do Lince, fim da morte da Rainha, contorno de `esporos_3`, subsolo repetível e miolo da parede. Estado: **sem registro** de pedido aberto para eles no quadro.

---

## 3. Deserto de Ferrugem (pedido DF, arte da fase)

Pedido: [DF_deserto_ferrugem.md](../colaboracao/pedidos/DF_deserto_ferrugem.md). Escala: Daymon = 400 px (D). Todos os itens estão **entregues** no quadro. A versão jogável está só na branch `prototipo/deserto-de-ferrugem`; **nenhum asset do DF está integrado na campanha principal** (não há `assets/deserto/` nem referência no código da `main`). Não há revisão registrada em `colaboracao/revisoes/` para o pacote DF.

| ID | Item | Ficha de referência | Estado | Arquivos (`colaboracao/entregas/`) | Onde aparece |
|---|---|---|---|---|---|
| DF00 | Prancha de referência do Deserto | Prancha de Elementos do Laboratório | entregue (aprovado pelo responsável, segundo o quadro) | `DF00/DF00_prancha_deserto.png` | Referência; não entra no jogo |
| DF01 | Ficha do Robô e do Drone do deserto | Folha de Inimigos do Laboratório | entregue (aprovado pelo responsável, segundo o quadro) | `DF01/DF01_ficha_inimigos_deserto.png` | Referência; não entra no jogo |
| DF10–DF12 | Fundos em parallax: céu, fábricas distantes, dunas de sucata | DF00 | entregue | `DF10/DF10_fundo_ceu.png`, `DF11/…_fabricas_distantes.png`, `DF12/…_dunas_sucata.png` (a peça opcional `DF10b_sol` não foi entregue) | Só no protótipo |
| DF20–DF28 | Chão das dunas, espinhos, paredes externa/interna/do Núcleo, piso de metal, esteira (e pontas), trilho vertical, cabo | DF00 | entregue | `DF20` a `DF28` | Só no protótipo |
| DF30–DF39 | Montes de sucata, mastro com viga, chaminé, porta da fábrica, engrenagem de fundo, abertura na parede, torre do Núcleo, lâmpada (acesa e apagada), porta de saída (fechada e aberta), painel e canos | DF00 | entregue | `DF30` a `DF39` | Só no protótipo |
| DF50–DF57 | Prensa grande e pequena (3 peças cada), serra e base, plataformas suspensas, vertical e móvel (com trilho), válvula de vapor (2 estados), ponto de gancho | DF00 | entregue | `DF50` a `DF57` | Só no protótipo |
| DF60–DF65 | Robô: idle, andar, aviso, tiro, dano, destruído | DF01 | entregue | `DF60` a `DF65` | Só no protótipo |
| DF66–DF69 | Drone do deserto: voo, aviso, tiro, dano e destruído | DF01 | entregue | `DF66` a `DF69` | Só no protótipo |
| DF70–DF71 | Projéteis do Robô e do Drone | DF01 | entregue | `DF70`, `DF71` | Só no protótipo |
| DF80–DF86 | Fumaça de chaminé, jato de vapor, faíscas da prensa, poeira de areia, explosão de máquina, impacto de projétil, partículas de vento | DF00 | entregue | `DF80` a `DF86` | Só no protótipo |

---

## 4. Portais e Fase 2 (campanha do Deserto)

Base: [proposta da Fase 2](fases/deserto_ferrugem/proposta_fase2.md) e decisões [D02](../colaboracao/decisoes/D02_passagem_verdamia_deserto.md) (retorno ao Hélix e Receptáculo), [D03](../colaboracao/decisoes/D03_forma_deserto.md) (Autômato), [D04](../colaboracao/decisoes/D04_chefe_deserto.md) (Forja-Mãe) e [D05](../colaboracao/decisoes/D05_portais.md) (portais), todas decididas em 12/11/2026. As fichas novas só viram referência depois da aprovação do João Marcelo, e os lotes 2 e 3 esperam a ficha correspondente.

| ID | Item | Ficha de referência | Estado | Arquivos | Onde vai aparecer |
|---|---|---|---|---|---|
| DF02 | Ficha do Autômato (forma de Daymon no Deserto) | Ficha do Daymon; DF00 | pedido (ABERTO; aprovação final do João) | [pedido](../colaboracao/pedidos/DF02_ficha_automato.md) | Referência do lote DF87–DF99 |
| DF03 | Ficha da Forja-Mãe e esquema da arena | DF00, DF01 | pedido (ABERTO; aprovação final do João) | [pedido](../colaboracao/pedidos/DF03_ficha_forja_mae.md) | Referência do lote DF100–DF112 |
| PT00 | Ficha dos portais e do Receptáculo | Prancha de Elementos do Laboratório | pedido (ABERTO; aprovação final do João) | [pedido](../colaboracao/pedidos/PT00_ficha_portais.md) | Referência do lote PT10–PT23 |
| DF87–DF99 | Autômato: 7 folhas do corpo, braço, rebite, disparo, feixe e pulso | DF02 (pendente) | suspenso (aguarda DF02) | [pedido](../colaboracao/pedidos/DF87-DF99_automato.md) | Jogador no Deserto (`player.gd`, forma nova, a implementar) |
| PT10–PT23 | Arco de Dobra, glifos, Receptáculo, membrana e Fenda | PT00 (pendente) | suspenso (aguarda PT00) | [pedido](../colaboracao/pedidos/PT10-PT23_portais.md) | Portal do Hélix (`portal.gd`, hoje desenhado por código), Receptáculo e fenda de retorno de Verdâmia (D02) |
| DF100–DF112 | Forja-Mãe: corpo, lente, peito, braço, martelo, núcleo, escotilha, grade e efeitos | DF03 (pendente) | suspenso (aguarda DF03) | [pedido](../colaboracao/pedidos/DF100-DF112_forja_mae.md) | Chefe do Deserto (a implementar) |

---

## 5. Interface (UI)

| Item | Ficha de referência | Estado | Arquivos | Onde aparece |
|---|---|---|---|---|
| HUD (Integridade, Energia, Células, fragmentos, avisos, vitória) | sem registro | sem registro (desenhado por código) | — | `hud.gd` |
| Menu principal, pausa e opções | sem registro | sem registro (desenhado por código) | — | `menu.gd`, `menu_list.gd` |
| Mapa | sem registro | sem registro (desenhado por código) | — | `hud.gd` |
| Calibração do portal | sem registro | sem registro (desenhado por código) | — | `calibration.gd` |
| Painel da Bancada e painel de Registros | sem registro | sem registro (desenhado por código) | — | `bench_panel.gd`, `log_panel.gd` |
| Placas de dica | sem registro | sem registro (desenhado por código) | — | `sign.gd` |

Nenhum pedido de arte de UI existe no quadro em 12/11/2026.
