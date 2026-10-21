# Prompt: spritesheets animadas (ChatGPT)

Envie junto: a prancha **DAYMON SAGAN**, a prancha **LABORATÓRIO HÉLIX – INIMIGOS** e o GIF do Rastejador (se tiver).

---

Você vai criar spritesheets animadas para o jogo 2D WARP FRACTURE, que já está rodando na Godot. Anexei as pranchas de personagem e de inimigos. Elas são a referência OFICIAL: mantenha exatamente o mesmo design, as proporções, a paleta e o estilo (2D ilustrado, traço limpo, sombreamento suave, SEM pixel art, SEM 3D).

## Regras técnicas (valem para TODAS as imagens)
1. Uma animação por imagem. Tamanho da imagem: 1536 × 1024 px.
2. Grade invisível de 4 colunas × 2 linhas (8 células de 384 × 512 px). Os quadros seguem a ordem de leitura: linha de cima da esquerda para a direita, depois a linha de baixo. Se a animação tiver menos de 8 quadros, deixe as células finais vazias.
3. Fundo totalmente TRANSPARENTE (PNG). Se não for possível, use verde chapado #00FF00, uniforme, sem gradiente, sem textura e sem sombra.
4. Vista lateral, personagem olhando para a DIREITA em todos os quadros.
5. Mesma escala em todos os quadros e em todas as animações. O personagem fica centralizado na célula, e os pés tocam a MESMA linha de chão, a 40 px da borda de baixo da célula.
6. NADA além do personagem: sem texto, números, legendas, bordas de célula, linhas de grade, chão, sombra projetada ou cenário.
7. Nenhuma parte do personagem pode sair da própria célula ou invadir a vizinha.
8. Entre um quadro e outro, mude só a pose. Rosto, roupa, cores e tamanho continuam idênticos.

## Lista de animações (gere UMA por vez, na ordem; espere meu "ok" entre elas)

### Daymon Sagan (forma humana)
IMPORTANTE: nas animações de corpo (1 a 7), desenhe o Daymon SEM o braço da arma (o braço direito, mais próximo da câmera, deve ser omitido). No jogo, o braço com a arma é uma peça separada que gira para mirar no mouse.
1. **idle**: 6 quadros, respiração leve e jaleco balançando.
2. **run**: 8 quadros, ciclo de corrida completo (o último quadro emenda no primeiro).
3. **jump**: 3 quadros (impulso, subida, topo do pulo).
4. **fall**: 3 quadros, caindo, com o jaleco esvoaçando para cima.
5. **dash**: 4 quadros, esquiva rápida para frente, corpo inclinado, com rastro ciano leve.
6. **hurt**: 2 quadros, recuo ao levar dano.
7. **death**: 6 quadros, cai de joelhos e desaba, com as faixas ciano do traje apagando.
8. **braço + Estabilizador de Fase**: 1 quadro só, o braço esticado na horizontal segurando a arma, apontando para a direita. O ombro deve ficar exatamente no centro-esquerdo da célula (é o ponto de giro).
9. **disparo da arma**: 3 quadros de clarão ciano saindo do cano (só o efeito, sem o braço).

### Drone de Segurança
10. **fly**: 6 quadros, flutuando, com as asas laterais em movimento suave e a luz vermelha de baixo pulsando.
11. **charge**: 4 quadros, o olho vermelho acende cada vez mais forte antes do tiro.
12. **shoot**: 3 quadros, recuo do disparo com clarão vermelho no olho.
13. **hurt**: 2 quadros, sacudida com faíscas.
14. **death**: 6 quadros, o drone falha, solta faíscas e explode em pedaços.

### Rastejador de Fenda (mesmo design do GIF anexado)
15. **death**: 6 quadros, as patas se recolhem, os cristais roxos se apagam e o corpo se desfaz em fragmentos roxos.

### Efeitos (sem personagem, centralizados na célula)
16. **explosão do barril**: 8 quadros, laranja e vermelha, com fumaça escura no final.
17. **caixa quebrando**: 6 quadros, a caixa metálica azul se partindo em pedaços com brilho ciano.
18. **impacto do tiro**: 4 quadros, faísca ciano pequena.
19. **campo de energia** (loop): 6 quadros, a barreira roxa da prancha de cenário com os raios internos se movendo. O último quadro emenda no primeiro.

Ao terminar cada imagem, escreva a lista dos quadros (exemplo: "1–8 = run, quadro 1 = pé esquerdo no chão").

Comece pela animação 1 (Daymon – idle).
