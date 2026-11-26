# DF-KEY · Quadros-chave do Deserto de Ferrugem

Direção diurna do pacote 1 aprovada por João Marcelo em 25/11/2026, incluindo a orientação de separar as peças de sucata com areia e iluminar as faces em ferrugem. Para as Dunas, usar o céu diurno de referência DF10 e luz de areia. A faixa de luma do exterior escuro pertence à proposta crepuscular anterior.

## Parte 1 — Revisão das regras

| Regra | Parecer | Aplicação |
|---|---|---|
| 1 · Formas chapadas | **Manter** | Dois a três planos por material na mesma incidência de luz. Usar facetas amplas na rocha e no tronco. No metal, a face principal e o chanfro se separam por valor. Hachura, grão e pincel aparente entram fora da linguagem de produção. |
| 2 · Contorno | **Ajustar** | Substituir o traço perimetral no cenário por encontro entre massas e sombras de contato recortadas. Uma junta escura pode indicar que duas peças se encaixam. Reservar o contorno seletivo e frio da DA-02 às figuras e aos interativos que precisam dele. |
| 3 · Detalhe em profundidade | **Manter** | Um ou dois planos no distante, dois no intermediário e até três planos com juntas e detalhes funcionais no plano jogável. A camada intermediária próxima pode ter um ou dois vazados grandes quando ajudam a identificar a silhueta. |
| 4 · Cor-assinatura | **Ajustar** | Usar âmbar em trechos da crista da areia, frisos aquecidos e peças em funcionamento. Interromper nas emendas e estreitar nas zonas em sombra. Concentrar halos nas fontes. Preservar ciano no Traje Âncora e nos ganchos e vermelho nos avisos de perigo. |
| 5 · Arestas e formas | **Manter** | Massas robustas e legíveis no tamanho do jogo, facetas simples, cantos com suavização discreta. Usar chanfro no metal onde a espessura é visível e curva no material que a pede. |
| 6 · Gradiente | **Ajustar** | Permitir gradientes amplos no céu, na névoa e nos halos. Representar o efeito da iluminação sobre faces sólidas por um plano de luz chapado. Antialiasing na borda pertence ao acabamento da silhueta. |
| 7 · Resolução aparente | **Ajustar** | Usar 1–2 px de arquivo por pixel de tela como faixa de referência na câmera normal. Aprovar na resolução final do jogo e inspecionar a 2× para achar artefatos. A consistência depende do menor detalhe que sobrevive ao redimensionamento e da nitidez entre camadas. |

### Âmbar do Deserto

**Manter #EFAA55 como cor-assinatura, com aplicação seletiva.** Na areia, a crista pega luz em trechos curtos e tem uma segunda face em ferrugem. No metal, o âmbar marca um friso aquecido, uma lâmpada ou um indicador de máquina ativa. O brilho ocupa uma área pequena e mantém o contraste da DA-03.

### Traços comuns a Hélix e Verdâmia

- **Chanfro com função.** O Hélix resolve plataforma ou carcaça com uma face larga, um chanfro oblíquo estreito e um plano mais frio atrás. Verdâmia faz o equivalente com encontros de facetas na rocha, sem repetir chanfros regulares no material orgânico.
- **Friso estreito e hierarquia.** A faixa clara acompanha a superfície de apoio e perde largura quando a luz cai. Para o Deserto, usar **2–5 px de tela** como ponto de partida com Daymon a 91 px. Na areia, variar a espessura por agrupamento, sem transformar toda a crista numa linha contínua.
- **Luz com origem legível.** Núcleo pequeno e saturado, halo amplo e fraco apenas ao redor da fonte e, quando necessário, uma face iluminada. Manter a direção de luz coerente em faces próximas.
- **Detalhe agrupado por D.** A concentração vem de encontros entre materiais e de elementos com função. Como referência de desenho, começar com **um grupo de juntas ou rebites por módulo de 1 D no plano jogável**. No fundo, manter **no máximo um recorte interno principal por massa de 1 D aparente**. São metas iniciais de composição, sem exigir contagem onde a cena pede silêncio visual.

### Como manter a mesma mão

Começar cada peça pelo mesmo gabarito do quadro-chave: escala de câmera, três amostras chapadas por material, direção de luz, exemplos de junta, chanfro, corte de rocha e friso. Reaproveitar esses elementos e as proporções nas peças da mesma família. Comparar a peça no contexto com Hélix, Verdâmia e o quadro-chave, em tamanho de jogo e em recorte 2×. Conferir silhuetas, textura, distribuição da cor, separação do plano jogável e costuras. Repetir a medição DA-03 depois de montar as camadas no jogo. Após a aprovação, usar esse quadro para redesenhar a DF201 e retocar a crista da DF205 sem alterar o gabarito de colisão.


### Miolo e halo das luzes

Para os próximos assets, o miolo de brasa mais quente usa #FFD38A. A assinatura continua #EFAA55. Na câmera do jogo, a lâmpada pequena tem raio proposto de 32 px e a janela de fornalha, de 48 px. O halo parte de 24% de opacidade junto à fonte, cai a 6% na metade do raio e chega a zero na borda. Esses números são parâmetros de produção propostos para as camadas de luz.

## Quadros para revisão

As duas cenas medem 1280 × 720. A prancha compara as quatro zonas em meia escala. A revisão visual das Dunas usa as texturas originais de céu, fábricas e dunas (DF10–DF12) como referências. O céu pêssego e o sol creme recuperam a identidade da primeira versão. As chaminés ficam em segundo plano e a cabine, a roda e a viga próxima têm areia visível entre si e faces em cobre. A revisão é um quadro de direção de arte. Os recortes de parallax e a validação em movimento pertencem à integração após a aprovação. A cena da Fábrica permanece a da revisão anterior.

## Medidas

Dunas diurnas, segundo as janelas de medição da DA-03: luma média 0,515, terço superior 0,767. O novo exterior excede os tetos crepusculares de 0,18 e 0,15. A revisão propõe luminosidade própria para o exterior. O contraste individual e a separação do contorno do personagem exigem as camadas em separado.

Fábrica, de acordo com o teste anterior sobre esta mesma imagem: luma 0,157, terço superior 0,131, contraste do personagem 0,256, separação do contorno 0,790, densidade de bordas 0,065 e área lisa 0,286.

## SHA-256

- DA04_quadro_chave_comparacao.png — 00bffa966745070785dc50bc30028c01ab9216a7b5d3fb8bf8e89261bfe3ca25
- DA04_quadro_chave_deserto.png — e38b97cc2c0cd257880759c4200d05e56dcc7e2037acba6e190c3e8880f0829f
- DA04_quadro_chave_interior.png — 46707c1e476ea0ebcc0c4631c449f1fb3f01872ebcdb17c908a6cea25da6f7d9
