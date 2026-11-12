# Revisão A1_eco_appear: Materialização do Eco

**Resultado:** ❌ **AJUSTE**  
**Revisor:** Antigravity (Revisor de Arte Independente)  
**Data:** 12/11/2026 (Ciclo 1 do fluxo automático)  
**Entrega revisada:** [A1_eco_appear.png](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A1_eco_appear/A1_eco_appear.png)  
**Documento de entrega:** [ENTREGA.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A1_eco_appear/ENTREGA.md)  
**Pedido de referência:** [A1_eco_appear.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/pedidos/A1_eco_appear.md)  
**Diretrizes aplicadas:** [DA-01](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png) e revisão modelo [A2_eco_float.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/revisoes/A2_eco_float.md)

---

## 1. Saída da verificação técnica (`check_art.py`)

Comando de referência: `python tools/fluxo/check_art.py colaboracao/entregas/A1_eco_appear/A1_eco_appear.png --grid 4x2 --cell 384x512`

```text
arquivo: C:\Users\joao.marcelo\AreaJM\Projetos\warp-fracture\colaboracao\entregas\A1_eco_appear\A1_eco_appear.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x105-229 y60-346
quadro 2: caixa x60-206 y56-360
quadro 3: caixa x47-256 y16-443
quadro 4: caixa x50-255 y17-444
quadro 5: caixa x81-290 y16-444
quadro 6: caixa x62-290 y17-443
quadro 7: caixa x38-260 y18-443
quadro 8: caixa x50-262 y13-393
OK
```

---

## 2. Medições e escala do Eco

| Quadro | Altura da figura | Largura | Topo (y) | Base (y) | Distância da base à borda inferior (512 - y) | Status |
|---|---|---|---|---|---|---|
| 1 | 286 px | 124 px | 60 | 346 | 166 px | Fora de posição (rachadura alta) |
| 2 | 304 px | 146 px | 56 | 360 | 152 px | Fora de posição (rachadura alta) |
| 3 | **427 px** | 209 px | 16 | 443 | 69 px | ❌ Escala violada (+47 px) e base incorreta |
| 4 | **427 px** | 205 px | 17 | 444 | 68 px | ❌ Escala violada (+47 px) e base incorreta |
| 5 | **428 px** | 209 px | 16 | 444 | 68 px | ❌ Escala violada (+48 px) e base incorreta |
| 6 | **426 px** | 228 px | 17 | 443 | 69 px | ❌ Escala violada (+46 px) e base incorreta |
| 7 | **425 px** | 222 px | 18 | 443 | 69 px | ❌ Escala violada (+45 px) e base incorreta |
| 8 | **380 px** | 212 px | 13 | 393 | 119 px | ✅ Perfeito (referência A2) |

---

## 3. Continuidade e conformidade com o pedido

- **Regra A1 quadro 8 = A2 quadro 1:** ✅ Perfeito. Diferença medida de 0 em 196.608 pixels (0,00%).
- **Regra de escala do Eco (380 px):** ❌ Violada. O pedido exige expressamente que todas as folhas do Eco mantenham a mesma escala da animação A2 (`A2_eco_float.png`, onde o Eco mede **380 px** na vertical). Nos quadros 3 a 7, a figura foi desenhada ou montada com altura entre 425 e 428 px (aproximadamente 12% maior do que a escala oficial de 380 px).
- **Regra da linha de apoio / flutuação:** ❌ Violada. O pedido define que a parte mais baixa do corpo ou do jaleco deve ficar a cerca de 120 px da borda inferior da célula (y ≈ 392). No quadro 8 a base está em y=393 (119 px, correto). Porém, nos quadros 3 a 7 a base está em y=443–444 (a apenas 68–69 px da borda inferior).
- **Continuidade interna:** ❌ Do quadro 7 para o quadro 8, ocorre um salto inaceitável: a figura encolhe abruptamente 45 px na altura (de 425 px para 380 px) e os pés sobem bruscamente 50 px (a base salta de y=443 para y=393), quebrando a fluidez da materialização antes de emendar no loop de pairar.

---

## 4. Estilo (DA-01)

- O traço cartunizado, sombreamento econômico, paleta e silhueta estão de acordo com a ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png).
- Sem realismo, sem chamas, sem arte painterly e com contorno limpo sem halo verde.

---

## 5. Lista exata do que refazer (AJUSTE)

- **quadro 1:** rachadura inicial posicionada muito acima do peito (base y=346) -> reposicionar verticalmente para coincidir com a altura do peito do Eco normalizado (y ≈ 200–220).
- **quadro 2:** expansão da rachadura deslocada para cima (base y=360) -> reposicionar verticalmente acompanhando a ancoragem do peito do Eco normalizado.
- **quadro 3:** figura com 427 px de altura (escala ~12% acima dos 380 px) e base em y=443 (51 px abaixo da linha de flutuação de 120 px) -> aplicar redução proporcional de escala (fator ~0,89, 380/427) para igualar a anatomia aos 380 px da A2 e alinhar a base em y ≈ 393.
- **quadro 4:** figura com 427 px de altura e base em y=444 -> aplicar redução proporcional de escala (~0,89) para altura de 380 px e alinhar base em y ≈ 393.
- **quadro 5:** figura com 428 px de altura e base em y=444 -> aplicar redução proporcional de escala (~0,89) para altura de 380 px e alinhar base em y ≈ 393.
- **quadro 6:** figura com 426 px de altura e base em y=443 -> aplicar redução proporcional de escala (~0,89) para altura de 380 px e alinhar base em y ≈ 393.
- **quadro 7:** figura com 425 px de altura e base em y=443, provocando salto de 45 px de altura e 50 px de base para o quadro 8 -> aplicar redução proporcional de escala (~0,89) para que o corpo/cabeça corresponda aos 380 px e alinhar base em y ≈ 393, garantindo transição suave e sem solavancos para o quadro 8.
