# A8_fx_rachadura_teto

## Prompt final (image_gen integrada)

```text
Use case: stylized-concept. Create a production sprite source for Warp Fracture A8, four successive animation frames of a ceiling fissure opening downward. Solid pure green #00FF00 background for chroma key, no green in artwork. Four separate evenly spaced objects in one horizontal row, no text, no grid, no labels. Each fissure starts at the SAME top baseline, extends downward only, short and wide, maximum opening progressively increasing left to right. ONLY jagged crack edges, sparks and light, never an entire ceiling slab. Steel blue metallic thin faceted edges, navy dark void, tiny cyan sparks, restrained purple #7A3CFF interior. Match the official Helix Laboratory reference previously viewed: simplified clean 2D side-scroller cartoon objects, few flat cel shaded faces, sparse detail, no photorealism, no painterly texture. Frame 1 thin dark fissure with one cyan spark. Frame 2 same fissure branches, small purple light leaks. Frame 3 larger opening with sparse fine falling dust and sparks. Frame 4 widest opening, contained purple light and exactly 3 small falling steel blue shards. Preserve common shape evolution and top anchor. Isolated assets with generous green spacing and no large diffuse glows. Landscape 1536x1024.
```

12/11/2026, ciclo 2. ENTREGUE para revisao.

## Arquivos e quadros

- A8_fx_rachadura_teto.png: folha final.
- ENTREGA.md: especificacao, evidencias e prompt.

1. Fissura fina escura com faisca ciano.
2. Ramificacoes com luz roxa.
3. Abertura crescente, poeira fina e faiscas.
4. Abertura maxima, roxo contido e tres lascas azul-aco.
5-8. Vazios.

## Producao e decisoes

Geracao pela ferramenta image_gen integrada, seguindo DA-01 e comparacao visual com a Prancha de Elementos do Laboratorio Helix. Fundo verde solicitado #00FF00, removido com numpy/Pillow, com descontaminacao verde nas bordas. Recortes individuais reamostrados em LANCZOS com fator comum 0,58, centralizados em cada celula e ancorados em y=0. Apenas bordas metalicas da rachadura, sem teto inteiro.

Arquivo: `A8_fx_rachadura_teto.png`; PNG RGBA 1536 x 1024, grade 4 x 2, celulas 384 x 512.

SHA-256: `2a6f135a7bccd5d8fc44f6d13bc091d0e9f7180dd3a35c3bec9c9ef8a40ec80f`.

### Medidas por quadro

Caixa de conteudo com alfa > 16, mesma convencao do check_art; limites superiores exclusivos. Inclui fragmentos/efeitos, nao segmentacao anatomica independente.

| Quadro | Altura (px) | Topo y | Base y | Largura (px) |
|---|---:|---:|---:|---:|
| 1 | 26 | 0 | 26 | 147 |
| 2 | 48 | 0 | 48 | 173 |
| 3 | 132 | 0 | 132 | 208 |
| 4 | 194 | 0 | 194 | 255 |
| 5 | vazio | - | - | - |
| 6 | vazio | - | - | - |
| 7 | vazio | - | - | - |
| 8 | vazio | - | - | - |
Linha inferior integralmente transparente. Conteudo RGBA limitado aos primeiros 194 px; centros horizontais a ate 0,5 px do centro da celula.

### check_art

`python tools/fluxo/check_art.py colaboracao/entregas/A8_fx_rachadura_teto/A8_fx_rachadura_teto.png --grid 4x2 --cell 384x512 --margin 0`

```text
arquivo: colaboracao/entregas/A8_fx_rachadura_teto/A8_fx_rachadura_teto.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x118-265 y0-26
quadro 2: caixa x105-278 y0-48
quadro 3: caixa x88-296 y0-132
quadro 4: caixa x64-319 y0-194
quadro 5: vazio
quadro 6: vazio
quadro 7: vazio
quadro 8: vazio
OK
```

### Verificacao visual e ressalvas

Resultado final visualizado. O conteudo encostar na borda de CIMA e esperado neste pedido: o teto corresponde a y=0. Por isso check_art usa --margin 0. Os quatro quadros ocupam no maximo 200 px de altura. Revisao artistica e integracao no jogo pendentes; nao houve teste na Godot. STATUS.md nao alterado: e responsabilidade do gerente e esta fora do escopo autorizado.
