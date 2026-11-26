# Auditoria das entregas dos pacotes 11 a 20 (25/11/2026)

Os 67 PNGs de produção dos commits `[arte]` b9f0ab8…06e3979 da `main` foram verificados por `tools/auditar_entregas_deserto.py` (tabelas abaixo), por comparação visual de cada folha com a v1, com o pedido v2 e com a montagem do GPT, e pelas capturas no jogo (`docs/integracao_deserto_v2/`).

## Resultado

**Tudo confere em:** medidas, grade e quantidade de quadros dos 67 arquivos, e SHA-256 contra o ENTREGA. Nenhuma diferença; DF98 v1 não tem SHA, mas é arquivo antigo.

Também conferem a âncora de cada folha (pés em y 472, centro em (192, 256), efeitos em y 500 ou 472) e as emendas dos 5 módulos repetíveis (diferença 0,0 entre bordas opostas).

**Problemas encontrados (pedir ao GPT):**

| ID | Problema | Efeito no jogo | O que o jogo faz hoje |
|---|---|---|---|
| DF98 | cada célula da faixa de feixe termina num ímã (x ≥ 145); a faixa de ponta é um ímã pequeno, não a garra de luz | o feixe não pode repetir a célula inteira | repete só o trecho de feixe puro (x 0–140) e usa a ponta da v1 |
| DF103 | rodas embaixo; o pedido era rodas no trilho em y 120 e pivô em (512, 400) | o carrinho ficaria de cabeça para baixo no trilho do teto | peça virada na vertical |
| DF104 | veio uma barra fina com rodinhas, parecida com um trilho; o pedido era uma viga de 140 px com pistão e articulações | braços da Forja finos | usa assim; refazer |
| DF105 | o bloco começa em y 192; o encaixe no braço (512, 96) fica no vazio | 20 px de vão entre a junta e o martelo | o núcleo DF106 cobre o vão |
| DF91 | quadros 3 e 7 com 2 fragmentos laranja soltos abaixo dos pés | pontinhos no chão ao andar | usa assim |
| DF96 | 2 fragmentos soltos | quase invisível | usa assim |
| DF87 | 3 dos 4 quadros iguais | o rebite não gira | usa assim |
| DF210 | as 6 células e os 6 núcleos são o mesmo desenho; os 4 registros são iguais | coletáveis sem animação | usa assim (com o brilho e o balanço do jogo) |
| DF69c | 3 dos 4 quadros iguais | drone derrubado quase parado | aceitável |
| DF70, DF71, DF85, DF106 | praticamente a v1 (diferença média 0,3 a 2,2 níveis) | nenhum | usa a v2 |
| DF60–DF71, DF100–DF112 | o texto dos ENTREGA_v2 foi copiado da v1 (ex.: DF100 diz "aguardando aprovação"; olho âmbar, mas a arte tem olho vermelho) | nenhum; só documentação | — |
| DF200 | `DF200_ceu_diurno.png` continua corrompido na main (pacote 3) | — | recomposição de `tools/import_deserto_v2.py` |

"Pixels soltos" nas faíscas, explosões e vapor (DF81–DF84, DF110–DF112) são partículas do próprio efeito, não defeito. DF102 q4 e q6 fora do centro também está certo: são as placas sozinhas na posição em que encaixam.

**Corpo da Forja (DF100):** segue as medidas do pedido v2 (lente no recorte de cima, escotilhas, peito e grade), mas o acabamento é mais chapado que o resto da fase. Montado no jogo, bate com o `DF100_montagem.png` do GPT.


## Forja-Mãe (DF100–DF112 v2): segunda verificação (26/11/2026)

Medidas tiradas dos PNGs (pixels do original) e comparadas com o pedido v2 (etapa 7). Cada quadro também foi conferido a olho.

