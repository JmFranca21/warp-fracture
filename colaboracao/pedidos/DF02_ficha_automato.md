# Pedido DF02: ficha do Autômato

**Lote 1: fichas de referência.** Fase 2 (Deserto de Ferrugem) e passagem entre fases.
**Estado:** SUSPENSO até o João Marcelo aprovar a decisão correspondente; depois, ABERTO.
**Depende de:** [D03](../decisoes/D03_forma_deserto.md).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 11/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), que prevalece sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez** para gerar a peça.

---

## DF02: Ficha de personagem: Autômato (forma de Daymon no Deserto)

````markdown
**[DF02] Ficha de personagem: Autômato (forma de Daymon no Deserto)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF02
- **Arquivo(s):** `DF02_ficha_automato.png`
- **Finalidade no jogo:** referência oficial da forma de Daymon no Deserto de Ferrugem. Ela define a silhueta, as proporções, as cores e o braço-ímã que todas as animações do Autômato (DF87–DF99) vão seguir. Não entra no jogo
- **Referências obrigatórias do repositório:** `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem); `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF01/DF01_ficha_inimigos_deserto.png` (Robô e Drone do Deserto, escala D = 400 px); `colaboracao/entregas/DF57/DF57_ponto_gancho.png` (argola com anel ciano); `colaboracao/entregas/VD_verdamia/D0_lince.png` (forma de Verdâmia; o Autômato precisa ser diferente dela); `arte_original/00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png` (traço de robôs).
- **Escala:** D = 400 px é a altura de Daymon. O Autômato mede **1,05 D (420 px) de altura e 0,8 D (320 px) de largura**, sem contar o braço
- **Orientação:** vista frontal e vista lateral olhando para a **direita**
- **Paleta:** cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido (títulos e medidas), no mesmo layout da DF01.
- **Fundo:** azul-marinho escuro chapado, como as outras fichas (DF01, A0).
- **Âncora e apoio:** pés apoiados numa linha de chão comum em todas as vistas. Marque com uma cruz pequena o **ombro do braço-ímã** na vista lateral: o braço gira em torno desse ponto no jogo
- **Conteúdo e desenho:** Daymon atravessou o portal e o Traje Âncora o revestiu com placas de sucata magnetizadas do deserto. Ele virou uma máquina **amigável e pesada**, claramente o herói, nunca parecido com os robôs inimigos (que são escuros, quadrados e de olho âmbar). Monte a ficha com: (1) **vista frontal** e (2) **vista lateral** de corpo inteiro; (3) o **braço-ímã** sozinho, de lado, apontando para a direita, com o eletroímã em forma de ferradura na ponta e a faixa ciano; (4) um detalhe do **visor**; (5) uma pose de ação: braço estendido, soltando um feixe ciano curto; (6) **paleta**; (7) faixa de escala, com Daymon humano em silhueta (400 px) ao lado do Autômato (420 px), como na DF01. **Corpo:** cúpula de cabeça grande e arredondada, na mesma proporção cabeça/corpo de Daymon. Visor de vidro claro que mostra **os olhos e a franja de Daymon** em formas simples. Tronco em barril, com placas rebitadas e a **faixa ciano diagonal** do Traje Âncora atravessando o peito. Pernas curtas e grossas, com pés largos e **duas rodinhas no calcanhar** (usadas no Arranque). O braço esquerdo, de trás, é curto e simples. O **braço da frente (direito) é o braço-ímã**, separado do corpo na lateral. **Leitura:** pesado, lento e confiável. A silhueta precisa ser bem diferente do Lince-Vagalume (D0_lince), que é baixo, rápido e felino.
- **Antes de apresentar, confira:** vistas lado a lado com a ficha de Daymon: mesma linguagem de cabeça, traço e sombreamento; reduzido a ~90 px de altura, o Autômato ainda se lê como Daymon (faixa ciano e olhos no visor) e se distingue do Robô da DF01; medidas de 420 × 320 px na faixa de escala; nenhum âmbar ou vermelho no rosto.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF02/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF02 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````
