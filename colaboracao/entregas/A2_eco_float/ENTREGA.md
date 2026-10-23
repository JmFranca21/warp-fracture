# A2 — Eco pairando (loop)

**Estado:** ENTREGUE para revisão técnica do Claude; ainda não integrado.
**Aprovação artística:** João Marcelo respondeu “aprovo” em 23/10/2026 à primeira versão com fundo verde, autorizando usá-la como base para finalizar a montagem técnica. A aprovação é do desenho e da pose; a validação em Godot continua pendente.

## Arquivo
- `A2_eco_float.png`: PNG RGBA, 1536 × 1024 px, fundo transparente.
- Grade 4 × 2, células 384 × 512 px; seis quadros em ordem de leitura. Células 7 e 8 totalmente transparentes.
- SHA-256: `5fd47c23d0513182e030a17c4ba6b7ac26298007c7892682785f45bdb0765a95`.
- Tamanho: 575.340 bytes.
- Commit do PNG: `a240947e42b8002f1a5f71f99b67770e25031abe`.
- Hash conferido novamente lendo o arquivo publicado pelo Git após atualizar `origin/main`.

## Direção artística e montagem
Referências: DA-01, ficha A0 aprovada e spritesheets do Daymon usadas no jogo. Todos os quadros olham para a direita. Foi preservada a arte da versão verde aprovada; as novas gerações com névoa não foram usadas como fonte.

Montagem técnica: recorte de cada quadro, remoção do verde e descontaminação de bordas, normalização proporcional para 380 px de altura visível e posicionamento em células regulares. O eixo horizontal foi estimado pela região do peito e centralizado em aproximadamente x192. Não houve redesenho de cabelo, roupa, rosto ou membros durante a montagem.

## Quadros
As descrições abaixo identificam os quadros de origem aprovados. Os deslocamentos verticais foram aplicados de forma exata; movimentos de roupa e mãos são os presentes no desenho gerado.

| Quadro | Posição no ciclo | Último pixel inferior na célula |
|---|---|---|
| 1 | Pose base pairando | y392 |
| 2 | Subida de 4 px | y388 |
| 3 | Topo, 8 px acima da base | y384 |
| 4 | Retorno, 4 px acima da base | y388 |
| 5 | Altura base | y392 |
| 6 | Fundo, 4 px abaixo da base | y396 |

Reprodução proposta: 8 quadros/s, loop. Quadro 1 é a base para a continuidade com A1 e A5.

## Verificações e ressalvas
- Dimensões, modo RGBA, seis células ocupadas e duas vazias: verificados.
- Nenhum desenho toca a borda ou invade outra célula; fundo externo com alfa zero.
- Linha de flutuação e oscilação ±8 px: conferidas por limites do alfa.
- Silhueta inspecionada em imagem reduzida.
- Altura normalizada em 380 px, próxima dos cerca de 400 px pedidos. Essa redução permite manter margem superior e a linha de flutuação sem cortar o cabelo.
- A região do peito é uma estimativa para centralização; não é um esqueleto ou pivô anatômico validado.
- Não se garante correspondência exata dos microgestos pedidos (fechamento dos dedos, pulsação ciano no quadro 3 e expansão de aura). Foram preservados os seis desenhos aprovados; a névoa difusa foi removida.
- Continuidade perceptual do loop, variações de cabelo/jaleco entre quadros e escala relativa ao Daymon precisam da revisão de Claude em Godot. A montagem não constitui aprovação de integração.

## Revisão solicitada
Claude: conferir a animação a 8 fps, a estabilidade do eixo do corpo, a transição 6→1, os contornos após chroma key e a escala em jogo. Registrar o resultado em `colaboracao/revisoes/A2_eco_float.md` conforme o protocolo. Código e outros assets não foram alterados.
