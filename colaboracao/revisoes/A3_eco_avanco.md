# Revisão A3_eco_avanco: Avanço flutuante agressivo (loop)

**Resultado:** ✅ **APROVADO**  
**Revisor:** Antigravity (Revisor de Arte Independente)  
**Data:** 12/11/2026 (Ciclo 1 do fluxo automático)  
**Entrega revisada:** [A3_eco_avanco.png](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A3_eco_avanco/A3_eco_avanco.png)  
**Documento de entrega:** [ENTREGA.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A3_eco_avanco/ENTREGA.md)  
**Pedido de referência:** [A3_eco_avanco.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/pedidos/A3_eco_avanco.md)  
**Diretrizes aplicadas:** [DA-01](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png), [D01](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/decisoes/D01_locomocao_eco.md) e revisão modelo [A2_eco_float.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/revisoes/A2_eco_float.md)

---

## 1. Saída da verificação técnica (`check_art.py`)

Comando de referência: `python tools/fluxo/check_art.py colaboracao/entregas/A3_eco_avanco/A3_eco_avanco.png --grid 4x2 --cell 384x512`

```text
arquivo: C:\Users\joao.marcelo\AreaJM\Projetos\warp-fracture\colaboracao\entregas\A3_eco_avanco\A3_eco_avanco.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x26-303 y130-393
quadro 2: caixa x22-301 y129-390
quadro 3: caixa x26-301 y125-387
quadro 4: caixa x18-302 y131-393
quadro 5: caixa x18-303 y137-396
quadro 6: caixa x16-302 y142-399
quadro 7: vazio
quadro 8: vazio
OK
```

---

## 2. Medições e escala do Eco

| Quadro | Altura da figura | Largura | Topo (y) | Base (y) | Distância da base à borda inferior (512 - y) | Status |
|---|---|---|---|---|---|---|
| 1 | 263 px | 277 px | 130 | 393 | 119 px | ✅ Base ideal (120 px pedido) |
| 2 | 261 px | 279 px | 129 | 390 | 122 px | ✅ Oscilação de -3 px |
| 3 | 262 px | 275 px | 125 | 387 | 125 px | ✅ Pico de subida (-6 px) |
| 4 | 262 px | 284 px | 131 | 393 | 119 px | ✅ Retorno à base |
| 5 | 259 px | 285 px | 137 | 396 | 116 px | ✅ Descida (+3 px) |
| 6 | 257 px | 286 px | 142 | 399 | 113 px | ✅ Fundo do ciclo (+6 px) |
| 7 | vazio | - | - | - | - | ✅ Célula transparente |
| 8 | vazio | - | - | - | - | ✅ Célula transparente |

- **Escala anatômica do Eco:** ✅ Conforme. A altura medida de 257–263 px decorre da postura inclinada de mergulho frontal (~35°). A proporção da cabeça e do corpo preserva rigorosamente a escala de desenho da folha [A2_eco_float.png](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A2_eco_float/A2_eco_float.png) (distância do topo da cabeça ao centro do olho mede 76 px, plenamente coerente com os 78 px de A2).
- **Linha de flutuação e oscilação:** ✅ Conforme. A base inicia em y=393 (119 px da borda inferior da célula de 512 px, atendendo à especificação de 120 px) e oscila entre 387 e 399 px (amplitude total de 12 px, ou ±6 px), perfeitamente dentro do limite estipulado de ±8 px.

---

## 3. Continuidade e conformidade técnica

- **Verificação de formato:** 1536 × 1024 px, RGBA, alfa min 0 max 255. Grade 4 × 2 com células de 384 × 512 px. Células 7 e 8 estritamente vazias. Nenhuma figura ultrapassa os limites da célula.
- **Continuidade com A2:** A pose de mergulho agressivo decorre harmoniosamente da pose de pairar da A2, permitindo transição fluida na máquina de estados.
- **Loop:** A transição do quadro 6 de volta ao quadro 1 fecha o ciclo de avanço de forma orgânica.

---

## 4. Estilo (DA-01)

- Estilo 2D cartunizado e simplificado plenamente compatível com o Daymon e com a ficha [A0_ficha_eco](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A0_ficha_eco/A0_ficha_eco.png).
- Efeitos visuais contidos (fragmentos roxos discretos, rastro suave sem cobrir o desenho).
- Sombreamento cel com poucos tons, sem texturas ruidosas, sem realismo.
- Recorte limpo e despill bem executado, sem halo verde residual.

---

## 5. Ressalvas para a integração

1. **Variação vertical na passagem 6 → 1:** O centro do olho sobe cerca de 10,5 px na transição do quadro 6 para o quadro 1, enquanto a barra inferior varia 6 px. No teste a 12 fps no Godot, se for percebida uma leve vibração na cabeça, compensar com um microajuste de offset vertical de 1 a 2 px no nó `AnimatedSprite2D` / `eco_frames.tres`.
2. **Registro de âncora:** Centralizar o nó pelo centro do corpo (x ≈ 160–180 px no espaço do frame de avanço) de modo que a colisão de perseguição fique estável horizontalmente.
