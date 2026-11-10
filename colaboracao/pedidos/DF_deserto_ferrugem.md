# Pedido DF: pacote de arte da fase Deserto de Ferrugem

**Para:** ChatGPT (diretor de arte)
**De:** Claude (desenvolvimento)
**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md). Em caso de conflito, a DA-01 vale mais que este pedido.
**Base da fase:** [detalhamento da fase](../../docs/fases/deserto_ferrugem/detalhamento_da_fase.md) e [esboço do layout](../../docs/fases/deserto_ferrugem/esboco_da_fase.png), escritos pelo autor da fase. Leia os dois antes de começar.

Este pedido lista **todos os assets** da fase: cenário, terreno, mecanismos, inimigos e efeitos. Cada asset tem um ID (DF00, DF01...) e segue o fluxo normal do `PROTOCOLO.md`:
1. Gere o asset.
2. Apresente ao João Marcelo.
3. Suba **só o que ele aprovar** em `colaboracao/entregas/<ID>/`.
4. Atualize o `STATUS.md`.

---

## 1. A fase em resumo

Fase 2D de rolagem horizontal, da esquerda para a direita, em três zonas:

| Zona | O que tem | Clima visual |
|---|---|---|
| **Dunas de sucata** | Céu aberto, dunas de sucata, um mastro enferrujado com gancho sobre um fosso de espinhos, um drone e um robô | Externo, luz quente de fim de tarde, poeira no ar |
| **Fábrica autônoma** | Prédio por dentro: esteira com 2 prensas e 1 serra, plataformas suspensas, engrenagem gigante no fundo, abertura na parede com gancho | Interno, âmbar das janelas, máquinas funcionando sozinhas, sem operários |
| **Núcleo central** | Corredor suspenso por cabos, torre do Núcleo, plataforma vertical em trilhos, salão escuro com lâmpadas âmbar, plataforma móvel, válvulas de vapor, porta de saída | Interno escuro, mais mecânico e opressivo |

**Personagem jogável:** o Daymon em forma humana, já pronto no jogo. Ele anda, pula, atira e usa o gancho. **Não desenhe o jogador.** Os itens coletáveis também já existem (Células de Fase).

**Sensação geral:** um deserto onde as máquinas continuam trabalhando depois que todos foram embora. Ferrugem, poeira e luzes âmbar. Os perigos se destacam em vermelho e cinza metálico, e o que o jogador pode usar (gancho) se destaca em ciano.

## 2. Paleta da fase

| Uso | Cores (referência) |
|---|---|
| Céu e luz ambiente | laranja-poeira #E8B98A, #F2CDA0, sol creme #F7E3BE |
| Estruturas e ferrugem | marrom #6B3A22, #8A4B2C, ferrugem #A8552E, sombra #3A2116 |
| Luzes das fábricas | âmbar #F2B24C, #E8963A |
| Perigos | vermelho #C8402F, cinza metálico #7C7F86 |
| Pontos de gancho (interação) | ciano #2EC7E6, o mesmo do Traje Âncora |
| Chão e areia | areia #D9A877, #C08A5A |

Use poucos tons por superfície e o mesmo sombreamento econômico das referências oficiais. A ferrugem é feita com **áreas de cor definidas**, e não com textura realista de manchas e arranhões.

## 3. Referências obrigatórias (no repositório)

- `arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png`: o padrão de objetos e cenários. Mesma geometria simples, mesmo tipo de contorno e de sombra.
- `arte_original/00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png`: o padrão dos robôs inimigos. O Robô e o Drone do deserto devem parecer **primos de fábrica** do Drone e do Rastejador do laboratório.
- `arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png`: a escala. O Daymon de referência mede **400 px de altura** no desenho, e todo o resto se mede em relação a ele.
- `docs/fases/deserto_ferrugem/esboco_da_fase.png`: o layout e a função de cada elemento. O esboço é um diagrama: **não copie o traço dele**.

## 4. Regras técnicas (recorte automático; siga à risca)

**Escala:** use **D = 400 px**, a altura do Daymon no desenho. Cada asset abaixo informa o tamanho em D.

