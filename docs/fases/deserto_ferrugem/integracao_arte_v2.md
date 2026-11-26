# Deserto de Ferrugem: integração da arte v2 (25/11/2026)

Branch `dev/deserto`. A fase agora é a cena `scenes/fases/deserto.tscn` (veja `docs/CENAS_DAS_FASES.md`), com a arte dos pacotes 3 a 20. Capturas reais do Godot (1280 × 720, câmera do jogo, entrada pelo fluxo normal `main.tscn` → `load_level`): `docs/integracao_deserto_v2/`.

## O que entrou

Todos os PNGs vêm de `colaboracao/entregas/` sem alteração (SHA-256 conferido contra o ENTREGA por `tools/import_deserto_v2.py`), exceto onde a tabela diz. Escala uniforme em tudo: peças 2× a 0,5; DF204 a 0,4; recorte de folhas por grade fixa, com a âncora do ENTREGA.

| ID | Arquivo usado | Onde | Substitui | Teste |
|---|---|---|---|---|
| DF200 | `DF200_ceu_diurno.png` (**recomposto**, ver abaixo) | céu das Dunas, parallax 0,06 | DF200 crepuscular | captura parada e em movimento nas Dunas |
| DF201 v2 | `DF201_distante_v2.png`, `DF201_proximo_v2.png` | Dunas, parallax 0,20 e 0,38 (próximo repete a cada 2.560 sem espelhar) | DF201 v1 | 60 quadros com a câmera andando: sem faixa escura nem costura |
| DF205 v2 | as 22 peças `*_v2.png` | terreno inteiro (mesmos nomes do jogo, `tools/import_df205.py`) | DF205 v1 | `test_df205` 0 falhas; friso âmbar sobre a linha de colisão nas capturas; `test_deserto` (pousos e degraus) |
| DF202 | `DF202_fabrica.png`, `DF202_salao.png` | Fábrica a partir de (1700, −80); Salão a partir de (3580, −80) e Saída | DF22–DF24 (paredes) | capturas da Fábrica, do Salão e da Saída; repetição alinhada à origem |
| DF203 | `DF203_camara.png` | Câmara da Forja, (7050, 150) a (8490, 770) | DF24 na Câmara | capturas da Câmara com a luta (zoom 0,85) |
| DF204 | `DF204_estrutura.png` (10 células) | 7 peças em `EstruturasDeFundo`, parallax 0,85, base escondida pelo terreno; névoa de 22% nas Dunas | — | capturas e passagem com a câmera; nada sobre os vãos dos fossos |
| DF206 | `DF206_media.png`, `DF206_pequena.png` | Dunas, Salão e Saída; sucata com pneu e com tubo no lugar de DF30_1 e DF30_2 | DF30_1, DF30_2 | capturas; nada sobre a esteira, perigos ou a fenda |
| DF207 | `DF207_moldura.png` | 8 peças suspensas na Fábrica e no Salão, com a corrente repetida até o alto | — | capturas |
| DF208 | `DF208_primeiro_plano.png`, `..._interior.png` | primeiro plano só na frente dos pisos largos (base 190 px abaixo do piso) | — | capturas; não cobre fossos, a Câmara nem a Saída |
| DF209 | poeira, faíscas, vapor, halo | poeira nas Dunas (no lugar da DF86), vapor no tanque e nos canos, faíscas na bancada e no painel, halo âmbar nas lâmpadas | DF86 | capturas; halo some junto com a lâmpada que pisca |
| DF220 | `DF31`–`DF36_*_v2.png` | mastro, chaminé, porta da Fábrica, engrenagem (gira no centro 320, 320), abertura, torre | DF31–DF36 | olhal do mastro em (975, 480): o gancho DF57 pende dali e o Ímã puxa para ele (`test_deserto`); cabos da torre em (4820, 72) |
| DF221 | `DF37`, `DF37b`, `DF39`, `DF39b`, `DF28_*_v2.png` | 7 lâmpadas (acesa e apagada no mesmo lugar, 38 × 69, fio no centro de cima), painel 65 × 90, canos 240 × 120, cabos da torre e fios | DF37, DF37b, DF39, DF39b, DF28 | troca da lâmpada que pisca em x 6410 com o halo junto |

### Pacotes 11 a 20 (DF222–DF225, DF210, DF60–DF112)

Folhas importadas em meia resolução por `tools/import_deserto_v2_folhas.py` (mesmo nome do jogo, SHA conferido), escala uniforme K = 0,214 (nó a 0,428). Peças de máquina copiadas byte a byte para `assets/deserto/v2/`, a 0,5. Auditoria completa: `auditoria_pacotes_11_20.md`.

