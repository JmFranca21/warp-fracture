# Pedido DF03: ficha da Forja-Mãe

**Lote 1: fichas de referência.** Fase 2 (Deserto de Ferrugem) e passagem entre fases.
**Estado:** SUSPENSO até o João Marcelo aprovar a decisão correspondente; depois, ABERTO.
**Depende de:** [D04](../decisoes/D04_chefe_deserto.md).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 11/11/2026
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), que prevalece sobre este pedido.

Cada bloco abaixo é um prompt completo. Copie **um por vez** para gerar a peça.

---

## DF03: Ficha do chefe: Forja-Mãe (e esquema da Câmara da Forja)

````markdown
**[DF03] Ficha do chefe: Forja-Mãe (e esquema da Câmara da Forja)**

Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.

- **ID:** DF03
- **Arquivo(s):** `DF03_ficha_forja_mae.png`
- **Finalidade no jogo:** referência oficial do chefe do Deserto e da sua arena. Define a silhueta, a escala e as peças separadas (corpo, lente, peito, braços e martelos) que o código anima. As peças finais (DF100–DF112) seguirão esta ficha. Não entra no jogo
- **Referências obrigatórias do repositório:** `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto); `colaboracao/entregas/DF01/DF01_ficha_inimigos_deserto.png` (Robô e Drone do Deserto, escala D = 400 px); `colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças); `colaboracao/entregas/DF57/DF57_ponto_gancho.png` (argola com anel ciano); `colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo); `colaboracao/entregas/VD_verdamia/VD_fragmento.png` (fragmento da Máquina de Dobra); `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas); `arte_original/00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png` (traço de robôs).
- **Escala:** D = 400 px. Corpo de **3,5 D (1400 px) de altura e 3 D (1200 px) de largura**. Cada braço-guindaste tem cerca de 2 D, do carrinho ao martelo. Cabeça do martelo: **1,4 D (560 px) de largura × 0,6 D (240 px) de altura**
- **Orientação:** o corpo é visto **de frente** (está embutido na parede do fundo). Os braços aparecem de frente, pendurados num trilho de teto
- **Paleta:** ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6.
- **Dimensões e formato:** PNG de 1536 × 1024 px, ficha com texto permitido (títulos, medidas e setas).
- **Fundo:** azul-marinho escuro chapado, como as outras fichas.
- **Âncora e apoio:** o corpo se apoia no chão (base plana da fornalha) e na parede do fundo (flanges parafusadas nas laterais). Os braços pendem de carrinhos com rodinhas encaixadas num trilho de teto. **Nada flutua**
- **Conteúdo e desenho:** A Forja-Mãe é a IA da fábrica autônoma. O fragmento da Máquina de Dobra virou o núcleo dela. É uma **fábrica viva, pesada e paciente**, sem rosto humano. Monte a ficha com: (1) **corpo inteiro** de frente: forno de ferro com ombros largos, uma **grade de fornalha** brilhando embaixo, uma **única lente-olho** grande e redonda no alto, com íris mecânica de lâminas, e, no peito, a **câmara do núcleo** fechada por **três placas blindadas**, com o fragmento ciano visível pelas frestas; nos ombros, duas **escotilhas** fechadas, de onde saem drones; (2) **um braço-guindaste** de frente: carrinho no trilho, dois segmentos articulados com pistões, **cabeça de martelo** com faixas de perigo vermelho e cinza na face de baixo (como a prensa DF50) e, em cima do martelo, uma **placa de âncora ciano** redonda, no mesmo estilo da argola DF57; mostre também o **núcleo do pistão** laranja na junta de cima do martelo; (3) **lente em 4 estados**, pequenos: repouso âmbar, aviso âmbar forte, mira vermelha (íris fechada em um ponto) e apagada; (4) **peito em 2 estados**: fechado, e com as três placas arrancadas, mostrando o fragmento; (5) **esquema da arena**, pequeno, em vista lateral: sala de 1500 × 760 px no jogo, corpo no centro da parede do fundo, trilho no teto com os dois braços, faixa de esteira no centro do chão, duas âncoras de teto e duas válvulas nas laterais, porta à esquerda (entrada) e porta à direita (saída); (6) faixa de escala com Daymon humano em silhueta (400 px) e o Autômato (420 px) diante do corpo; (7) paleta. Ela precisa parecer **feita da mesma fábrica** das prensas, portas e robôs do Deserto (DF00, DF01, DF38, DF50). A ameaça vem do tamanho, da lente e da grade, e não de detalhe excessivo (DA-01).
- **Antes de apresentar, confira:** lado a lado com DF00, DF01 e DF50: mesmos materiais, rebites, faixas de perigo e sombreamento; corpo, braço e martelo desenhados como peças separáveis (o código os move separadamente); a placa de âncora ciano é o elemento mais fácil de achar em cima do martelo; reduzida à escala do jogo (corpo com ~300 px de altura), a lente e as placas do peito continuam legíveis.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em `colaboracao/entregas/DF03/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não conseguiu cumprir. Mude a linha DF03 do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.
````