**A) Animação (spritesheet):**
- Um PNG de **1536 × 1024 px** por animação, com grade **invisível** de 4 colunas × 2 linhas (células de **384 × 512 px**), em ordem de leitura. Células que sobrarem ficam vazias.
- Fundo **transparente**. Se não for possível, use verde chapado #00FF00, uniforme e sem gradiente.
- Personagens e inimigos olham para a **direita**.
- **Âncora fixa** informada em cada pedido (ex.: pés a 40 px da borda de baixo), exatamente igual em todos os quadros.
- Mesma escala em todos os quadros. Nada sai da célula. Sem texto, grade, chão ou sombra projetada.

**B) Objeto estático (prop):**
- Um PNG de **1024 × 1024 px** por objeto, com fundo transparente, centralizado.
- **Ponto de apoio visível**, para nada parecer flutuando no jogo (regra do responsável): base plana no chão, corrente ou suporte no teto, ou placa de fixação na parede. Informe o apoio no `ENTREGA.md`.

**C) Textura repetível (tile):**
- PNG com o tamanho indicado, **emendável na horizontal**: a borda esquerda continua exatamente a direita. Quando indicado, também na vertical.
- Para conferir, coloque duas cópias lado a lado e verifique se a emenda some.

**P) Fundo em camadas (parallax):**
- PNG de **2048 × 1024 px**, emendável na horizontal.
- Fundo transparente acima da silhueta (exceto o céu, que é opaco).
- Sem personagens e sem elementos de jogabilidade.

**E) Peças animadas por código:** prensas, serra, engrenagem, esteira, plataformas e lâmpadas são **montadas em peças separadas**, e o jogo anima o movimento (subir e descer, girar, deslizar, piscar). Entregue as peças estáticas pedidas, e não animações delas.

**Nomes de arquivo:** `DFxx_nome.png`, exatamente como na lista. Variações levam `_v2`. Não apague versões anteriores.

---

## 5. Lista de assets

### Etapa 1: direção de arte (faça primeiro e aprove antes do resto)

| ID | Arquivo | Formato | O que é |
|---|---|---|---|
| **DF00** | `DF00_prancha_deserto.png` | 1536 × 1024, ficha com texto permitido | **Prancha de referência do Deserto de Ferrugem**, no mesmo estilo da Prancha de Elementos do Laboratório. Inclui: amostra da paleta, um trecho de chão de areia com sucata, um pedaço de parede de fábrica com janela âmbar, a prensa, a serra, um ponto de gancho do deserto e uma amostra de espinhos. Depois de aprovada, vira a referência de todos os itens abaixo. |
| **DF01** | `DF01_ficha_inimigos_deserto.png` | 1536 × 1024, ficha com texto permitido | **Ficha do Robô e do Drone do deserto**, de frente e de lado, ao lado de um Daymon em silhueta para escala. Veja a descrição na seção 5.6. |

### Etapa 2: fundos em parallax (Dunas; formato P)

| ID | Arquivo | Formato | Conteúdo |
|---|---|---|---|
| DF10 | `DF10_fundo_ceu.png` | P, opaco | Céu laranja-poeira em degradê suave (mais claro perto do horizonte), sol grande e pálido à esquerda, 2 ou 3 nuvens de poeira achatadas. O sol pode ser uma peça separada, `DF10b_sol.png` (1024 × 1024). |
| DF11 | `DF11_fundo_fabricas_distantes.png` | P | Silhuetas de fábricas, chaminés e torres muito ao fundo, em 1 ou 2 tons de laranja-acinzentado, quase sem detalhe. Fumaça parada saindo de 2 ou 3 chaminés. A base é uma linha de horizonte contínua. |
| DF12 | `DF12_fundo_dunas_sucata.png` | P | Dunas médias com sucata meio enterrada (chapas, rodas, canos), em tons de areia e marrom mais escuros que o DF11. A base é contínua. |

### Etapa 3: terreno e paredes (texturas repetíveis, formato C)

