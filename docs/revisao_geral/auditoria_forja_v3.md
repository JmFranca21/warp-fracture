# Auditoria da Forja-Mãe v3 (gerada por `tools/auditar_forja_v3.py`)

Total: 54 quadros ocupados e 17 células vazias (a entrega diz 54 e 17).

| ID | medidas | SHA mestre (atlas / ENTREGA) | quadros | WebP = mestre/2 | borda | soltos | quadros iguais | dif. entre quadros seguidos |
|---|---|---|---|---|---|---|---|---|
| DF100 | 2048x2048 | ok / ok | 1 ocup. · 0 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [] |
| DF101 | 1536x1024 | ok / ok | 4 ocup. · 4 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [9.29, 17.45, 9.44] |
| DF102 | 1536x1024 | ok / ok | 6 ocup. · 2 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [24.72, 18.67, 108.51, 133.45, 133.45] |
| DF103 | 1024x512 | ok / ok | 1 ocup. · 0 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [] |
| DF104 | 1024x512 | ok / ok | 1 ocup. · 0 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [] |
| DF105 | 2048x1024 | ok / ok | 4 ocup. · 0 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [9.23, 24.33, 16.33] |
| DF106 | 1536x1024 | ok / ok | 3 ocup. · 5 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [18.43, 42.33] |
| DF107 | 1536x1024 | ok / ok | 4 ocup. · 4 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | 1=2 (0.08) | [0.49, 9.98, 10.76] |
| DF108 | 1536x1024 | ok / ok | 8 ocup. · 0 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | 1=2 (0.47), 1=6 (0.32), 3=5 (0.40), 4=5 (0.29) | [2.39, 3.42, 2.74, 1.47, 4.12, 26.19, 29.13] |
| DF110 | 1024x512 | ok / ok | 8 ocup. · 0 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [18.33, 17.19, 17.19, 151.12, 81.54, 82.28, 79.03] |
| DF111 | 1536x1024 | ok / ok | 6 ocup. · 2 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | — | — | [75.88, 57.35, 69.4, 38.06, 75.0] |
| DF112 | 1536x1024 | ok / ok | 8 ocup. · 0 vaz. | ok · rgb 0.0 · alfa 0.00 · desloc 0.00 | — | 4:5 [(230, 134), (306, 136), (50, 156), (83, 365), (294, 369)]; 5:2 [(278, 149), (109, 363)]; 6:5 [(262, 167), (111, 171), (112, 338), (284, 338), (260, 342)]; 7:1 [(271, 293)] | — | [101.2, 91.46, 75.08, 85.76, 57.27, 81.29, 103.8] |

## Encaixes do corpo DF100

| vão | centro (arte) | pedido | medida real no centro | alfa ≠ 0 dentro | moldura opaca em volta | centro no mundo |
|---|---|---|---|---|---|---|
| lente | [1024, 900] | 360 | (360, 360) | 0.00 % | 100 % | [7770.0, 532.89] |
| peito | [1024, 1330] | (420, 360) | (420, 360) | 0.00 % | 100 % | [7770.0, 624.91] |
| escotilha_esquerda | [640, 820] | (240, 160) | (240, 160) | 0.00 % | 100 % | [7687.82, 515.77] |
| escotilha_direita | [1408, 820] | (240, 160) | (240, 160) | 0.00 % | 100 % | [7852.18, 515.77] |
| grade | [1024, 1820] | (700, 240) | (700, 240) | 0.00 % | 100 % | [7770.0, 729.77] |

Constantes atuais de `scripts/forja.gd`: `{'BASE': 'Vector2(7770, 770)', 'LENS': 'Vector2(7770, 533)        # lente Ø 360, centro (1024, 900)', 'CHEST': 'Vector2(7770, 625)       # peito 420 × 360, centro (1024, 1330)', 'HATCH': '[Vector2(7688, 516), Vector2(7852, 516)]    # escotilhas 240 × 160, centros (640, 820) e (1408, 820)', 'GRATE': 'Vector2(7770, 730)       # grade 700 × 240, centro (1024, 1820)'}`

## Problemas por ID

- **DF100**: nenhum problema técnico
- **DF101**: nenhum problema técnico
- **DF102**: nenhum problema técnico
- **DF103**: nenhum problema técnico
- **DF104**: nenhum problema técnico
- **DF105**: nenhum problema técnico
- **DF106**: nenhum problema técnico
- **DF107**: quadros iguais: 1=2 (0.08)
- **DF108**: quadros iguais: 1=2 (0.47), 1=6 (0.32), 3=5 (0.40), 4=5 (0.29)
- **DF110**: nenhum problema técnico
- **DF111**: nenhum problema técnico
- **DF112**: pixels soltos: 4:5 [(230, 134), (306, 136), (50, 156), (83, 365), (294, 369)]; 5:2 [(278, 149), (109, 363)]; 6:5 [(262, 167), (111, 171), (112, 338), (284, 338), (260, 342)]; 7:1 [(271, 293)]
