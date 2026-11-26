# DF110 · Feixe e impacto da Forja-Mãe

Arte refeita em 26/11/2026 para o Deserto de Ferrugem.

Mestre PNG RGBA de 1024 × 512 px, com 4 colunas e 2 linhas de 256 × 256 px.

Cada célula mede 256 × 256 px. A primeira linha contém quatro segmentos horizontais que se repetem no eixo X. O centro do feixe usa y = 128. A segunda linha contém quatro impactos com ponto de contato (128, 224) na célula, equivalente a (128, 480) na primeira coluna da folha.

| Quadro | Conteúdo |
| --- | --- |
| 1 | Feixe 1 |
| 2 | Feixe 2 |
| 3 | Feixe 3 |
| 4 | Feixe 4 |
| 5 | Impacto 1 |
| 6 | Impacto 2 |
| 7 | Impacto 3 |
| 8 | Impacto 4 |

## Cor e verificação técnica

Vermelho e vermelho-alaranjado em volta de um núcleo claro.

Saída de `tools/fluxo/check_art.py` no PNG entregue.

```text
arquivo: DF110_forja_feixe_v3.png
tamanho: 1024x512  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x0-256 y93-154
quadro 2: caixa x0-256 y93-161
quadro 3: caixa x0-256 y93-161
quadro 4: caixa x0-256 y93-161
quadro 5: caixa x50-211 y140-226
quadro 6: caixa x87-247 y140-226
quadro 7: caixa x47-213 y131-226
quadro 8: caixa x64-231 y134-226
OK
```

O feixe ocupa toda a largura de cada célula para poder se repetir. O teste de continuidade comparou as duas bordas RGBA em cada um dos quatro quadros.

A textura de meia resolução é `DF110_jogo_v3.webp` nesta entrega do repositório e `assets/deserto/DF110.webp` no ZIP. SHA-256 `e3d354b1f7123c041a36528def955d63c325d53d9cd66be43e3f4e1eddf9998c`.

## SHA-256

- `DF110_forja_feixe_v3.png` · `5a143e97df80f6b678989c93ffca6adbd8894aebde919c683896238a573d8547`
