# Correções de enquadramento — Lince

Preservar os originais. Versões `_v2` são correções geradas a partir da folha original e da D0; não foram editadas por script. O manifesto seleciona a versão numerada mais recente. Conferir as medidas dessa versão antes de importar.

## D_lince_wall_v2

Prompt de correção: preservar identidade e cores; três poses pequenas de escorregar na parede na primeira linha da grade invisível 4×2, tela 1536×1024, células 384×512. Pose 1 contida em x48–350/y70–466, pose 2 em x432–734/y70–466, pose 3 em x816–1118/y70–466. Patas voltadas à direita param em x350, 734 e 1118. Cauda e orelhas inteiras dentro dos retângulos. Não distribuir três poses pela largura inteira. Quarta coluna e linha inferior completamente transparentes. Sem parede, grade ou texto. Remover névoa de fundo cinza/branca/azul; alpha zero fora da silhueta, exceto brilho pequeno da lanterna.

## D_lince_claw_v2

Prompt de correção: preservar as quatro poses e a ordem do ataque; tela 1536×1024, grade invisível 4×2. Centros x192,576,960,1344. Silhueta, garras, arco e lanterna dentro de x24–360,408–744,792–1128,1176–1512/y80–472. Reduzir todas as poses igualmente para caber; o terceiro arco não pode cruzar x1152. Linha inferior completamente vazia. Remover névoa cinza de fundo. Sem chão, sombras, grade ou texto.

## D_lince_flash_v2

Prompt de correção: preservar as seis fases do clarão e a identidade do Lince; tela 1536×1024, grade invisível 4×2. Centros da primeira linha x192,576,960,1344 e da segunda linha x192,576. Toda silhueta e luz ficam a pelo menos 24 px da borda da célula. Clarão máximo do quadro 4 é um anel âmbar de até 300 px, contido em x1176–1512/y100–450, sem disco opaco ou luz cruzando células. Alpha zero fora do personagem e anel. Remover névoa ambiente cinza/azul. Últimas duas células vazias. Sem texto, grade, chão ou sombra.
