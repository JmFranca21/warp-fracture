# Warp Fracture — Assinatura de estilo (DA-04)

**Status:** PROPOSTA do Claude (24/11/2026), para revisão do ChatGPT e aprovação do João.
**Vale junto com:** a DA-01 (estilo), a DA-02 (figuras) e a DA-03 (cena: valores e estrutura).

## Por que existe

O João avaliou, depois da DF200, da DF201 e da DF205 integradas, que o Deserto ainda não parece do mesmo jogo: "o jogo como um todo deve seguir um mesmo estilo de arte, como se fosse tudo feito por um único artista".

A DA-03 resolveu os **valores**: o Deserto agora passa na régua de luma, contraste e estrutura. O que continua diferente é a **linguagem gráfica**, isto é, como cada forma é desenhada e pintada. Esta diretriz fixa essa linguagem, a partir do que o Laboratório Hélix e Verdâmia têm em comum, e vale para tudo que vier depois, inclusive a refação de Nivária.

Comparação no jogo: `docs/auditoria_cena/estilo_referencia_e_desvios.jpg`. Em cima, as referências; embaixo, os desvios.

## O que o Laboratório e Verdâmia têm em comum

1. **Formas chapadas com sombreamento em degraus.** Cada material tem 2 ou 3 tons, com a fronteira entre eles nítida: luz, meio-tom e sombra. Rochas e troncos são facetados em planos, e o metal é feito de blocos com chanfro. Não há textura pintada, ruído, hachura nem pincel aparente.
2. **Sem traço de tinta no cenário.** O cenário se separa por valor e cor, nunca por linha preta ou marrom. O contorno escuro frio (DA-02) é das figuras: personagens, inimigos e objetos de interação.
3. **Detalhe que cresce do fundo para a frente.**
   - O fundo distante é silhueta de 1–2 tons, com névoa.
   - O fundo intermediário tem 2 tons e poucos recortes.
   - O plano do jogo tem 3 tons, chanfros, rebites e plantas.
   - Nenhum fundo tem mais detalhe que o chão onde o jogador pisa.
4. **Uma cor-assinatura saturada por universo**, num conjunto fixo de lugares:
   - a **borda de apoio** do terreno: luz ciano sob as plataformas do Laboratório, musgo verde-limão no topo do chão de Verdâmia;
   - as **luzes**, com halo suave;
   - os **elementos vivos** ou ativos.

   O resto da tela fica na família escura do universo. A cor-assinatura é o que faz a tela "acender" onde se joga.
5. **Arestas limpas e formas de cartum robusto.** Silhuetas legíveis em miniatura, cantos chanfrados ou arredondados, proporções levemente exageradas, curvas suaves e nada de contorno serrilhado ou rasgado.
6. **Atmosfera só por gradiente amplo.** Céu, névoa e halos de luz podem ter gradiente; as formas, não.
7. **Mesma resolução aparente.** A arte de cenário aparece entre 1 e 2 px de arquivo por px de tela. Peças pintadas muito maiores, e depois reduzidas, ganham detalhe fino que as outras não têm.

## Onde o Deserto foge hoje

| Peça | Desvio | Regra |
|---|---|---|
| DF201 (camadas intermediárias) | Ilustração com traço escuro, hachura e detalhe vazado fino: parece gravura. | 2, 3 e 7 |
| DF205 (terreno) | O facetado está no caminho certo, mas a borda de apoio não tem a cor-assinatura e o topo se mistura ao fundo. | 4 |
| DF200 (céu) | Compatível: é atmosfera, só gradiente. | — |
| v0.8 (paredes DF22–DF24, esteira, adereços DF30–DF39, guindaste) | Cartum chapado, mas claro e saturado demais e sem planos. Ao lado da arte nova, parece de outro artista. | 1 e 3; valores pela DA-03 |
| Paleta da DF00 v2 | Só define a família escura. O âmbar ficou restrito a lâmpadas, então a tela não tem cor-assinatura. | 4 |

## Proposta para o Deserto

- **Cor-assinatura:** **âmbar incandescente** (`#EFAA55`, com um tom mais quente para o miolo das brasas), usado:
  - na **borda de apoio**: na areia, a crista do topo pega a luz baixa do sol e brilha em âmbar fino; na chapa, um friso de metal aquecido;
  - nas **luzes**: lâmpadas, fornalhas e fendas de calor;
  - nas **máquinas ativas**.

  O ciano continua só no gancho e no Traje Âncora, e o vermelho só no perigo.
- **Família escura:** ferrugem escura e azul-marinho, como na DF00 v2.

## Como garantir "um único artista"

1. **Quadro-chave de estilo antes de qualquer peça nova.** Uma tela de 1.280 × 720 do Deserto, pintada na linguagem acima, que depois de aprovada vira a referência obrigatória de todo pedido do Deserto, ao lado de recortes do Laboratório e de Verdâmia. O mesmo vale para Nivária.
2. **Todo pedido de arte anexa a prancha de referência de estilo**, `estilo_referencia_e_desvios.jpg` e, depois, os quadros-chave aprovados, e cita a DA-04.
3. **Conferência no jogo:** além dos números da DA-03, um recorte 2× de cada peça ao lado dos recortes 2× do Laboratório e de Verdâmia. Se uma pessoa não consegue dizer qual veio de qual fase pelo jeito de desenhar, passa.
4. **Refação, depois do quadro-chave aprovado:**
   - DF201 redesenhada na linguagem chapada (mesmas medidas e enquadramento: o código não muda);
   - DF205 com a borda de apoio em âmbar e limpeza das faces;
   - as peças v0.8 que ficam (paredes, esteira, adereços) reajustadas ou substituídas nos pedidos seguintes (DF202, DF204 e DF206–DF210).
