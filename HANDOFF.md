# Warp Fracture — Documento de passagem (handoff)

Situação em 13/11/2026, protótipo **v0.7** (seção 13: Fuga do Eco). D02–D05 decididas em 12/11/2026, com as recomendações aceitas; o trabalho segue o [fluxo automático](colaboracao/FLUXO_AUTOMATICO.md). Este arquivo tem o contexto que um novo agente (ou programador) precisa para continuar o projeto sem refazer nada.

---

## 1. O que é o projeto

- **Jogo:** *Warp Fracture*, metroidvania 2D em visão lateral, com visual inspirado em Hollow Knight (ilustrado, **sem pixel art**). É um trabalho acadêmico do João Marcelo (Unifesp).
- **História:** em 2100, o cientista Daymon Sagan explode a Máquina de Dobra do Projeto Hélix. Os 4 fragmentos da máquina caem em 4 universos (Verdâmia, Hidrópolis, Ferrumgrado e Umbra). Em cada universo, Daymon assume outra forma. A IA IRIS orienta pelo rádio, e o vilão é o **Eco**, uma entidade de energia com a silhueta de Daymon. No final, aparece um quinto sinal.
- **Documento de design:** [caderno de dez páginas](docs/Caderno_de_10_paginas_Warp_Fracture_v2.docx), revisado em 11/11/2026. É a fonte de verdade do design. Se o jogo mudar, o caderno precisa ser atualizado também, **sem passar de 10 páginas**.
- **Motor:** Godot **4.3** (stable), GDScript, renderizador **GL Compatibility** (OpenGL 3.3). Exporta para **Windows e Linux**.

> **Arte:** a diretriz oficial é a **DA-01** (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): 2D cartunizado, simplificado e minimalista, no mesmo traço das referências oficiais. A arte é feita pelo ChatGPT (diretor de arte) pelo canal `colaboracao/` (veja `colaboracao/PROTOCOLO.md`). O desenvolvimento não altera estilo nem gera arte final; só integra assets aprovados.

## 2. Preferências do usuário (obrigatórias)

1. **Sempre verificar bugs e o posicionamento dos elementos**, inclusive os do cenário de fundo. Nada pode parecer flutuando sem contexto: correntes, suportes, apoio no chão ou no teto. Valide com capturas de tela.
2. A fase deve ser **complexa e difícil, sem ficar aglomerada nem exagerada**.
3. **Plataformas atravessáveis por baixo.** O jogador pula através delas e desce com S + Espaço.
4. Toda entrega precisa ter **builds testados para Windows e Linux**, mais o zip do projeto.
5. Textos do jogo e respostas em **português do Brasil**.
6. Trabalhar seguindo o roteiro (seção 8), etapa por etapa. Entregue um build a cada marco e avise o que mudou.

## 3. Estado atual (v0.6; v0.7 e v0.8 nas seções 13 e 14)

**Laboratório Hélix** (forma humana, com o Estabilizador de Fase):
- Salas: A Despertar, B Fosso, C Turreta, D Sala Alta, E Lasers, F Campo, G Saída, mais a S Ala Secreta.
- Tiro mirado com o mouse (ou analógico direito) e tiro carregado (1/3 da energia).
- Movimento: esquiva, pulo variável e descida de plataformas.
- Arpão de Fase: tecla F; encontrado na Sala Alta; dá para encadear ganchos.
- Puzzles e obstáculos:
  - plataformas suspensas, móveis e quebradiças;
  - elevador ligado por alavanca;
  - lasers alternados;
  - câmera de segurança que dispara um alarme e solta Rastejadores;
  - campo de força com trava de energia;
  - caixas, caixas pesadas e barris explosivos;
  - 2 terminais que abrem a porta;
  - portal com o mini-game de Calibração (alinhar 3 ondas).
- Inimigos: Rastejador (animado), Drone (animado) e Turreta Sentinela.

**Verdâmia** (forma Lince-Vagalume):
- Movimento: pulo duplo, salto na parede e golpe para baixo que quica (pogo).
- Ataques: garras e clarão.
- Inimigos: Esporângio e Mariposa.
- Chefe: **Rainha Micélia** (esporos, raízes, rajada e invocação de mariposas). Vencê-la abre a barreira e faz surgir o fragmento. A coleta aciona a tela de vitória e salva o jogo.
- O Lince, os inimigos da floresta e a Rainha ainda são desenhados por código. As folhas ilustradas estão em `colaboracao/entregas/VD_verdamia/`.

**Sistemas:**
- Menu principal: Continuar, Novo jogo, Opções e Sair.
- Pausa: Continuar, Mapa, Registros, Opções e Salvar e sair.
- Mapa (Tab/M): revela as salas conforme a exploração.
- Opções: volumes, tela cheia e tremor de tela.
- Save em JSON:
  - Salva nas Estações de Recarga, na Bancada, no portal e na pausa.
  - Mexendo no código, também é possível salvar a qualquer momento (função `save_now()` em `main.gd`).
- **Bancada de Upgrades:** fica na sala A e também funciona como checkpoint. Melhorias:
  - Blindagem: 12 e 30 células.
  - Condensador: 10 e 24 células.
  - Esquiva: 18 células.
  - Gatilho: 15 células.
- **Registros do Projeto:** 8 tablets (5 no laboratório e 3 em Verdâmia). Abrem um painel de leitura e podem ser relidos pela pausa.
- **Núcleo de Integridade:** +1 de vida máxima. Fica na Ala Secreta.
- Áudio: 44 efeitos e 4 músicas, todos gerados por síntese (`tools/gen_audio.py`). Barramentos Master, Musica e Efeitos.

## 4. Estrutura do projeto

```
warp/
  project.godot, main.tscn, export_presets.cfg ("Windows Desktop", "Linux")
  LEIA-ME.md            manual do jogador + novidades por versão (atualizar a cada versão)
  ROTEIRO.md            roteiro de melhorias (o que foi feito e o que falta)
  PROMPT_SPRITESHEETS.md  prompt usado no ChatGPT para gerar spritesheets
  HANDOFF.md            este arquivo
  scripts/              todo o código (cerca de 6.800 linhas de GDScript, sem cenas além de main.tscn)
  assets/               personagens/daymon, inimigos/{rastejador,drone,turreta}, laboratorio/*.png,
                        efeitos/fx_*_sheet.png + *_frames.tres, audio/{sfx,music}
  tools/                extract.py (recorta pranchas), build_sheets.py (gera .tres e sprite_meta.gd),
                        gen_audio.py (sintetiza WAV/OGG; precisa de numpy e ffmpeg)
```

**Arquitetura (tudo é criado por código):**
- `main.gd`: gerenciador do jogo.
  - Guarda o estado: `cells`, `fragments`, `terminals`, `collected`, `modules`, `upgrades`, `visited`, `checkpoint_*`.
  - Controla a máquina de estados: `menu`, `level` e `victory`.
  - Monta a UI em CanvasLayers: Hud na camada 6, Calibration, BenchPanel e LogPanel na 7, MainMenu na 8 e fade na 10.
  - Também define o mapa de entrada (`_setup_input`), o save/load e o **harness de testes**.
