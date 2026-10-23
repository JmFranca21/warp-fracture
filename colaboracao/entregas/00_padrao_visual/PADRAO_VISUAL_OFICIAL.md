# Warp Fracture — Padrão visual oficial (DA-01)

**Status:** DIRETRIZ ARTÍSTICA APROVADA PELO RESPONSÁVEL DO PROJETO em 23/10/2026.  
**Responsável:** ChatGPT — direção de arte.  
**Abrangência:** todos os personagens, inimigos, chefes, cenários, plataformas, props, UI, efeitos e sprites futuros.  
**Natureza:** diretriz de estilo, **não** aprovação de um asset específico.

## Regra central — continuidade de autoria

> **Toda arte nova deve parecer ter sido desenhada pelo mesmo artista que produziu as artes oficiais já utilizadas no Warp Fracture.** Não basta compartilhar a paleta: forma, proporções, contorno, volume, tratamento de luz/sombra, grau de detalhe e legibilidade devem ser consistentes com o conjunto atual.

As **artes do próprio projeto** são a fonte principal. O termo “inspirado em Hollow Knight” descreve apenas uma influência geral e **nunca** autoriza trocar a linguagem visual do jogo por arte realista, pintura conceitual cinematográfica ou outras estéticas externas.

## Referências prioritárias existentes

1. `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` — **padrão principal de desenho de personagens**: cabeça relativamente grande, anatomia compacta/simplificada, silhueta clara, poucos recortes internos, cabelo e roupa construídos com formas definidas e sombreamento econômico.
2. `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` — **padrão principal de objetos e ambientes**: geometria simples, materiais reconhecíveis, volumes definidos por poucas faces/sombras, iluminação pontual ciano/vermelho/roxo conforme função.
3. Demais arquivos da pasta `arte_original/00_Referencias_oficiais/` e artes **efetivamente usadas no jogo**, conforme `arte_original/USADAS_NO_JOGO.md`.
4. Uma nova ficha **só** entra no conjunto oficial após aprovação explícita do responsável do projeto.

**Prioridade de decisão:** referência oficial do projeto > ficha/arte nova aprovada pelo usuário > especificação de produção compatível > qualquer referência externa. Em caso de conflito, solicitar resolução antes de concluir a peça.

## Linguagem visual obrigatória

- **2D cartunizado, simplificado e minimalista**, com visual de jogo de ação/plataforma lateral.
- **Silhueta legível imediatamente**, inclusive reduzida à escala real em jogo.
- **Proporções estilizadas coerentes:** nunca alongar anatomia, aumentar dramaticamente escala ou tornar um humano realista apenas para transmitir ameaça.
- **Contornos e recortes limpos**, áreas de cor bem definidas, poucos detalhes internos.
- **Sombreamento econômico, de aspecto chapado/cel**, mas não uma mancha de cor uniforme: preservar facetas, dobras e áreas de luz/sombra que dão volume à roupa e aos objetos.
- **Paleta controlada e coesa com o universo.** Usar ciano/roxo como acentos energéticos, sem saturar todos os contornos ou cobrir a silhueta com brilhos.
- **Efeitos proporcionais:** partículas, aura, rachaduras e estática devem reforçar o desenho, não esconder anatomia ou torná-lo visualmente congestionado.
- **Estilo consistente em todos os ângulos e quadros** da mesma peça.

## O que é proibido como direção artística

- Realismo ou semirrealismo anatômico; arte conceitual cinematográfica/painterly.
- Personagens excessivamente alongados, musculosos, ornamentados ou hipertexturizados.
- Excesso de partículas, fragmentos, iluminação e efeitos que dificultem ler o personagem.
- Misturar tratamentos: por exemplo, uma roupa recolorida como massa chapada sobre um corpo com outra lógica de sombreamento.
- Confundir “sombrio”, “vilanesco” ou “épico” com **mudar o estilo gráfico**.
- Usar resultados de propostas rejeitadas como referências visuais para novos assets.

## Diretrizes para personagens sombrios e vilões

Construir ameaça **dentro do mesmo traço cartunizado**: olhos/rosto, gesto, postura, silhueta, áreas de vazio, paleta escura e efeitos contidos. O personagem pode ser maligno sem virar monstro realista e sem perder as proporções do universo.

### A0 — Eco (ainda pendente de aprovação específica)

- Conserva parentesco visual com Daymon: **mesma linguagem de cabeça, cabelo, tronco e membros**.
- Pode usar jaleco/forma espectral em roxo muito escuro, integrado ao **mesmo sombreamento** do corpo, e aura negra que não encubra a silhueta.
- O rosto pode ter olhos mais ameaçadores, sem excessos anatômicos; fenda/rachadura ciano como detalhe legível, não brilho generalizado.
- **Nenhuma das imagens de tentativa anteriormente rejeitadas é referência aprovada.** O Eco não está aprovado; o pedido `A0_ficha_eco` permanece aberto.

## Verificação obrigatória antes de apresentar uma nova arte

1. **Comparar lado a lado com as referências oficiais**, não com exemplos genéricos de internet.
2. Verificar proporção de cabeça/corpo, silhueta, número de tons por superfície, acabamento das roupas/objetos e quantidade de efeitos.
3. Checar que a peça parece pertencer à **mesma prancha de personagens/objetos** do jogo.
4. Visualizar reduzida à **escala aproximada de jogo** e conferir leitura da silhueta.
5. Quando for sprite/objeto, verificar dimensões, transparência, grade, direção, alinhamento, apoios e recorte conforme `docs/GUIA_PROXIMOS_PASSOS_E_ASSETS.md`.
6. **Apresentar ao usuário para aprovação explícita antes do upload do asset.** Se reprovado, não publicar nem considerar como nova referência.
7. Após aprovação, entregar asset + documentação em `colaboracao/entregas/<ID>/`, respeitando `colaboracao/PROTOCOLO.md`, e fornecer um prompt curto para o agente de desenvolvimento ler a entrega no GitHub.

## Separação de responsabilidades

- **ChatGPT:** direção de arte, criação, revisão visual e documentação de assets.
- **Responsável do jogo:** aprovação estética final.
- **Claude Code:** código, integração na Godot, testes e builds.

**Observação:** este documento estabelece o padrão visual; não altera código, não aprova arte individual e não muda o estado dos pedidos existentes.
