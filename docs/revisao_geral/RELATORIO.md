# Revisão geral do Warp Fracture: relatório

**Branch:** `dev/revisao-geral` (a partir da `dev/deserto`, com a `main` da Forja-Mãe v3 mesclada em `e3821f4`). Nada foi feito na `main` nem na `dev/neve-fase`.
**Período:** 26 e 27/11/2026. **Engine:** Godot 4.3 stable (a do projeto). O editor 4.7.2 foi usado só para reproduzir as mensagens ao abrir o projeto, numa cópia.
**Pedido:** [prompt da revisão geral](../../PROMPT_REVISAO_GERAL.md): mecânicas, lógica, hitboxes, assets e visual, mais a verificação e integração da Forja-Mãe v3.

## Resumo

- **Gancho:** a travessia não depende mais de um pulo no instante exato. Antes, 151 de 300 tentativas atravessavam os vãos obrigatórios (Deserto: 5 de 75). Agora, 300 de 300, a 30, 60 e 144 FPS.
- **Autômato:** o Pulso Magnético e o Ímã têm nome e tecla no HUD, anel de alcance, marcação dos alvos, placas separadas e uma porta que só o Pulso abre antes da Forja. As funções, o custo e o alcance não mudaram.
- **Defeito grave novo:** o ponto seguro era gravado em cima do elevador e dos carrinhos do Deserto. Quem caía num fosso depois que a máquina andava voltava para o ar e perdia vida a cada volta. Corrigido e coberto por teste.
- **Hitboxes:** os tiros do Robô e do Drone do Deserto saem do cano. As caixas do Esporângio e da Rainha Micélia passam a cobrir o desenho. Todas as outras foram medidas e conferidas.
- **Forja-Mãe v3:** verificada peça por peça (SHA, grade, quadros, âncoras, encaixes) e integrada. Saíram os paliativos da v2 que a v3 resolveu.
- **Arte e cenário:**
  - DF91 e DF96 limpos por script.
  - Nenhum sprite esticado num eixo só, em nenhuma fase.
  - Os entulhos do Laboratório que flutuavam agora se apoiam.
  - Nove pedidos de arte escritos para o que exige desenho novo.
- **Console:** nenhum erro nem aviso na bateria inteira. Os avisos de UID ao abrir a Nivária no 4.3 sumiram.

## 1. Tabela de achados

Severidade: **A** quebra o jogo ou frustra injustamente · **B** atrapalha leitura ou controle · **C** acabamento.

