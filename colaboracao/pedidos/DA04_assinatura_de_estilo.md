# Pedido DA-04: assinatura de estilo e quadro-chave do Deserto

**Estado:** ABERTO (24/11/2026). Os pedidos de arte do Deserto (DF202 em diante) ficam suspensos até o quadro-chave ser aprovado.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento)
**Documento:** [DA-04 (proposta)](../entregas/00_padrao_visual/DA-04_ASSINATURA_DE_ESTILO.md), na branch `dev/deserto`.

Anexe `docs/auditoria_cena/estilo_referencia_e_desvios.jpg` e `docs/auditoria_cena/DF201_no_jogo.jpg`.

````markdown
**[DA-04] Assinatura de estilo e quadro-chave do Deserto**

Você é o diretor de arte do Warp Fracture. O João Marcelo avaliou o Deserto de Ferrugem no jogo, já com o céu DF200, o fundo intermediário DF201 e o terreno DF205 integrados, e disse: "a qualidade e a padronização de estilo ainda parecem muito fora do que se estava fazendo nas fases anteriores. O jogo como um todo deve seguir um mesmo estilo de arte, como se fosse tudo feito por um único artista."

A DA-03 resolveu os valores: o Deserto agora passa na régua de luma, contraste e estrutura. O problema que sobrou é a **linguagem gráfica**. A imagem anexa (`estilo_referencia_e_desvios.jpg`) mostra, na linha de cima, recortes 2× do Laboratório Hélix e de Verdâmia e, na linha de baixo, onde o Deserto foge:
- a DF201 é ilustração com traço de tinta e hachura;
- o terreno não tem cor-assinatura na borda de apoio;
- as paredes e os adereços antigos (v0.8) são cartum claro e chapado, de outra mão.

A proposta está em `colaboracao/entregas/00_padrao_visual/DA-04_ASSINATURA_DE_ESTILO.md`, na branch `dev/deserto`. Resumo das sete regras tiradas do Laboratório e de Verdâmia:

1. Formas chapadas com sombreamento em degraus (2–3 tons por material, fronteira nítida, rochas facetadas, metal em blocos chanfrados); sem textura pintada, ruído, hachura ou pincel.
2. Sem traço de tinta no cenário; o contorno escuro frio é só das figuras (DA-02).
3. Detalhe que cresce do fundo para a frente: fundo distante em silhueta de 1–2 tons, intermediário com 2 tons e poucos recortes, plano do jogo com 3 tons e detalhe.
4. Uma cor-assinatura saturada por universo, na borda de apoio, nas luzes (com halo) e nos elementos ativos: ciano no Laboratório, verde-limão em Verdâmia. Proposta para o Deserto: **âmbar incandescente** `#EFAA55` (crista da areia pegando a luz baixa, friso de metal aquecido, lâmpadas, fornalhas, máquinas ativas).
5. Arestas limpas e formas de cartum robusto, legíveis em miniatura.
6. Gradiente só na atmosfera (céu, névoa, halos).
7. Mesma resolução aparente: 1–2 px de arquivo por px de tela no cenário.

**O que preciso de você, em duas partes:**

**Parte 1 (só texto):** revise as sete regras e a cor-assinatura do Deserto (manter, ajustar ou retirar, com o porquê). Diga o que mais distingue o "artista" do Laboratório e de Verdâmia e não está escrito (forma dos chanfros, espessura dos frisos, como a luz é pintada, densidade de detalhe por D). Depois, diga como você vai garantir a mesma mão em todas as peças seguintes.

**Parte 2 (uma imagem):** o **quadro-chave de estilo do Deserto**, `DA04_quadro_chave_deserto.png`, com 1.280 × 720 px.
- **Cena:** as Dunas de Sucata com a entrada da Fábrica à direita. Pinte na linguagem do Laboratório e de Verdâmia, como se o mesmo artista tivesse feito as três fases.
- **Composição:** use o mesmo enquadramento e as mesmas camadas da captura do jogo (`DF201_no_jogo.jpg`, primeira linha):
  - céu DF200;
  - duas camadas intermediárias, redesenhadas em silhueta chapada;
  - terreno de areia com a borda de apoio em âmbar;
  - o Autômato a ~91 px de altura, no chão em y ≈ 541 da tela;
  - uma lâmpada ou fornalha acesa;
  - a parede da Fábrica.
- **Valores:** os da DA-03 (luma 0,08–0,18, terço de cima ≤ 0,15, personagem o mais claro).
- **Comparação:** ao lado, na mesma escala visual, recortes do Laboratório e de Verdâmia, numa prancha `DA04_quadro_chave_comparacao.png`.

**Entrega:** apresente ao João Marcelo e **só suba depois da aprovação explícita dele**.
- **Onde:** `colaboracao/entregas/00_padrao_visual/DA04/`, com um `ENTREGA.md` com a revisão da Parte 1 e as medidas DA-03 do quadro-chave.
- **Status:** atualize a linha DA-04 do `colaboracao/STATUS.md`.
- **Commit:** `[arte]` na `main`.

Este quadro-chave vira a referência obrigatória dos próximos pedidos do Deserto, da refação da DF201 e do retoque da borda da DF205.
````
