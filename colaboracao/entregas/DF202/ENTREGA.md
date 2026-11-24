# DF202 — Fundos internos da Fábrica e do Salão do Núcleo

Publicação autorizada por João Marcelo em 24/11/2026.

| Arquivo | Dimensão | Âncora em pixels do arquivo | Função |
|---|---:|---|---|
| DF202_fabrica.png | 2.048 × 2.048, RGB opaco | (0, 2.048), borda inferior | Estrutura de fundo da Fábrica. Vigas transversais, pilares, tubulações, passarelas apoiadas e janelas altas. |
| DF202_salao.png | 2.048 × 2.048, RGB opaco | (0, 2.048), borda inferior | Estrutura de fundo do Salão. Arcos recuados, pilares, passarelas e pontes sustentadas por correntes. |
| DF202_cena.png | 2.560 × 1.885 | Montagem | Duas vistas de 1.280 × 720, capturas de Hélix e Verdâmia em escala proporcional e ampliação da emenda horizontal. |

## Escala e montagem

Texturas a 2×. Cada repetição ocupa 1.024 px de mundo no eixo horizontal. O ritmo interno combina dois vãos com desenho diferente, dentro do período completo. A união comprovada é entre x 2.047 e x 0 da textura inteira. Alinhar o pé à base do cenário. As prévias projetam 0,55 px de tela por pixel do arquivo, com zoom 1,1. No Salão, a câmera alta mostra as passarelas DF205, e a base da textura permanece no nível do piso inferior.

Usar no fundo atrás dos inimigos, máquinas, sinalizadores, terreno e elementos interativos. As novas paredes pertencem aos trechos internos. O vão aberto do Salão mantém DF200/DF201. A Câmara da Forja recebe o fundo da DF203.

## Materiais e valores

Referência de produção DF00 v2. Azul-marinho #0F1422 e #253045 nos vazios e nas sombras. Ferrugem #3A2929 e #493736 em grandes áreas. Vigas e aço #1D2A3C e #3B3237. Janelas e indicadores com âmbar contido da família #EFAA55. Os tons do PNG são misturas dessaturadas, com a luz concentrada nas janelas e nos indicadores.

| Ambiente | Y′ média do PNG | Pico do PNG | Y′ média da cena | Terço superior | Densidade de bordas | Área lisa | ΔY′ do Daymon | Borda separada |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Fábrica autônoma | 0,111 | 0,247 | 0,132 | 0,118 | 0,060 | 0,161 | 0,422 | 98.2% |
| Salão do Núcleo | 0,105 | 0,247 | 0,116 | 0,109 | 0,048 | 0,184 | 0,433 | 96.3% |

Y′ sRGB e Sobel conforme DA-03, com a faixa das primeiras 130 linhas excluída. As colunas x 0 e x 2.047 coincidem pixel a pixel em RGB nas duas texturas. A prancha mostra a união no meio dos recortes inferiores. O Daymon mede 91 px e foi montado com a luz de preenchimento simulada da DF00 v2. As métricas referem-se às montagens estáticas, sem primeiro plano novo. A leitura em movimento, a repetição em ultrawide e a combinação com a DF204 ficam para a validação no Godot.

## SHA-256

- `DF202_cena.png` — `ccfa588a76ca9e7eb7023a971d47a21a1cb157f90ea524cf4c79bd2966c2ebe6`
- `DF202_fabrica.png` — `3c33ca3130626d9028e3225132cf205fa8b5c00b4f21ab7297d97994d363b8bc`
- `DF202_salao.png` — `f694ac78f90b95a07e7cd9d009e195d0a8550474d66bb8bc075592e014e99a1a`