| ID | Pedido | Entregue | Situação |
|---|---|---|---|
| DF100 | corpo 1.400 × 1.200, base em y 2008; vãos: lente Ø 360 em (1024, 900), peito 420 × 360 em (1024, 1330), escotilhas 240 × 160 em (640, 820) e (1408, 820), grade 700 × 240 em (1024, 1820) | corpo 1.400 × 1.276, base em y 2007; peito e grade exatos; a lente fica num recorte em U aberto para cima (y 720–1080); as escotilhas são molduras de 240 de largura acima do corpo | **ok**, mas o acabamento é mais chapado que o do resto da fase |
| DF101 | Ø 340 no centro, 4 estados (repouso âmbar, aviso, mira vermelha, apagada) | Ø 340 exato, 4 estados distintos | **ok** |
| DF102 | câmara 400 × 340; fechada, aberta, danificada e 3 placas soltas | 360 × 326, estados distintos, placas na posição de encaixe | **ok** |
| DF103 | carrinho de 360, rodas no trilho em y 120, pivô do braço em (512, 400) | 360 de largura, mas carroceria em cima (y 111–280) e rodas embaixo (até y 414): é um carrinho de chão | **errado**; no jogo vai virado na vertical |
| DF104 | viga de 140 px com pistão ao lado e articulações redondas, pivôs (112, 256) e (912, 256) | barra fina (≈ 30 px) com dois truques de roda pendurados; o 140 px da caixa conta as rodas. Não tem pistão nem articulação | **errado**; é o motivo dos braços parecerem um trilho |
| DF105 | bloco 560 × 240, encaixe no braço em (512, 96), face em y 432; 3 "preso" com âncora **ciano** acesa | bloco 560 × 239 e face em y 430 certos; não há peça de encaixe acima do bloco (começa em y 192). No quadro 3 não há ciano, só o núcleo laranja | **parcial**: vão de 20 px entre a junta e o martelo; o "preso" não mostra a âncora (o jogo mostra o ponto de gancho por cima) |
| DF106 | Ø 160; íntegro, danificado, destruído | Ø 160; o 1 e o 2 são quase iguais (diferença 0,6); o 3 apagado | **parcial**: dano não aparece |
| DF107 | 240 × 160; 2 = aviso com luz **vermelha** | 240 × 160; o 2 é idêntico ao 1 (diferença 0,0), sem luz nenhuma | **errado**: o jogo usa esse quadro para avisar que vêm drones. Paliativo no código: a escotilha fica vermelha durante o aviso |
| DF108 | 340 × 120; 1–6 fogo pulsando | 340 × 120; 1–6 quase iguais (diferença < 1) | **parcial**: o fogo quase não pulsa |
| DF110 | feixe vermelho de 60 px no eixo y 128, impacto com contato em (128, 480) | 60 px em y 98–157, impacto até y 479 | **ok** |
| DF111, DF112 | centro (192, 256), 6 e 8 quadros | centrados, crescendo quadro a quadro | **ok** |

**Pedir ao GPT para refazer:**
- DF103: rodas em cima, no trilho, e pivô embaixo.
- DF104: viga grossa com pistão e articulações redondas.
- DF105: peça de encaixe em (512, 96) e âncora ciano no quadro 3.
- DF106: dano visível no quadro 2.
- DF107: luz vermelha no quadro 2.
- DF108: pulsação do fogo nos quadros 1–6.

## Tabelas da verificação automática

