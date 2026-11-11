# DF50 — prensa grande, entrega aprovada

Estado: ENTREGUE após aprovação explícita do responsável.

João Marcelo aprovou a prensa, suas três peças e a prévia de montagem nesta conversa: “pode seguir”.

## Arquivos e peças

- `DF50_previa_montagem.png` — 1024 × 1024 px; SHA-256 `820e722faffc3eeea3a44ff5d4205295e437ca03aeaf197c295060b714604b02`.
- `DF50a_prensa_cabeca.png` — 1024 × 1024 px; SHA-256 `9b2497cd9ec97dd099f778ff0e95ec1a143bae6b5a691a22db77e210640caaba`.
- `DF50b_prensa_haste.png` — 128 × 512 px; SHA-256 `1f90a8ed8e5b4f1259ee8fef6b2480c8fc093e4d4b8c37f4e65c985007e9982c`.
- `DF50c_prensa_suporte.png` — 1024 × 1024 px; SHA-256 `a23828844f6ace95adf1c69265340a50def07fcfdfb0c861f921f99a9879ffff`.

- Cabeça: peça móvel, metal cinza, faixa diagonal vermelha/cinza no terço inferior. Limites visíveis no PNG: (192, 412) até (832, 612), ou 640 × 200 px = 1,6 D × 0,5 D com D=400. Eixo x=512. Encaixe superior em torno de (512, 412); face de esmagamento inferior na linha y=612.
- Haste: textura de pistão para repetição vertical, 128 × 512; metal visível entre x=13 e x=115. Eixo x=64. Seção transversal constante, bordas superior e inferior RGBA idênticas. Usar repetição/recorte para ajustar a extensão, evitando deformação do metal.
- Suporte: peça fixa no teto, trave de ferrugem com presilhas parafusadas e guia central do pistão. Limites visíveis (112, 432) até (912, 592), largura800 × altura160; eixo x=512.
- `DF50_previa_montagem.png`: somente demonstração de montagem em fundo opaco, não é asset de gameplay nem animação.

## Apoio e montagem

O suporte é preso ao teto pelas duas presilhas parafusadas. A haste encaixa na guia central do suporte; a cabeça conecta-se à extremidade inferior da haste. O suporte permanece fixo, e o jogo move a cabeça/ajusta a extensão da haste por código. Cabeça não deve ser usada isoladamente sem haste e suporte.

Prévia no canvas1024 × 1024: suporte recortado no retângulo útil em (112,120), haste em (448,252), cabeça recortada no retângulo útil em (192,750). Os encaixes se sobrepõem para não deixar lacunas. A prévia representa uma extensão ilustrativa, não uma âncora obrigatória de gameplay.

## Referências e cores

Pedido DF, seção DF50; DA-01; prensa da DF00 aprovada. Geometria simples, contorno limpo, sombreamento facetado. Cinza #7C7F86 e tons auxiliares, perigo vermelho #C8402F, ferrugem #6B3A22 / #8A4B2C / #A8552E e sombra #3A2116. Sem ciano ou efeitos de energia.

## Preparação e verificação

Arte criada por geração de imagem, com recorte e normalização técnica. Cabeça e suporte em PNG1024 × 1024 transparente; haste em128 × 512 com laterais transparentes, sem margens transparentes nas extremidades superior/inferior do metal. Os PNGs finais são derivados técnicos, não os originais brutos do gerador. Para obter repetição vertical uniforme da haste, foi usada uma seção horizontal do desenho gerado, estendida verticalmente.

Dimensões e canal alfa conferidos. Cabeça na escalaD400; eixo central das três peças compatível. Prévia montada e conferida visualmente contra a DF00. A haste repete sem emenda numérica entre bordas superior/inferior. Sem animações, grade, texto ou sombras projetadas nos três assets. A faixa inferior identifica a área de esmagamento. Nenhuma exceção dimensional pendente; a prévia adicional tem fundo opaco por ser somente apresentação.

Aprovação estética: confirmada pelo responsável nesta conversa.
