# DF53 — entrega aprovada

Estado: ENTREGUE após aprovação explícita do responsável.

João Marcelo aprovou as peças e a exceção de escala apresentada para a DF53b, nesta conversa: “gostei, pode seguir”.

## Arquivos

- `DF53a_plataforma_pequena.png` — 1024 × 1024, RGBA, limites visíveis (x0, y0, x1, y1) (212, 226, 812, 798), SHA-256 `217b98d095866a8191027ed94bcc344fd5431eb4fc6557ff885b5a20cd8ac50e`.
- `DF53b_plataforma_grande.png` — 1024 × 1024, RGBA, limites visíveis (x0, y0, x1, y1) (32, 239, 992, 785), SHA-256 `d7db8513acbab5869cdf277bc9d3f52572e8e3aa45598d166be4331fcb316de2`.

## Conteúdo, escala e apoio

Duas plataformas de chapa ferrugem com borda superior clara, correntes verticais e placas de fixação no teto. Correntes presas a olhais na plataforma, com suporte visível nas duas extremidades superiores. A pequena tem 600 px de largura visível (1,5 D em D=400). A grande tem 960 px de largura visível no PNG. As correntes fazem parte da arte estática; qualquer movimento deve ser feito por código.

## Referências e cores

Pedido DF, DA-01 e DF00 aprovada. A DF53 também segue as plataformas da prancha oficial de Elementos do Laboratório Hélix e o piso DF25 aprovado. Metais #7C7F86; ferrugem #6B3A22 / #8A4B2C / #A8552E; sombra #3A2116; ciano #2EC7E6 somente na interação do gancho. Tons auxiliares de sombreamento presentes.

## Verificações

Dimensões, canal alfa, centralização e limites visíveis conferidos. Recorte e normalização técnica aplicados à imagem gerada; os PNGs finais são derivados técnicos, sem alteração manual do desenho. Apoios visíveis; sem animações ou grade; comparação visual com as referências oficiais. Aprovação estética confirmada pelo responsável nesta conversa.

## Exceções / integração

O pedido exige simultaneamente largura literal de 1.200 px (3 D) e canvas de 1.024 × 1.024 px para a grande, o que é impossível sem corte ou redução. EXCEÇÃO APROVADA PELO RESPONSÁVEL: manter o canvas exigido e exportar a grande com 960 px de largura visível (80% de 1.200); na integração, aplicar fator 1,25 para obter 1.200 px no espaço de referência. A pequena permanece em escala 1,00. A grande NÃO cumpre a largura literal de 1.200 pixels dentro do PNG. Esta exceção foi apresentada junto da arte e aprovada pelo responsável. As placas de teto devem ser alinhadas ao teto na integração; a margem transparente não representa uma lacuna física.
