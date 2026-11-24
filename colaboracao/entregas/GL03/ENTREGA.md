# GL03 — Guardião Glacial e Arena do Guardião

Ficha, comparação e esquema da arena aprovados por João Marcelo em 19/11/2026. D08 aprovada em 19/11/2026. GL00, GL01 e GL02 aprovadas.

## Peças e ciclo da luta

Ficha em 1536 × 1024. Guardião frontal e perfil esquerdo, com 600 px de altura em meia escala. Daymon mede 200 px na mesma linha. Quatro detalhes mostram a cobertura do fragmento com 3, 2, 1 e 0 placas. Seis poses mostram o aviso da Investida (batida de pés, 0,6 s), a corrida, o punho cravado, o sopro rente ao chão, o atordoamento e o monte de neve depois da ruptura. O fragmento flutuante é recortado da peça oficial de Verdâmia.

Em cada sequência, a Investida termina na parede. As estalactites caem e o Guardião fica atordoado por 2 s. O anel laranja do Pulso Térmico do traje, usado perto do peito, derrete uma placa. O núcleo fica vulnerável por 3 s, o tempo de 4 tiros. As aberturas intermediárias do peito registram a progressão da blindagem. Fase 1: Investida e Estacas de Gelo, com rachaduras antes da erupção. Fase 2: soma a Onda de Gelo, que congela ao contato, e acelera a alternância. Fase 3: piso escorregadio, dois Gelinhos e ataques encadeados. Na derrota o gelo se desfaz em neve, o céu clareia e o fragmento abre a fenda de retorno ao Hélix.

## Arena e comparação

O esquema de 1536 × 768 incorpora o salão da GL00 e mantém os 1.400 × 520 px jogáveis do esboço de D08. Origem interna no canto superior esquerdo (68, 110) do PNG. O chão está em y=630 na prancha. Centro dos ganchos a x=470 e 930 no salão e 320 px acima do apoio. Alcance do Arpão: 380 px. Elevador à esquerda, checkpoint antes da porta, Braseiro próximo à chegada, Guardião à direita. O Braseiro recupera 1/3 de energia a cada 10 s. A onda de 60 px é superada pelos 144 px de elevação dos pés de Daymon. Desenhos e rótulos de ataques são sobreposições de leitura. A rachadura vermelha é o aviso no chão.

A comparação usa o perfil de inverno da GL01, a primeira célula de E_rainha_idle_1.png e o Guardião frontal. A altura da Rainha vem da silhueta do primeiro quadro de espera do atlas integrado, à escala 0,6667 do Godot: 268 px de jogo. A faixa superior conserva Daymon a 400 px e o Guardião a 1.200 px. Embaixo, a relação é 91:273 no cenário, com os apoios alinhados.

## Âncoras

Origem no canto superior esquerdo. As coordenadas de produção usam o canto superior esquerdo da caixa visível da vista, em D=400.

| Vista | Pivô | x na ficha | y na ficha | x local em produção | y local em produção |
|---|---|---:|---:|---:|---:|
| Frontal | Base | 360 | 703 | 670 | 1198 |
| Frontal | Ombro próximo / esquerdo | 193 | 278 | 336 | 348 |
| Frontal | Ombro distante / direito | 527 | 278 | 1004 | 348 |
| Frontal | Centro do peito | 367 | 368 | 684 | 528 |
| Perfil esquerdo | Base | 932 | 703 | 482 | 1198 |
| Perfil esquerdo | Ombro próximo / esquerdo | 964 | 272 | 546 | 336 |
| Perfil esquerdo | Ombro distante / direito | 955 | 272 | 528 | 336 |
| Perfil esquerdo | Centro do peito | 789 | 362 | 196 | 516 |

## Materiais e cores

Sombra de encaixe e bordas de sombra: #101923 e #253045. Gelo glacial em sombra, meio-tom e luz: #253045, #31425A e #49617B. Gelo iluminado e placas: #49617B, #7897AC e #849DAE; sombra no diagrama das placas: #485D74. Perigo: #E0303A. O fragmento conserva as cores do PNG oficial (turquesa pálido, satélites violetas e órbita verde); é uma peça independente, medida separadamente do chefe fechado. Calor e cotas de montagem: #EF9655. Ciano #39E6FF reservado ao traje.

## DA-02

Máscaras das vistas neutras em tamanho de produção, antes da aposição de cruzes e legendas. Luma Y′ em sRGB (0,2126 / 0,7152 / 0,0722); saturação HSV. A borda é a diferença entre máscara e erosão de 1 px. A medição de contraste usa o salão limpo na posição inicial do Guardião e a escala de 91 px por D. O entorno dos olhos é o anel sólido exterior de 3 px na escala de produção.

| Medida | Meta | Frontal | Perfil esquerdo |
|---|---|---:|---:|
| A/D | 3,0; faixa 2,5–3,5 | 3.00 | 3.00 |
| L/D | Registrar | 3.35 | 2.23 |
| L/A | Registrar | 1.12 | 0.74 |
| Perímetro em amostra de contorno | ≤ 50% | 33.5% | 31.6% |
| Cores efetivas da figura fechada | ≤ 12 | 7 | 7 |
| S médio | 0,20–0,55 | 0.420 | 0.419 |
| Área com S > 0,80 | ≤ 10% | 0.00% | 0.00% |
| Contraste local no contorno | ΔY′ ≥ 0,10 em ≥ 66,7% | 92.5% | 92.0% |
| Área dos olhos vermelhos | 4–10% | 4.14% | 4.11% |
| Luma dos olhos / ΔY′ sobre entorno | ΔY′ ≥ 0,20 | 0.338 / 0.244 | 0.338 / 0.244 |
| Tamanho de cada olho em jogo (L,A) | ≥ 2 px | [(56, 28), (57, 29)] | [(54, 47)] |
| Luma do corpo / salão local | Corpo mais escuro que o salão | 0.352 / 0.441 | 0.347 / 0.453 |
| Hex do contorno | Amostras frias DA-02 | #101923 / #253045 | #101923 / #253045 |
| Espessura mediana / P90 | ≤ 4 / 6 px | Sem linha aplicada | Sem linha aplicada |
| Tons por material | 2–3, detalhes 1 | 3 por grupo de gelo, 1 vermelho | Idem |
| S do acento de perigo | Energia ou perigo | 0,786 | 0,786 |
| Luma média do fundo da arena | ≤ 0,20 | 0.195 | Mesmo fundo |
| Resultado em jogo | Montagem a D≈90 | 273 px, três placas e olhos legíveis | 273 px, ataque dirigido à esquerda |

As porcentagens de borda incluem os planos escuros que atingem a silhueta. Como o desenho usa massas de sombra e luz em vez de um traço externo sobreposto, não há espessuras de linha para calcular mediana ou P90. O ensaio reproduz a escala do jogo em montagem estática. Animação, colisão, janelas de tempo e o comportamento real dependem da implementação futura.

## SHA-256

- `GL03_ficha_guardiao.png` — `8e0fc7a25bfdb1f9aa16d2acfbd9a8bfe61d2a5b0d9c53a99860b3e61d6bc257`
- `GL03_esquema_arena.png` — `a86e869e1a2ffc9afe77d11c4d5f56798fc802de27e1d9503312238b85015a05`
- `GL03_comparacao.png` — `d883c6a372801cc702ceb5dbf96eace4307530fe0c8d249d0cba2eb43fc8fac3`
