# DF200 — Céu do crepúsculo de tempestade

Arte aprovada por João Marcelo em 24/11/2026.

| Arquivo | Quadro | Dimensões | Função |
|---|---:|---:|---|
| DF200_ceu.png | 1 | 2.560 × 1.440 | Fundo distante opaco para as Dunas e o vão do Salão, atrás da DF201 e da DF205. |
| DF200_cena.png | 2 montagens + 2 referências | 2.560 × 1.590 | Dois painéis de 1.280 × 720 com a DF205 e o Daymon a 91 px. Capturas proporcionais de Hélix e Verdâmia abaixo. |

## Âncora, escala e valores

Imagem inteira, sem repetição ou espelhamento. Origem superior esquerda (0, 0), centro geométrico (1.280, 720). Centros de câmera demonstrados em x 1.120 e x 1.420, com fonte vertical y 210–1.230, escala de mundo 0,645 e projeção aproximada de 0,71 na tela. A montagem corta os 2 px excedentes em cada extremidade vertical após redução proporcional. Parallax 0,06, a aplicar no Godot.

Céu de tempestade em azuis-marinho de referência #0F1422 e #253045. Faixas de poeira com referência #3A2929, #59403A e #493736, em misturas dessaturadas. O disco é de ferrugem velada. Âmbar #EFAA55 reservado à iluminação funcional. Sem chão e sem construções no asset de céu.

| Região do PNG (y inicial inclusivo, y final exclusivo) | Y′ média | Meta |
|---|---:|---:|
| 210–550 | 0,099 | ≤ 0,110 |
| 550–900 | 0,131 | 0,120–0,150 |
| 900–1.230 | 0,123 | 0,110–0,140 |

Y′ sRGB ponderado (0,2126 R′ + 0,7152 G′ + 0,0722 B′). Pico no sol de 0,235. A área acima de 0,25 é 0,00%. O centro horizontal do disco fica em x ≈ 1.280 e o centro aparente perto de y 742. A parte visível tem largura de ~100 px, medida no recorte do disco pelo limiar Y′ ≥ 0,195, abaixo do limite de 120 px.

| Montagem | Y′ média sem faixa de HUD | Y′ do terço superior (linhas 130–239) | Borda do Daymon com ΔY′ ≥ 0,10 |
|---|---:|---:|---:|
| Dunas, x 1.120 | 0,126 | 0,105 | 83,9% |
| Vão do Salão, x 1.420 | 0,128 | 0,104 | 83,0% |

Perfil oficial do Daymon com a luz de preenchimento simulada da DF00 v2. As montagens são estáticas, com o terreno e as passarelas DF205. A DF201 ainda depende da produção de arte. Parallax, enquadramento na câmera real e separação em movimento ficam para a validação no Godot.

## SHA-256

- DF200_cena.png — `f091284e188dc2720bf068de7c42effd2078ac44c6c42a47fbe96dfd654e6e0d`
- DF200_ceu.png — `b28fbb31a70633d9b2161b17a2f1e84acda1702fd8dadc8ff23dcc1245eec6d1`
