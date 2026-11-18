# Warp Fracture — Régua de consistência visual (DA-02)

**Status:** APROVADA pelo João Marcelo em 17/11/2026. Vale para toda arte nova, junto com a [DA-01](PADRAO_VISUAL_OFICIAL.md).
**Histórico:** proposta do Claude a partir da [auditoria do Deserto](../../../docs/auditoria_deserto/) (17/11/2026). R2 corrigida pelo João (17/11). Revisada pelo ChatGPT (17/11): concordou com o diagnóstico, ajustou R1 e R3–R8, propôs R9–R11 e a tabela de evidência. Consolidada pelo Claude.
**Os números de R6, R7 e R9 são metas da primeira rodada.** Serão recalibrados com as referências aprovadas e com as duas fichas v2 (DF02 e DF01) antes de virarem corte definitivo.

## Por que existe

A DA-01 descreve o estilo em palavras. No Deserto isso não bastou: surgiram três famílias visuais.

1. **Laboratório e Verdâmia (aprovadas):** volume construído por massas e facetas de cor, contorno frio só em parte da borda, fundo escuro.
2. **DF00/DF01:** a ferrugem do Robô e da parede ficam em faixas próximas de cor e valor; a lente se vê, o corpo some no fundo quente.
3. **DF02/DF03 e lotes 2–3:** proporção de brinquedo (Autômato com L/A 0,76, como o pedido mandava), contorno fechado preto-marrom e excesso de chanfros, aros, rebites e faixas dividindo a atenção.

Os pedidos e a integração também erraram (pedido de tronco em barril; peças esticadas no jogo). A DA-02 vale para quem desenha, para quem pede e para quem integra.

## Base de medição

Peças aprovadas, escala de ficha **D = 400 px = altura do Daymon** (no jogo, D ≈ 91 px):

| Peça aprovada | Altura | Contorno na borda | Cor do contorno | Saturação média | Cores efetivas |
| --- | --- | --- | --- | --- | --- |
| Daymon (ficha oficial) | 1,00 D | parcial (jaleco sem traço) | azul-marinho | baixa | ~8 |
| Eco (A3) | 0,70 D | 26% | #302389 | 0,85 (energia) | 10 |
| Lince-Vagalume | 0,67 D | 36% | #101923 / #253045 | 0,52 | 8 |
| Mariposa | 0,58 D | 75% (linha fina nas asas) | #2e3035 | 0,22 | 10 |
| Esporângio | 0,86 D | 46% | #1d3d3e | 0,54 | 11 |
| Rainha Micélia | 3,14 D | 19% | #372e4c | 0,43 | 13 |
| Pedra com musgo, Altar | 0,96–1,43 D | 83–93% | #102027–#142426 | 0,49–0,54 | 8–10 |
| Arco PT10 | 2,30 D | 97% | #0f1422 | 0,38 | 12 |