| ID | Arquivo usado | Onde | Substitui | Teste |
|---|---|---|---|---|
| DF222 | `DF26_esteira_v2`, `DF26b/c_*_v2`, `DF27_*_v2`, `DF55b_*_v2` | esteira da Fábrica (1700–2780) e da Câmara, pontas imóveis no pivô (60, 60), trilho vertical do elevador, trilho horizontal do carrinho e da Forja | DF26, DF26b, DF26c, DF27, DF55b | esteira anda a 65 px/s, a mesma velocidade que empurra (`test_deserto`); capturas |
| DF223 | `DF50a/b/c_*_v2`, `DF51a/b/c_*_v2`, `DF52_*_v2`, `DF52b_*_v2` | 3 prensas (haste repetida no eixo Y), serra com o eixo (70, 70) no encaixe (80, 0) da base, base apoiada no piso | DF50–DF52 | `test_deserto`; captura da Fábrica |
| DF224 | `DF54_*_v2`, `DF55_*_v2`, `DF56_*_v2`, `DF57_*_v2` | elevador, carrinho (rodas no trilho, piso na colisão), válvulas da Fábrica e da Câmara, 5 ganchos pela argola (38, 73) na âncora lógica, tirante até o topo da peça | DF54–DF57 | Ímã puxa para as 5 âncoras (`test_deserto`, `test_forja`) |
| DF225 | `DF38_porta_fechada_v2`, `DF38_porta_aberta_v2` | portas da Câmara e da Saída, 150 × 190, colisão de 60 px no meio | DF38 | portas abrem e fecham (`test_forja`) |
| DF210 | `DF210_objetos`, `DF210_coletaveis` | estação (apagada; ativa quando é o ponto de retorno), placa, 12 células, núcleo e registro no tema do Deserto | estação, placa e célula do Laboratório | capturas (Dunas, Salão) |
| DF60–DF71 | `*_v2` + DF64b, DF69c | Robô (pés em (192, 472)) e Drone (centro (192, 256)); robô paralisado pelo Pulso usa DF64b; drone no chão usa DF69c com a base no piso; hitbox do desenho novo (48 × 64 e 54 × 34) | folhas v1 esticadas (0,56 × 0,50) | `test_deserto` (3 rebites derrubam o robô, Ímã e Pulso no drone) |
| DF80–DF85 | `*_v2` | efeitos com a âncora do ENTREGA e escala uniforme; multiplicador igual nos dois eixos onde o jogo precisa: jato da válvula ×1,5 (cobre a área de dano), fumaça ×1,3, faíscas da prensa ×1,5, martelo da Forja ×1,7 a ×2 | tamanhos não uniformes da v0.8 | capturas; `test_forja` |
| DF87–DF99 | `*_v2` | Autômato: ombro do braço por quadro (`DF97_ancoras.json`), braço visível em todas as poses (as folhas novas não têm o braço), ponta em x 280 | v1 | `test_deserto` |
| DF98 | `DF98_feixe_ima_v2` (só x 0–140) + ponta da v1 | feixe do Ímã | — | defeito da entrega, ver auditoria |
| DF100–DF112 | `*_v2` | Forja-Mãe nos encaixes do pedido v2 (lente (1024, 900), peito (1024, 1330), escotilhas (640, 820) e (1408, 820), grade (1024, 1820) ampliada para 700 × 240); carrinho DF103 virado na vertical | v1 | `test_forja`; captura da Câmara confere com `DF100_montagem.png` |

**Fichas** DF01, DF02 e DF03 v2: só referência.

## DF200 diurno: arquivo corrompido na main

`colaboracao/entregas/DF200/DF200_ceu_diurno.png` (SHA `4ef56118…`) tem o 6º bloco de dados com CRC inválido: só as linhas 0–579 de 1.440 decodificam, e o Godot não abre. O jogo usa uma recomposição feita por `tools/import_deserto_v2.py`: as linhas 0–579 do arquivo entregue e, abaixo, a fonte dele, a DF10 a 1,25 com 53 px de deslocamento (diferença média de 1 nível de cor na parte comum). **Pedir ao GPT que suba o arquivo de novo**; quando chegar, rodar o importador troca pela cópia fiel.

## Ainda depende de arte (o jogo usa a v0.8)

- Fachada da Fábrica (DF22) e correntes das plataformas (DF53): não estavam nos pacotes 11–20.
- Partículas de vento DF86: substituídas pela poeira DF209.
- Para refazer: DF98 (feixe e ponta), DF103, DF104, DF105 (encaixe), DF91 e DF96 (pixels soltos), DF87 e DF210 (quadros iguais) e DF200 (arquivo corrompido). Ver `auditoria_pacotes_11_20.md`.

## Testes

| Teste | Resultado |
|---|---|
| `test_deserto -- save at=999` | PASS (inclui 3 rebites no robô novo, Ímã e Pulso no drone, esteira, prensas, ganchos) |
| `test_forja -- save at=999` | PASS |
| `test_df205` | 0 falhas |
| `test_cenas_fases` | 0 falhas (Laboratório e Verdâmia inalterados) |
| `test_verdamia`, `test_passagem`, `test_fragmento`, `test_nivaria -- level=nivaria arpao at=999` | PASS |
| `test_portal -- level=lab terminals pos=6500,690 at=999` | PASS |
| `test_fuga -- level=lab terminals arpao pos=4250,790 save at=999` | PASS sozinho, 2 de 2 (falha às vezes quando roda junto com outro Godot: é sensível ao tempo) |
| `dump_fase -- level=deserto` cena × `codigo=1`, estados zero, avançado e chefe | mesmos nós e valores; só a ordem das correntes DF207 dentro do pai e o arredondamento do comprimento de um cabo (2323,570 × 2323,574) mudam |

Não testado: jogar com o teclado de ponta a ponta numa máquina com tela (os testes usam input simulado e captura em xvfb). Nos testes, a câmera foi conferida parada em 14 pontos e andando em 2 trechos de 60 quadros.
