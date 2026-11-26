# DF100 · Corpo da Forja-Mãe

Arte refeita em 26/11/2026 para o Deserto de Ferrugem.

Mestre PNG RGBA de 2048 × 2048 px.

A base do corpo fica em (1024, 2008). A carcaça central tem 1.400 × 1.200 px. Os aros dos ombros e da lente avançam acima dela. A lente usa o furo circular de 360 px em (1024, 900). O peito usa 420 × 360 px em (1024, 1330), as escotilhas usam 240 × 160 px em (640, 820) e (1408, 820), e a grade usa 700 × 240 px em (1024, 1820). Os cinco vãos têm alfa zero.

## Montagem na Câmara

As duas imagens de conferência usam o cenário DF203, a Forja montada em repouso e em aviso, e o Autômato a 91 px de altura. Os dois braços reutilizam o mesmo segmento em torno dos respectivos pivôs.

No Godot 4.7.2, a rotina DFArt da fase carregou os 12 atlas em meia resolução. Foram verificados 54 quadros ocupados e 17 células transparentes. A conferência cobriu os recortes e as animações em um projeto de teste. A luta completa depende da integração na fase.

### Coordenadas para integração

Com a base em (7770, 770) e K = 0,214, use os centros abaixo. A coluna de referência reproduz as posições encontradas em `dev/cenas` durante a entrega.

| Peça | Centro na arte original | Centro de mundo calculado | Referência da fase |
| --- | --- | --- | --- |
| Lente | (1024, 900) | (7770,00 / 532,89) | (7770 / 540) |
| Peito | (1024, 1330) | (7770,00 / 624,91) | (7771 / 634) |
| Escotilha esquerda | (640, 820) | (7687,82 / 515,77) | (7691,5 / 556) |
| Escotilha direita | (1408, 820) | (7852,18 / 515,77) | (7848,5 / 556) |
| Grade | (1024, 1820) | (7770,00 / 729,77) | (7770 / 730) |

A referência para o centro de mundo é `base + (centro_na_arte - Vector2(1024, 2008)) * 0.214`. Use cada centro também para o interior escuro, a origem de emissão e a área de interação correspondente. Os quadros de placas avulsas já incluem o afastamento lateral em relação ao centro do peito. Instancie as três células na origem do peito antes de aplicar o movimento de soltura.

O importador existente usa o primeiro PNG com o prefixo do ID. Como há originais, prévias e arquivos atuais nas pastas, selecione o nome completo que termina em `_v3.png`. Divida a textura inteira em dimensões iguais. Para o caminho de meia resolução de DFArt, os WebP da entrega já têm a redução de 50% aplicada por igual nos dois eixos.

## Cor e verificação técnica

Aço azul-acinzentado, cobre ferrugem e juntas escuras.

Saída de `tools/fluxo/check_art.py` no PNG entregue.

```text
arquivo: DF100_forja_corpo_v3.png
tamanho: 2048x2048  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x326-1722 y664-2006
OK
```

A textura de meia resolução é `DF100_jogo_v3.webp` nesta entrega do repositório e `assets/deserto/DF100.webp` no ZIP. SHA-256 `69d75914b35cdc1f68b28e050ccf8f550895308474fa60c8c0689b7d195f4c59`.

## SHA-256

- `DF100_forja_corpo_v3.png` · `357a8eeeac8bc01cf32bc3eeabb77957453493e922e10c3ed6ced9f90144112e`
- `DF100_montagem_aviso_v3.png` · `509429a8c21e8a9cba622f617581f7558836ff6157b07266880047b9866c7d47`
- `DF100_montagem_v3.png` · `b5ffc8360760bcd4d91cf69e2cfeadf6a1304f52b6bae7d3e58311bff513fc58`