| ID | Área | Fase | Problema | Evidência | Sev. | Correção | Arquivos | Teste / captura | Situação |
|---|---|---|---|---|---|---|---|---|---|
| R01 | mecânica | Lab, Deserto, Nivária | Gancho: o puxão termina parado sob a argola e só um pulo numa janela curta vira travessia | `test_gancho`: 151/300 antes (Deserto 5/75) | A | Atravessar com o momento: saída para a frente e para cima segurando a direção; pulo durante o puxão fica guardado (ver seção 2) | `player.gd` | `test_gancho` 300/300 nos 3 FPS; `capturas/gancho` | corrigido (`bd0652b`) |
| R02 | mecânica | todas com gancho | Resultado do gancho dependia do FPS (freio da corda por quadro, última etapa passava do ponto) | `test_gancho` a 30/60/144 | B | `pow(0.85, dt·60)`; último trecho limitado a dist/dt | `player.gd` | `test_gancho` | corrigido (`bd0652b`) |
| R03 | mecânica | todas com gancho | Escolha do alvo pegava gancho atrás da mira ou atrás de plataforma de mão única | `tools/mapa_ganchos.gd` | B | Gancho atrás da mira vale 2,5× a distância, abaixo do ombro 1,5×; linha de visão inclui as de mão única quando o gancho está abaixo | `player.gd` | `test_gancho` | corrigido (`bd0652b`) |
| R04 | mecânica | Deserto (Forja) | Gancho que some ou deixa de ser gancho (martelo da Forja) continuava puxando | código | B | Solta o jogador | `player.gd` | `test_forja` | corrigido (`bd0652b`) |
| R05 | mecânica | todas | O retorno ao ponto seguro (perigo) não cancelava o puxão do gancho | código | A | `hurt(hazard)` zera o gancho | `player.gd` | `test_gancho` | corrigido (`bd0652b`) |
| R06 | mecânica | Nivária | Saída do gancho herdava 55 % do puxão: o Yeti passava por cima do pilar entre os poços 3 e 4 | `test_nivaria` | B | Saída fixa por forma, menor para quem fica mais tempo no ar | `player.gd` | `test_nivaria`, `test_gancho` | corrigido (`5de2f84`) |
| R07 | mecânica | Deserto | O João não entendeu o especial do Autômato: Pulso e Ímã numa placa só, sem HUD, sem alcance visível, a única situação que exigia o Pulso era a fase 3 da Forja | leitura do jogo | A | HUD com tecla, ícone e nome; anel de 150 px e cantoneiras nos alvos; placas separadas; porta imantada da Câmara que só o Pulso abre (ver seção 2) | `player.gd`, `hud.gd`, `desert.gd`, `deserto.tscn` | `test_pulso` (novo, 20), `test_forja` | corrigido (`5de2f84`) |
| R08 | mecânica / leitura | Deserto | O anel do Pulso (ciano a 0,30) sumia contra a areia clara | `capturas/pulso/anel_antes_depois.jpg` | B | Contorno escuro sob cada traço e ciano a 0,55 ± 0,15 | `player.gd` | `test_pulso`; captura | corrigido (`5cbdcb4`) |
| R09 | lógica | Deserto (e Fuga) | Ponto seguro gravado no elevador e nos carrinhos sobre os fossos: cair depois que a máquina andava devolvia o jogador ao ar, em ciclo de dano | `test_ponto_seguro`: reaparecia dentro do fosso de x 5490 | A | O raio do chão ignora `AnimatableBody2D` e `CollapseSlab` | `player.gd` | `test_ponto_seguro` (novo, 7) | corrigido (`cf6e92b`) |
| R10 | hitbox | Deserto | Tiro do Robô nascia em (±30, −27), 24 px abaixo do cano | folhas DF60/DF63 | B | Sai de (±24, −51), a ponta do cano medida na arte | `desert_enemy.gd` | `capturas/hitboxes` | corrigido (`5396244`) |
| R11 | hitbox | Deserto | Tiro do Drone nascia em (0, +18), fora da lente | DF67/DF68 | C | (±10, +13), na lente | `desert_enemy.gd` | `capturas/hitboxes` | corrigido (`5396244`) |
| R12 | hitbox | Verdâmia | Esporângio: caixa até 62 px do chão; o bulbo vai a ~75 | `capturas/hitboxes` | B | 44 × 74 | `spore_plant.gd` | `test_verdamia` | corrigido (`5396244`) |
| R13 | hitbox | Verdâmia | Rainha Micélia: caixa sem o chapéu e o rosto (39 % do desenho), onde o jogador mira | `capturas/hitboxes/hitbox_verdamia_queen_*.jpg` | B | 180 × 250 em (−10, −125) | `queen.gd` | `test_verdamia`; `medir_hitboxes` | corrigido (`4ca0427`) |
| R14 | hitbox / arte | Deserto (Forja) | DF105: o Autômato afundava 13 px na chapa do martelo; núcleo do pistão fora do encaixe | captura v2 × v3 | B | Topo do bloco a 22 px da junta; núcleo no encaixe; área de dano 110 × 60 | `forja.gd` | `test_forja` | corrigido (`d4abcf3`) |
| R15 | arte | Deserto | DF91: quadros 1, 2, 3 e 7 do andar desenhados 35–36 px acima dos pés (o Autômato subia 7,7 px a cada passo) | `capturas/automato_andar_antes_depois.jpg` | B | Desce os quadros por script; ombros acompanham | `tratar_arte_revisao.py`, `player.gd` | captura; `test_deserto` | corrigido (`a755032`) |
| R16 | arte | Deserto | DF91 e DF96: fragmentos soltos sob os pés | auditoria pacotes 11–20 | C | Apaga componentes < 0,4 % do maior | `tratar_arte_revisao.py` | captura | corrigido (`a755032`) |
| R17 | arte | Deserto | Correntes DF53 esticadas (0,30 × 0,35 e 0,50 × 0,60) | `varrer_escalas` | C | Escala uniforme pela largura da laje; tirante até a corrente | `desert.gd`, `deserto.tscn` | `capturas/escala/correntes_antes_depois.jpg` | corrigido (`1a5fd27`) |
| R18 | arte | Laboratório | Campo de força esticado (0,98 × 0,43) | `varrer_escalas` | C | Poste + miolo repetido + poste, recortados do quadro, escala uniforme | `energy_field.gd` | `capturas/escala/campo_*` | corrigido (`1a5fd27`) |
| R19 | cenário | Laboratório | Três entulhos (x 5910–6017) 16–24 px no ar | `varrer_apoio`; `capturas/apoio` | C | Offset pela última linha opaca da imagem | `lab.tscn` | `varrer_apoio` (0); captura | corrigido (`8db154b`) |
| R20 | lógica / console | Nivária | 7 avisos "invalid UID" a cada carregamento da fase no 4.3 (21 no mapa de ganchos; 7 ao abrir a cena no editor) | editor 4.3: 8 mensagens → 1 (só V-Sync do vídeo virtual) | C | Tira os `uid=` do 4.4+ das referências de script | `fases/nivaria.tscn` | editor 4.3 e bateria sem avisos | corrigido (`ac8e04f`) |
| R21 | arte | Deserto (Forja) | Forja-Mãe v2 com defeitos (DF103 de cabeça para baixo, DF104 barra fina, DF105 sem encaixe, DF107 sem aviso, DF108 parado) | auditoria v2 | B | v3 integrada; `flip_v` do carrinho e afastamento das placas removidos | `forja.gd`, `import_deserto_v2_folhas.py` | `test_forja` (37); `capturas/forja` | corrigido (`d4abcf3`) |
| R22 | arte | Deserto (Forja) | DF107 v3: a luz do aviso tem ~4 px no jogo (diferença 0,08 entre repouso e aviso) | `auditoria_forja_v3.md` | B | Tinta vermelha nas escotilhas (paliativo) | `forja.gd` | `capturas/pedidos/REV-03_DF107.jpg` | parcial: pedido REV-03 |
| R23 | arte | Deserto | DF98: cada célula termina num ímã; a ponta é um ímã | auditoria pacotes 11–20 | C | Recorte x 0–140 + ponta da v1 (paliativo) | `player.gd` | `REV-01_DF98.jpg` | parcial: pedido REV-01 |
| R24 | arte | Deserto | DF66/DF68: lente do drone cortada reta na linha 342 | `tratar_arte_revisao.py` | C | Não tratável sem desenho | — | `REV-02_DF66.jpg` | pendente: REV-02 |
| R25 | arte | Deserto | DF87 rebite e DF210 coletáveis com quadros iguais (parados) | auditoria | C | Brilho e balanço do jogo por cima (paliativo) | — | `REV-04`, `REV-05` | pendente: REV-04, REV-05 |
| R26 | arte | Deserto | DF200 céu diurno corrompido | integração v2 | C | Recomposição por script (paliativo) | `import_deserto_v2.py` | — | pendente: REV-06 |
| R27 | arte | Deserto | DF22 fachada e DF53 plataformas ainda na v1 | integração v2 | C | — | — | `REV-07_DF22_DF53.jpg` | pendente: REV-07 |
| R28 | arte | Deserto (Forja) | DF108 v3: pulsos do fogo quase iguais | `auditoria_forja_v3.md` | C | — | — | — | pendente: REV-08 |
| R29 | arte / cenário | Nivária | Terreno em polígonos lisos sem textura nem borda; bloco com estalactites (x −80 a 180, y −460) sem apoio | `capturas/percurso/folha_nivaria_*`; `REV-09_nivaria.jpg` | B | — (fase do Caio) | — | — | pendente: REV-09 e decisão do Caio |
| R30 | arte | Deserto (Forja) | O feixe da lente é uma linha desenhada por código; os 4 segmentos repetíveis da DF110 v3 não são usados | `forja.gd` (`_draw`) | C | — | — | — | pendente |
| R31 | design | Nivária | A fase do Caio ainda não tem inimigos nem o chefe (a proposta pede 12 inimigos e o Guardião Glacial) | `Nivaria.layout()`: `enemies: []` | — | Fora do escopo da revisão | — | — | pendente (Caio) |
| R32 | projeto | todas | Projeto em Godot 4.3; o Caio regera metadados no 4.7 (`07162da`) e o artista confere no 4.7.2. Cada cena salva no 4.4+ volta a gravar `uid=` que o 4.3 não entende | R20 | B | — | — | — | decisão do João (seção 8) |

