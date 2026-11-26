# Deserto de Ferrugem: integração da arte v2 (25/11/2026)

Branch `dev/deserto`. A fase agora é a cena `scenes/fases/deserto.tscn` (veja `docs/CENAS_DAS_FASES.md`), com a arte aprovada dos pacotes 3 a 10. Capturas reais do Godot (1280 × 720, câmera do jogo, entrada pelo fluxo normal `main.tscn` → `load_level`): `docs/integracao_deserto_v2/`.

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

**Fichas** DF01, DF02 e DF03 v2: só referência; as folhas de animação novas ainda não existem.

**Encaixe no cenário (pedido do João: peças "jogadas" e flutuando):** tudo que pende agora mostra de onde pende. Tirantes da DF205 sobem até o alto nas prensas, nas correntes das plataformas da Fábrica e nos ganchos do Salão (o da abertura pende da verga) e da Câmara (do teto). As estruturas grandes recuaram para um plano de parallax, com névoa no exterior, e saíram do plano do jogo. A decoração saiu da esteira, da fenda de retorno e dos perigos.

## DF200 diurno: arquivo corrompido na main

`colaboracao/entregas/DF200/DF200_ceu_diurno.png` (SHA `4ef56118…`) tem o 6º bloco de dados com CRC inválido: só as linhas 0–579 de 1.440 decodificam, e o Godot não abre. O jogo usa uma recomposição feita por `tools/import_deserto_v2.py`: as linhas 0–579 do arquivo entregue e, abaixo, a fonte dele, a DF10 a 1,25 com 53 px de deslocamento (diferença média de 1 nível de cor na parte comum). **Pedir ao GPT que suba o arquivo de novo**; quando chegar, rodar o importador troca pela cópia fiel.

## Ainda depende de arte (o jogo usa a v0.8)

- Fachada da Fábrica (DF22).
- Esteira e pontas (DF26, DF26b, DF26c).
- Trilhos (DF27, DF55b) e correntes das plataformas (DF53).
- Prensas e serra (DF50–DF52).
- Plataformas móveis, válvulas e gancho (DF54–DF57). Os ganchos ciano v1 são os mais destoantes.
- Portas da Câmara (DF38).
- Robô e Drone (DF60–DF71), efeitos (DF80–DF85), Autômato (DF87–DF99) e Forja-Mãe (DF100–DF112): só as fichas v2 existem.
- Placas, estação e coletáveis do Deserto (DF210): hoje usam os do Laboratório.

## Testes

| Teste | Resultado |
|---|---|
| `test_deserto -- save at=999` | ok 38, falhas 0 |
| `test_forja -- save at=999` | ok 36, falhas 0 |
| `test_df205` | 0 falhas |
| `test_cenas_fases` | 0 falhas (Laboratório e Verdâmia inalterados) |
| `test_verdamia`, `test_passagem`, `test_fragmento`, `test_nivaria` | PASS |
| `test_portal -- level=lab terminals pos=6500,690 at=999` | PASS |
| `test_fuga -- level=lab terminals arpao pos=4250,790 save at=999` | PASS sozinho (falha às vezes quando roda junto com outro Godot: é sensível ao tempo) |
| `dump_fase -- level=deserto` cena × `codigo=1`, estados zero, avançado e chefe | 0 diferenças |

Não testado: jogar com o teclado de ponta a ponta numa máquina com tela (os testes usam input simulado e captura em xvfb). Nos testes, a câmera foi conferida parada em 14 pontos e andando em 2 trechos de 60 quadros.
