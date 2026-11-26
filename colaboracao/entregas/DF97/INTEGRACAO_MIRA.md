# DF97 · Montagem do braço-ímã

As sete folhas DF90–DF96 têm o corpo sem o braço-ímã. O outro braço integra o corpo. DF97 fornece o braço que mira, com 4 quadros e pivô no ombro. As células são de 384 × 512 px. As posições do JSON são locais à célula, em ordem de leitura.

No Sprite2D do corpo, converta o ombro do quadro ativo para a posição local do sprite. Aplique deslocamento, escala e espelhamento usados pelo corpo. Posicione nesse ponto um Node2D para a mira. Coloque nele o Sprite2D do DF97 alinhado pela origem (60, 256) da célula, com o braço de repouso voltado para +X. Rotacione o Node2D em direção à mira e atualize o ponto de saída a partir da ponta do braço. Preserve o mesmo pivô na troca de estado e confira no jogo o recuo, os dois lados e os oito ângulos da prancha.

## SHA-256

- DF97_ancoras.json · bfea3b1577f58db91b1636a3a947b69aee3c1435e3231a55a8429c41158469f4
- DF97_mira_oito_direcoes.png · d3fdd0bbc3843ebacca25ed36cae03a5c3670350cb4912166f867f63d043d524
