# DF205 — Terreno do Deserto de Ferrugem

Arte aprovada por João Marcelo em 24/11/2026. A validação dos encaixes em execução no Godot fica para a integração.

## Montagem

Sprites RGBA a 2×. Origem no canto superior esquerdo. Azul-marinho de sombra da DF00 v2, areia de ferrugem, chapa e viga. As cores intermediárias foram ajustadas em luma após recortar as pinturas. Nenhuma geometria do jogo foi alterada.

| Arquivo | Tamanho em px | Apoio ou referência em px de arquivo | Escala e função |
|---|---:|---|---|
| `areia_chao.png` | 1024 × 320 | y 50 | 5.63 D, plano jogável |
| `chapa_chao.png` | 1024 × 192 | y 16 | 5.63 D, plano jogável |
| `areia_subsolo.png` | 1024 × 1024 | origem do bloco | 5.63 D, plano jogável |
| `estrutura_subsolo.png` | 1024 × 1024 | origem do bloco | 5.63 D, plano jogável |
| `areia_borda.png` | 144 × 1024 | x 6, face | 5.63 D, plano jogável |
| `areia_canto_esquerdo.png` | 180 × 260 | (18, 50) | 1.43 D, plano jogável |
| `areia_canto_direito.png` | 180 × 260 | (162, 50) | 1.43 D, plano jogável |
| `chapa_borda.png` | 144 × 1024 | x 6, face | 5.63 D, plano jogável |
| `chapa_canto_esquerdo.png` | 180 × 260 | (18, 16) | 1.43 D, plano jogável |
| `chapa_canto_direito.png` | 180 × 260 | (162, 16) | 1.43 D, plano jogável |
| `transicao_areia_estrutura.png` | 256 × 768 | (128, 0) em (1700, 690) do mundo | 4.22 D, plano jogável |
| `teto_chapa.png` | 1024 × 192 | y 160, face inferior | 5.63 D, plano jogável |
| `teto_canto_esquerdo.png` | 192 × 192 | (96, 96), união interna | 1.05 D, plano jogável |
| `teto_canto_direito.png` | 192 × 192 | (96, 96), união interna | 1.05 D, plano jogável |
| `verga_porta.png` | 144 × 96 | y 96, encontro com DF38 | 0.79 D, plano jogável |
| `passarela_meio.png` | 256 × 128 | y 8, apoio | 1.41 D, plano jogável |
| `passarela_ponta_esquerda.png` | 96 × 128 | y 8, apoio | 0.70 D, plano jogável |
| `passarela_ponta_direita.png` | 96 × 128 | y 8, apoio | 0.70 D, plano jogável |
| `coluna_trelica.png` | 96 × 512 | x 48, eixo | 2.81 D, suporte cenográfico |
| `tirante.png` | 32 × 256 | x 16, eixo | 1.41 D, suporte cenográfico |
| `fixacao.png` | 48 × 48 | (24, 24), centro | 0.26 D, suporte cenográfico |
| `fosso_fundo.png` | 1024 × 192 | y 32, dano | 5.63 D, plano jogável |

## Passarelas

Cada painel mede 64 px de arquivo. O miolo repete no passo de 256 px e a última região termina numa junta completa. As regiões de emenda são `Rect2(64, 0, 32, 128)` na ponta esquerda e `Rect2(0, 0, 32, 128)` na direita. Desenhe cada região como sobreposição a partir da face interna da respectiva ponta, com a mesma origem y do tabuleiro. Apoio em y 8 e tabuleiro principal entre y 8 e y 60.

| Colisão (px do jogo) | Vão | Treliça | Painéis | Sobra por lado | Sobreposição sobre o meio |
|---:|---:|---:|---:|---:|---:|
| 145 | 49 | 32 | 1 | 8.5 | 7.5 |
| 240 | 144 | 128 | 4 | 8 | 8 |
| 430 | 334 | 320 | 10 | 7 | 9 |
| 450 | 354 | 352 | 11 | 1 | 15 |

## Valores e conferência

Paleta de referência DF00 v2: areia #3A2929 / #59403A / #806050, chapa #253045 / #493736 / #654947, vigas #1D2A3C / #3B3237 / #615457. O brilho vermelho foi reservado às peças de fosso.

| Amostra | Y′ média com alpha ≥ 200 |
|---|---:|
| areia_chao | 0.229 |
| chapa_chao | 0.231 |
| areia_subsolo | 0.104 |
| estrutura_subsolo | 0.105 |
| fosso_fundo | 0.081 |

| Cena montada | Luma média | Terço superior |
|---|---:|---:|
| Dunas | 0.131 | 0.136 |
| Fábrica | 0.126 | 0.116 |
| Salão | 0.133 | 0.128 |
| Câmara | 0.124 | 0.119 |