| ID | Arquivo | Formato e tamanho | Conteúdo |
|---|---|---|---|
| DF20 | `DF20_chao_dunas.png` | C, 512 × 256, horizontal | Chão das Dunas: os 40 px de cima são a **borda pisável** (areia compacta com pedacinhos de metal); abaixo, terra e sucata compactada escurecendo para baixo. |
| DF21 | `DF21_espinhos.png` | C, 256 × 128, horizontal | Espinhos de metal enferrujado em fileira, com pontas cinza-claro e base escura. As pontas ficam no topo e a base reta embaixo. Devem ser lidos como **perigo** de imediato. |
| DF22 | `DF22_parede_fabrica_externa.png` | C, 512 × 512, horizontal e vertical | Fachada da fábrica: chapas rebitadas marrom-ferrugem, com uma janela âmbar acesa por bloco. |
| DF23 | `DF23_parede_fabrica_interna.png` | C, 512 × 512, horizontal e vertical | Fundo interno da Fábrica, mais escuro que a fachada: chapas, um pilar e um cano horizontal. Fica atrás do jogador e não pode competir com os perigos. |
| DF24 | `DF24_parede_salao_nucleo.png` | C, 512 × 512, horizontal e vertical | Fundo do Salão do Núcleo, o mais escuro da fase: marrom quase preto, painéis grandes e poucas linhas. |
| DF25 | `DF25_piso_plataforma_metal.png` | C, 512 × 64, horizontal | Piso de metal para plataformas, corredor e salão: chapa com rebites e borda superior clara. |
| DF26 | `DF26_esteira.png` | C, 512 × 96, horizontal | Esteira: faixa escura com setas âmbar apontando para a **direita** e rolos por baixo. O jogo rola a textura. Mais duas peças estáticas: `DF26b_esteira_ponta_esq.png` e `DF26c_esteira_ponta_dir.png` (256 × 256), que são as engrenagens das pontas. |
| DF27 | `DF27_trilho_vertical.png` | C, 128 × 512, vertical | Trilho da plataforma vertical: duas guias metálicas com travessas. |
| DF28 | `DF28_cabo.png` | C, 256 × 32, horizontal | Cabo de aço trançado, que o jogo estica e gira entre dois pontos. |

### Etapa 4: objetos de cenário (props estáticos, formato B)

| ID | Arquivo | Tamanho no desenho | Apoio | Conteúdo |
|---|---|---|---|---|
| DF30 | `DF30_monte_sucata_1.png` / `_2.png` | 0,6 D de altura, 1,2 D de largura | chão | Montes de sucata: chapas, engrenagens e um pneu, em 2 variações. Decorativos, sem ar de perigo. |
| DF31 | `DF31_mastro_viga.png` | 3 D de altura, viga de 2 D | chão | Mastro enferrujado com uma viga horizontal no topo, apontando para a **direita**, e um olhal na ponta, onde o jogo prende o gancho. Base com sapata parafusada no chão. |
| DF32 | `DF32_chamine.png` | 2,5 D de altura | chão ou telhado | Chaminé de fábrica com faixas e rebites, boca escura no topo. |
| DF33 | `DF33_porta_fabrica.png` | 1,3 D de altura | chão | Porta escura de entrada da fábrica, com moldura metálica e uma luz âmbar em cima. |
| DF34 | `DF34_engrenagem_fundo.png` | 3 D de diâmetro | parede (eixo central) | Engrenagem gigante do fundo da Fábrica, de frente, com eixo central parafusado. O jogo gira a peça, então ela deve parecer correta em qualquer ângulo. É decorativa: tons recuados. |
| DF35 | `DF35_abertura_parede.png` | 1,5 D de altura | parede | Abertura retangular na parede direita da Fábrica, perto do teto, com batente metálico e luz âmbar vindo de fora. É por ela que o jogador sai para o corredor. |
| DF36 | `DF36_torre_nucleo.png` | formato 1024 × 2048 (vertical) | chão | Torre do Núcleo vista de fora: estrutura alta com um núcleo âmbar pulsando no meio e pontos de fixação para os cabos do corredor. |
| DF37 | `DF37_lampada_ambar.png` | 0,3 D | teto (haste ou corrente) | Lâmpada industrial âmbar, pendurada. O jogo faz a luz piscar. Entregue também `DF37b_lampada_apagada.png`. |
| DF38 | `DF38_porta_saida.png` | 1,5 D de altura | chão | Porta de saída da fase, em 2 estados: `_fechada` e `_aberta` (luz âmbar e passagem iluminada). |
| DF39 | `DF39_painel_controle.png` / `DF39b_canos.png` | 1 D | parede ou chão | Enfeites internos: um painel de controle com luzes âmbar e um conjunto de canos com válvulas. Servem para quebrar paredes vazias. |

### Etapa 5: mecanismos e perigos (peças, formato B; o jogo anima)

