# Warp Fracture — Receita de cena (DA-03)

**Status:** APROVADA pelo João Marcelo em 24/11/2026. Vale junto com a [DA-01](PADRAO_VISUAL_OFICIAL.md) (estilo) e a [DA-02](DA-02_CONSISTENCIA.md) (personagens, inimigos e objetos).
**Histórico:** proposta do Claude a partir da avaliação do João (Laboratório e Verdâmia no padrão; Deserto e Nivária abaixo). Revisada pelo ChatGPT em 24/11/2026: concordou com o diagnóstico, ajustou C1 e C4–C7, manteve os números de C2 e C3 com teste mais rigoroso, tirou C8 da aprovação de arte e acrescentou três checagens e o protocolo de medição. Consolidada pelo Claude, com os limites recalibrados ponto a ponto nas fases de referência.
**Ordem aprovada pelo João:** fechar a receita, validar em Nivária e só então aplicar ao Deserto.

## Por que existe

A DA-02 resolveu a consistência das figuras, mas não a da **cena**: como fundo, chão, decoração, primeiro plano e luz se juntam numa tela. Esta régua mede o Laboratório Hélix e Verdâmia e transforma o que eles fazem em regra.

## Medição (protocolo fixo)

- **Captura no Godot:** `tools/scene_metrics.gd -- out=<pasta>`. Janela 1.280 × 720, zoom 1,1, câmera no alvo normal do jogador, HUD escondido (e a faixa de 130 px do alto fora da conta). Quatro pontos fixos por fase (lista `SPOTS` no script). Em cada ponto, quatro variantes **no mesmo quadro** (árvore pausada): tudo; sem primeiro plano; sem o jogador; só o jogador sobre preto (máscara exata).
- **Cálculo:** `tools/scene_metrics.py <pasta>`. Luma sRGB Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′ (canais de 0 a 1). Bordas: magnitude de Sobel da luma > 0,25. Área lisa: blocos de 40 px com menos de 0,4% de bordas e desvio de luma < 0,015. Contraste do jogador: luma média do personagem (máscara exata, do joelho para cima) menos a do anel de 2 a 8 px em volta no quadro sem ele. Separação da silhueta: fração da borda do personagem em que dentro e fora (janelas de 9 px) diferem ≥ 0,10 de luma, como na R6 da DA-02.
- **Publicação:** C2 e C3 **por ponto**, além da média. Os limites valem nos quatro pontos de jogo normal. Uma exceção intencional (um trecho calmo, a iluminação de uma arena) identifica a tela e mostra a leitura do jogador e dos perigos.

## Referências medidas (24/11/2026, por ponto)

| Ponto | Luma | Terço de cima | Contraste do jogador | Separação da silhueta | Bordas | Área lisa |
| --- | --- | --- | --- | --- | --- | --- |
| Laboratório 0–3 | 0,087–0,099 | 0,078–0,113 | +0,23 a +0,37 | 0,67–0,76 | 0,042–0,058 | 0,48–0,53 (0,63 na Galeria do Portal, trecho calmo) |
| Verdâmia 0–3 | 0,158–0,177 | 0,135–0,141 | +0,11 a +0,21 | 0,71–0,72 | 0,076–0,108 | 0,14–0,22 |
| Deserto 0–3 | **0,129–0,566** | **0,114–0,673** | **−0,36** a +0,24 | 0,74–0,89 | 0,051–0,106 | 0,20–0,47 |
| Nivária v0.9, antes da composição | 0,158 (média) | 0,124 | — | — | **0,038** | **0,69** |
| Nivária com a composição provisória | 0,143–0,168 | 0,117–0,148 | +0,24 a +0,33 | 0,69–0,80 | 0,040–0,059 | 0,43–0,59 |

Leitura: o Deserto é claro demais (as Dunas chegam a 0,57 de luma e o Daymon fica mais escuro que o fundo) e a borda da silhueta se separa por cor, não por valor. Nivária v0.9 tinha bons valores e faltava estrutura; com a composição provisória passa em C2 e C3 nos quatro pontos, mas perto dos limites de estrutura. Só a arte do lote 2 leva a cena ao acabamento das referências.

## As regras

### C1. Cinco funções visuais em cada zona
- Cada zona tem as cinco funções: **fundo distante**, **fundo intermediário**, **estrutura de fundo** no plano do jogo (paredes, colunas, troncos; numa área aberta, uma massa de média distância), **plano do jogo** (terreno, objetos e decoração) e **primeiro plano** escuro na borda de baixo; mais **luzes e partículas**.
- Em **cada tela**: fundo contínuo (nunca termina em vazio), uma referência de escala e o plano jogável legível.
- Camadas pintadas juntas podem cumprir mais de uma função. Os fatores de parallax (0,02–0,15; 0,25–0,5; 1,0–1,2) são pontos de partida.
- O primeiro plano pode sumir num salto crítico ou numa arena. A interface fica acima dos efeitos, e os efeitos nunca escondem perigos nem interações.

