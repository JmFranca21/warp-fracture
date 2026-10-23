# Warp Fracture — Documento de passagem (handoff)

Situação em 21/10/2026, versão **v0.5**. Este arquivo tem o contexto que um novo agente (ou programador) precisa para continuar o projeto sem refazer nada.

---

## 1. O que é o projeto

- **Jogo:** *Warp Fracture*, metroidvania 2D em visão lateral, com visual inspirado em Hollow Knight (ilustrado, **sem pixel art**). É um trabalho acadêmico do João Marcelo (Unifesp).
- **História:** em 2100, o cientista Daymon Sagan explode a Máquina de Dobra do Projeto Hélix. Os 4 fragmentos da máquina caem em 4 universos (Verdâmia, Hidrópolis, Ferrumgrado e Umbra). Em cada universo, Daymon assume outra forma. A IA IRIS orienta pelo rádio, e o vilão é o **Eco**, uma entidade de energia com a silhueta de Daymon. No final, aparece um quinto sinal.
- **Documento de design:** `Caderno_de_10_paginas_Warp_Fracture_v2.docx`, já atualizado para refletir o jogo real. É a fonte de verdade do design. Se o jogo mudar, o caderno precisa ser atualizado também, **sem passar de 10 páginas**.
- **Motor:** Godot **4.3** (stable), GDScript, renderizador **GL Compatibility** (OpenGL 3.3). Exporta para **Windows e Linux**.

## 2. Preferências do usuário (obrigatórias)

1. **Sempre verificar bugs e o posicionamento dos elementos**, inclusive os do cenário de fundo. Nada pode parecer flutuando sem contexto: correntes, suportes, apoio no chão ou no teto. Valide com capturas de tela.
2. A fase deve ser **complexa e difícil, sem ficar aglomerada nem exagerada**.
3. **Plataformas atravessáveis por baixo.** O jogador pula através delas e desce com S + Espaço.
4. Toda entrega precisa ter **builds testados para Windows e Linux**, mais o zip do projeto.
5. Textos do jogo e respostas em **português do Brasil**.
6. Trabalhar seguindo o roteiro (seção 8), etapa por etapa. Entregue um build a cada marco e avise o que mudou.

## 3. Estado atual (v0.5)

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
- Chefe: **Rainha Micélia** (esporos, raízes, rajada e invocação de mariposas). Vencê-la dá o fragmento e leva à tela de vitória.
- O Lince ainda é desenhado por código, sem sprites.

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
- **Pranchas originais:** estão na pasta `arte_original/` do pacote de handoff. Veja `arte_original/USADAS_NO_JOGO.md` para saber qual arquivo virou cada animação. As referências oficiais de design ficam em `00_Referencias_oficiais`.
- **Arte nova:** siga `docs/GUIA_PROXIMOS_PASSOS_E_ASSETS.md`, que define os pacotes A–G com prompts e especificações. Os chefes grandes (Rainha e Leviatã) usam uma grade de 2×1, com células de 768×1024. Para eles, o `extract.py` precisa aceitar `CW, CH` por arquivo.
- **Pendente:** o Lince-Vagalume precisa de spritesheets. Escreva um prompt nos mesmos moldes: idle, run, jump, fall, wall, garras, pogo, clarão, hurt e death.

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
- Depois, atualizar o caderno (página 8, Eco).

**8. Cena de abertura:**
- Sequência de cerca de 60 s feita no motor, com opção de pular.
- Conteúdo: contagem regressiva, aviso da IRIS, sobrecarga, clarão, o Eco surgindo e Daymon acordando nos escombros.
- Toca só em "Novo jogo".

**9. Fendas Instáveis:**
- 2 ou 3 salas-desafio escondidas e cronometradas, de 1 a 3 minutos.
- Recompensa: muitas células ou uma melhoria exclusiva.
- O melhor tempo de cada sala fica salvo.

**10. Lince e Hidrópolis:**
- Primeiro, o prompt das spritesheets do Lince e a aplicação das sprites.
- Depois, Hidrópolis: forma Cefalóide, nado em 360°, tentáculos e tinta; inimigos Enguia Voltaica e Guardião de Coral; chefe Leviatã Custódio.

**Fase 4, polimento contínuo:**
- Inimigos mais táticos.
- Transições entre áreas.
- Remapeamento de teclas.
- Acessibilidade.

## 9. Pendências conhecidas

- A mira 360° no analógico direito foi implementada, mas **não foi testada com um controle físico**.
- Ao fechar o jogo, aparece o aviso "2 resources still in use at exit". É inofensivo.
- O usuário relatou que algo não roda no PC dele ("meu pc nao rod..."). A mensagem chegou cortada e o sistema dele não foi confirmado. Se ele voltar ao assunto, peça o sistema operacional e a mensagem de erro. Lembre que o jogo precisa de OpenGL 3.3 e de x86_64.