- `level_data.gd`: **dados das fases** em dicionários. Cada fase tem `solids`, `platforms`, `hazards`, `lasers`, `cameras`, `levers`, `fields`, `locks`, `hooks`, `enemies`, `crates`, `pickups`, `decor`, `signs`, `checkpoints`, `benches`, `terminals`, `door`, `portal`, `boss`, `rooms` (para o mapa) e `backwall`. Para editar uma fase, normalmente basta mexer aqui.
- `level.gd`: lê os dados e instancia cada objeto. Também tem `trigger(target)` (grupo `switchable`) e `drop_cell`.
- `player.gd`: Daymon. Forma `human` (rig de sprite com braço que gira, `BODY_SCALE 0.58`) e forma `lince` (desenhada por código). Arpão, esquiva, pogo e drop-through.
- Outros scripts: `upgrades.gd` (tabela de melhorias), `logs.gd` (textos dos registros), `pickup.gd` (tipos cell, heal, energy, modulo, nucleo e registro), `hud.gd`, `menu.gd` e `menu_list.gd`, `audio_mgr.gd` (`AudioMgr.sfx(nome, pos, vol, pitch)` e `AudioMgr.music(trilha)`), `save_game.gd` e `settings.gd`.
- Plataformas one-way: `AnimatableBody2D` na camada 256. **Atenção:** defina `sync_to_physics` ANTES da posição, senão a plataforma fica presa em (0,0).
- Coordenadas: o chão do laboratório fica em y=800. O teto das salas baixas fica em y=220, e o da Sala Alta e da Ala Secreta em y=-260.

## 5. Como rodar e testar

**Ambiente usado até agora (Linux):**
- Godot 4.3 com os export templates instalados. Binário oficial: `Godot_v4.3-stable_linux.x86_64`.
- `xvfb-run`.
- Python 3 com Pillow, numpy e ffmpeg.

**Script de teste** (`tools/run.sh`; defina `GODOT=/caminho/do/godot`):
```bash
#!/bin/bash
cd /caminho/warp
timeout ${TO:-60} xvfb-run -a -s "-screen 0 1280x720x24" ./Godot_v4.3-stable_linux.x86_64 \
  --rendering-driver opengl3 --audio-driver Dummy --path . -- "$@" 2>&1 | grep -vE "^$|Godot Engine|OpenGL API"
```

**Harness:** são argumentos depois de `--`, lidos em `main.gd` (`_parse_args`, `_auto_process`, `_physics_process`). O jogo imprime uma linha `STATE ...` (posição, vida/máx, energia, células, terminais, estado) e fecha sozinho depois de `at` segundos.

| Flag | Efeito |
|---|---|
| `level=lab` / `level=verdamia` / `level=deserto` | Pula o menu e carrega a fase |
| `pos=x,y` | Posição inicial |
| `at=2.0` | Tempo até a captura e o fechamento |
| `shot=/tmp/x.png` | Salva uma captura de tela em `at` |
| `act=acao@t0-t1;acao@t0-t1` | Aperta ações em janelas de tempo (right, left, jump, attack, special, dash, hook, interact, confirm, pause, up, down, map...) |
| `god` | Invulnerável |
| `terminals` | Terminais A e B ativos |
| `energy=99`, `hp=3`, `cells=50`, `arpao` | Estado inicial |
| `boss`, `killboss=1.5`, `victory`, `calib`, `pause`, `trigger=id`, `visitall`, `trace`, `title` | Atalhos de teste |
| `save` | Permite gravar o save durante o teste (normalmente fica desligado) |
| `frags=verdamia,deserto`, `installed=verdamia`, `cal=verdamia,deserto`, `bossdone=verdamia,deserto`, `fugadone` | Progresso inicial da campanha (v0.8) |

Exemplos:
```bash
./run.sh level=lab pos=645,790 cells=50 "act=interact@0.3-0.35;confirm@0.6-0.65" at=1 shot=/tmp/bancada.png
./run.sh level=verdamia pos=4100,790 boss killboss=1.5 god at=4
```

Regras do harness que já causaram bugs:
- Use `Input.action_press` para ações de jogo.
- Eventos de direção só são enviados quando há menu aberto ou o jogo está pausado.
- O harness roda em `_physics_process`, por causa da confiabilidade do `just_pressed`.

Arquivo de save no Linux: `~/.local/share/godot/app_userdata/Warp Fracture - Prototipo/warp_save.json` (as configurações ficam em `settings.cfg`).

**Exportar e empacotar:**
```bash
godot --headless --import --path .            # após adicionar assets/scripts novos
godot --headless --path . --export-release "Windows Desktop" build/WarpFracture.exe
godot --headless --path . --export-release "Linux" build_linux/WarpFracture.x86_64
```
- Windows: zip com `WarpFracture.exe` e `LEIA-ME.md`.
- Linux: tar.gz com `WarpFracture.x86_64` e `LEIA-ME.md`.
- Projeto: zip da pasta inteira, **sem a pasta `.godot`**.

**Checklist antes de cada entrega:**
1. Importação sem erros de SCRIPT ou Parse.
2. Testes de alcance de cada caminho novo, usando o harness com `act`.
3. Capturas de tela de cada área alterada, conferindo se algo flutua, se há sobreposição ou se algum objeto está cortado.
4. Regressão: menu, portal com calibração, chefe e vitória, save e continuar.
5. Exportar os dois builds e rodar o build Linux exportado uma vez.
6. Atualizar `LEIA-ME.md` (seção "Novidades da vX") e `ROTEIRO.md`.

## 6. Arte: fluxo de sprites

- O usuário gera as pranchas e spritesheets no ChatGPT com `PROMPT_SPRITESHEETS.md`. As regras são: grade 4×2 de células 384×512 px, fundo transparente ou verde #00FF00, pés a 40 px da borda de baixo, olhando para a direita.
- `tools/extract.py` recorta as imagens. `tools/build_sheets.py` gera os `*_frames.tres` (SpriteFrames) e o `scripts/sprite_meta.gd`.
- No jogo, use `AnimatedSprite2D` com animações nomeadas (idle, walk, attack, hurt, death...), trocadas por código.
- **Entregas do diretor de arte:** em grade 4×2 com fundo transparente. Importe com `python tools/import_cells.py .`: os conjuntos ficam em `CELL_SETS`, e o script gera `scripts/sprite_meta_cells.gd`. A escala é calibrada para a altura do Daymon idle no jogo.
- **Pranchas originais:** estão na pasta `arte_original/` do pacote de handoff. Veja `arte_original/USADAS_NO_JOGO.md` para saber qual arquivo virou cada animação. As referências oficiais de design ficam em `00_Referencias_oficiais`.
- **Arte nova:** siga `docs/GUIA_PROXIMOS_PASSOS_E_ASSETS.md`, que define os pacotes A–G com prompts e especificações. Os chefes grandes (Rainha e Leviatã) usam uma grade de 2×1, com células de 768×1024. Para eles, o `extract.py` precisa aceitar `CW, CH` por arquivo.
- **Verdâmia:** 64 assets em 67 PNGs. Usar o manifesto e as versões v2 de parede, garras e clarão. Revisar recortes, âncoras, escala e os 19 objetos/terrenos com dimensões diferentes do pedido antes de configurar animações e colisões.

## 7. Decisões de design já tomadas

- Tudo em visão lateral, inclusive as formas futuras. Nada de visão de cima.
- O Arpão de Fase é o 1º módulo, achado no laboratório. Os próximos módulos vêm dos universos: Dispersor, Canhão de Carga e Lança de Fase.
- A economia de Células é de cerca de 1 por inimigo ou caixa, mais as células fixas no mapa. As melhorias custam 10 a 30.
- Registros: 40 no jogo completo, 8 no protótipo.
- Save: 1 slot no protótipo, 3 slots e nuvem na versão final.

## 8. Próximos passos (Fase 3 do roteiro, nesta ordem)

