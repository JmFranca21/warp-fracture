# Deserto de Ferrugem · Conferência de conjunto

As telas de Deserto são montagens representativas, com céu diurno, terreno e fundos do refazimento. Referências de Hélix e Verdâmia retiradas da prancha DA-04. As tabelas medem somente as áreas de imagem. As proporções de elementos e os valores na câmera do jogo ainda precisam de validação em Godot.

## Autômato e mira

- DF90 a DF96 são folhas do corpo. O personagem conserva o outro braço e deixa a junta lateral visível para montar o braço-ímã separado. Célula 384 × 512, pés em y=472. Os pivôs locais estimados para cada quadro constam nos arquivos de entrega.
- DF97 é o braço-ímã de quatro quadros. No Godot, deixe a origem do Sprite2D nesse pivô local (60,256) e monte o Sprite2D num Node2D na junta registrada pelo quadro ativo. Gire o nó ao redor da junta em direção à mira, em coordenadas globais ou no espaço local do pai. Use um ponto filho na ponta do ímã para o rebite e o feixe; ajuste o recuo no quadro de disparo. Se o corpo for espelhado, espelhe também o ponto do ombro e confira a orientação do braço para a esquerda sem inverter a mira duas vezes.
- DF97_encaixe_oito_angulos.png mostra a referência de montagem. A extensão da arma e os pontos de disparo devem ser conferidos no jogo.

## Valores medidos
| Tela | Média Y′ | Terço superior Y′ |
|---|---:|---:|
| Dunas | 0.522 | 0.600 |
| Fábrica | 0.140 | 0.106 |
| Salão do Núcleo | 0.106 | 0.091 |
| Câmara da Forja | 0.149 | 0.099 |
| Laboratório Hélix | 0.085 | 0.081 |
| Verdâmia | 0.157 | 0.125 |

A meta documentada de cena é média 0,08–0,18 e terço superior ≤ 0,15. O céu diurno aprovado das Dunas eleva essas medidas. O acabamento das figuras reaproveita as fichas aprovadas e, na Forja, a carcaça modular introduz uma superfície central mais plana. Retomar a leitura da silhueta em comparação à ficha e medir as cenas no próprio jogo. 
As folhas originais do Esporângio e da Mariposa não retornaram dados pelo conector, e a referência do Rastejador não estava no workspace. Esses três comparativos visuais ficaram pendentes.

## SHA-256

- `DF_unidade_cenas.png` · `c4441acfbed741c245f373647c0c65ab02bd21c56ace45fbd15e990d7c451e5b`
- `DF_unidade_figuras.png` · `d362adaa81a9baa1429c294f372054d69d3537299c53ea37dcf5ff0bbd7c3c46`
