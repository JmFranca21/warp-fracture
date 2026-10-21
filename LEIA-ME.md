# Warp Fracture — Protótipo v0.5

Primeiro protótipo jogável do *Warp Fracture*, feito em **Godot 4.3** a partir do Caderno de 10 páginas.

A arte é 2D vetorial e desenhada por código, sem pixel art, com camadas de parallax, silhuetas escuras, brilhos e partículas. O visual tem atmosfera inspirada em Hollow Knight, mas os personagens e cenários são originais.

## Como jogar

**Windows:** abra `WarpFracture.exe`. Não precisa instalar nada.

Como o executável não é assinado, o Windows pode mostrar "O Windows protegeu o computador". Clique em **Mais informações** e depois em **Executar assim mesmo**.

**Linux (64 bits):** extraia `WarpFracture_Jogo_Linux.tar.gz` e rode `./WarpFracture.x86_64`. Pelo gerenciador de arquivos, basta dar dois cliques. Se aparecer "permissão negada", rode antes `chmod +x WarpFracture.x86_64`. É preciso ter um driver de vídeo com OpenGL 3.3; o Mesa, padrão no Ubuntu, Mint e Fedora, já serve.

**Pelo código-fonte:**
1. Baixe o Godot 4.3 em godotengine.org (cerca de 60 MB, sem instalação).
2. No Godot, clique em **Importar** e escolha o `project.godot` desta pasta.
3. Aperte **F5** para rodar.

O jogo usa o renderizador *Compatibility* (OpenGL 3.3), que funciona em PCs simples e com vídeo integrado.

## Controles

| Ação | Teclado e mouse | Controle |
|---|---|---|
| Mover | A / D ou setas | Analógico esquerdo |
| Pular (segure para ir mais alto) | Espaço | A |
| Esquiva | Shift ou L | B |
| Atacar | Clique esquerdo ou J | X |
| Especial (gasta 1/3 da energia) | Clique direito ou K | Y |
| Mirar | Mouse | Analógico direito (360°) |
| Mudar a direção do ataque (sem mouse) | Segurar W (cima) / S (baixo, no ar) | Analógico esquerdo |
| Arpão de Fase (depois de encontrá-lo) | F ou botão do meio do mouse | RB |
| Interagir | E | LB |
| Descer de uma plataforma | S + Espaço | Baixo + A |
| Pausa | Esc | Start |
| Mapa | Tab ou M | Select |

## O que tem no protótipo

**1. Laboratório Hélix** (Daymon na forma humana, com o Estabilizador de Fase)
- O tiro mira no cursor do mouse. Acertar inimigos carrega a Energia de Fase, que libera o tiro carregado.
- Inimigos: Rastejador de Fenda e Drone de Segurança.
- Hazards: fosso eletrificado e cabos expostos. Cair num deles tira 1 de Integridade e devolve o jogador ao último chão seguro.
- Puzzle: ativar os 2 terminais para destravar a porta de emergência.
- Estação de Recarga: restaura a vida e salva o ponto de retorno.
- Mini-game de Calibração de Portal: alinhar 3 ondas de frequência.

**2. Verdâmia** (forma Lince-Vagalume)
- Pulo duplo, salto de parede, garras e golpe para baixo que quica em inimigos e espinhos.
- Clarão: fere e atordoa tudo ao redor.
- Inimigos: Mariposa Lanterna e Esporângio.
- Chefe: **Rainha Micélia**, com chuva de esporos, raízes que irrompem do chão, rajada e invocação de mariposas. Ela tem uma 2ª fase abaixo de 50% de vida.
- Recuperar o Fragmento 1/4 encerra o protótipo.

**HUD:** Integridade (cristais), Energia de Fase (orbe), Células de Fase (moeda), fragmentos, dicas contextuais e títulos de área.

## Diferenças em relação ao Caderno

- O laboratório virou visão **lateral** em vez de visão de cima, para combinar com o estilo Hollow Knight pedido. A visão de cima pode voltar no Ferrumgrado.

## Sprites animados (AnimatedSprite2D)

O **Rastejador de Fenda** já usa arte desenhada, em `assets/inimigos/rastejador/`:

| Arquivo | O que é |
|---|---|
| `rastejador_original.gif` | GIF original (16 quadros) |
| `rastejador_sheet.png` | Spritesheet 4×4, com fundo removido e pés alinhados (cada quadro tem 175×78) |
| `rastejador_frames.tres` | SpriteFrames com as animações |