Conferido sem defeito: origem do tiro do Rastejador, do Drone do Laboratório (vira com ele: (+21, +8) e (−24, +6)), da Turreta (olho a ~3 px do feixe) e do Esporângio. Na Forja, a rajada sai da grade, o feixe parte da lente e os martelos ferem na face. Os 61 grupos de animação do Laboratório, de Verdâmia, do Daymon, do Lince, do Eco e dos efeitos não têm quadro repetido nem animação parada ([auditoria_animacoes.md](auditoria_animacoes.md)).

## 2. Decisões de design

### Gancho (Arpão de Fase, Ímã do Autômato, gancho do Yeti)

**Modelo escolhido:** atravessar o gancho com o momento (a primeira opção do pedido).

| | Antes | Depois |
|---|---|---|
| Alvo | 380 px, linha de visão na camada 1, mira com peso 0,4 | 380 px; gancho atrás da mira vale 2,5× a distância, abaixo do ombro 1,5×; linha de visão inclui as plataformas de mão única quando o gancho está abaixo do ombro |
| Disparo | 0,09 s, velocidade × 0,85 por quadro | 0,09 s, × `pow(0.85, dt·60)` (igual em qualquer FPS) |
| Puxão | 980 px/s até 46 px abaixo do gancho | igual; o último trecho chega exatamente no ponto; presa numa quina perto da chegada, sai como se tivesse chegado |
| Chegada sem direção | 55 % do puxão na direção da reta | igual |
| Chegada segurando uma direção | 55 % do puxão na direção da reta (morre sob o gancho) | 1,4 × corrida para a frente (fixo por forma, menor para quem fica mais tempo no ar) e 0,72 × pulo para cima; por 0,45 s não freia abaixo disso nem sofre o corte de gravidade do pulo variável |
| Pulo durante o puxão | solta no meio do vão com 60 % | fica guardado e vira 0,8 × pulo na chegada |
| Ao soltar | devolve pulo extra e arranque; 0,08 s de coyote | igual |
| Resultado | 151/300 vãos obrigatórios | 300/300, a 30, 60 e 144 FPS, nas 5 variantes (parado, correndo, no ar, pulo no meio, pulo cedo) |