| ID | Arquivo(s) | Tamanho no desenho | Conteúdo e regras |
|---|---|---|---|
| DF50 | `DF50a_prensa_cabeca.png`, `DF50b_prensa_haste.png`, `DF50c_prensa_suporte.png` | cabeça com 1,6 D de largura e 0,5 D de altura | **Prensa grande**, em 3 peças: cabeça (bloco pesado com faixas de perigo vermelhas e cinza na face de baixo), haste do pistão (repetível na vertical, 128 × 512) e suporte de teto (a peça que a prende ao teto). A face de baixo precisa ser lida como **área de esmagamento**. |
| DF51 | `DF51a_prensa_pequena_cabeca.png`, `DF51b_..._haste.png`, `DF51c_..._suporte.png` | cabeça com 1 D de largura | **Prensa pequena** do corredor, no mesmo desenho da grande, mais compacta. |
| DF52 | `DF52_serra.png` + `DF52b_serra_base.png` | 0,8 D de diâmetro | **Serra circular**: disco com dentes vermelho-metálicos, vista de frente, girada pelo jogo. A base é o suporte fixo onde o disco se encaixa na esteira. |
| DF53 | `DF53a_plataforma_pequena.png`, `DF53b_plataforma_grande.png` | 1,5 D e 3 D de largura | **Plataformas suspensas** da Fábrica: chapa de metal com borda superior pisável e **correntes ou hastes subindo até o teto** (as correntes podem sair pela borda de cima da imagem, que o jogo estende). |
| DF54 | `DF54_plataforma_vertical.png` | 1,4 D de largura | **Plataforma vertical** (elevador): piso com guias laterais que encaixam no trilho DF27 e uma luz âmbar de "em movimento". |
| DF55 | `DF55_plataforma_movel.png` | 1,6 D de largura | **Plataforma móvel horizontal** do salão: carrinho suspenso num trilho superior por 2 hastes, com rodinhas no trilho. Entregue também `DF55b_trilho_horizontal.png` (textura C, 256 × 64). |
| DF56 | `DF56_valvula_grade.png` | 1 D de largura | **Válvula de vapor:** grade de metal no chão, com bocal e luz que fica vermelha antes do jato. Entregue 2 estados: `_inativa` e `_aviso` (luz vermelha). |
| DF57 | `DF57_ponto_gancho.png` | 0,35 D | **Ponto de gancho do deserto:** argola metálica com anel **ciano** brilhando de leve, presa por um suporte curto em cima. Deve ser o objeto mais fácil de achar na tela. |

### Etapa 6: inimigos (fichas na DF01, animações em formato A)

**Robô** (as regras de jogo estão no detalhamento):
- **Aparência:** corpo quadrado de metal escuro, cabeça pequena com **um olho âmbar** e um cano curto na frente. Anda sobre esteiras ou pés curtos.
- **Tamanho:** 0,9 D de altura e 0,8 D de largura.
- **Âncora:** pés a 40 px da borda de baixo da célula, centro do corpo em x = 192.
- **Leitura:** pesado, lento e teimoso. Parente do Rastejador do laboratório.

| ID | Arquivo | Quadros | O que acontece |
|---|---|---|---|
| DF60 | `DF60_robo_idle.png` | 4 (loop) | Parado, com um leve balanço e o olho piscando fraco. |
| DF61 | `DF61_robo_andar.png` | 6 (loop) | Patrulha: passos curtos e pesados. |
| DF62 | `DF62_robo_aviso.png` | 3 | **Aviso** antes de atirar: para, o olho acende forte e o cano levanta. No jogo dura cerca de 0,5 s, e precisa ser muito claro. |
| DF63 | `DF63_robo_tiro.png` | 3 | Disparo para a frente: recuo do corpo e clarão na boca do cano. |
| DF64 | `DF64_robo_dano.png` | 2 | Recebe dano: tranco para trás e faíscas pequenas. |
| DF65 | `DF65_robo_destruido.png` | 6 | Desmonta: o olho apaga, peças soltam e ele cai num monte com fumaça. O último quadro fica parado. |

**Drone do deserto:**
- **Aparência:** corpo **oval achatado**, **hélice no topo** e **olho vermelho embaixo**.
- **Tamanho:** 0,6 D de largura e 0,35 D de altura.
- **Âncora:** centro do corpo no centro da célula (192, 256).
- **Leitura:** leve e vigilante. Parente do Drone do laboratório, com cores de ferrugem.

