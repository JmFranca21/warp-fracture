# GL02 — Inimigos de Nivária

GL01 aprovada por João Marcelo em 19/11/2026. GL02 aprovada explicitamente por João Marcelo em 19/11/2026 após a apresentação da ficha e da comparação.

## Vistas
Gelinho — perfil direito, frontal, inflação de aviso (0,5 s) e sopro curto. Drone Gélido — perfil direito, frontal, mira acesa, esfera e mancha escorregadia. Morcego-de-Cristal — repouso invertido, rasante lateral direito e frontal. A estalactite ao lado do repouso vem do estudo de gelo suspenso da GL00. A GL04 não foi localizada para comparação definitiva.
## Âncoras na ficha
Origem no canto superior esquerdo do PNG. Cruzes em cor de anotação.
| Inimigo | Função | x (px) | y (px) |
|---|---|---:|---:|
| Gelinho | base | 415 | 281 |
| Gelinho | boca | 473 | 239 |
| Drone Gélido | centro | 415 | 458 |
| Drone Gélido | saída | 497 | 458 |
| Morcego-de-Cristal | teto | 415 | 602 |
| Morcego-de-Cristal | centro em voo | 1033 | 669 |
## Materiais
Neve: #4F6386, #9FB3CF, #E6EEF7. Gelo e geada: #38536B, #628499, #A4BDCC. Carcaça metálica: #263447, #526275, #8999A8. Cristal: #483D65, #7A6FC9, #AA9ACF. Foco de perigo: #E0303A. Sombra e encaixes: #101923.
## Comparação
Perfil direito do Daymon da GL01. Rastejador e Drone de Segurança recortados das ilustrações principais da Folha de Inimigos do Laboratório Hélix. Larguras estimadas pelas miniaturas da própria folha, normalizadas para Daymon a 400 px. Os terrestres compartilham a linha de apoio e os drones aparecem suspensos. Inimigos novos comparados em perfil, morcego em rasante. Acabamento conferido com E0_inimigos de Verdâmia. A comparação inferior usa a GL00 e reduz o conjunto a 22,5%.
## Aferição DA-02
Medidas nas máscaras das três poses de referência acima, excluídos rótulos e cruzes. Luma Y′ ponderada em sRGB; saturação HSV. O perímetro é a borda interna de 1 px por erosão. Contorno é a fração dessa borda em amostra escura permitida. Sem traço externo sobreposto, os percentis de espessura de traço não se aplicam. ΔY′ do foco usa o anel exterior de 1 px dentro da silhueta.
| Medida | Meta | Gelinho | Drone Gélido | Morcego-de-Cristal |
|---|---|---:|---:|---:|
| A/D | 0,55–0,65 terrestre; voadores A ≥ 0,55 ou L ≥ 0,70 | 0.600 | 0.472 | 0.530 |
| L/D | Drone e asas abertas ≥ 0,70 | 0.573 | 1.150 | 0.880 |
| L/A | Registrar | 0.954 | 2.434 | 1.660 |
| Cor escura na borda | Amostra fria | #101923 | #101923 | #101923 |
| Perímetro em cor de contorno | ≤ 50% | 35.9% | 18.6% | 31.1% |
| Espessura mediana / P90 | ≤ 4 / 6 px | Sem traço aplicado | Sem traço aplicado | Sem traço aplicado |
| Tons e cores efetivas | 2–3 por material dominante; ≤ 12 por figura | Até 3 / 8 cores | Até 3 / 8 cores | Até 3 / 7 cores |
| S médio | 0,20–0,55 | 0.317 | 0.319 | 0.382 |
| S do foco / área com S > 0,80 | ≤ 10% de área intensa | 0,786 / 0.0% | 0,786 / 0.0% | 0,786 / 0.0% |
| Área do foco ativo | 4–10% | 4.6% | 4.6% | 4.6% |
| Luma do foco / ΔY′ local | Δ ≥ 0,20 | 0.338 / 0.244 | 0.338 / 0.244 | 0.338 / 0.244 |
| Foco com D a 90 px | ≥ 2 px | 7 × 16 px | 9 × 17 px | 9 × 10 px |
| Borda em contraste no recorte exibido | ΔY′ ≥ 0,10 em ≥ 66,7% | 83.8% | 84.7% | 77.6% |
| Leitura em jogo | Simulação a 90 px | Boca no perfil | Lente no eixo | Olhos à frente |
## Contraste por cenário
Faixa mais difícil selecionada pela média das três poses nos pontos testados. O morcego aparece fora da caverna apenas para o teste de contraste.
| Zona | Luma do fundo (≤ 0,20) | Gelinho | Drone | Morcego |
|---|---:|---:|---:|---:|
| Cume Congelado | 0.196 | 83.8% | 84.7% | 77.6% |
| Caverna de Cristal | 0.171 | 83.8% | 88.4% | 89.6% |
| Encosta Nevada | 0.157 | 88.1% | 83.3% | 81.7% |
| Arena do Guardião | 0.188 | 81.6% | 90.5% | 89.6% |
## Estados complementares
Morcego pendurado: 200 px de altura (0,50 D), com 4 pixels vermelhos na redução a 45 px. Drone: caixa de 460 px incluindo aletas. O corpo entre as raízes das aletas tem cerca de 300 px (0,75 D), por leitura visual do perfil.
## Limites
A prancha de referência não foi integrada ao Godot. O resultado em jogo é uma simulação visual estática. A validação das animações depende das folhas futuras. A GL04 segue pendente para a conferência da camuflagem.
## SHA-256
- GL02_ficha_inimigos_nivaria.png — `0b6b289079a95dd2cd059b42e186bd0c0bd952d97f0c67e8e360d954f84a3ef3`
- GL02_comparacao.png — `cbeafcc1cacb2c85507e1bba3dab7fd9312900c3654ec719de1dbb53ed6188bb`