Dados: [`dados/gancho_antes.csv`](dados/gancho_antes.csv) e [`dados/gancho_depois.csv`](dados/gancho_depois.csv). Sequência: [`capturas/gancho`](capturas/gancho).

### Autômato: Pulso Magnético e Ímã

A conclusão foi que as duas habilidades fazem sentido juntas e não precisam mudar de função: o Ímã (botão do gancho) é para **ir até** uma argola ou **trazer** um drone; o Pulso (especial) **empurra para longe** e desliga máquinas em volta. O que faltava era o jogo ensinar e mostrar. Custo (33 de energia), alcance (150 px) e efeitos ficaram como estavam.

| | Antes | Depois |
|---|---|---|
| HUD | nada | abaixo do orbe: `F ÍMÃ: argola ou drone` e `K PULSO MAGNÉTICO`; o especial fica cinza abaixo de 1/3 de energia e pulsa quando está pronto. As outras formas ganharam a mesma linha |
| Alcance | invisível | com energia e um alvo a até 240 px: anel tracejado de 150 px (com contorno escuro, legível na areia) e cantoneiras ciano nos alvos, cheias dentro e vazadas fora |
| Alvo do Ímã | invisível | sem argola ao alcance, um triângulo ciano marca o drone que será puxado |
| Acerto | onda | faíscas ciano em cada alvo, anel nítido na borda, hitstop de 0,05 s, tremor e som; sem alvo, um anel fraco mostra o alcance |
| Placas | uma placa para as duas | placas separadas (x 1320 e 1520, antes do primeiro robô) e uma na porta da Câmara (x 6900) |
| Situação que exige | só a fase 3 da Forja | a entrada da Câmara fica presa por placas imantadas que só o Pulso a até 180 px abre; IRIS explica; sem energia, aponta a célula de energia (x 6800, volta em 9 s). É a mesma regra do peito da Forja |
| Situação que exige o Ímã | os três vãos das Dunas e da Fábrica | igual; a placa não manda mais pular no fim |