| ID | Arquivo | Quadros | O que acontece |
|---|---|---|---|
| DF66 | `DF66_drone_voo.png` | 6 (loop) | Hélice girando e corpo oscilando levemente (±6 px). |
| DF67 | `DF67_drone_aviso.png` | 3 | **Aviso:** o olho vermelho pisca forte e aponta para baixo. |
| DF68 | `DF68_drone_tiro.png` | 3 | Disparo **para baixo**: recuo para cima e clarão sob o olho. |
| DF69 | `DF69_drone_dano.png` + `DF69b_drone_destruido.png` | 2 + 6 | Dano: tranco e faíscas. Destruído: a hélice para, o drone gira e cai soltando fumaça, e termina fora do quadro ou como sucata no último quadro. |

**Projéteis:**

| ID | Arquivo | Quadros | O que é |
|---|---|---|---|
| DF70 | `DF70_projetil_robo.png` | 4 (loop) | Bola de energia âmbar alongada na horizontal, com 0,15 D. Centro da célula. |
| DF71 | `DF71_projetil_drone.png` | 4 (loop) | Gota de energia vermelha alongada na vertical, apontando para baixo, com 0,12 D. Centro da célula. |

### Etapa 7: efeitos (formato A; centro da célula, salvo indicação)

| ID | Arquivo | Quadros | O que é |
|---|---|---|---|
| DF80 | `DF80_fumaca_chamine.png` | 6 (loop) | Fumaça saindo de uma chaminé, em blocos arredondados cinza-alaranjados. A boca da chaminé fica no centro da borda de baixo da célula. |
| DF81 | `DF81_jato_vapor.png` | 8 | Jato de vapor de uma válvula: nasce na borda de baixo da célula, sobe até cerca de 2 D (pode ocupar a célula toda na altura), se mantém e se dissipa. Branco-acinzentado, com o núcleo mais denso. **A forma precisa mostrar com clareza a área que causa dano.** |
| DF82 | `DF82_faiscas_prensa.png` | 6 | Faíscas e poeira de impacto quando a prensa bate. A base fica na linha de chão (40 px da borda de baixo). |
| DF83 | `DF83_poeira_areia.png` | 6 | Poeira de areia do pouso e dos passos na areia, em tom areia. Base na linha de chão. |
| DF84 | `DF84_explosao_maquina.png` | 8 | Explosão de inimigo destruído: clarão âmbar, fumaça escura e 3 ou 4 peças voando. |
| DF85 | `DF85_impacto_projetil.png` | 4 | Impacto de projétil inimigo na parede ou no chão: estouro pequeno âmbar e vermelho. |
| DF86 | `DF86_particulas_vento.png` | 8 células | Partículas soltas de vento: grãos de areia, folhas de metal e fiapos de poeira, **uma partícula por célula**. O jogo espalha essas partículas pela tela. |

---

## 6. Ordem de produção

1. **DF00 e DF01** (direção de arte e inimigos). **Aguarde a aprovação do João Marcelo antes de seguir.**
2. **Primeiro bloco jogável:** DF20, DF21, DF25, DF57, DF53, DF50, DF52, DF26, DF60–DF65 e DF66–DF71. Com isso a fase já funciona com arte final.
3. DF10–DF12 e DF22–DF24 (fundos e paredes).
4. Os demais objetos, mecanismos e efeitos.

## 7. Entrega de cada asset

- Pasta: `colaboracao/entregas/<ID>/`. Exemplo: `colaboracao/entregas/DF60_robo_idle/`.
- `ENTREGA.md` com:
  - a lista dos quadros ou peças;
  - o apoio do objeto;
  - as cores usadas;
  - a confirmação da aprovação do responsável;
  - o SHA-256 do PNG;
  - qualquer regra que não conseguiu cumprir.
- Atualize a linha do asset no `STATUS.md` para `ENTREGUE`. Assets entregues juntos podem ser registrados juntos.

## 8. Checklist antes de apresentar cada peça

- [ ] O estilo bate com as referências oficiais, lado a lado (DA-01)?
- [ ] O tamanho do PNG e a grade estão certos? O fundo é transparente?
- [ ] A âncora ou o apoio está exatamente onde o pedido manda, em todos os quadros?
- [ ] O tamanho em D está correto? Compare com o Daymon de 400 px.
- [ ] Perigos são lidos como perigo (vermelho e cinza)? O gancho se destaca em ciano?
- [ ] Nada flutua sem apoio (exceto efeitos, projéteis e o entulho que cai)?
- [ ] As texturas emendam sem marca visível?
- [ ] Reduzida à escala do jogo, a peça continua legível?