### C2. Valores
- Luma média da tela **0,08–0,18**; terço de cima **≤ 0,15**.
- Contraste do personagem (do joelho para cima) **≥ +0,10** contra o entorno, e separação da silhueta **≥ 2/3** da borda.
- Nenhuma **mancha clara grande** compete com o personagem, a energia ou os perigos pela atenção. Brilhos pontuais (neve jogável, auroras pequenas, janelas) podem existir.
- Em profundidade, o que importa é **reduzir contraste e saturação** de um plano para o seguinte, mais do que escurecer cada camada.

### C3. Estrutura e detalhe
- Densidade de bordas **0,04–0,11**; área lisa **≤ 0,60** (limites dos pontos das referências; a Galeria do Portal, a 0,63, é um trecho calmo intencional).
- Diagnóstico obrigatório: as mesmas medidas **sem o primeiro plano**. Um rodapé cheio de detalhe pode passar enquanto o fundo continua vazio.
- A estrutura **organiza o espaço**: algo desce do alto ou sobe dos lados, ou uma massa (encosta, paredão, massa lateral) dá a moldura.

### C4. Escala da decoração (D = altura do Daymon)
- Três faixas como referência de composição: **pequena** 0,15–0,5 D, **média** 1–2 D, **grande** 3–6 D (atrás do plano do jogo).
- Ponto de partida numa tela típica: 6–12 pequenas, 2–4 médias e 1–2 grandes. **Não é requisito por câmera.**
- A medida é a dimensão dominante visível da peça. Uma coluna recortada, um paredão contínuo ou o próprio relevo podem dar a escala. Um agrupamento que se lê como unidade conta como um.
- Nada de painel chapado enorme no lugar de estrutura. Peças da mesma família na mesma escala.

### C5. Terreno
- A **linha de apoio** é sempre legível; a **borda visual** do terreno varia com o material (musgo, neve acumulada, rebites, raízes). Uma plataforma metálica pode ter topo reto.
- O subsolo se distingue do topo por valor e por planos de material.
- Pontas, emendas e cantos internos e externos conferidos em sequências montadas, com a colisão visível.
- Plataformas suspensas mostram o que as segura (cabos, correntes, suportes) ou o mecanismo que as move.

### C6. Luz e ambiente
- **1 a 3 focos luminosos de atenção por tela.** Um painel com várias luzes conta como um foco.
- Até **dois efeitos de ambiente simultâneos** como referência (neve, esporos, poeira, faíscas). Brilho pintado e iluminação do entorno podem cumprir a mesma função.
- Partículas e reflexos conferidos **em movimento**.

### C7. Cor da cena
- Uma **família escura dominante** por universo (Laboratório azul-marinho, Verdâmia verde-azulado, Deserto ferrugem escura, Nivária azul de noite), um **acento de energia** do universo e o azul-marinho comum do jogo (`#0F1422` a `#253045`) nas sombras profundas.
- As **cores funcionais** já definidas mantêm o papel: perigo (vermelho), gancho e Traje Âncora (ciano), e as cores próprias de cada universo. Em Nivária: aurora rosa, fratura roxa e ciano funcional, cada um com papel distinto.

### Referência de level design (fora da aprovação de arte)
Cerca de 1,2–1,4 inimigos por 1.000 px e um elemento de leitura ou interação a cada 400–600 px, medidos **ao longo do percurso jogável** em trechos comparáveis. Travessias, checkpoints, arenas e trechos verticais têm ritmo próprio.

## Checagens além dos números

1. **Hierarquia na rota jogável.** Na escala real, dá para identificar onde pousar, o que causa dano, onde o gancho pega e para onde seguir, em cor, em cinza e em movimento. A média pode passar mesmo com o rosto sumindo contra uma aurora ou as pernas sumindo num salto.
2. **Estrutura distribuída entre os planos.** Na captura sem primeiro plano, localizar os blocos lisos: a mesma densidade pode vir de uma estação que dá escala à montanha ou de riscos espalhados no fundo.
3. **Continuidade na travessia.** Rolagem horizontal e vertical, encaixe dos tiles, bordas dos fundos e oclusão de perigos. Uma prancha estática esconde a emenda que aparece na subida ou a silhueta de primeiro plano que cobre o aviso de uma estaca.

## Entrega de cenário

- Toda entrega de fundo, terreno, estrutura, decoração ou primeiro plano traz `<ID>_cena.png`: **um painel de 1.280 × 720 por cena**, com a cena nova (Daymon a ~91 px) e as capturas do Laboratório e de Verdâmia **na mesma escala visual, sem esticar**. A prancha serve para a direção de arte.
- O `ENTREGA.md` diz a faixa de escala (C4) e a função (C1) de cada peça.
- **O que libera a fase são as capturas do Godot** (desenvolvimento), com os números por ponto no HANDOFF. O teste decisivo de Nivária é remontar as mesmas quatro câmeras com a arte do lote 2 e comparar com o Laboratório e Verdâmia: os números verificam valores e estrutura; acabamento, hierarquia e leitura em movimento fecham a aprovação visual.