Capturas: [`capturas/pulso`](capturas/pulso).

## 3. Hitboxes e origem dos ataques

Medido por `tools/medir_hitboxes.gd` (caixa de dano contra o desenho opaco do quadro na tela, px do mundo). Tabela completa em [`dados/hitboxes_medidas.md`](dados/hitboxes_medidas.md); fotos em [`capturas/hitboxes`](capturas/hitboxes).

| Entidade | Antes | Depois | Desenho coberto | De onde sai o ataque |
|---|---|---|---|---|
| Daymon (Laboratório) | 18 × 54 em (0, −31) | igual | 17 % | `gun_tip()`; caixa menor de propósito (tolerância) |
| Lince (Verdâmia) | 26 × 26 em (0, −17) | igual | 21 % | idem |
| Autômato (Deserto) | 24 × 54 em (0, −31) | igual | 23 % | ponta do braço-ímã por quadro (`SHOULDER_AUT_PX`, corrigido no andar) |
| Yeti (Nivária) | 32 × 68 em (0, −38) | igual | 29 % | idem |
| Rastejador | 88 × 50 em (0, −25) | igual | 86 % | (±44, −26), a boca |
| Drone do Laboratório | 52 × 44 em (0, 0) | igual | 28 % (corpo inteiro; asa, chama e clarão fora de propósito) | lente (±15, +1) + 8 px na direção do tiro |
| Turreta | 42 × 68 em (0, −35) | igual | 88 % | olho (93, 43) da imagem, a ~3 px do centro vermelho medido |
| Esporângio | 40 × 60 em (0, −32) | **44 × 74 em (0, −38)** | 61 % | (±30, −60), a boca do bulbo |
| Mariposa | 40 × 32 em (0, 0) | igual | 56 % (asas) | investida (o corpo) |
| Rainha Micélia | 150 × 220 em (0, −110) | **180 × 250 em (−10, −125)** | 53 % (braço fino e raízes fora) | espinhos do chão (56 px de largura) e esporos |
| Robô do Deserto | 48 × 64 em (0, −32) | igual | 87 % | **(±30, −27) → (±24, −51)**, a ponta do cano |
| Drone do Deserto | 54 × 34 em (0, 0) | igual | 84 % | **(0, +18) → (±10, +13)**, a lente |
| Forja-Mãe: núcleo do martelo | 110 × 40 | **110 × 60** (junta −36 a +24) | — | — |
| Forja-Mãe: rajada | — | — | — | grade, x da base ±70, alturas 16 e 52 px |
| Forja-Mãe: feixe | — | — | — | lente (7770, 533) até o chão varrido |
| Forja-Mãe: martelo | — | — | — | face do martelo, 120 × 40 |
| Nivária | — | — | — | sem inimigos nem chefe nesta versão |

## 4. Forja-Mãe v3

Verificação completa em [`auditoria_forja_v3.md`](auditoria_forja_v3.md) (`tools/auditar_forja_v3.py`). Os 12 mestres e os 12 WebP conferem com o SHA do atlas e dos ENTREGA. Há 54 quadros ocupados e 17 células vazias, como a entrega diz. Cada `*_jogo_v3.webp` é o mestre reduzido a 50 %, com diferença 0. Os cinco vãos do DF100 têm alfa zero nas medidas exatas, e as constantes `LENS`, `CHEST`, `HATCH` e `GRATE` batem com o mundo calculado (base (7770, 770), K 0,214). Tudo importa e roda no 4.3.