O terço superior e a média da cena usam o recorte sem HUD da DA-03. Os pontos de iluminação e os personagens nas comparações vêm da DF00 v2. A integração e a leitura com colisões em execução no Godot serão medidas após a aprovação. A verificação de costura compara bordas opostas das texturas repetíveis em cada eixo indicado, com igualdade de RGBA, e inspeciona os recortes do gabarito.

## SHA-256

- `DF205_cena.png` — `428abc70660344399b71126a8bbc1a842f0b92558c64be9cf9b17e2cd75e39f4`
- `DF205_encaixes.png` — `5b0ff8fbd9e8ca9cb10609155f5f54849630d3db46dbec14cf4231bb1ce903c3`
- `areia_borda.png` — `dab677034b0debab1fc9afe53a62f2f53feab078adb4f907ffe0c8d2da1b087c`
- `areia_canto_direito.png` — `c4a411d0171b818ee05ef075470002a071479aca71da2ccb92d7551116a0996d`
- `areia_canto_esquerdo.png` — `9009f6b2aeeb7cdef47e42aed091156b1076c0442295969cd24faf0d1217ebd0`
- `areia_chao.png` — `38b86f91d5b38fddb0047a72e9805b2ab0ae51f11e637bd180a31fafc0ce3ecd`
- `areia_subsolo.png` — `24a7baec54bbaeb82f6b98e6003c7df27d5e380c6385afe7f0ffdf8387b54d16`
- `chapa_borda.png` — `d356d714359bb1c5afa2c6329473e0a797d91aa73bc4235c29bd9e3cddc2ad29`
- `chapa_canto_direito.png` — `ab5b47efce0e370082c300c0aae9de2ae5b39dcb1575d84563fa7d33a0545ff3`
- `chapa_canto_esquerdo.png` — `94f3fd501c33b9525fd8d8863735515a5acff6b70307b2157c9ae5de57f6eb08`
- `chapa_chao.png` — `23ca8bb5c867f40a052d4ff71e6d26fe44dcece6be30aa2a249dc4b4a437a503`
- `coluna_trelica.png` — `9902fbb016031b29da10f13674b85193f518bdd61b2b11c40f07baac7a0c98ed`
- `estrutura_subsolo.png` — `45edb6410ffdf1ca9e57d2876e1d7c97c602f0708e5c8c6be3f49a5f3e2e37b7`
- `fixacao.png` — `46364dd83fb3ca80e5512e9e632ef2c5a21ac296f7956566daf7fd1977a1aab6`
- `fosso_fundo.png` — `8a639abaa844a7e05807331a934382a9528877d3c6e9d028ae380dbfd1700753`
- `passarela_meio.png` — `96a65842987c64391b139e4368220b30c7408906efbcc48fbd6b42ec34359983`
- `passarela_ponta_direita.png` — `05b89b72bb3ff67d3bd0c8c2e9661a4ce5d6ffa886e1491da0f5e88f6b37d7e1`
- `passarela_ponta_esquerda.png` — `53a8e91dda51a60e57fac2020843813c4d36b3a444ecbc7477279dc4df85f6c7`
- `teto_canto_direito.png` — `93c3e81e451fea67d6847a568537f08014958731737394bd29e79d19596fab54`
- `teto_canto_esquerdo.png` — `7260fce26f8b03acf215af72d15f215043ac5d60eae0a745dab6493bc77983e9`
- `teto_chapa.png` — `9acc6c6956ed71bce103b8df7205cfd68aa42d2a094a57d65625808c62f56228`
- `tirante.png` — `ae639a43d97777fd056f3bde372a2a143fa1de263fe945a488137248bceb3b5b`
- `transicao_areia_estrutura.png` — `ba007fc150bd695a2d13c7b43caa1293e1a651bf364284b94d7f1f1a9f23315f`
- `verga_porta.png` — `7cdc766a693201c54603cb79042e0c44ca1a89d40734bb6913ffa581f465b3a2`

## Retoque dos cantos de areia

Aprovado por João Marcelo em 24/11/2026. Opacidade média em y 8–48: 0,00% nos dois cantos. Apoio em y 50 e pintura abaixo do apoio preservados. As remontagens usaram as emendas em x 780 e x 1.180. A validação no Godot usa o sprite inteiro no pivô original.

- areia_canto_direito.png — `4f5a164759b0d93d3b35bbfe563852ff06c199a354fddcfb5b82fe8cef9d349d`
- areia_canto_esquerdo.png — `8cdfb7c7cfddea563654acff5baa9a97386a87be6d506c4dfbb79aa3a76d3c53`
