# Pedido PT00: ficha dos portais

**Lote 1: fichas de referência.** Fase 2 (Deserto de Ferrugem) e passagem entre fases.
**Estado:** SUSPENSO até o João Marcelo aprovar a decisão correspondente; depois, ABERTO.
**Depende de:** [D05](../decisoes/D05_portais.md).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 11/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), que prevalece sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez** para gerar a peça.

---

## PT00: Ficha dos portais: Arco de Dobra, Fenda e Receptáculo

````markdown
**[PT00] Ficha dos portais: Arco de Dobra, Fenda e Receptáculo**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** PT00
- **Arquivo(s):** `PT00_ficha_portais.png`
- **Finalidade no jogo:** referência oficial da linguagem dos portais em todas as fases: o Arco de Dobra do Laboratório Hélix (hub), a Fenda que se abre nos universos e o Receptáculo da Máquina, onde os fragmentos são instalados. As peças PT10–PT23 seguirão esta ficha. Não entra no jogo
- **Referências obrigatórias do repositório:** `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/VD_verdamia/VD_fragmento.png` (fragmento da Máquina de Dobra); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/decisoes/D05_portais.md` (regras de leitura: cor, glifo e movimento).
- **Escala:** D = 400 px. **Arco:** 1,7 D (680 px) de largura × 2,3 D (920 px) de altura, base de 2,0 D (800 px) de largura e **abertura útil de 1,0 D × 1,5 D (400 × 600 px)**. **Fenda:** oval de 1,1 D × 1,6 D. **Receptáculo:** 1,2 D de altura × 1,0 D de largura
- **Orientação:** todas as peças **de frente**
- **Paleta:** metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), âmbar #F2B24C (Deserto).
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido.
- **Fundo:** azul-marinho escuro chapado, como as outras fichas.
- **Âncora e apoio:** o Arco e o Receptáculo apoiam a base plana no chão. A Fenda nasce de uma rachadura no chão, com lascas de cristal, e nunca flutua solta
- **Conteúdo e desenho:** O portal é a máquina que Daymon construiu (Arco de Dobra) e o rasgo que um fragmento abre em outro universo (Fenda). Os dois compartilham a mesma **membrana** interna, clara, translúcida e oval. Monte a ficha com: (1) **Arco de Dobra** em 3 estados lado a lado: **bloqueado** (diafragma fechado: 8 lâminas metálicas formam um disco que tapa a abertura; glifo apagado), **calibrando** (lâminas meio recolhidas, membrana cortada e instável) e **aberto** (lâminas recolhidas dentro do anel, membrana inteira, partículas sendo puxadas para o centro). O arco tem anel grosso de metal do Hélix, base larga em degrau, dois pilares na frente e, no topo, um **painel de destino** com três encaixes de glifo; (2) os **três glifos de destino**, grandes e simples: hexágono com ponto central (Hélix, ciano #2EC7E6), folha-cogumelo com chapéu sobre um caule (Verdâmia, verde-lima #A6E05A) e engrenagem de seis dentes (Deserto, âmbar #F2B24C); (3) a **membrana** tingida nas três cores, com setas pequenas indicando o movimento de cada destino: pulsos para dentro (Hélix), espiral anti-horária (Verdâmia) e ondulação horizontal de calor (Deserto); (4) a **Fenda** em 3 estados: rachadura dormente (linha fina vertical saindo do chão), abrindo e aberta (oval com bordas rasgadas e lascas de cristal roxo-ciano, apoiada numa base de chão rachado); (5) o **Receptáculo da Máquina**: pedestal de laboratório com **quatro soquetes** em losango, um deles com o fragmento encaixado, e um cabo grosso saindo pela direita (no jogo, o cabo vai até o Arco); (6) **escala**: Daymon (400 px), o Autômato (420 px) e o Lince ao lado do Arco, mostrando que a abertura útil comporta os três; (7) paleta. Leitura: **fechado = parado; tremendo = instável; partículas para dentro = pode atravessar**.
- **Antes de apresentar, confira:** lado a lado com a Prancha de Elementos do Laboratório: mesmo metal, contorno e luz; os três glifos se distinguem pela forma, mesmo em tons de cinza; a abertura útil de 400 × 600 px comporta Daymon, o Autômato e o Lince; a Fenda tem apoio visível no chão.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/PT00/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha PT00 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````
