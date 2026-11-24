# GL02 — Revisão de acabamento

João Marcelo aprovou o acabamento v2 e autorizou sua publicação em 24/11/2026.

## Conferência

Dimensões de produção conservadas: Gelinho 229 × 240 px, Drone 460 × 189 px e Morcego 352 × 212 px. D = 400 px. Porcentagem vermelha medida nas poses principais da ficha: 4.40%, 4.55%, 4.45%. As três passam no intervalo de 4–10%. Cores intermediárias de pintura e suavização contam como mistura; os números da aferição antiga descrevem o raster v1.

Comparação a 200%: cada pixel dos quatro recortes é mostrado em 2 × 2 pixels. A pintura das peças foi gerada com referências oficiais; a montagem usa recortes das imagens originais. Na GL04, o detalhe principal é o aro do gancho.

## SHA-256

- GL02_comparacao_v2.png — `701f579b22707fcc768bef8f59515249954b0c2f528363eb12c1a4fc46b6b55f`

- GL02_ficha_inimigos_nivaria_v2.png — `33730fcb39379ad0073107cb8278c42d520c2e279768a3bf0491bc5910738472`

## Medição complementar na comparação

| Perfil | S médio | Área S > 0,80 | Menor fração da borda com contraste ≥ 0,10 |
|---|---:|---:|---:|
| Gelinho | 0.316 | 0.40% | 79.2% |
| Drone | 0.354 | 0.49% | 81.0% |
| Morcego | 0.372 | 0.35% | 74.0% |

HSV em pixels de cobertura ≥ 75%; contraste de luma sRGB em escala de jogo sobre os quatro recortes da GL00. Metas: S médio entre 0,20 e 0,55, área muito saturada ≤ 10%, contraste em ≥ 66,7% da borda. A contagem exata de cores e os percentis de espessura de linha da v1 não foram reconfirmados na pintura suavizada.

| Foco no perfil pintado | ΔY′ médio contra anel de 2 px | Borda próxima de uma cor de contorno DA-02 |
|---|---:|---:|
| Gelinho | 0.215 | 5.0% |
| Drone | 0.251 | 8.9% |
| Morcego | 0.245 | 2.8% |

Amostras a 2 px para dentro da máscara, excluindo a mistura com o fundo no antialiasing; classificação por distância euclidiana RGB ≤ 25 para incluir a suavização.