**7. Fuga do Eco** (clímax do laboratório) — **concluída na v0.7; veja a seção 13.** A especificação original fica abaixo como registro:
- Depois que os dois terminais forem ativados e a porta abrir, o Eco aparece. É uma silhueta de energia roxa e ciano com a forma do Daymon. Ele persegue o jogador sem poder ser morto.
- A sala desmorona enquanto isso: pedaços caem do teto com aviso no chão, o piso se fende e o alarme toca. O jogador corre até o portal usando a esquiva, o Arpão e as plataformas.
- Precisa de um checkpoint no início da fuga, de uma trilha de fuga nova (em `gen_audio.py`) e de efeitos de desabamento.
- Um registro novo pode amarrar o evento.
- A [decisão D01](colaboracao/decisoes/D01_locomocao_eco.md) define o avanço flutuante pelo rastro, o agarrão aéreo e a Dobra com aviso. A2 está importada; A1/A3/A4/A5/A9 estão entregues (A4 provisória). Produzir A6–A8 e testar a sequência no motor.

> **Atualização da v0.8:** a Fase 2 (Deserto e Forja-Mãe) foi feita antes da cena de abertura, porque a arte estava pronta. O plano do jogo está em revisão para incluir uma fase de neve; a ordem abaixo vale até o novo plano chegar.

**8. Cena de abertura:**
- Sequência de cerca de 60 s feita no motor, com opção de pular.
- Conteúdo: contagem regressiva, aviso da IRIS, sobrecarga, clarão, o Eco surgindo e Daymon acordando nos escombros.
- Toca só em "Novo jogo".

**9. Fendas Instáveis:**
- 2 ou 3 salas-desafio escondidas e cronometradas, de 1 a 3 minutos.
- Recompensa: muitas células ou uma melhoria exclusiva.
- O melhor tempo de cada sala fica salvo.

**10. Lince e Hidrópolis:**
- Revisar e aplicar as sprites já entregues do Lince, dos inimigos, da Rainha e do cenário de Verdâmia.
- Depois, Hidrópolis: forma Cefalóide, nado em 360°, tentáculos e tinta; inimigos Enguia Voltaica e Guardião de Coral; chefe Leviatã Custódio.

**Fase 4, polimento contínuo:**
- Inimigos mais táticos.
- Transições entre áreas.
- Remapeamento de teclas.
- Acessibilidade.

## 9. Pendências conhecidas

O [roteiro](ROTEIRO.md) consolida a implementação. Na v0.8 o Deserto, a Forja-Mãe e a passagem entre universos entraram no jogo (seção 14). Pendências: aprovação das fichas DF02, DF03 e PT00 pelo João Marcelo (os lotes foram integrados como estão) e o plano da **fase de neve**, que o João Marcelo vai enviar.

- A mira 360° no analógico direito foi implementada, mas **não foi testada com um controle físico**.
- Ao fechar o jogo, aparece o aviso "2 resources still in use at exit". É inofensivo.
- O usuário relatou que algo não roda no PC dele ("meu pc nao rod..."). A mensagem chegou cortada e o sistema dele não foi confirmado. Se ele voltar ao assunto, peça o sistema operacional e a mensagem de erro. Lembre que o jogo precisa de OpenGL 3.3 e de x86_64.

## 10. Correção v0.5.1 — 10/11/2026

`Portal` herdava o `interact()` vazio de `Interactable`: o aviso aparecia, mas E não iniciava a calibração. `scripts/portal.gd` agora chama `main.open_calibration(self)` quando ainda não está ativo. Sem mudança de design ou de save.

Teste de regressão com Godot 4.3 (entradas reais de teclado, sem a flag que resolve a calibração automaticamente):

```bash
godot --headless --audio-driver Dummy --path . --script res://tools/test_portal.gd -- level=lab pos=6560,680 terminals god at=30
```

Verifica proximidade, E, pausa, Esc, reabertura, ajuste das três ondas e chegada a Verdâmia como Lince. Falhava antes da correção e passou depois.

## 11. v0.6 — Verdâmia com a arte oficial (11/11/2026)

Toda a arte de `colaboracao/entregas/VD_verdamia/` foi integrada. Nenhuma mecânica nova e nenhuma mudança no formato do save. O registro asset por asset está em `colaboracao/revisoes/VD_verdamia.md`.

**Importação.** `python tools/import_verdamia.py .` e depois `godot --headless --import`. O script lê os PNGs entregues (nunca os altera) e gera `assets/verdamia/` e `scripts/sprite_meta_verd.gd`. Ele faz o que as folhas não trazem prontas:
- normaliza a escala entre folhas (cada folha do Lince veio em um tamanho; a tabela de fatores está no script);
- alinha a âncora: pés no chão, centro do corpo no ar, patas na parede, base da Rainha e dos Esporângios;
- mede a posição da lanterna do Lince em cada quadro (`LINCE_LANTERN`), para o brilho acompanhar a cauda;
- recorta os objetos pelos limites visuais e prepara o terreno repetível (fusão das bordas no chão e nos espinhos, mosaico espelhado no subsolo, borda de parede e quinas com esmaecimento).

**Onde cada coisa é ligada.**
- `player.gd`: `_build_lynx()` e `_update_lynx()` (prioridade: morte, dano, ação, esquiva, parede, ar, pouso, corrida, idle). O Lince não é mais desenhado por código.
- `moth.gd`, `spore_plant.gd`, `queen.gd`: `Enemy.make_sprite()`. A Rainha toca a animação e solta o efeito no quadro certo (`WINDUP`).
- `spike.gd` (aviso + raiz), `enemy_bullet.gd` (`sprite = "esporo_verde"` ou `"esporo_violeta"`), `slash.gd` (garras), `gate.gd` (barreira), `fragment.gd`, `checkpoint.gd`.
- `terrain.gd` (`_verd_all`), `hazard.gd` (espinhos), `verd_bg.gd` (parallax), `fg_layer.gd` (primeiro plano), `level_data.gd` (`decor` e `thin_art` de Verdâmia).
- `fx_anim.gd`: `FxAnim.verd(pai, "poeira" | "clarao" | "invocacao" | "impacto_esporo", pos)`.

**Cuidado ao desenhar texturas em `_draw()`.** A textura precisa continuar referenciada depois do `_draw` (use `Props.tex()`, que guarda em cache). Uma textura carregada em variável local é liberada antes de o quadro ser desenhado e aparece como um retângulo branco.

**Teste de regressão novo:**

```bash
godot --headless --audio-driver Dummy --path . --script res://tools/test_verdamia.gd -- save at=999
```

Percorre menu, novo jogo, portal, as 11 animações do Lince, garras em inimigo, santuário (E), morte e retorno, salvar e continuar, os quatro ataques da Rainha, barreira, fragmento e vitória. Ele apaga o save no fim.

**Mudanças de comportamento (pequenas):** a Rainha conta só as mariposas da arena antes de invocar (antes, as mariposas do resto da fase bloqueavam a invocação); os ataques dela saem 0,35 a 0,5 s depois do início da animação; a raiz tem colisão de 56 px de largura (era 40) para acompanhar o desenho; a placa do Clarão foi de x 2600 para 2700 e o Registro 07 de x 2680 para 2800, para não ficarem sobre o santuário.

## 12. Correção v0.6.1 e ambiente Windows (12/11/2026)

**Fragmento duplicado (defeito da D02).** O `level.gd` recriava o fragmento sempre que `boss_done` tinha a fase, sem saber se ele já tinha sido pego; no save só havia o contador `fragments`. Agora:
- `main.frags` guarda os fragmentos recuperados por fase (`{"verdamia": true}`), e `fragments` é sempre `frags.size()`;
- `collect_fragment()` ignora uma segunda coleta na mesma fase;
- `level.gd` só cria o fragmento se a Rainha foi vencida **e** a fase não está em `frags`;
- o save grava `frags` (o `version` continua 1, porque o campo é opcional). `SaveGame.fragment_set()` migra os saves antigos como a D02 pede: Rainha vencida e `fragments` ≥ 1 vira `["verdamia"]` (2/4 volta a 1/4); Rainha vencida e `fragments` = 0 mantém o fragmento no altar. O resumo do menu usa a mesma função.

