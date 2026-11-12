# Entrega A6_entulho — ciclo automático 1

Arte gerada no ciclo automático 1 em 12/11/2026. Aguarda o revisor; não é aprovação nem integração.

Objetos:
1. A6_entulho_1.png: placa retangular amassada, viga torta presa, dois cabos soltos e acento ciano.
2. A6_entulho_2.png: duto partido com grade de ventilação, rebites e pequeno indicador ciano.
3. A6_entulho_3.png: placa compacta com luminária rachada, metade apagada e metade ciano fraco.

Decisões: objetos em queda, inclinados e sem apoio. Maior extensão de 666 px (65,04% do canvas), centralização pela caixa de conteúdo, proporções preservadas. Luz fria superior esquerda, faces azul-aço, poucos recortes e acentos ciano. Recorte por chave verde, descontaminação das bordas, redimensionamento Lanczos e limpeza após reamostragem. Não há chão, texto, grade ou sombra projetada.

Ressalva artística: como o pedido exige PNG estático, o piscar da luminária é representado por um instante de iluminação parcial; este arquivo não contém animação de luz. A placa 3 é menor em construção, mas normalizada para a mesma faixa de ocupação exigida; escala física relativa fica para integração.

## Arquivos finais

| Arquivo | Dimensões | Modo | Bytes | SHA-256 |
|---|---|---|---:|---|
| A6_entulho_1.png | 1024x1024 | RGBA | 256766 | `7c208951847aa89cb7b34a185b77f230045b27dac40eac64b2bbcd501ad22cb9` |
| A6_entulho_2.png | 1024x1024 | RGBA | 250737 | `bda103276fe3d48154acee207173577fab358b0ca5fa87c8a346ceac760f2d3d` |
| A6_entulho_3.png | 1024x1024 | RGBA | 266625 | `e4c0bd2e9a3373e13799a6ea3a414771c1b7ccf9263a618cfbcc1fe6d5249fad` |

## Validação técnica

`python tools/fluxo/check_art.py colaboracao/entregas/A6_entulho/A6_entulho_1.png --size 1024x1024 --fill 0.6-0.7`

Saída (código 0):

```text
arquivo: colaboracao/entregas/A6_entulho/A6_entulho_1.png
tamanho: 1024x1024  modo: RGBA
alfa: min 0 max 255
objeto: caixa x179-845 y265-758  ocupação 0.65
OK
```

`python tools/fluxo/check_art.py colaboracao/entregas/A6_entulho/A6_entulho_2.png --size 1024x1024 --fill 0.6-0.7`

Saída (código 0):

```text
arquivo: colaboracao/entregas/A6_entulho/A6_entulho_2.png
tamanho: 1024x1024  modo: RGBA
alfa: min 0 max 255
objeto: caixa x179-845 y310-714  ocupação 0.65
OK
```

`python tools/fluxo/check_art.py colaboracao/entregas/A6_entulho/A6_entulho_3.png --size 1024x1024 --fill 0.6-0.7`

Saída (código 0):

```text
arquivo: colaboracao/entregas/A6_entulho/A6_entulho_3.png
tamanho: 1024x1024  modo: RGBA
alfa: min 0 max 255
objeto: caixa x179-845 y275-749  ocupação 0.65
OK
```

## Revisão visual e processo

Geração com a ferramenta nativa image_gen, em fundo verde #00FF00, seguida de montagem com Python, Pillow e NumPy. Referências consultadas: DA-01, Prancha de Elementos do Laboratório Hélix, Ficha de Personagem Daymon Sagan e Folha de Inimigos do Laboratório Hélix. Resultados finais visualizados; comparação lado a lado em memória com a prancha oficial, incluindo redução aproximada de escala (objetos em canvas de 250 px e folha de efeito a 50%). Silhuetas legíveis, sombreamento econômico e recorte sem halo verde visível. A continuidade e o estilo aguardam avaliação independente do revisor.

Limitação de ambiente: a cópia para pasta temporária externa foi tentada e negada com PermissionError, tanto pelo caminho curto quanto pelo caminho completo de Temp. O processamento ocorreu inteiramente em memória, lendo os originais de ~/.codex/generated_images/; nenhum arquivo temporário foi colocado no repositório. Originais preservados. Essa etapa de cópia externa não pôde ser cumprida; os formatos e verificações finais foram cumpridos.

Somente as duas pastas de entrega foram alteradas. STATUS.md permanece sob responsabilidade do gerente conforme FLUXO_AUTOMATICO.md. Sem commit, upload ou integração.

## Prompts usados

Crie um sprite único A6_entulho_1 para Warp Fracture: placa retangular de teto metálico azul-aço amassada, uma viga torta presa e dois cabos soltos. Rebites grandes e pequeno detalhe ciano. Caindo, levemente inclinado, centralizado em quadrado 1024x1024, ocupa 65% da extensão. Estilo DA-01 conforme prancha oficial vista no contexto: 2D cartunizado simplificado, geometria compacta, faces grandes azul-marinho #1c2945 e azul-aço #354e78, contorno discreto, apenas 2-3 tons por superfície, luz fria superior esquerda. Poucos recortes, sem textura ou arranhões realistas, sem pintura nem 3D. Fundo INTEIRO verde puro chapado #00FF00, sem sombras projetadas, sem chão, sem texto, sem grade, sem partículas separadas. Não desenhe verde no objeto.

Crie um sprite único A6_entulho_2 para Warp Fracture: pedaço curto de duto retangular de ventilação partido, boca com grade de quatro lâminas, extremidade traseira irregular quebrada. Metal azul-aço, poucos rebites e um pequeno indicador ciano. Objeto flutuando em queda, inclinado uns 15 graus, visão lateral levemente 3/4. Centralizado quadrado 1024x1024, ocupa 65%. Mesmo desenho da prancha oficial Hélix e do entulho anterior: 2D cartunizado simplificado, poucas faces chapadas azul-marinho #1c2945 e azul-aço #354e78, luz fria superior esquerda, contornos discretos, só 2-3 tons por superfície. Sem textura, sem arranhões, sem realismo, sem 3D, sem detalhes excessivos. Fundo verde puro chapado #00FF00, sem chão, sem sombra projetada, sem texto, sem grade de layout. Não desenhe verde no objeto.

Crie sprite único A6_entulho_3 para Warp Fracture: pequena placa de teto metálica irregular azul-aço, quatro rebites, com luminária retangular ciano rachada presa no centro. Luminária com uma metade apagada azul escuro e outra metade ciano FRACO, sugerindo instante de falha elétrica. Uma rachadura clara diagonal, sem brilho externo. Objeto em queda levemente inclinado, sem apoio. Centralizado quadrado 1024x1024, ocupa 65%. Mesmo traço dos dois entulhos anteriores e prancha oficial Hélix: 2D cartunizado simples, poucas faces grandes chapadas azul-marinho #1c2945 e azul-aço #354e78, 2-3 tons, luz fria superior esquerda, contornos discretos, formas compactas e legíveis. Sem textura, realismo, arranhões decorativos ou 3D. Fundo verde puro chapado #00FF00. Sem chão, texto, sombra projetada ou grade. Não desenhar verde no objeto.