| ID | Peça | Resultado | O que mudou no jogo |
|---|---|---|---|
| DF100 | corpo | aprovado | — |
| DF101 | lente | aprovado | — |
| DF102 | peito | aprovado com ajuste no código | escala da entrega (400/358); placas na origem do peito, sem o afastamento extra de ±26 px |
| DF103 | carrinho | aprovado com ajuste no código | rodas em cima: saiu o `flip_v` |
| DF104 | segmento do braço | aprovado | viga com pistão e articulações, pivôs (112, 256) e (912, 256) |
| DF105 | martelo | aprovado com ajuste no código | topo real do bloco a 22 px da junta (antes 35); âncora do Ímã na placa ciano |
| DF106 | núcleo do pistão | aprovado com ajuste no código | núcleo no encaixe; área de dano 110 × 60 |
| DF107 | escotilha | aprovado com ressalva | usa o quadro "abrindo"; a luz do aviso é pequena demais na escala do jogo: a tinta vermelha fica (REV-03) |
| DF108 | grade | aprovado com ressalva | fogo pulsa pouco (REV-08) |
| DF110 | feixe e impacto | aprovado | impactos usados; os segmentos ainda não (R30) |
| DF111 | carga da lente | aprovado | — |
| DF112 | explosão de núcleo | aprovado | fragmentos soltos nos quadros 4–7 são estilhaços da explosão |

Capturas da Câmara em repouso, no aviso, com o martelo preso e com o peito aberto (v2 × v3), e a comparação com `DF100_montagem_v3.png`: [`capturas/forja`](capturas/forja).

## 5. Arte tratada por script

| ID | Script | O que mudou | Onde entrou |
|---|---|---|---|
| DF91 | `tools/tratar_arte_revisao.py` (chamado por `import_deserto_v2_folhas.py`) | fragmentos apagados; quadros 1, 2, 3 e 7 descidos 36/36/35/35 px até os pés em y 470 | `assets/deserto/DF91.webp`; ombros em `Player.SHOULDER_AUT_PX` |
| DF96 | idem | fragmentos apagados | `assets/deserto/DF96.webp` |
| fx_campo | `scripts/energy_field.gd` (no carregamento) | quadro recortado em poste, miolo e poste | campo de força do Laboratório |

Os originais em `colaboracao/entregas/` não mudaram.

## 6. Pedidos de arte

Em [`colaboracao/pedidos/REV_pedidos_de_arte.md`](../../colaboracao/pedidos/REV_pedidos_de_arte.md), cada um com captura, formato, grade, quadros, âncoras, onde entra e qual paliativo sai:

| ID | Peça | Prioridade |
|---|---|---|
| REV-01 | DF98 feixe do Ímã (segmento e ponta) | B |
| REV-02 | DF66 e DF68 lente do drone | B |
| REV-03 | DF107 aviso da escotilha da Forja | B |
| REV-04 | DF87 rebite girando | C |
| REV-05 | DF210 coletáveis animados | C |
| REV-06 | DF200 céu diurno íntegro (reexportar) | C |
| REV-07 | DF22 fachada e DF53 plataformas na v2 | C |
| REV-08 | DF108 fogo da grade | C |
| REV-09 | Nivária: módulos de terreno e apoio do bloco suspenso | B |

## 7. Testes

Bateria: `tools/rodar_testes.sh` (um teste por vez; o gancho roda separado por FPS).

Resultado final (27/11/2026, Godot 4.3, `tools/rodar_testes.sh`): **15 execuções, 0 falhas, 0 erros ou avisos no console** (fora o aviso de vazamento ao fechar o harness, que não é do jogo).