Fora da régua no Deserto: Autômato DF90 (1,08 D, L/A 0,76, contorno 96% #23191a); Robô DF60 (0,77 D, 87% #221513, corpo some no fundo); Drone DF01 (0,35 D × 0,60 D); Forja-Mãe DF100 (3,62 D, 95% #2c1c1b, faixas sem perigo associado). Detalhe: a média de saturação do DF90 (0,475) e do DF100 (0,518) **passa** na faixa. A média sozinha não pega o problema, por isso existem R9–R11.

## As regras

### R1. Escala
- D = 400 px. Inimigos terrestres **0,55–1,00 D**. Voadores: **A ≥ 0,55 D ou L ≥ 0,70 D**, medindo corpo e superfícies visíveis (não a hélice solta). Chefes **2,50–3,50 D**. Interativos de porte comum **0,50–1,50 D**.
- Estruturas atravessáveis (portais, arcos) e formas jogáveis recebem cota própria na ficha.
- Escala sempre uniforme no sprite e nos nós acima dele: `abs(scale.x) = abs(scale.y)`.
- **Medir:** caixa da máscara do corpo com alfa ≥ 128, sem halo nem efeito solto, na pose de jogo; A/D, L/D e L/A. Sprites compostos: corpo e montagem em separado.

### R2. Formas do Daymon pertencem ao universo
- A forma **não precisa seguir a estética do Daymon**. Ela segue a estética do universo em que aparece, como um ser nativo dali. O Lince-Vagalume é muito diferente do Daymon e funciona porque combina com Verdâmia (observação do João, 17/11/2026). Ele é exemplo do princípio, **não modelo** para as outras formas.
- A forma se distingue dos inimigos da fase pelo **conjunto de silhueta, postura e ação**. A distinção tem que sobreviver em silhueta (sem cor), a ~90 px, sem depender do rosto.
- Vale para ela todo o resto da régua. Cotas de tamanho e proporção ficam na ficha de cada forma.

### R3. Contorno
- Personagens e inimigos: traço escuro em **no máximo 50% do perímetro externo**, cedendo à luz de recorte.
- Exceção: linha estrutural fina em apêndices claros (asas da Mariposa), indicando a referência aprovada e registrando a cobertura total.
- Objetos inertes podem fechar **até 100%** da borda com traço fino e frio. Chefe integrado ao cenário segue a regra de inimigo na montagem ativa.
- **Cores de contorno: só amostras frias aprovadas**, `#101923`, `#1D2A3C`, `#253045`, `#302389`, `#372E4C` (B > R). Nunca preto puro nem marrom-preto, mesmo na ferrugem.
- **Medir:** perímetro da máscara, trechos com faixa escura distinta do preenchimento ÷ perímetro total; hex no miolo do traço, fora do antialias. Linhas internas à parte (R9).

### R4. Tons
- **2–3 tons por material dominante**; 1 tom em detalhes pequenos. Volume por planos chapados; desgaste em manchas localizadas, sem textura espalhada nem degradê.
- **Até 12 cores efetivas** no corpo, contando contorno e núcleo sólido dos acentos. Halos, partículas e efeitos ficam fora da conta.

### R5. Saturação
- **0,20–0,55 (HSV)** de média é triagem, não aprovação: olhar também a distribuição.
- **S > 0,80 em até 10% da área sólida**, só em energia e sinal de perigo. Entidades de energia (Eco) têm orçamento próprio documentado.
- Listras de aviso só numa superfície ou zona de perigo identificável no jogo.

### R6. Valores da cena
- Fundo jogável com luma média **≤ 0,20**, em `Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′` (canais 0–1), medida em recortes da área jogável sem HUD.
- **Contraste local:** diferença de **≥ 0,10 de luma** em pelo menos **⅔ do perímetro visível** da figura nos fundos típicos. Onde a separação depender de matiz, validar em cor na escala de jogo e registrar.
- Universo quente usa fundo quente **escuro** e figuras com sombras frias. Exterior claro precisa de validação na faixa onde há combate.

### R7. Ponto de leitura dos inimigos
- Uma **região focal** (olho, máscara, boca, lanterna, núcleo ou grupo compacto de marcas) com **4–10% da silhueta sólida**, sem contar o halo. Pontos menores são aceitos se passarem no teste de jogo.
- Diferença de **≥ 0,20 de luma** entre o foco e o entorno; núcleo de **≥ 2 px no eixo menor** na escala de jogo.
- O foco também indica a ameaça: para onde o inimigo ataca (canhão horizontal do Robô, lente inferior do Drone).
- No Deserto o foco não usa a cor do fundo (laranja ou âmbar sobre ferrugem); vermelho é a cor de perigo.

### R8. Paleta
- Por universo: **uma família dominante de material**, os materiais de apoio e as **cores de estado** (cada uma com função fixa).
- Sombra de referência: o azul-marinho comum `#0F1422` a `#253045`.
- Deserto: ferrugem na face exposta das chapas; ferro frio nas juntas e cavidades; chapa clara onde um plano precisa destacar; ciano, âmbar e vermelho só com função por peça e estado.

### R9. Espessura e linhas internas
- Traço escuro com **mediana ≤ 1% de D (4 px)** e **P90 ≤ 1,5% de D (6 px)** na ficha; no jogo isso dá cerca de 0,9 e 1,35 px.
- Linhas internas contadas à parte: uma junta pode ter linha; **cada rebite e cada placa fechados por linha escura recriam o acabamento rejeitado**, mesmo com metade da borda externa aberta.
- Objetos inertes: espessura comparada ao PT10 ou à pedra de musgo na escala de jogo.

### R10. Construção da sucata (e de materiais em geral)
- Chapas em **planos grandes**; luz de recorte na mesma direção em todas as peças da cena.
- Rebite só onde se vê uma união; desgaste onde há quina, atrito ou impacto.
- Reduzir aros concêntricos, chanfros repetidos e molduras em volta de cada placa quando competirem com a silhueta.
- **Olhos e lentes:** a função é padronizada por inimigo e por estado; a geometria varia. O visor do herói e a lente dos inimigos se distinguem mesmo em cinza.

### R11. Aprovação na montagem
- A peça é aprovada **como entra no jogo**: escala uniforme, pivôs e encaixes conferidos nas poses de espera e de ação.
- Peças montadas (braço, lente, núcleo, escotilhas, martelos) são conferidas montadas, em repouso e em aviso.
- Composição esticada, ou sinal que muda de posição sem motivo, volta para correção mesmo se os PNGs isolados passaram.

## Evidência em cada entrega

1. **`<ID>_comparacao.png`**: a peça, Daymon a **400 px** e uma referência aprovada do mesmo tipo, com orientação e apoio alinhados; a mesma linha com Daymon a **~90 px** sobre o fundo da fase, e também o recorte de pior contraste, se for outro. Referências combinadas:
   - forma jogável: o Lince (forma aprovada) e o inimigo comum da fase (teste de distinção);
   - inimigo de tiro horizontal: a Turreta do Laboratório; voador: o Drone do Laboratório;
   - objeto: PT10 ou a pedra de musgo.
2. **`ENTREGA.md`** com pose, quadro, estado e referência usados e a tabela:

| Medida | Meta | Resultado |
| --- | --- | --- |
| A/D, L/D, L/A | R1 e ficha | |
| Hex do contorno | R3 | |
| % do perímetro com contorno | R3 | |
| Espessura mediana / P90 | R9 | |
| Tons por material; cores efetivas | R4 | |
| S médio; S dos acentos; área com S > 0,80 | R5 | |
| Luma do fundo; contraste local | R6 | |
| Área e tamanho do foco (inimigos) | R7 | |
| Resultado em jogo (silhueta, distinção, leitura) | R2, R11 | |

Metas escritas na ficha entram como metas; medidas do PNG e da montagem entram como resultados. O que não se aplica é marcado; exceções são justificadas. Se algo sair da régua, o João decide antes do upload.

## Do lado do desenvolvimento

- Escala uniforme sempre; nada de esticar peça para caber num retângulo.
- Antes de cada entrega de fase: prancha das figuras na escala do jogo (`tools/lineup.gd`) e capturas de cena, conferidas contra R1, R6, R7 e R11.
- Pedidos de arte seguem esta régua: nada de pedir proporção, contorno ou detalhe que ela proíbe.
- Nada de preencher parede, teto ou peça faltando com cor chapada: se falta arte, o desenvolvimento pede.