| Animação | Quadros da sheet | Quando toca |
|---|---|---|
| `idle` | 0–3 | Atordoado pelo Clarão |
| `walk` | 9–15 | Patrulhando |
| `attack` | 6 (preparo) → 7 (disparo) | Jogador à frente, a até ~380 px: para e atira pelo olho |
| `hurt` | 8 | Ao levar dano (empurrão) |
| `death` | 8 + fade | Ao morrer |

Para ajustar no editor: dê dois cliques em `rastejador_frames.tres`. O painel **SpriteFrames** abre na parte de baixo, e ali dá para trocar, reordenar ou adicionar quadros e mudar a velocidade (FPS). A troca de animação é feita pelo código em `scripts/crawler.gd`, com `_anim("walk")`, `_anim("hurt")` etc.

**Para os próximos inimigos:** gere o GIF ou spritesheet com fundo transparente ou de cor sólida e diga quais quadros são de cada ação.


## Novidades da v0.5

- **Arpão de Fase:** o primeiro módulo da arma fica na Sala Alta, no alto, perto do Terminal A. Com ele, aperte **F** perto de um gancho (anel ciano) para ser puxado até lá. Dá para encadear ganchos no ar. A abertura no alto da parede direita da Sala Alta leva à **Ala Secreta**, uma passagem sobre um fosso eletrificado com células e um **Núcleo de Integridade** (+1 de vida máxima). No fim dela, um alçapão devolve você à sala dos lasers.
- **Bancada de Upgrades:** fica na sala inicial, ao lado do tanque. Usar a bancada também salva o ponto de retorno e restaura a vida. Ela troca Células de Fase por melhorias:
  - Blindagem do Traje: +1 de vida máxima, 2 níveis (12 e 30 células).
  - Condensador de Fase: +40% de energia por acerto, 2 níveis (10 e 24 células).
  - Propulsor de Esquiva: a esquiva recarrega em 0,28 s em vez de 0,5 s (18 células).
  - Gatilho Rápido: o Estabilizador dispara 30% mais rápido (15 células).
- **Registros do Projeto:** 8 tablets de dados contam o que houve antes da explosão: o Conselho Global, os avisos da IRIS, o ECO e o quinto sinal. São 5 no laboratório (um deles na Ala Secreta) e 3 em Verdâmia. Ao pegar um tablet, o texto abre na tela. Para reler, use a pausa (**Registros do Projeto**).
- O mapa tem a sala nova (Ala Secreta), e o HUD mostra o ícone do Arpão quando há um gancho ao alcance.

## Novidades da v0.4

- **Som e música:** 41 efeitos sonoros e 4 músicas (menu, laboratório, Verdâmia e chefe), todos gerados por síntese em `tools/gen_audio.py`. Os efeitos baixam de volume com a distância, a música troca suavemente entre áreas e a luta contra a Rainha tem trilha própria.
- **Salvamento:** o jogo salva ao usar uma Estação de Recarga, ao atravessar um portal e ao sair pela pausa. O menu tem **Continuar** (com resumo do progresso), **Novo jogo** (pede confirmação para apagar), **Opções** e **Sair**.
- **Mapa (TAB, M ou Select):** as salas aparecem conforme você explora, com terreno, plataformas, Estações, terminais (vermelho = pendente, verde = ativo), porta e portal.
- **Pausa interativa:** Continuar, Mapa, Opções e Salvar e sair.
- **Opções:** volume geral, música e efeitos, tela cheia e tremor de tela (salvos em `settings.cfg`).

## Novidades da v0.3

**Sprites animados (pacote do ChatGPT):** cada prancha foi recortada pelo contorno, teve o verde removido das bordas, foi normalizada para a mesma escala e teve os pés alinhados. O script que faz isso está em `tools/` no zip do projeto.

| Personagem | Animações | Arquivo |
|---|---|---|
| Daymon | idle, run, jump, fall, dash, hurt, death | `assets/personagens/daymon/daymon_frames.tres` |
| Braço + arma | gira no ombro seguindo a mira | `braco_frames.tres` |
| Disparo | clarão na ponta do cano | `disparo_frames.tres` |
| Drone | fly, charge, shoot, hurt, death | `assets/inimigos/drone/drone_frames.tres` |
| Rastejador | death (novo) | `assets/inimigos/rastejador/rastejador_morte_frames.tres` |
| Efeitos | explosão do barril, caixa quebrando, impacto do tiro, campo de energia | `assets/efeitos/` |