A D02 (Opção A) vai trocar a tela de vitória pela fenda de retorno e levar o save à `version 2` com `installed` e `portal_cal`. O campo `frags` já tem o nome e o formato que ela define.

Teste novo, que restaura o save do usuário no fim:

```bash
tools/fluxo/godot.sh --script res://tools/test_fragmento.gd -- save at=999
```

Ele cobre três casos: o jogo real (Rainha → coleta → Continuar), um save antigo com 2/4 e um save antigo gravado entre a vitória e a coleta.

**Ambiente Windows.** O fluxo automático roda em Windows com Git Bash. O `tools/fluxo/godot.sh` substitui o `tools/run.sh`: usa o Godot 4.3 de `C:/Users/joao.marcelo/AreaJM/Ferramentas/godot-4.3/` (ou o que estiver em `GODOT`) e aceita as mesmas flags; `--script` e `--import` rodam sem tela. Capturas usam caminhos Windows (`shot=C:/...png`). O ffmpeg não está instalado, então o `gen_audio.py` não converte OGG. O save fica em `%APPDATA%/Godot/app_userdata/Warp Fracture - Prototipo/warp_save.json`.

## 13. v0.7: Fuga do Eco (13/11/2026)

**Como acontece no jogo.** Com os dois terminais ativos, a porta da Sala G abre. Ao entrar na Sala G (x ≥ 4330), começa a fuga:
- o jogo salva o ponto de retorno na estação da Sala G (Integridade cheia), troca para a trilha `fuga`, liga o alarme (som a cada 1,6 s, tela levemente vermelha, tremores) e mostra "FUGA" e a fala de IRIS;
- uma fenda (A9) se abre atrás da porta, na Sala F, e o Eco sai por ela (A1), observa (A2) e começa a avançar (A3);
- o teto cai em 5 pontos do caminho. Cada pedaço avisa 0,9 s antes com a rachadura no teto (A8), uma marca vermelha tracejada no chão e poeira caindo; ao bater, levanta poeira (A7) e fica caído, sem ferir;
- o piso sobre o fosso 1 da Galeria racha e despenca 0,55 s depois que o jogador passa de x 5220;
- perto do portal (300 px), a luz do portal segura o Eco. Ele paira na borda, observando, e dá para calibrar com calma;
- ao atravessar, o Eco se desfaz (A5) e o evento `fuga_lab` vai para o save. O laboratório não repete a fuga.

**Rota nova.** O laboratório foi estendido à direita com a **Galeria do Portal** (sala H, x 5050–6700). O portal saiu de x 4960 e foi para **x 6560**. A Sala G perdeu o drone, a turreta, o rastejador e as três caixas: a pressão ali é o Eco. A rota é: degrau do bloco elevado → piso que desaba sobre o fosso 1 (200 px) → plataforma suspensa → topo da barricada de escombros → **gancho do Arpão** sobre o fosso 2 (300 px; também dá para atravessar com corrida, pulo e esquiva) → plataforma do portal. Os fossos têm piso eletrificado (dano e volta ao último ponto seguro).

**Eco (`scripts/eco.gd`).** Segue o rastro do jogador (pontos gravados a cada 0,05 s na altura do tronco), sem atravessar paredes. A velocidade é elástica: 230 px/s perto e até 410 px/s quando o rastro passa de 650 px; ele para a ~55 px do jogador. A menos de 95 px, agarra (A4): os quadros 1–3 são o aviso (0,4 s) e o golpe é o quadro 4 (dano 1). **A esquiva atravessa o golpe.** Se o rastro passar de 820 px, usa a Dobra: some (A5, quadros 1–4), abre a fenda (A9) num ponto do rastro ~330 px atrás do jogador, nunca a menos de 250 px dele, espera 0,4 s e sai (A1, quadros 3–8). Há 4 s entre Dobras. Tiros atravessam o Eco: ele não pode ser morto.

**Outros scripts.** `fuga.gd` (orquestra), `debris.gd` (entulho), `collapse_slab.gd` (piso que desaba; se o jogador estava em cima, o ponto seguro recua para antes do fosso). `level.gd` cria a fuga quando a fase tem `"fuga"` e `main.events` não tem `fuga_<fase>`.

**Save.** Campo novo `events` (`["fuga_lab"]`). O `version` continua 1. Saves de antes da v0.7 que já estavam fora do laboratório, ou com fragmento, recebem `fuga_lab`. Morrer na fuga volta à estação da Sala G, e a fuga recomeça ao andar.

**Arte e som.** `tools/import_cells.py` importa A1_v2, A3, A4, A5_v2 (Eco), A9 (fenda), A7 (poeira), A8 (rachadura) e A6 (entulho reduzido a 256 px). Os quatro sons novos (`eco_dobra`, `eco_agarra`, `rachadura`, `desaba`) e a trilha `fuga` saem de `python tools/gen_audio.py . --so-fuga`, que não regrava os outros arquivos.

**Harness.** Flag nova `fugadone` (marca a fuga como concluída). O teste do portal agora usa `pos=6560,680`. Teste novo, que restaura o save do usuário:

```bash
tools/fluxo/godot.sh --script res://tools/test_fuga.gd -- level=lab terminals arpao pos=4250,790 save at=999
```

Ele cobre: início (ponto de retorno, trilha, Eco longe do jogador), agarrão com aviso (≥ 0,28 s), esquiva atravessando o golpe, morte e recomeço, corrida completa por input até o portal (degrau, piso que desaba, plataforma, barricada e gancho) sem levar dano, zona do portal, Dobra a pelo menos 250 px, calibração, Verdâmia e save.

**Pontos para ajustar jogando.** A corrida perfeita da Sala G ao portal leva cerca de 7 s, então a fuga é curta. Alongar a Galeria ou somar obstáculos é a primeira melhoria se o João Marcelo achar que falta tensão.

## 14. v0.8: Fase 2, Deserto de Ferrugem e Forja-Mãe (17/11/2026)

Implementa as decisões D02 a D05 com a arte do pacote Revisão v2 (DF02, DF03, DF87–DF112, PT00–PT23) e a arte do Deserto (DF10–DF86).

**Passagem (D02, `main.gd`).**
- `collect_fragment(at)`: sem tela de vitória. Trava os controles por 3 s, o cristal sobe e entra no Traje (`fragment.gd`), aparece "FRAGMENTO RECUPERADO · n/4", o ponto de retorno vai para o altar e o jogo salva. Depois `level.open_return_rift(true)` abre a fenda e IRIS fala (`hud.say`, caixa de diálogo em fila).
- Fenda de retorno (`rift.gd`): `return_rift` nos dados da fase (Verdâmia x 4560; Deserto x 8720, atrás da porta direita da Câmara). `[E] Voltar ao Laboratório Hélix` chama `enter_portal("lab", ...)`. A chegada no Hélix é em (6470, 690), ao lado do Arco.
- Receptáculo (`receptacle.gd`, PT15, x 6395 da Galeria): `[E] Instalar o fragmento` → `install_fragment()`: soquete aceso, feixe no cabo, `log_09`, ponto de retorno e save. Sem fragmento pendente, funciona como estação.
- Arco (`portal.gd`): `main.portal_action()` decide destino, estado e texto. Antes do 1º fragmento, `[E] Calibrar o portal` (igual à v0.7). Fragmento sem instalar: `[E] Portal sem energia`. Depois: `[E] Escolher destino` abre o seletor (`dest_select.gd`). Verdâmia atravessa direto. O Deserto, sem calibrar, abre a calibração com `pattern = "deserto"` (âmbar, onda 2 com deriva de um passo a cada 2,4 s); ao concluir, `portal.arm("deserto")` deixa o diafragma aberto com `[E] Atravessar`, e só esse E viaja. Esc cancela em qualquer ponto.
- `_form_banner()`: "FORMA HUMANA", "NOVA FORMA: LINCE-VAGALUME" e "NOVA FORMA: AUTÔMATO" (primeira vez; depois "FORMA: AUTÔMATO", evento `forma_automato`).
- Fim da versão: o fragmento do Deserto, ~5,5 s depois da coleta, abre o resumo (`show_victory`); ENTER continua explorando e ESC salva e volta ao menu.

