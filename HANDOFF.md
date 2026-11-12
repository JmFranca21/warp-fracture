# Warp Fracture — Documento de passagem (handoff)

Situação em 12/11/2026, protótipo **v0.6.1** (seção 12). D02–D05 decididas em 12/11/2026, com as recomendações aceitas; o trabalho segue o [fluxo automático](colaboracao/FLUXO_AUTOMATICO.md). Este arquivo tem o contexto que um novo agente (ou programador) precisa para continuar o projeto sem refazer nada.

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

## 3. Estado atual (v0.6)

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
| `level=lab` / `level=verdamia` | Pula o menu e carrega a fase |
| `pos=x,y` | Posição inicial |
| `at=2.0` | Tempo até a captura e o fechamento |
| `shot=/tmp/x.png` | Salva uma captura de tela em `at` |
| `act=acao@t0-t1;acao@t0-t1` | Aperta ações em janelas de tempo (right, left, jump, attack, special, dash, hook, interact, confirm, pause, up, down, map...) |
| `god` | Invulnerável |
| `terminals` | Terminais A e B ativos |
| `energy=99`, `hp=3`, `cells=50`, `arpao` | Estado inicial |
| `boss`, `killboss=1.5`, `victory`, `calib`, `pause`, `trigger=id`, `visitall`, `trace`, `title` | Atalhos de teste |
| `save` | Permite gravar o save durante o teste (normalmente fica desligado) |

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

**7. Fuga do Eco** (clímax do laboratório):
- Depois que os dois terminais forem ativados e a porta abrir, o Eco aparece. É uma silhueta de energia roxa e ciano com a forma do Daymon. Ele persegue o jogador sem poder ser morto.
- A sala desmorona enquanto isso: pedaços caem do teto com aviso no chão, o piso se fende e o alarme toca. O jogador corre até o portal usando a esquiva, o Arpão e as plataformas.
- Precisa de um checkpoint no início da fuga, de uma trilha de fuga nova (em `gen_audio.py`) e de efeitos de desabamento.
- Um registro novo pode amarrar o evento.
- A [decisão D01](colaboracao/decisoes/D01_locomocao_eco.md) define o avanço flutuante pelo rastro, o agarrão aéreo e a Dobra com aviso. A2 está importada; A1/A3/A4/A5/A9 estão entregues (A4 provisória). Produzir A6–A8 e testar a sequência no motor.

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

O [roteiro](ROTEIRO.md) consolida a implementação. O [quadro de arte](colaboracao/STATUS.md) detalha os 29 pedidos restantes do Deserto. A fase está especificada para Daymon humano com tiro e gancho; falta implementar o percurso e definir seu encaixe na campanha.

- A mira 360° no analógico direito foi implementada, mas **não foi testada com um controle físico**.
- Ao fechar o jogo, aparece o aviso "2 resources still in use at exit". É inofensivo.
- O usuário relatou que algo não roda no PC dele ("meu pc nao rod..."). A mensagem chegou cortada e o sistema dele não foi confirmado. Se ele voltar ao assunto, peça o sistema operacional e a mensagem de erro. Lembre que o jogo precisa de OpenGL 3.3 e de x86_64.

## 10. Correção v0.5.1 — 10/11/2026

`Portal` herdava o `interact()` vazio de `Interactable`: o aviso aparecia, mas E não iniciava a calibração. `scripts/portal.gd` agora chama `main.open_calibration(self)` quando ainda não está ativo. Sem mudança de design ou de save.

Teste de regressão com Godot 4.3 (entradas reais de teclado, sem a flag que resolve a calibração automaticamente):

```bash
godot --headless --audio-driver Dummy --path . --script res://tools/test_portal.gd -- level=lab pos=4960,680 terminals god at=30
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
