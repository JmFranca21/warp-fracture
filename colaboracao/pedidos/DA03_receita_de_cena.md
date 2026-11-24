# Pedido DA-03: receita de cena

**Lote 0: correção de qualidade de cena.** O João avaliou (24/11/2026) que o Laboratório Hélix e Verdâmia têm o padrão e a qualidade esperados, e que o Deserto de Ferrugem e Nivária estão bem abaixo.
**Estado:** ABERTO (revisão do ChatGPT). Os pedidos de cenário de Nivária (GL50–GL59, em [GL lote 2](GL_lote2_producao.md)) já seguem a proposta; se a revisão mudar algum número, eles são atualizados antes do envio.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 24/11/2026
**Documento:** [DA-03 (proposta)](../entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md), na branch `dev/neve`.

Copie o bloco abaixo e anexe a imagem `comparacao_cenas.png` (as quatro fases capturadas no jogo, dois pontos de cada).

---

## 1. DA-03: revisão pelo diretor de arte

````markdown
**[DA-03] Revisão da receita de cena**

Você é o diretor de arte do Warp Fracture. O João Marcelo avaliou que o **Laboratório Hélix e Verdâmia** têm o padrão e a qualidade que o jogo quer, e que o **Deserto de Ferrugem e Nivária** estão bem abaixo. A DA-02 resolveu a consistência das figuras; o problema agora é a **cena**: como fundo, chão, decoração, primeiro plano e luz se juntam numa tela. A imagem anexa mostra as quatro fases capturadas no jogo.

Medi as quatro fases no jogo (quatro pontos de cada; luma sRGB Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′, sem o HUD):

| Medida | Laboratório | Verdâmia | Deserto | Nivária |
| --- | --- | --- | --- | --- |
| Luma média da tela | 0,090 | 0,167 | 0,263 | 0,158 |
| Luma do terço de cima | 0,092 | 0,138 | 0,285 | 0,124 |
| Contraste do jogador (personagem − anel de 8 px, do joelho para cima) | +0,07 a +0,12 | +0,12 a +0,13 | +0,02 a +0,03 | +0,12 |
| Densidade de bordas | 0,051 | 0,092 | 0,075 | 0,038 |
| Área sem estrutura (blocos de 40 px lisos) | 0,54 | 0,18 | 0,33 | 0,69 |
| Primeiro plano / luzes pontuais / partículas | sim / 63 / 2 | sim / 8 + arte / 2 | não / 2 / 0 | não / 0 / 0 |

Diagnóstico: o Deserto é claro demais e o personagem some no fundo (painéis chapados laranja, escalas que não conversam). Nivária, com a arte provisória, é vazia: céu sem nada, chão em retângulos, objetos soltos, sem primeiro plano nem luz.

A proposta, a **DA-03** (está em `colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md`, na branch `dev/neve`), resumida:

- **C1 Cinco camadas em toda tela:** fundo distante (parallax 0,02–0,15), fundo intermediário (0,25–0,5), estrutura de fundo no plano do jogo (paredes, colunas, troncos), plano do jogo (terreno e decoração) e primeiro plano escuro na borda de baixo; mais luzes e partículas.
- **C2 Valores:** luma média da tela 0,08–0,18; terço de cima até 0,15; personagem pelo menos +0,07 acima do entorno; a cor mais clara é do personagem, da energia ou do perigo, nunca do fundo.
- **C3 Estrutura:** densidade de bordas 0,05–0,10; área lisa até 0,55; toda tela tem moldura (algo descendo do alto ou subindo dos lados).
- **C4 Escala da decoração (D = Daymon):** pequena 0,15–0,5 D (6–12 por tela), média 1–2 D (2–4 por tela), grande 3–6 D (1–2 por tela, atrás do plano do jogo); nada de painel chapado enorme no lugar de estrutura.
- **C5 Terreno:** topo de chão nunca liso e reto; subsolo escuro com textura; cantos próprios; nada flutua sem mostrar o que segura.
- **C6 Luz e ambiente:** 1–3 luzes pontuais por tela marcando o que importa; dois sistemas de partículas de ambiente por fase; brilho próprio nos objetos de energia.
- **C7 Cor:** uma cor escura dominante por universo e um acento de energia só nos detalhes; o azul-marinho comum nas sombras mais profundas.
- **C8 Densidade de jogo:** 1,2–1,4 inimigos por 1.000 px; algo para ler ou pegar a cada 400–600 px.
- **Comprovação:** toda entrega de cenário traz uma prancha de cena (`<ID>_cena.png`): uma tela de 1.280 × 720 com as peças novas e o Daymon a ~91 px, ao lado de capturas do Laboratório e de Verdâmia.

**O que preciso de você (só texto, nenhuma imagem):**

- Diga se concorda com o diagnóstico das quatro fases.
- Revise cada regra C1–C8: **manter**, **ajustar** (número novo e por quê) ou **retirar**. Aponte o que, cumprido à risca, ainda deixaria a cena abaixo do Laboratório e de Verdâmia.
- Diga o que falta (por exemplo: composição por tela, ritmo entre trechos cheios e calmos, como as zonas de uma fase se diferenciam entre si).
- Diga como vai montar a prancha de cena sem o jogo (o que dá para conferir a olho e o que precisa de ferramenta).
- Responda num bloco Markdown para eu colar no documento. **Não mude arquivos do repositório nem gere arte agora:** o João decide primeiro, e os pedidos de cenário de Nivária (GL50–GL59) vêm em seguida.
````