**Save versão 2 (`save_game.gd`).** Campos novos `installed` e `portal_cal`. Saves da versão 1 são migrados em `portal_cal_set`: quem esteve em Verdâmia ou tem o fragmento dela recebe `portal_cal = ["verdamia"]`. Os cinco estados de "Continuar" da D02 estão cobertos por `test_passagem.gd`.

**Portais com arte (D05).** `DFArt` (`df_art.gd`) carrega a arte da Fase 2, importada em meia resolução por `tools/import_fase2.py` (escala do jogo K = 0,214 do original; nó a 0,428). O Arco usa o registro comum (centro da base em 512, 984): PT10 atrás, membrana PT20 tingida (pulsos para Hélix, véus no sentido anti-horário para Verdâmia, ondulação horizontal para o Deserto), 8 lâminas PT12 que giram, encolhem e somem ao abrir, glifo PT13 no painel do topo (pisca em "sinal") e PT11 com `z_index` absoluto 7, na frente do personagem. A Fenda usa PT22 no chão, PT23 para abrir e fechar (ao contrário) e PT21 em loop; a de chegada fica dormente.

**Deserto (`desert.gd`, D03).** Layout e máquinas do protótipo, reescritos na estrutura da `main` (sem merge da branch). Zonas: A Dunas (0–1700), B Fábrica (1700–3580), C Salão do Núcleo (3580–6990), D Câmara da Forja (6990–8550) e E Saída (8550–8900). Estações em x 1650, 4730 e 6650 (antes da porta). Portas DF38 com colisão (`set_door`). Os jatos das válvulas destroem drones baixos (`vent_hits`).

**Autômato (`player.gd`, forma `automato`).** Colisão 30 × 62, 272 px/s, `jump_v` 721 (~136 px), sem pulo duplo nem salto de parede. Corpo DF90–DF96 com âncora nos pés (192, 472) e braço DF97 com pivô (60, 256), no ombro medido nas entregas (`SHOULDER_AUT`). Rebitadeira: `Bullet.rivet` (DF87, clarão DF88), intervalo 1,25 × o do Estabilizador. Ímã de Fase: a física do Arpão, sem precisar do módulo, com o feixe DF98 desenhado em `_draw_beam`; sem âncora, `_magnet_drone()` puxa o drone mais próximo até o chão. Pulso Magnético (`_magnet_pulse`, DF99): 150 px, derruba drones, para robôs por 2 s, estoura projéteis e abre o peito da Forja. Arranque: 0,2 s a 600 px/s, só no chão, invulnerável. Sem recuo ao levar dano.

**Inimigos (`desert_enemy.gd`).** Robô (3 vidas) e Drone (2) com aviso de 0,5 s antes do tiro; `magnet_pulse`, `knock_down` e `magnet_pull`. Drone derrubado fica 1,5 s no chão e volta a voar; no fosso ou no jato, explode.

**Forja-Mãe (`forja.gd`, D04).** Corpo DF100 na base (7770, 770); lente, escotilhas, peito e grade ficam atrás das aberturas do corpo, sobre um fundo escuro. Braços: carrinho DF103 no trilho (y 300, preso ao teto por tirantes), pivô em y 360, dois segmentos DF104 (IK de duas juntas) e martelo DF105 com o núcleo DF106 na junta. Começa quando o jogador passa de x 7110: a porta fecha, a câmera trava em (7770, 420) com zoom 0,85 e toca a trilha `chefe`.
- Fase 1 (6): martelo esquerdo. Corre no trilho (0,6 s), aviso de 0,7 s (sobe 40 px, faixas vermelhas, marca tracejada), golpe e onda de 40 px, preso por 1,6 s com a âncora ligada (o ímã leva o jogador para cima dele; plataforma de mão única no topo) e o núcleo exposto (área 110 × 40 na junta). Rajada de rebites a cada 3 ataques: aviso de 0,5 s na lente, três DF70 em duas alturas e a grade aberta por 0,8 s (rebite na grade = dano em dobro no núcleo da fase).
- Fase 2 (6): martelo direito com aviso de 0,55 s, esteira (setas por 1 s, empurra para a fornalha, a grade fere) e dois drones pelas escotilhas a cada 10 s.
- Fase 3 (8): os braços caem e os martelos viram degraus. O peito só abre com o Pulso a até 160 px do centro (placas voando por 3 s); feixe da lente (carga DF111 de 1 s, mira varrendo e feixe a 20 px do chão, da direita para a esquerda) e sobrecarga das válvulas laterais.
- Vitória: lente apagada, grade fria, explosões, fragmento 2/4 saindo do peito, `boss_done["deserto"]`; ao pegar, as duas portas abrem e a fenda de retorno aparece. Morrer volta à estação de x 6650 com a Forja inteira; a abertura longa (2 s) só acontece na primeira vez (`forja_intro`).

**Som.** `python tools/gen_audio.py . --so-fase2` gera 12 sons (`portal_abre`, `fenda_abre`, `arranque`, `ima`, `pulso`, `rebite`, `esteira`, `trilho`, `martelo_carga`, `martelo`, `feixe_carga`, `placas`) e a trilha `deserto`, sem regravar o resto.

**Testes novos** (restauram o save do usuário):
```bash
tools/fluxo/godot.sh --script res://tools/test_passagem.gd -- save at=999   # D02 e save v2 (37 checagens)
tools/fluxo/godot.sh --script res://tools/test_deserto.gd -- save at=999    # Autômato e percurso
tools/fluxo/godot.sh --script res://tools/test_forja.gd -- save at=999      # luta completa e volta ao Hélix
```
`tools/shots_fase2.gd -- out=<pasta>` gera 15 capturas de conferência. `test_verdamia` e `test_fragmento` foram atualizados para a D02 (sem tela de vitória). O entulho e o piso da Fuga passaram para `_physics_process` (o tempo de aviso não depende mais da taxa de quadros), o que também estabilizou `test_fuga`.

**Pontos para ajustar jogando.** O peito da Forja fica baixo na arte: o Pulso funciona do chão, sem precisar das âncoras do teto. Com o Pulso, os 8 rebites cabem numa abertura de 3 s. As fichas DF02, DF03 e PT00 ainda não foram aprovadas; se mudarem, os lotes 2 e 3 podem precisar de ajuste.

## 15. v0.9: Fase 3, Nivária, e Guardião Glacial (24/11/2026)

Branch `dev/neve` (baseada na `dev/deserto`, com a `main` mesclada até `22828aa`, as fichas GL00–GL04 v2). Implementa a proposta `docs/fases/nivaria/proposta_fase3.md` com as decisões aprovadas: D07 (Daymon humano com roupa de inverno) e D08 (Guardião Glacial). D06 (lugar na campanha) segue aberta; o código já usa a opção A recomendada (Nivária no 3º encaixe do Receptáculo, `Receptacle.ORDER`).