| ID | arquivo | medidas | SHA | quadros (esperado) | âncora | encosta na borda | pixels soltos | quadros iguais | dif. média p/ v1 |
|---|---|---|---|---|---|---|---|---|---|
| DF60 | `DF60_robo_idle_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | — | 11.3 |
| DF61 | `DF61_robo_andar_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | — | — | 20.0 |
| DF62 | `DF62_robo_aviso_v2.png` | 1536 × 1024 | ok | 3 (3) | ok  | — | — | — | 10.1 |
| DF63 | `DF63_robo_tiro_v2.png` | 1536 × 1024 | ok | 3 (3) | ok  | — | — | — | 9.7 |
| DF64 | `DF64_robo_dano_v2.png` | 1536 × 1024 | ok | 2 (2) | ok  | — | 2 | — | 7.1 |
| DF64b | `DF64b_robo_paralisado.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | — | — |
| DF65 | `DF65_robo_destruido_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | 6 | — | 19.2 |
| DF66 | `DF66_drone_voo_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | — | — | 9.6 |
| DF67 | `DF67_drone_aviso_v2.png` | 1536 × 1024 | ok | 3 (3) | ok  | — | — | — | 8.2 |
| DF68 | `DF68_drone_tiro_v2.png` | 1536 × 1024 | ok | 3 (3) | ok  | — | 1 | — | 6.0 |
| DF69 | `DF69_drone_dano_v2.png` | 1536 × 1024 | ok | 2 (2) | ok  | — | 4 | — | 4.1 |
| DF69b | `DF69b_drone_destruido_v2.png` | 1536 × 1024 | ok | 6 (6) | ok (livre) | — | 8 | — | — |
| DF69c | `DF69c_drone_derrubado.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | 3 | — |
| DF70 | `DF70_projetil_robo_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | 1 | 0.4 |
| DF71 | `DF71_projetil_drone_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | 2 | 0.3 |
| DF80 | `DF80_fumaca_chamine_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | — | — | 12.6 |
| DF81 | `DF81_jato_vapor_v2.png` | 1536 × 1024 | ok | 8 (8) | ok  | — | 14 | — | 21.4 |
| DF82 | `DF82_faiscas_prensa_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | 71 | — | 9.0 |
| DF83 | `DF83_poeira_areia_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | 17 | — | 5.2 |
| DF84 | `DF84_explosao_maquina_v2.png` | 1536 × 1024 | ok | 8 (8) | ok  | — | 65 | — | 18.8 |
| DF85 | `DF85_impacto_projetil_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | — | 2.2 |
| DF87 | `DF87_rebite_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | 3 | 0.4 |
| DF88 | `DF88_disparo_rebite_v2.png` | 1536 × 1024 | ok | 3 (3) | ok (livre) | — | — | — | 1.4 |
| DF90 | `DF90_automato_parado_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | — | — | 31.1 |
| DF91 | `DF91_automato_andar_v2.png` | 1536 × 1024 | ok | 8 (8) | ok  | — | 2 | — | 35.0 |
| DF92 | `DF92_automato_pulo_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | — | 17.3 |
| DF93 | `DF93_automato_queda_v2.png` | 1536 × 1024 | ok | 3 (3) | ok  | — | — | — | 19.9 |
| DF94 | `DF94_automato_arranque_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | — | 16.7 |
| DF95 | `DF95_automato_dano_v2.png` | 1536 × 1024 | ok | 2 (2) | ok  | — | — | — | 14.8 |
| DF96 | `DF96_automato_derrota_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | 2 | 1 | 24.9 |
| DF97 | `DF97_automato_braco_v2.png` | 1536 × 1024 | ok | 4 (4) | ok (livre) | — | — | — | 5.9 |
| DF98 | `DF98_feixe_ima_v2.png` | 1024 × 512 | ok | 8 (8) | ok (livre) | 1, 2, 3, 4 | — | 3 | 12.5 |
| DF99 | `DF99_pulso_magnetico_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | — | — | 27.5 |
| DF100 | `DF100_forja_corpo_v2.png` | 2048 × 2048 | ok | 1 (1) | ok  | — | 2 | — | 21.5 |
| DF101 | `DF101_forja_lente_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | — | 11.4 |
| DF102 | `DF102_forja_peito_v2.png` | 1536 × 1024 | ok | 6 (6) | **q4: centro (86, 256); q6: centro (298, 256)**  | — | — | — | 25.8 |
| DF103 | `DF103_forja_carrinho_v2.png` | 1024 × 512 | ok | 1 (1) | ok (livre) | — | — | — | 12.0 |
| DF104 | `DF104_forja_segmento_v2.png` | 1024 × 512 | ok | 1 (1) | ok (livre) | — | — | — | 21.2 |
| DF105 | `DF105_forja_martelo_v2.png` | 2048 × 1024 | ok | 4 (4) | ok (livre) | — | — | — | 17.8 |
| DF106 | `DF106_forja_nucleo_pistao_v2.png` | 1536 × 1024 | ok | 3 (3) | ok  | — | — | — | 2.1 |
| DF107 | `DF107_forja_escotilha_v2.png` | 1536 × 1024 | ok | 4 (4) | ok  | — | — | 1 | 5.9 |
| DF108 | `DF108_forja_grade_v2.png` | 1536 × 1024 | ok | 8 (8) | ok  | — | — | — | 8.9 |
| DF110 | `DF110_forja_feixe_v2.png` | 1024 × 512 | ok | 8 (8) | ok (livre) | 1, 2, 3, 4 | 24 | — | 17.9 |
| DF111 | `DF111_forja_carga_lente_v2.png` | 1536 × 1024 | ok | 6 (6) | ok  | — | 12 | — | 18.3 |
| DF112 | `DF112_forja_explosao_nucleo_v2.png` | 1536 × 1024 | ok | 8 (8) | ok  | — | 38 | — | 37.2 |
| DF210 | `DF210_objetos.png` | 2048 × 1024 | ok | 8 (8) | ok (livre) | — | — | 3 | — |
| DF210 | `DF210_coletaveis.png` | 2048 × 1536 | ok | 12 (12) | ok  | — | — | 10 | — |

| peça | medidas | SHA | emenda (dif. média entre bordas opostas) | pixels soltos |
|---|---|---|---|---|
| `DF26_esteira_v2.png` | 1024 × 120 | ok | 0.0 | — |
| `DF26b_esteira_ponta_esq_v2.png` | 120 × 120 | ok | — | — |
| `DF26c_esteira_ponta_dir_v2.png` | 120 × 120 | ok | — | — |
| `DF27_trilho_vertical_v2.png` | 148 × 512 | ok | 0.0 | — |
| `DF55b_trilho_horizontal_v2.png` | 512 × 32 | ok | 0.0 | — |
| `DF50a_prensa_cabeca_v2.png` | 212 × 60 | ok | — | — |
| `DF50b_prensa_haste_v2.png` | 40 × 256 | ok | 0.0 | — |
| `DF50c_prensa_suporte_v2.png` | 212 × 70 | ok | — | — |
| `DF51a_prensa_pequena_cabeca_v2.png` | 140 × 60 | ok | — | — |
| `DF51b_prensa_pequena_haste_v2.png` | 40 × 256 | ok | 0.0 | — |
| `DF51c_prensa_pequena_suporte_v2.png` | 140 × 70 | ok | — | — |
| `DF52_serra_v2.png` | 140 × 140 | ok | — | — |
| `DF52b_serra_base_v2.png` | 160 × 64 | ok | — | — |
| `DF54_elevador_v2.png` | 240 × 48 | ok | — | — |
| `DF55_carrinho_v2.png` | 240 × 264 | ok | — | — |
| `DF56_valvula_aviso_v2.png` | 144 × 24 | ok | — | — |
| `DF56_valvula_inativa_v2.png` | 144 × 24 | ok | — | — |
| `DF57_ponto_gancho_v2.png` | 76 × 96 | ok | — | — |
| `DF38_porta_aberta_v2.png` | 300 × 380 | ok | — | — |
| `DF38_porta_fechada_v2.png` | 300 × 380 | ok | — | — |
