# DF00 v2 — Deserto de Ferrugem

DF00 v2 aprovada explicitamente por João Marcelo em 24/11/2026 para publicação.

## Arquivos

- `DF00_prancha_deserto_v2.png` (1.536 × 1.024). Quatro estudos laterais de 700 × 160 px com equivalentes em cinza, três amostras de plataformas a D = 400 px e paletas de materiais e de função.

- `DF00_v2_cena.png` (2.560 × 2.388). Quatro montagens de 1.280 × 720 com Daymon a 91 px e duas capturas da auditoria para referência.

## Referências

DA-01, DA-02 e DA-03 na branch `dev/neve`. `docs/auditoria_cena/comparacao_cenas.png` fornece os quadros do Laboratório Hélix e de Verdâmia. A GL00 forneceu a grade da prancha e o modelo de teste. A DF00 v1 foi consultada para material e construção. O Daymon recortado do perfil da ficha oficial serve de referência de escala.

## Camadas e escalas por zona

| Zona | Fundo distante | Intermediário | Estrutura de fundo | Plano do jogo | Primeiro plano | Luzes e partículas |
|---|---|---|---|---|---|---|
| Dunas de sucata | Céu de tempestade e sol velado | Escarpas e guindastes | Pórtico e torres (3–6 D) | Sucata (0,15–0,5 D), esteira e base do pórtico (1–2 D); areia irregular e subsolo | Sucata escura nos cantos | Gancho ciano, sinal de serviço e poeira de ferrugem |
| Fábrica autônoma | Vãos da nave | Passarelas recuadas e janelas | Vigas e tubulações (3–6 D) | Caixas e juntas (0,15–0,5 D), máquinas (1–2 D), passarela suspensa por cabos e piso aparafusado | Tubos e desmonte escuro abaixo do apoio | Lâmpada âmbar e faíscas |
| Salão do Núcleo | Recuos da galeria | Patamares industriais | Pilares, tirantes e pórticos (3–6 D) | Detalhes de chapa (0,15–0,5 D), equipamentos (1–2 D), passarela e plataforma sustentada | Sucata baixa recortando os cantos | Núcleo âmbar contido e pontos de serviço |
| Câmara da Forja | Fundo da câmara e shafts | Instalações e volumes da forja | Estrutura da boca da forja e dutos (3–6 D) | Apoio longo, ferragem pequena (0,15–0,5 D), encaixes e suportes médios (1–2 D) | Ferro escuro na borda inferior | Boca de fornalha e sinal de perigo |

As faixas identificam as funções e ordens de grandeza pretendidas. As pinturas são quadros compostos. As camadas, encaixes, partículas animadas e colisões serão montados em Godot com os assets finais. A saída está fora dos quatro quadros solicitados.

## Âncoras

Origem superior esquerda. Na prancha, as cruzes marcam os apoios em y = 568 px. Nas montagens, x é a borda esquerda do recorte do Daymon e y é a linha de apoio do recorte, relativos à câmera de 1.280 × 720.

| Peça | x | y | Faixa e função |
|---|---:|---:|---|
| Daymon | 838 | 568 | 1 D, referência de escala |
| Areia de ferrugem | 1002 | 568 | Amostra de apoio, 175 px de largura (0.44 D). Plano do jogo |
| Aço suspenso | 1197 | 568 | Amostra de apoio, 175 px de largura (0.44 D). Plano do jogo |
| Piso de fornalha | 1392 | 568 | Amostra de apoio, 175 px de largura (0.44 D). Plano do jogo |
| Daymon em Dunas de sucata | 574 | 525 | Perfil oficial, 91 px |
| Daymon em Fábrica autônoma | 655 | 507 | Perfil oficial, 91 px |
| Daymon em Salão do Núcleo | 600 | 528 | Perfil oficial, 91 px |
| Daymon em Câmara da Forja | 661 | 512 | Perfil oficial, 91 px |

## Paleta proposta de produção

- Areia de ferrugem — #3A2929 / #59403A / #806050

- Chapa — #253045 / #493736 / #654947

- Viga — #1D2A3C / #3B3237 / #615457

- Cobre — #523537 / #825246 / #A67357

- Vidro de lâmpada — #62463A / #9C643C / #EFAA55

- Fornalha — #422D31 / #754035 / #B36341

- Luz e energia — #EFAA55

- Perigo — #E0303A

- Gancho e traje — #39E6FF

- Sombras comuns — #0F1422 / #253045

Os hex são amostras para produção. As cenas pintadas têm misturas intermediárias.

## Conferência DA-03

Y′ sRGB. Na montagem de 1.280 × 720, a média exclui os primeiros 130 px, e o terço superior é medido entre as linhas 130 e 239, segundo o script de referência. Nas faixas da prancha entram todos os pixels. Bordas por Sobel > 0,25; blocos lisos de 40 px com menos de 0,4% de borda e desvio de luma < 0,015. A separação usa janelas de 9 px com ΔY′ ≥ 0,10 em cada amostra válida da borda. As medidas são de composições estáticas.

| Zona | Faixa média / topo | Cena média / topo | ΔY′ do jogador | Separação iluminada | Separação com arte-base | Bordas | Área lisa |
|---|---:|---:|---:|---:|---:|---:|---:|
| Dunas de sucata | 0,134 / 0,131 | 0,128 / 0,136 | 0,400 | 81.7% | 58.3% | 0,040 | 0,470 |
| Fábrica autônoma | 0,131 / 0,120 | 0,121 / 0,116 | 0,423 | 97.7% | 65.3% | 0,068 | 0,198 |
| Salão do Núcleo | 0,134 / 0,129 | 0,125 / 0,128 | 0,416 | 96.3% | 66.2% | 0,068 | 0,143 |
| Câmara da Forja | 0,131 / 0,117 | 0,120 / 0,119 | 0,436 | 95.0% | 66.2% | 0,053 | 0,189 |

Na comparação, o mesmo Daymon recebe luz de preenchimento simulada em RGB (+20, +18, +16 em escala de 255), mantendo as cores relativas e a silhueta da arte. O teste com arte-base usa a mesma posição e fundo. O resultado da simulação depende dessa separação de luz e deve ser repetido com o shader e o sprite definitivos na cena jogável.

## Limites desta entrega

A arena representa a direção visual. As medidas de 1.440 × 620 px são da geometria jogável e não foram validadas nesta pintura. A prancha não mede o primeiro plano isolado nem substitui as capturas da DA-03 em jogo.

## SHA-256

- DF00_prancha_deserto_v2.png — `1bc7798a204d9a902f1bde51458a0555589de03a987f4b01a466f453d4e2a690`

- DF00_v2_cena.png — `a4b1bd36ba30a39ff3f42fd03ce43982fe653fe21e98456518c9000c7216e9eb`