**Passagem.** Instalar o fragmento do Deserto (`install_fragment`) libera `log_10` e o destino **Nivária** no Arco (cor rosa `#FF8FD0`, glifo desenhado por `NvArt.glyph` porque a PT13 só tem três). Nivária pede calibração (`pattern = "nivaria"`, onda 3 com deriva) e abre o diafragma com `arm("nivaria")`; o último E atravessa. O Deserto **não** encerra mais a versão: IRIS manda instalar o fragmento. A tela de fim passou para o fragmento 3/4 de Nivária.

**Daymon de inverno (`player.gd`, forma `inverno`).** `is_human()` cobre `human` e `inverno`: mesmo rig, colisão 24 × 62, Estabilizador e Arpão (sem exigir o módulo). Extras de `_build_winter`:
- Cachecol: 5 pontos em verlet a partir de `scarf_anchor()` (−3·facing, −64), com gravidade, vento e arrasto pela velocidade; desenhado em `_draw_winter` (laranja `#EF9655`, faixas `#B67A51`).
- Geada: `add_geada(n)` (só na forma de inverno), `GEADA_MAX` 3, −15% de velocidade por camada, uma camada cai a cada 4 s (2,5 s com a melhoria `forro`). Na 3ª camada, `_freeze()`: 1,5 s preso (`_frozen_physics`), cada PULO ou ATAQUE tira 0,3 s, o Pulso liberta na hora, inimigos podem acertar. Braseiros derretem tudo (`Nivaria.near_fire`).
- Áreas de frio: grupo `frost` com a meta `geada` (sopro, esfera, onda); `_check_hurt` aplica a geada sem tirar Integridade (`frost_cd` de 0,7 s). Inimigos com `frost_touch` deixam +1 de geada no contato. Bolas de neve têm a meta `snowball` e arrastam o jogador.
- Pulso Térmico (`_heat_pulse`, 1/3 da energia): anel de 140 px, tira a geada e chama `Nivaria.on_heat` (placas de gelo, bolas pequenas, placas do Guardião).
- Gelo escorregadio: `slip_t` baixa a aceleração para 380.
- `_update_safe` ignora o gelo fino (`Nivaria.on_fragile`), para o retorno de queda não cair em gelo que quebra.

**Nivária (`nivaria.gd`).** Layout em `Nivaria.layout()` (`LevelData`): 9.080 px, quatro zonas (A Cume 0–2400, B Caverna 2400–4700, C Encosta 4700–7700, D Arena 7620–9020 com o chão em y −100). Fundo (`Backdrop`: céu, aurora, lua, duas cordilheiras) e terreno (`Terrain`) desenhados por código com a paleta da GL00; a rampa da Encosta é um `CollisionPolygon2D` (sobe 400 px em 2.050). Peças:
- `ThinIce` (gelo fino): racha em 3 estágios de 0,35 s, quebra, volta em 3 s.
- `Stalactite`: treme 0,5 s quando o jogador passa embaixo, cai e quebra; as da arena só caem com o impacto da Investida e voltam a crescer em 6 s.
- `CrystalGate` (cristais ressonantes, par chão/teto em x 2700): 1,4 s apagado, 0,4 s de aviso, 1,6 s ativo.
- `IceWall` (placa de gelo do nicho do Núcleo 1), `SlipPatch`, `Snowball` (pequena 45 px, grande 109 px; a cada 2,4 s enquanto o jogador está na Encosta; esmaga Gelinhos).
- Plataforma móvel sobre o poço de espinhos, bloco flutuante até a laje, elevador até a arena (sobe quando o jogador pisa, desce 1,5 s depois de ele sair, nunca esmaga), Braseiros (checkpoints `theme = "nivaria"`, x 2330, 4620 e 7480) e o braseiro da arena.
- 3 Núcleos (nicho atrás da placa; reentrância acima do poço 2; cadeia de ganchos acima do platô), 3 Registros (`log_11`–`log_13`), 12 células, 12 ganchos (4 na Caverna, 6 na Encosta, 2 no platô) e 2 na arena.

**Inimigos (`nv_enemy.gd`).** Gelinho (2 tiros; infla 0,5 s e sopra geada à frente, 100 px), Drone Gélido (1 tiro; mira 0,6 s, esfera lenta que vira gelo escorregadio no chão) e Morcego-de-Cristal (1 tiro; dorme no teto e dá um rasante em arco de 1,1 s). 12 no total (~1,3 por 1.000 px). Derrotados ficam registrados (`collected`), como no Deserto.

**Guardião Glacial (`guardiao.gd`, D08).** 273 px (3,0 D), começa em x 8800 quando o jogador entra na arena; câmera travada em (8320, −330) com zoom 0,85, trilha `chefe`. Plano por fase (`PLAN`): 1 = estacas e investida; 2 = estacas, onda e investida; 3 = onda, estacas, onda e investida, com chão escorregadio e 2 Gelinhos. A Investida (aviso de 0,6 s batendo os pés) para na parede: impacto, estalactites caindo perto do jogador e 2 s de atordoamento. Pulso Térmico até 210 px do peito derrete uma placa: núcleo exposto por 3 s; 4 tiros destroem a placa (fase seguinte); senão, a placa congela de novo. Fora disso, os tiros só fazem "tink". Na derrota, o fragmento flutua no lugar do peito; pegar mostra "FRAGMENTO RECUPERADO · 3/4" e a tela de fim.

**Arte.** Placeholders recortados das fichas v2 por `tools/import_nivaria.py` (54 peças em `assets/nivaria/`), dimensionados por `NvArt` (Daymon ≈ 91 px; sempre escala uniforme). O corpo do Daymon de inverno ainda é o do laboratório (o cachecol é desenhado). Os pedidos do lote 2 e 3 estão em `colaboracao/pedidos/GL_lote2_producao.md` (17 pedidos, gerados por `tools/gen_pedidos_nivaria_lote2.py`). A música é a do menu até a trilha própria.

**Testes.**
```bash
tools/fluxo/godot.sh --script res://tools/test_nivaria.gd -- [out=<pasta>]   # 66 checagens, entrada pelo fluxo normal até o fim
```
`tools/lineup.gd` ganhou a fila de Nivária e a captura do Guardião. `test_forja.gd` foi atualizado: o fragmento do Deserto não abre mais a tela de fim.

**Pontos para ajustar jogando.** As poses do Guardião são as miniaturas da GL03 ampliadas (borradas) e a frontal mostra as cruzes de âncora da ficha nos ombros; as duas coisas somem com a GL100. A cadeia de ganchos da Encosta exige pular no fim de cada puxada. A esfera do Drone do Cume pode cair no poço de espinhos.


### 15.1 Receita de cena (DA-03) e composição provisória de Nivária (24/11/2026)

O João avaliou que o Deserto e Nivária estão abaixo do Laboratório e de Verdâmia. `tools/scene_metrics.gd` captura quatro pontos de cada fase e `tools/scene_metrics.py <pasta>` mede luma, contraste do jogador, densidade de bordas e área lisa. O resultado virou a proposta [DA-03](colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md) (cinco camadas, valores, estrutura e moldura, decoração em três escalas, terreno com borda e nada flutuando sem motivo, luz e partículas). Revisão pedida ao ChatGPT em `colaboracao/pedidos/DA03_receita_de_cena.md`.