| Teste | Argumentos | Resultado | Tempo |
|---|---|---|---|
| test_deserto | `save at=999` | passa | 28 s |
| test_forja | `save at=999` | passa (37 checagens) | 63 s |
| test_df205 | — | passa | 9 s |
| test_cenas_fases | — | passa | 1 s |
| test_verdamia | — | passa | 40 s |
| test_passagem | — | passa | 52 s |
| test_fragmento | — | passa | 25 s |
| test_nivaria | `level=nivaria arpao at=999` | passa | 94 s |
| test_portal | `level=lab terminals pos=6500,690 at=999` | passa | 8 s |
| test_gancho | `fps=30` / `fps=60` / `fps=144` | passa (105/105 em cada) | 224 / 203 / 188 s |
| test_pulso | — | passa (20 checagens) | 8 s |
| test_ponto_seguro | — | passa (7 checagens) | 11 s |
| test_fuga | `level=lab terminals arpao pos=4250,790 save at=999` (sozinho) | passa | 31 s |

Varreduras: `varrer_escalas` 0 sprites esticados (lab 88, Verdâmia 31, Deserto 209, Nivária 8 olhados); `varrer_apoio` 0 flutuando (um falso positivo conferido: plataforma pendurada por correntes de código).

**Testes e ferramentas novos:**

| Arquivo | O que cobre |
|---|---|
| `test_gancho.gd` | cada vão de gancho de Lab, Deserto e Nivária, nos dois sentidos, 5 variantes, a 30, 60 e 144 FPS (105 checagens por FPS) |
| `test_pulso.gd` | Pulso e Ímã: HUD, alvos, porta imantada, peito da Forja (20 checagens) |
| `test_ponto_seguro.gd` | elevador e carrinhos do Deserto não viram ponto seguro; cair no fosso custa 1 de vida e devolve ao chão firme (7 checagens) |
| `varrer_escalas.gd` | sprites com escala não uniforme em cada fase (0 em todas) |
| `varrer_apoio.gd` | decoração flutuando acima do terreno (0 depois da correção) |
| `medir_hitboxes.gd` | caixa de dano × desenho de cada entidade |
| `exportar_quadros.gd` + `auditar_animacoes.py` | quadros repetidos, fragmentos e cortes nas animações das outras fases |
| `auditar_forja_v3.py` | verificação técnica da Forja v3 |
| `captura_hitboxes.gd`, `captura_ponto.gd`, `captura_percurso.gd`, `captura_gancho_seq.gd`, `captura_pulso.gd`, `captura_forja.gd`, `captura_automato_andar.gd` | capturas 1280 × 720 com a câmera do jogo |

Testes ajustados: `test_forja` (a entrada da Câmara começa imantada; o teste abre a porta com o Pulso antes de seguir).

## 8. O que não deu para fazer e o que depende do João

- **Versão do Godot (decisão do João).** O projeto diz 4.3, mas o Caio regera os metadados no 4.7 e o artista confere no 4.7.2. Cada cena salva num editor 4.4+ volta a gravar `uid=`, e o 4.3 avisa no console (R20 foi isso). **Recomendação:** escolher uma versão só para todo mundo. Subir o projeto para o 4.7 é o caminho mais simples, porque já é o que os outros usam. Rodar a bateria inteira depois. Se ficar no 4.3, o Caio precisa abrir o projeto no 4.3.
- **Nivária (decisão do Caio):** terreno sem arte (REV-09), bloco suspenso sem apoio, e a fase ainda sem os 12 inimigos e o Guardião Glacial da proposta. Por isso não há hitboxes nem origens de tiro da Nivária para revisar.
- **Feixe da Forja com a arte da DF110 (R30):** acabamento; a linha desenhada lê bem.
- **Peças que só se resolvem com desenho novo:** REV-01 a REV-09.
- **"27 mensagens ao abrir o projeto":** no 4.3, abrir a Nivária no editor dava 7 avisos de UID e rodar a fase dava mais 7 por carregamento; agora não dá nenhum. No 4.7.2, o projeto abre sem mensagem nenhuma, antes e depois. Se o editor do João ainda mostrar mensagens, vale mandar um print da aba Saída: nesta máquina não consegui reproduzir as 27.
- **Jogar com teclado.** Todas as fases foram percorridas por input simulado (testes) e capturas com a câmera do jogo, não à mão. Uma passada do João, com teclado, no Deserto inteiro, é o teste que falta para o critério "entende o Pulso sem ler o código".
