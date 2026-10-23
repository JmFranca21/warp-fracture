# A3 — Eco: avanço flutuante agressivo

**Estado:** ENTREGUE para revisão do Claude; não integrado.
**Aprovação artística:** João Marcelo respondeu “aprovo” em 23/10/2026 à prévia verde da pose de perseguição. A montagem preserva esses seis desenhos, sem redesenhar membros, rosto, cabelo ou roupa.
**Referências:** DA-01, ficha A0 aprovada e escala da A2 integrada.

## Arquivo e integridade
- `A3_eco_avanco.png`: PNG RGBA, 1536 × 1024 px.
- Grade 4 × 2, células 384 × 512; seis quadros em ordem de leitura e duas células finais totalmente transparentes.
- 498.937 bytes.
- SHA-256: `3156a4698424b8ff79d6d6d6471dd0005ec994aebcbd5fd73f92dfbae9013867`.
- Commit do PNG: `3d7c12cca0166dcb67bb0ed3b0ff92f949756140`.
- Verificação após publicação: arquivo lido pelo Git em `origin/main`, com SHA-256 idêntico ao arquivo final local.

## Desenho e montagem
Eco avança pelo ar, olhando para a direita, com braços e pernas arrastados para trás e jaleco ondulando. Foram mantidos os olhos brancos, cabelo roxo, fissura ciano e garras da prévia aprovada.

Montagem: remoção do fundo verde, limpeza do verde nas bordas inclusive após reamostragem, fator proporcional único de 0,8 nos seis desenhos de origem e registro horizontal pelos olhos. A redução foi uniforme, sem normalizar a altura projetada de uma pose inclinada para 380 px.

A escala foi comparada à A2 pelo tamanho da cabeça: a distância aproximada entre o topo visível e o olho é 76 px na A3 contra 78 px no quadro base da A2. Isso é uma aproximação visual; a escala anatômica completa deve ser confirmada na transição A2→A3 em Godot.

## Quadros e medições
Reprodução proposta: 12 fps, loop.

| Quadro | Fase | Último pixel inferior local | Centro mediano do olho (x, y) |
|---|---|---|---|
| 1 | Pose base de perseguição | 392 | 259; 206 |
| 2 | Subida, jaleco para cima | 389 | 259; 204 |
| 3 | Topo do ciclo, jaleco elevado | 386 | 258; 201 |
| 4 | Retorno à base | 392 | 259; 207 |
| 5 | Descida, variação dos braços e jaleco | 395 | 260; 212 |
| 6 | Fundo do ciclo, retorno ao primeiro | 398 | 260; 216,5 |

Os rótulos identificam a intenção das poses aprovadas; os microgestos não foram redesenhados na montagem.

## Verificações
- Dimensões, modo RGBA e contagem de células: verificados.
- Células 7 e 8 sem nenhum pixel visível.
- Nenhuma figura toca as bordas da própria célula ou invade outra.
- Linha inferior y392 na pose base, com oscilação de ±6 px.
- Registro horizontal dos olhos entre x258 e x260; escala proporcional constante.
- Zero pixels fortemente dominados por verde com alfa >16 no teste de bordas (G > R+10 e G > B+10).
- Silhueta conferida em imagem reduzida sobre fundo escuro.

## Ressalvas para revisão
1. O pedido combina uma âncora de tronco imóvel em (200,280) com oscilação vertical do tronco. A montagem prioriza a escala constante, registro horizontal da cabeça e linha de flutuação. A âncora anatômica exata não foi validada; não tratar esta entrega como uma animação com esqueleto.
2. A altura projetada dos desenhos inclinados é 257–263 px, menor que os 380 px da pose vertical da A2. Não esticar verticalmente a sheet para igualar essas alturas; conferir a escala de cabeça e corpo na importação.
3. Os olhos sobem cerca de 10,5 px na passagem 6→1, enquanto a linha inferior sobe 6 px. Conferir essa variação de cabeça/jaleco a 12 fps; pode precisar de refinamento se aparecer como salto.
4. As formas e contagem de pontas do jaleco, fragmentos e microgestos são os da prévia aprovada; não se garante correspondência exata à descrição quadro a quadro do pedido.
5. A inclinação é a da pose aprovada, sem certificação geométrica de 35°.
6. Despill executado, mas conferir contornos em fundo claro e escuro no jogo.

## Próximo passo do desenvolvimento
Revisar a A3 a 12 fps, sobretudo estabilidade do tronco, transição 6→1, escala com a A2 e transição float→avanço. Registrar em `colaboracao/revisoes/A3_eco_avanco.md`. Se aprovado tecnicamente, integrar conforme o protocolo.

Somente esta entrega e o estado de A3 no STATUS.md foram alterados pela direção de arte.