Nivária ganhou a composição pela DA-03 com peças desenhadas por código (`scripts/nv_scenery.gd`, `NvScenery.build`): pinheiros, rochas, ruínas e pilares de gelo atrás do plano do jogo; tufos, pedras e rochas no chão; postes que seguram os ganchos e as lajes; trilho da plataforma móvel; correntes na caverna e na arena; primeiro plano escuro (`FgSnow`); luzes nos cristais e nas estações; neve caindo e brilho de cristal. O terreno (`Terrain._block`, `_snow_line`) tem neve irregular, beiral nos cantos e subsolo com pedras; a neve ficou abaixo do branco para o personagem ser o mais claro. Medidas depois: luma 0,156, contraste do jogador +0,17, bordas 0,051, área lisa 0,50 (antes: bordas 0,038 e área lisa 0,69). As peças serão trocadas pelas folhas GL50–GL59 do lote 2, agora reescrito pela DA-03 com o inventário de Verdâmia (fundo distante e intermediário, caverna, arena, estrutura, terreno completo, decoração, moldura, primeiro plano e efeitos).

**Protocolo da DA-03 (versão final, revisada pelo ChatGPT).** `scene_metrics.gd` agora pausa a árvore e captura quatro variantes no mesmo quadro (tudo, sem primeiro plano, sem o jogador, só o jogador sobre preto); `scene_metrics.py` publica C2 e C3 por ponto e marca o que fica fora (limites calibrados nos oito pontos do Laboratório e de Verdâmia: luma 0,08–0,18, terço de cima ≤ 0,15, contraste do jogador ≥ +0,10, separação da silhueta ≥ 2/3, bordas 0,04–0,11, área lisa ≤ 0,60). Os pontos e parâmetros fixos estão na própria DA-03. Nivária passa nos quatro pontos; o Deserto fica fora em três (claro demais, e nas Dunas o Daymon fica mais escuro que o fundo).

**Refação do Deserto e inventário (24/11/2026).** DA-03 aprovada pelo João. Pedido de refação da cena do Deserto em `colaboracao/pedidos/DF_refacao_cena.md` (13 prompts gerados por `tools/gen_pedidos_deserto_refacao.py`: DF00 v2, DF200–DF210 e o retoque DF03 v2; o exterior passa a um crepúsculo de tempestade de ferrugem). O inventário das quatro fases por função da DA-03 está em `docs/INVENTARIO_DE_ARTE.md`, com a ordem recomendada de envio ao ChatGPT.


### 15.2 DF00 v2 aprovada e pedido DF205, o terreno do Deserto (24/11/2026)

- **DF00 v2:** aprovada pelo João e publicada na `main` (`9aae70b`). Integrada na `dev/neve` (`af38d68`). Ela é a referência de valores e materiais da refação do Deserto.
- **DF205:** pedido reescrito em `colaboracao/pedidos/DF_refacao_cena.md`, com as 22 peças no formato do terreno de Verdâmia (2×, linhas de apoio fixas, borda espelhada, cantos com quina). O gabarito `docs/auditoria_cena/DF205_gabarito_colisoes.png` é gerado por `tools/gen_gabarito_df205.py` a partir das constantes de `scripts/desert.gd`.
- **Integração prevista:**
  - generalizar `Terrain._verd_all` para receber um conjunto de peças por material (areia, chapa) e trocar em `desert.gd` os tiles DF20, DF21 e DF25 e os `ColorRect` chapados;
  - passarelas montadas com ponta, meio e ponta, com tirantes e colunas. O meio é recortado em painéis inteiros de 32 px, sem escala, e centralizado; a sobra (até 17 px) fica sob as chapas de junção das pontas;
  - capturar os sete recortes do gabarito com a colisão visível e rodar `scene_metrics` nos quatro pontos.
- **Pontos DA-03 do Deserto antes da troca** (Godot, 24/11/2026):

  | Ponto | Luma | Terço de cima | Separação | Contraste |
  |---|---|---|---|---|
  | 0 (500, 700) | 0,566 | 0,673 | 0,889 | −0,359 |
  | 1 (2300, 700) | 0,176 | 0,182 | 0,713 | +0,176 |
  | 2 (5200, 770) | 0,184 | 0,170 | 0,864 | +0,241 |
  | 3 (6500, 770) | 0,129 | 0,114 | 0,741 | +0,180 |

  O ponto 0 só passa em C2 com o céu novo (DF200–DF201). Por isso, a medição da DF205 isolada é intermediária.
- **Separação nas Dunas:** no Deserto o jogador é o Autômato (DF90–DF97), não o Daymon. Os 58,3% e 81,7% da DF00 v2 são do Daymon. Estimativa sobre a pintura das Dunas da DF00 v2, com o sprite e o halo reais do jogo:

  | Sprite e luz | Separação |
  |---|---|
  | Autômato atual, sem o halo | 83–89% |
  | Autômato atual, com o halo `amb` do jogador (aditivo, atrás dele) | 71–76% |
  | Daymon do jogo, sem luz | 48–54% |

  O jogo não tem `Light2D`. A "iluminação real" é esse halo, que clareia o entorno e reduz a separação. Validar no Godot quando o terreno e o céu entrarem, e de novo com a DF02 v2. Se ficar abaixo de 2/3, a primeira opção é baixar o halo no Deserto.

### 15.3 DF205 integrada: terreno do Deserto (24/11/2026, branch `dev/deserto`)

A refação do Deserto passa a ser feita na branch `dev/deserto`, criada a partir da `dev/neve`. A `dev/neve` fica para Nivária.

**Montagem**
- `tools/import_df205.py` copia as 22 peças da entrega (`colaboracao/entregas/DF205/`, `cbdd27c`) para `assets/deserto/terreno/`.
- `scripts/df_terrain.gd` (classe `DFTerrain`) desenha o terreno. Usa as linhas do `ENTREGA.md`:
  - apoio da areia em y 50 e da chapa em y 16;
  - face das bordas em x 6;
  - cantos em (18, 50), (162, 50), (18, 16) e (162, 16);
  - face do teto em y 160 e cantos internos do teto em (96, 96);
  - verga em y 96, passarela em y 8 e dano do fosso em y 32.
- A repetição usa o próprio amostrador (`texture_repeat`), sem frestas entre as cópias.
- **Colisões:** não mudaram. `layout()` ganhou a constante `WALLS`, com os mesmos 15 sólidos da v0.8. O teste confere isso.
- **Passarelas:**
  - 1, 4, 10 e 11 painéis inteiros de 32 px nas larguras 145, 240, 430 e 450;
  - miolo sem escala e centralizado, com sobra de 8,5, 8, 7 e 1 px por lado;
  - chapas de junção desenhadas por cima, a partir da face interna das pontas;
  - as do Salão têm tirantes até o alto e fixação; as de máquina têm coluna treliçada até o fundo do fosso.
- **Retirado:**
  - DF20, DF21 e DF25 (no chão);
  - os `ColorRect` das paredes e do corpo dos pisos;
  - a laje da arte antiga DF53. A DF53 agora só desenha as correntes, que terminam no tabuleiro novo.

**Verificação**
- `tools/test_df205.gd`: 24 verificações, nenhuma falha.
  - colisões iguais às da v0.8;
  - painéis e sobras das quatro passarelas;
  - os 4 cantos internos e as 6 quinas;
  - o Autômato apoiado exatamente na linha em 10 superfícies.
- `test_deserto` e `test_forja` passam com o mesmo número de verificações de antes.
- `tools/df205_encaixes.gd` captura os sete recortes do gabarito, as quatro passarelas e 16 emendas em 1:4, com e sem a colisão. A prancha fica em `docs/auditoria_cena/DF205_encaixes_no_jogo.jpg`.

**Problemas encontrados na arte e o que foi feito na integração**