**Plataformas atravessáveis:** pule por baixo para subir nelas, sem bater a cabeça. S + Espaço desce.

**Laboratório redesenhado (7 seções):**
1. **Despertar:** tutorial; o barril explode o primeiro Rastejador.
2. **Fosso eletrificado:** atravessado na plataforma móvel, que corre num trilho.
3. **Corredor da Turreta:** pule o feixe ou se proteja na plataforma acima dele.
4. **Sala alta (Terminal A):** subida por plataformas suspensas. O **elevador só funciona depois de puxar a alavanca** do beiral. Plataforma bônus com Célula de Energia.
5. **Corredor de lasers:** dois lasers alternados e uma **câmera de segurança**. Se ela vir você, o alarme solta 2 Rastejadores pelo rombo da parede.
6. **Sala do campo de força (Terminal B):** a **trava pede 1/3 da Energia de Fase**. Ao lado há uma Célula de Energia que reaparece, para o jogador nunca ficar preso. Depois vem uma plataforma frágil até o beiral do terminal e uma caixa pesada com Kit de Reparo dentro.
7. **Saída:** porta (A + B), turreta no alto do bloco e portal.

**Cenário com apoio:** a parede de fundo agora tem painéis, colunas, rodapé, canos (os tanques se ligam a eles) e rombos com rachaduras. Janelas e válvulas ficam na parede; plataformas suspensas têm correntes até o teto; plataformas móveis têm trilho; passagens têm batente com faixa de aviso.

## Arte das pranchas (v0.2)

Os elementos estáticos foram recortados das pranchas "Laboratório Hélix – Elementos de Cenário" e "Inimigos" e estão em `assets/laboratorio/`. A animação deles é feita por código: flutuar, piscar, abrir, desmoronar.

| Elemento | Uso no jogo |
|---|---|
| Terminal, Porta | Puzzle dos 2 terminais. A porta recolhe para cima e a luz fica verde. |
| Célula de Suporte | Estação de Recarga (checkpoint) |
| Kit de Reparo | +1 Integridade |
| Célula de Energia | +1/3 de Energia de Fase (novo item) |
| Caixa | Quebra com tiros ou garras e solta Células de Fase |
| Caixa Pesada | Só quebra com tiro carregado (clique direito) ou Clarão |
| Barril | Explode: fere inimigos, outras caixas e o jogador, se estiver perto |
| Plataforma móvel / quebrável / suspensa | Sobre o fosso / desmorona ao pisar e volta depois / fixa |
| Laser | Barreira vertical que liga e desliga |
| Turreta Sentinela | Inimigo novo: carrega o tiro (linha de aviso) e dispara um feixe. Pule por cima! |
| Drone | Animado na v0.3 |
| Janela, tanque, bandeira, cabos, tubulação, câmera, alerta, trava, alavanca | Decoração |

As animações que faltam (Daymon, Drone, efeitos) estão em `PROMPT_SPRITESHEETS.md`.

## Estrutura do código (`scripts/`)

| Arquivo | Função |
|---|---|
| `main.gd` | Menu, troca de fases, câmera, checkpoints, pausa |
| `level_data.gd` | **Layout das fases** (plataformas, inimigos, itens). É o arquivo para editar ao criar fases. |
| `level.gd` | Monta a fase a partir dos dados |
| `player.gd` | Daymon: movimento, formas, ataques, dano |
| `crawler.gd`, `drone.gd`, `moth.gd`, `spore_plant.gd`, `queen.gd` | Inimigos e chefe |
| `bg_layer.gd`, `terrain.gd`, `fg_layer.gd` | Arte do cenário (fundo com parallax, chão, primeiro plano) |
| `hud.gd`, `menu.gd`, `calibration.gd` | Interface |

## Próximos passos sugeridos

1. Sons e trilha: o tema principal com variações por universo, como descrito na página 6 do Caderno.
2. Hidrópolis (Cefalóide, nado livre), Ferrumgrado (Autômato) e Umbra (Espectro).
3. Bancada de Upgrades para gastar as Células de Fase.
4. Substituir a arte por código por ilustrações feitas à mão (sprites), mantendo a mesma paleta.
