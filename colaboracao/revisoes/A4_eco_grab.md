# Revisão A4_eco_grab: Agarrão no ar (ataque do Eco)

**Resultado:** ✅ **APROVADO**  
**Revisor:** Antigravity (Revisor de Arte Independente)  
**Data:** 12/11/2026 (Ciclo 1 do fluxo automático)  
**Entrega revisada:** [A4_eco_grab.png](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A4_eco_grab/A4_eco_grab.png)  
**Documento de entrega:** [ENTREGA.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A4_eco_grab/ENTREGA.md)  
**Pedido de referência:** [A4_eco_grab.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/pedidos/A4_eco_grab.md)  
**Diretrizes aplicadas:** [DA-01](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png), [D01](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/decisoes/D01_locomocao_eco.md) e revisão [A3_eco_avanco.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/revisoes/A3_eco_avanco.md)

---

## 1. Saída da verificação técnica (`check_art.py`)

Comando de referência: `python tools/fluxo/check_art.py colaboracao/entregas/A4_eco_grab/A4_eco_grab.png --grid 4x2 --cell 384x512`

```text
arquivo: C:\Users\joao.marcelo\AreaJM\Projetos\warp-fracture\colaboracao\entregas\A4_eco_grab\A4_eco_grab.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x22-275 y89-393
quadro 2: caixa x20-273 y83-393
quadro 3: caixa x17-275 y66-393
quadro 4: caixa x3-313 y109-393
quadro 5: caixa x16-277 y92-393
quadro 6: caixa x26-303 y130-393
quadro 7: vazio
quadro 8: vazio
OK
```

---

## 2. Medições e escala do Eco

| Quadro | Altura da figura | Largura | Topo (y) | Base (y) | Distância da base à borda inferior (512 - y) | Status |
|---|---|---|---|---|---|---|
| 1 | 304 px | 253 px | 89 | 393 | 119 px | ✅ Base ideal (120 px pedido) |
| 2 | 310 px | 253 px | 83 | 393 | 119 px | ✅ Base ideal |
| 3 | 327 px | 258 px | 66 | 393 | 119 px | ✅ Base ideal (pico de aviso) |
| 4 | 284 px | 310 px | 109 | 393 | 119 px | ✅ Base ideal (golpe) |
| 5 | 301 px | 261 px | 92 | 393 | 119 px | ✅ Base ideal |
| 6 | 263 px | 277 px | 130 | 393 | 119 px | ✅ Idêntico ao A3 quadro 1 |
| 7 | vazio | - | - | - | - | ✅ Célula transparente |
| 8 | vazio | - | - | - | - | ✅ Célula transparente |

- **Estabilidade da linha de apoio / flutuação:** ✅ Notável. A base dos pixels da figura situa-se em **y=393** em todos os 6 quadros da sequência (exatamente 119 px da borda inferior da célula, cumprindo com extrema precisão a regra de ~120 px).
- **Escala e proporção anatômica:** ✅ Totalmente compatível com as animações A2 e A3. A variação de altura observada (de 263 px a 327 px) reflete com naturalidade o movimento de levantar o tronco e armar o braço com as garras para o golpe diagonal.

---

## 3. Continuidade e transições

- **Regra A4 quadro 6 = A3 quadro 1:** ✅ Absoluta. 0 pixels diferentes em 196.608 pixels (0,00%). A recuperação do golpe emenda perfeitamente no ciclo de avanço flutuante da animação A3.
- **Regra A4 quadro 1 ~ A3 quadro 1:** ✅ Conforme. O quadro 1 realiza a transição da pose de mergulho (35°) para a desaceleração (cerca de 20° de inclinação), mantendo o alinhamento da cabeça e pernas.
- **Leitura do ataque:** Quadros 1 a 3 estabelecem uma antecipação (telegraph) nítida para a esquiva do jogador; o quadro 4 executa o ataque com o corte diagonal descendente; o quadro 5 recolhe o membro.

---

## 4. Estilo (DA-01)

- Respeita rigorosamente a linguagem 2D simplificada da DA-01 e os elementos da ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png).
- Efeitos visuais do arranhão com traços roxos contidos, sem poluição de partículas excessivas.
- Recorte nítido, fundo limpo sem artefatos ou halo verde.

---

## 5. Ressalvas para a integração

1. **Hitbox de dano no quadro 4:** A área perigosa do golpe se estende horizontalmente até x=313 na célula. No nó da entidade Eco em Godot, posicionar o `CollisionShape2D` da área de dano ativo exclusivamente durante o quadro 4.
2. **Âncora do sprite:** Alinhar o ponto de pivô do nó com a posição do tronco (x ≈ 150 px, y ≈ 280 px relativo ao centro da célula) conforme especificado no pedido, para que o movimento de avanço do golpe não desloque a raiz da física do inimigo.