| Peça | Problema | O que foi feito |
|---|---|---|
| `areia_canto_esquerdo` e `areia_canto_direito` | Bloco escuro de topo reto, 23 px acima do apoio. No jogo parecia um toco na borda do fosso. | O canto é desenhado só a partir de y 42 do arquivo (4 px acima do apoio). Pedir retoque. |
| `fosso_fundo` (colunas 0–1 e 1022–1023) e `coluna_trelica` (linhas 0–5 e 506–511) | Pontas da repetição desbotadas. As bordas opostas eram iguais, mas fracas, e formavam uma faixa por onde o fundo aparecia. | `import_df205.py` repete a primeira fileira íntegra nas cópias do jogo. A entrega fica intacta. |
| `areia_borda` | A face da rocha fica em média em x 27 do arquivo, não em x 6. A rocha recua ~10 px da colisão na lateral do fosso. | Nada. Ninguém encosta nessa lateral; só vale anotar. |
| `fosso_fundo` | A massa de sucata começa ~40 px do arquivo abaixo da linha de dano. O dano vem ~20 px antes de a sucata parecer sólida. | Nada. Fica a critério do João. |
| Abaixo do `fosso_fundo` | A faixa termina semitransparente e o céu aparecia embaixo. | Preenchimento escuro com a cor média do fim da peça, `#0D1118`. |

**DA-03 nos quatro pontos** (Godot)

| Ponto | Luma | Terço de cima | Separação | Contraste | Bordas | Área lisa | O que ainda falta |
|---|---|---|---|---|---|---|---|
| 0 Dunas (500, 700) | 0,566 → 0,516 | 0,673 | 0,900 | −0,359 | 0,041 | 0,346 | Céu: DF200 e DF201. As bordas estão no limite (0,04): DF204, DF206 e DF208. |
| 1 Fábrica (2300, 700) | 0,176 → 0,167 | 0,182 | 0,736 | +0,176 | 0,102 | 0,180 | Terço de cima: parede DF23 → DF202. |
| 2 Salão (5200, 770) | 0,184 → 0,176 | 0,170 → 0,163 | 0,867 | +0,247 | 0,088 | 0,327 | Terço de cima: parede DF24 → DF202. A luma já passa. |
| 3 Salão (6500, 770) | 0,129 → 0,124 | 0,114 | 0,745 | +0,176 | 0,049 | 0,387 | Passa. |

O terço de baixo, onde fica o terreno, escureceu nos quatro pontos: 0,415 → 0,292, 0,158 → 0,135, 0,178 → 0,166 e 0,137 → 0,125. O terço de cima e o terço do meio só mudam com os fundos.

**Separação nas Dunas:** a medida de 0,90 no jogo ainda é contra o céu claro antigo e não vale como validação. A validação com a iluminação real fica para quando entrarem DF200 e DF201; a estimativa da seção 15.2 é de 71–76% com o halo. Repetir com a DF02 v2.

**Próximos envios ao ChatGPT (24/11/2026):**
- **Retoque dos cantos de areia:** `colaboracao/pedidos/DF205_retoque_cantos.md`.
- **DF200:** pedido reescrito com as medidas do jogo.
  - A camada entra a 0,645, sem espelhamento, com a imagem inteira centralizada no percurso da câmera. A faixa útil vai das linhas 210 a 1.230.
  - Na integração, a `VerdBg` precisa de um deslocamento em x. Hoje ela espelha as cópias e começa no x 0 da camada.

### 15.4 Testes das prévias: retoque dos cantos (DF205) e céu (DF200) (24/11/2026, `dev/deserto`)

As prévias chegaram por anexo e não foram para o repositório. Só o código foi para o commit. A arte final entra pela `main` depois da aprovação do João.

**Cantos de areia (retoque)**
- As linhas 0–49 estão vazias; a opacidade média entre y 8 e 48 é 0%.
- `DFTerrain` decide o recorte sozinho: lê o canto carregado e só corta em y 42 se ainda houver o bloco antigo. Com o retoque, desenha a peça inteira nos pivôs (18, 50) e (162, 50).
- As emendas em x 780 e 1.180 ficaram sem toco e sem degrau (`docs/auditoria_cena/DF205_retoque_cantos_no_jogo.jpg`).
- `test_df205` passa sem falhas.

**Céu (DF200)**
- Montagem:
  - `VerdBg.place()` monta uma cópia única a 0,645, com a coluna 1.020 e a linha 720 do arquivo no ponto (0, 30) da camada;
  - o `desert.gd` usa a DF200 só se existir `assets/deserto/fundo/DF200_ceu.png`, e se não, a DF10;
  - cópias espelhadas dos lados cobrem telas mais largas que 16:9 (`stretch=expand`), conferido em 2.520 × 1.080.
- Na prévia: luma 0,099 nas linhas 210–550, 0,131 nas linhas 550–900 e 0,123 nas linhas 900–1.230; pico de 0,235 em (1.285, 754).
- Enquadramento em 16:9 (`tools/df200_ceu.gd`), sem borda visível em nenhum ponto:

  | Câmera | Colunas | Linhas |
  |---|---|---|
  | Início das Dunas | 172–1.976 | 215–1.230 |
  | Fim das Dunas | 273–2.077 | 215–1.230 |
  | Ponto mais baixo (fosso) | 215–2.019 | 234–1.249 |
  | Vão do Salão | 477–2.359 | 189–1.204 |

  A borda direita só entraria com a câmera além de x ~6.000, onde as paredes cobrem o céu.
- Prancha: `docs/auditoria_cena/DF200_ceu_no_jogo.jpg`.
- `tools/scene_metrics.gd` ganhou `level=`, `spots=` e `hide_bg=`.
- `tools/df205_encaixes.gd` agora atualiza o parallax com a árvore pausada. Nas capturas anteriores, só os fundos estavam no lugar errado.

**DA-03 com o céu novo** (pontos 4 e 5 são extras, nas passarelas do vão do Salão)

| Ponto | Com DF11 e DF12 | Sem elas (o lugar da DF201) |
|---|---|---|
| 0 Dunas | luma 0,163 · topo 0,090 · separação 0,910 · contraste +0,248 · bordas 0,045 · área lisa 0,553 · **passa** | luma 0,119 · bordas **0,025** · área lisa **0,740** · fora |
| 1 Fábrica | topo **0,182** · fora (parede DF23 → DF202) | igual |
| 2 Salão 5200 | luma 0,146 · topo 0,130 · **passa** (antes 0,176 / 0,163) | 0,130 / 0,130 · passa |
| 3 Salão 6500 | passa | passa |
| 4 Passarela 1 | luma 0,153 · topo 0,100 · passa | passa (área lisa 0,592) |
| 5 Passarela 2 | luma 0,164 · topo 0,119 · passa | passa |

- **Separação nas Dunas com a iluminação real do jogo** (halo incluído): 0,910, com contraste de +0,248. Fecha a pendência das seções 15.2 e 15.3. Repetir com a DF02 v2.
- **O que depende da DF201:** as bordas e a área lisa das Dunas. Hoje é a DF11/DF12 antiga que segura esses números, e ela é a mancha clara que mais compete na tela.
- **O que depende da DF202:** o terço de cima da Fábrica.
- **Integração da DF201** (pedido pronto em `DF_refacao_cena.md`):
  - `DF201_distante`: cópia única, escala 1, coluna 686 no x 0 da camada, topo em y −260;
  - `DF201_proximo`: repete sem espelhar (período 2.560), topo em y −165;
  - nas duas, a base fica na linha 490 do arquivo;
  - a `VerdBg` precisa de um modo de repetição sem espelho.
