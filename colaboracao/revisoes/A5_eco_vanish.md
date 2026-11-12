# Revisão A5_eco_vanish: Eco se desfazendo

**Resultado:** ❌ **AJUSTE**  
**Revisor:** Antigravity (Revisor de Arte Independente)  
**Data:** 12/11/2026 (Ciclo 1 do fluxo automático)  
**Entrega revisada:** [A5_eco_vanish.png](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A5_eco_vanish/A5_eco_vanish.png)  
**Documento de entrega:** [ENTREGA.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A5_eco_vanish/ENTREGA.md)  
**Pedido de referência:** [A5_eco_vanish.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/pedidos/A5_eco_vanish.md)  
**Diretrizes aplicadas:** [DA-01](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png) e revisão modelo [A2_eco_float.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/revisoes/A2_eco_float.md)

---

## 1. Saída da verificação técnica (`check_art.py`)

Comando de referência: `python tools/fluxo/check_art.py colaboracao/entregas/A5_eco_vanish/A5_eco_vanish.png --grid 4x2 --cell 384x512`

```text
arquivo: C:\Users\joao.marcelo\AreaJM\Projetos\warp-fracture\colaboracao\entregas\A5_eco_vanish\A5_eco_vanish.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x50-262 y13-393
quadro 2: caixa x52-300 y15-490
quadro 3: caixa x53-313 y17-492
quadro 4: caixa x57-301 y20-427
quadro 5: caixa x108-270 y96-358
quadro 6: caixa x136-259 y181-339
quadro 7: vazio
quadro 8: vazio
OK
```

---

## 2. Medições e escala do Eco

| Quadro | Altura da figura | Largura | Topo (y) | Base (y) | Distância da base à borda inferior (512 - y) | Status |
|---|---|---|---|---|---|---|
| 1 | **380 px** | 212 px | 13 | 393 | 119 px | ✅ Perfeito (referência A2) |
| 2 | **475 px** | 248 px | 15 | 490 | 22 px | ❌ Escala inflada (+95 px / +25%) e base afundada |
| 3 | **475 px** | 260 px | 17 | 492 | 20 px | ❌ Escala inflada (+95 px / +25%) e base afundada |
| 4 | **407 px** | 244 px | 20 | 427 | 85 px | ❌ Escala inflada (torso e cabeça ampliados) |
| 5 | 262 px | 162 px | 96 | 358 | 154 px | Dissipação dos olhos e fragmentos |
| 6 | 158 px | 123 px | 181 | 339 | 173 px | Rachadura e resíduos finais |
| 7 | vazio | - | - | - | - | ✅ Célula transparente |
| 8 | vazio | - | - | - | - | ✅ Célula transparente |

---

## 3. Continuidade e conformidade com o pedido

- **Regra A5 quadro 1 = A2 quadro 1:** ✅ Perfeito. 0 em 196.608 pixels diferentes (0,00%).
- **Regra de escala fixa do Eco (380 px):** ❌ Grave violação nos quadros 2, 3 e 4. O pedido estipula categoricamente: *"Escala de desenho fixa do Eco: use a mesma escala da A2 entregue e integrada... Na pose de pairar, a figura mede 380 px... Todas as animações do Eco devem manter esse tamanho de cabeça e de corpo"*. No quadro 1 a figura mede 380 px, mas no quadro 2 ela cresce subitamente para **475 px** (um inchaço de 25% na escala do personagem).
- **Regra da linha de apoio / flutuação:** ❌ Grave violação nos quadros 2 e 3. A linha de apoio da A2 fica a 120 px da borda inferior da célula (y=393). Nos quadros 2 e 3, a base despenca para **y=490 e y=492** (a apenas 20 a 22 px da borda da célula). O Eco afunda 97 pixels na célula de um quadro para o outro.
- **Continuidade interna da animação:** ❌ A transição do quadro 1 para o quadro 2 gera um salto visual gritante: o personagem dá um "salto de zoom", aumentando de tamanho e descendo quase até o fundo da célula, antes de se dissolver.

---

## 4. Estilo (DA-01)

- O traço individual e a paleta respeitam a DA-01 e a ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png).
- Sem halo verde, recorte limpo e partículas proporcionadas.
- O problema é estritamente de escala anatômica e alinhamento vertical dos quadros 2 a 4 em relação ao quadro 1.

---

## 5. Lista exata do que refazer (AJUSTE)

- **quadro 2:** figura desenhada em escala excessiva (altura medida de 475 px contra 380 px do quadro 1, aumento de 25%) e base afundada em y=490 (97 px abaixo da linha de flutuação) -> aplicar fator de redução proporcional de escala de ~0,80 (380/475) para coincidir perfeitamente com o tamanho de cabeça e corpo do quadro 1, e alinhar a base em y ≈ 393.
- **quadro 3:** figura com 475 px de altura e base em y=492 -> aplicar fator de redução proporcional de escala de ~0,80 (380/475) e alinhar a base dos pés remanescentes em y ≈ 393.
- **quadro 4:** cabeça e tronco remanescentes desenhados na escala ampliada (altura 407 px) -> aplicar fator de redução proporcional de escala de ~0,80 e manter a cabeça alinhada com o topo do quadro 1 (topo em y ≈ 13–15).
- **quadro 5:** dispersão dos olhos e fragmentos posicionada com base no corpo gigante -> reposicionar a altura dos olhos e fragmentos para coincidirem com o nível do rosto do Eco do quadro 1 (olhos em y ≈ 88).
- **quadro 6:** rachadura e fragmentos finais -> alinhar verticalmente com a altura do peito do Eco normalizado (y ≈ 200–220).
