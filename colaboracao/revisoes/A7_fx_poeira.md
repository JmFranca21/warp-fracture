# Revisão A7_fx_poeira: Efeito de poeira de impacto

**Resultado:** ✅ **APROVADO**  
**Revisor:** Antigravity (Revisor de Arte Independente)  
**Data:** 12/11/2026 (Ciclo 1 do fluxo automático)  
**Entrega revisada:** [A7_fx_poeira.png](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A7_fx_poeira/A7_fx_poeira.png)  
**Documento de entrega:** [ENTREGA.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/A7_fx_poeira/ENTREGA.md)  
**Pedido de referência:** [A7_fx_poeira.md](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/pedidos/A7_fx_poeira.md)  
**Diretrizes aplicadas:** [DA-01](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) e referência oficial [Prancha de Elementos do Laboratório Hélix.png](file:///C:/Users/joao.marcelo/AreaJM/Projetos/warp-fracture/.alethe/worktrees/skill-6255f7bf-rev-arte/arte_original/00_Referencias_oficiais/Prancha%20de%20Elementos%20do%20Laborat%C3%B3rio%20H%C3%A9lix.png)

---

## 1. Saída da verificação técnica (`check_art.py`)

Comando de referência: `python tools/fluxo/check_art.py colaboracao/entregas/A7_fx_poeira/A7_fx_poeira.png --grid 4x2 --cell 384x512 --feet 40`

```text
arquivo: C:\Users\joao.marcelo\AreaJM\Projetos\warp-fracture\colaboracao\entregas\A7_fx_poeira\A7_fx_poeira.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x110-273 y393-472  pés a 40 px da base
quadro 2: caixa x74-309 y320-472  pés a 40 px da base
quadro 3: caixa x35-348 y270-472  pés a 40 px da base
quadro 4: caixa x25-359 y245-472  pés a 40 px da base
quadro 5: caixa x25-358 y328-472  pés a 40 px da base
quadro 6: caixa x65-319 y382-472  pés a 40 px da base
quadro 7: vazio
quadro 8: vazio
OK
```

---

## 2. Medições e conformidade técnica

| Quadro | Altura da figura | Largura | Topo (y) | Base (y) | Alinhamento da base (pés a 40 px) | Status |
|---|---|---|---|---|---|---|
| 1 | 79 px | 163 px | 393 | 472 | 40 px da borda inferior (512 - 472) | ✅ Perfeito |
| 2 | 152 px | 235 px | 320 | 472 | 40 px da borda inferior (512 - 472) | ✅ Perfeito |
| 3 | 202 px | 313 px | 270 | 472 | 40 px da borda inferior (512 - 472) | ✅ Perfeito |
| 4 | 227 px | 334 px | 245 | 472 | 40 px da borda inferior (512 - 472) | ✅ Perfeito |
| 5 | 144 px | 333 px | 328 | 472 | 40 px da borda inferior (512 - 472) | ✅ Perfeito |
| 6 | 90 px | 254 px | 382 | 472 | 40 px da borda inferior (512 - 472) | ✅ Perfeito |
| 7 | vazio | - | - | - | - | ✅ Célula transparente |
| 8 | vazio | - | - | - | - | ✅ Célula transparente |

- **Linha de base / apoio do chão:** ✅ Impecável. Todos os 6 quadros ativos têm o limite inferior em **y=472**, deixando exatamente 40 pixels transparentes até a base da célula (y=512), conforme a exigência do teste `--feet 40`.
- **Células e margens:** Grade 4 × 2 (células 384 × 512 px) em canvas de 1536 × 1024 px. As células 7 e 8 são estritamente transparentes. Nada invade células vizinhas nem corta nas bordas.

---

## 3. Análise de Estilo (DA-01)

- **Linguagem visual:** ✅ Nuvem com contornos arredondados claros e estilizados, em perfeita consonância com o estilo cartunizado 2D da DA-01 (sem textura fotográfica ou névoa realista).
- **Paleta e detalhes:** Paleta cinza-azulada coerente (#6E7A8C a #A9B4C2), com faíscas ciano de impacto pontuais no quadro 1 e pequenas lascas metálicas nos quadros 2 e 3 que acompanham a expansão.
- **Dissipação e transparência:** Evolução natural do impacto nos quadros 1 a 3, seguida por quebra central e desvanecimento suave da opacidade nos quadros 4 a 6.

---

## 4. Ressalvas para a integração

1. **Cadência de animação:** Reproduzir entre 10 e 14 fps no nó de efeito (`GPUParticles2D` ou `AnimatedSprite2D`), disparado imediatamente no momento em que o projétil de entulho (A6) atinge o piso.
2. **Posicionamento da âncora:** Configurar a âncora inferior do nó em y=472 (40 px acima da base da célula), garantindo que a poeira brote exatamente sobre a superfície do chão ou da plataforma.
