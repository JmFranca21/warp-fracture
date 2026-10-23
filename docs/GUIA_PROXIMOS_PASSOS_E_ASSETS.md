# Warp Fracture — Próximos passos e guia de criação de assets

Este guia vale a partir da versão v0.5. Ele diz o que fazer em seguida, quem faz cada parte e como criar a arte nova para que ela entre no jogo sem retrabalho.

---

## 1. Próximos passos (em ordem)

| # | Etapa | O que você faz | O que o agente faz |
|---|---|---|---|
| 7 | **Fuga do Eco** (clímax do laboratório) | Gera os assets do pacote A (Eco + desabamento) | Persegue, desaba a sala, adiciona checkpoint, trilha de fuga, registro novo e atualiza o caderno |
| 8 | **Cena de abertura** (explosão da Máquina de Dobra) | Gera o pacote B (Máquina, sala, Daymon acordando) | Monta a cena com legendas e botão de pular, que roda só em "Novo jogo" |
| 9 | **Fendas Instáveis** (salas-desafio cronometradas) | Gera o pacote C (entrada da fenda + plataformas) | Monta 2 ou 3 salas escondidas, cronômetro, recorde salvo e recompensa |
| 10a | **Lince-Vagalume com sprites** | Gera a ficha de personagem e depois o pacote D | Troca o Lince desenhado por código pelas sprites |
| 10b | **Verdâmia com sprites** (opcional, mas recomendado) | Gera o pacote E (inimigos, Rainha e cenário) | Substitui os desenhos por código |
| 10c | **Hidrópolis** (novo universo) | Gera as fichas e os pacotes F e G | Programa o nado em 360°, a forma Cefalóide, os inimigos, o chefe e a fase |

**Você não precisa esperar a arte para começar.** O agente pode programar cada etapa com arte provisória desenhada por código e trocar pelas sprites quando elas chegarem. Mesmo assim, entregar a arte antes economiza uma rodada de ajustes.

### Como continuar com um agente

1. Abra uma nova conversa no Claude ou no Claude Code com o GitHub conectado. Repositório: `JmFranca21/warp-fracture`.
2. Cole o conteúdo de `PROMPT_PROXIMO_AGENTE.md`. Se não usar o GitHub, anexe o `WarpFracture_Handoff.zip`.
3. Anexe os assets novos da etapa, ou envie-os para a pasta `arte_original/novos/<pacote>/` do repositório.
4. Peça: "Siga para a Etapa 7".

---

## 2. Regras técnicas para TODA arte nova

São as mesmas regras que já funcionaram no Daymon, no Drone e no Rastejador. Siga-as à risca, porque é isso que permite o recorte automático (`tools/extract.py`).

### 2.1 Animações (spritesheets)

1. **Uma animação por imagem**, de **1536 × 1024 px**.
2. A imagem é uma grade invisível de **4 colunas × 2 linhas**, com 8 células de **384 × 512 px**. A ordem de leitura vai da linha de cima, da esquerda para a direita, para a linha de baixo. Se a animação tiver menos de 8 quadros, as células finais ficam vazias.
3. Fundo **transparente** (PNG). Se não der, use **verde chapado #00FF00**, sem gradiente nem sombra. Para personagens verdes (como o Esporângio), use **magenta #FF00FF**.
4. Vista **lateral**, sempre olhando para a **DIREITA**.
5. Mesma escala em todos os quadros e em todas as animações do mesmo personagem.
6. Os **pés tocam a mesma linha de chão**, a 40 px da borda de baixo da célula. Para criaturas que voam ou nadam, o **centro do corpo** fica no centro da célula.
7. Nada além do personagem: sem texto, números, grade, chão, sombra projetada ou cenário.
8. Nenhuma parte sai da própria célula.
9. De um quadro para o outro, só a pose muda. Design, cores e tamanho continuam idênticos.
10. Em loops (idle, run, fly, swim), o último quadro deve emendar no primeiro.

### 2.2 Objetos de cenário (estáticos)

1. **Um objeto por imagem**, de **1024 × 1024 px**, com fundo transparente ou verde #00FF00.
2. O objeto fica centralizado e ocupa cerca de 70% da imagem.
3. Vista **frontal-lateral**, com a mesma iluminação das pranchas oficiais: luz fria vinda de cima e da esquerda, brilhos ciano e roxo.
4. **Mostre o ponto de apoio**, para nada parecer flutuando no jogo:
   - objetos de chão têm a base plana embaixo;
   - objetos de teto têm suporte ou corrente saindo por cima;
   - objetos de parede têm uma placa de fixação de um lado.
5. Escreva na resposta qual é o apoio: "chão", "teto" ou "parede".

### 2.3 Estilo (vale para tudo)

> **A diretriz oficial é a DA-01** (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`). Ela prevalece sobre este guia. Resumo: 2D **cartunizado, simplificado e minimalista**, com o mesmo traço das referências oficiais do projeto (ficha do Daymon e prancha do laboratório), cabeça grande, anatomia compacta, contornos limpos, sombreamento econômico (cel) e efeitos contidos. Hollow Knight é só uma influência de atmosfera. **Sem realismo, sem pixel art e sem 3D.**
- A **faixa ciano do Traje Âncora** aparece em todas as formas de Daymon. É assim que o jogador o reconhece.
- O Eco segue a DA-01: mesma construção do Daymon em roxo muito escuro, uma rachadura ciano (#39E6FF) no lugar da faixa do traje e uma aura negra contida. O pedido vigente é `colaboracao/pedidos/A0_ficha_eco.md`.
- Paletas por universo:
  - Laboratório: azul-aço escuro, ciano e vermelho de alarme.
  - Verdâmia: verde-azulado escuro, fungos que brilham em verde-limão e âmbar.
  - Hidrópolis: azul-petróleo, turquesa e vidro esverdeado.

### 2.4 Como nomear e entregar

- Nomeie os arquivos como `pacote_personagem_animacao.png`, por exemplo `A_eco_run.png` ou `D_lince_pogo.png`.
- Se gerar uma segunda versão, acrescente `_v2`. **Não apague as versões anteriores.**
- Entregue cada pacote num zip ou numa pasta `arte_original/novos/A_fuga_do_eco/` (e assim por diante).
- Inclua um `quadros.txt` com o que o ChatGPT descreveu de cada imagem, por exemplo "1–8 = run, quadro 1 = pé esquerdo no chão".

### 2.5 Checklist antes de enviar

Confira em cada imagem:
- [ ] Tem 1536 × 1024 (animação) ou 1024 × 1024 (objeto)?
- [ ] O fundo é transparente ou de uma cor chapada só?
- [ ] O número de quadros está certo, e nenhum invade a célula vizinha?
- [ ] O personagem olha para a direita, e os pés estão na mesma altura em todos os quadros?
- [ ] O design bate com a ficha de referência (cores, faixa ciano, proporções)?
- [ ] Não há texto, grade ou chão desenhado?

Se uma imagem falhar em algum item, peça ao ChatGPT para **refazer só ela**, citando a regra que não foi cumprida.

---

## 3. Prompt-base (cole no início de toda conversa com o ChatGPT)

> Você vai criar arte para o jogo 2D **WARP FRACTURE**, um metroidvania em visão lateral que já está rodando na Godot. Estilo: siga a diretriz oficial DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): 2D cartunizado, simplificado e minimalista, com o mesmo traço das referências oficiais do projeto, SEM realismo, SEM pixel art e SEM 3D. Anexei as pranchas de referência oficiais. Mantenha exatamente o mesmo design, as proporções e a paleta.
>
> **Regras para animações:** uma animação por imagem, de 1536 × 1024 px; grade invisível de 4 colunas × 2 linhas (células de 384 × 512 px) em ordem de leitura; fundo TRANSPARENTE (ou verde chapado #00FF00 sem gradiente); vista lateral olhando para a DIREITA; mesma escala em todos os quadros; pés na mesma linha, a 40 px da borda de baixo da célula (criaturas voadoras ou nadadoras ficam centralizadas); nada além do personagem (sem texto, grade, chão ou sombra); nada sai da célula; só a pose muda entre os quadros; loops emendam o último quadro no primeiro.
>
> **Regras para objetos:** um objeto por imagem, de 1024 × 1024 px, fundo transparente, centralizado, com o ponto de apoio visível (base no chão, corrente ou suporte no teto, ou placa na parede).
>
> Gere UMA imagem por vez, na ordem da lista, e espere meu "ok" antes da próxima. Depois de cada imagem, escreva a lista dos quadros.

Anexe sempre a ficha de referência do personagem e a prancha do ambiente: as que estão em `arte_original/00_Referencias_oficiais` ou as fichas novas que você gerar.

---

## 4. Pacotes de assets por etapa

### Pacote A — Fuga do Eco (Etapa 7)

**Referências a anexar:** Ficha de Personagem Daymon Sagan e Prancha de Elementos do Laboratório Hélix.

**A0. Ficha do Eco**: o texto abaixo foi **substituído** pelo pedido `colaboracao/pedidos/A0_ficha_eco.md` (revisão 2, conforme a DA-01). Use o pedido, não este trecho. (faça primeiro: uma imagem 1536 × 1024 em estilo de ficha de personagem, *com* texto permitido)
> Crie a ficha de personagem do **ECO**, o vilão: uma entidade de energia que tem a silhueta exata do Daymon Sagan da ficha anexada, mas sem rosto definido. O corpo é feito de energia roxa (#7A3CFF) com contornos e veias ciano (#39E6FF) e fragmentos de estática que se soltam das bordas. O jaleco aparece como chamas de energia esvoaçando. Os olhos são dois pontos de luz branca. Mostre vista lateral (olhando para a direita), vista frontal e 3 detalhes (mão, fragmentos e olhos).

Depois, as animações (com a ficha do Eco anexada):
1. **A_eco_appear**: 8 quadros. Ele se materializa a partir de faíscas e estática, de uma nuvem de partículas até o corpo completo.
2. **A_eco_float**: 6 quadros, loop. Paira parado, com os fragmentos se soltando e o jaleco de energia ondulando.
3. **A_eco_run**: 8 quadros, loop. Corre de forma fluida e um pouco inclinada para a frente, deixando um rastro de estática.
4. **A_eco_grab**: 6 quadros. Estende o braço para agarrar, e a mão cresce em garras de energia.
5. **A_eco_vanish**: 6 quadros. Se desfaz em estática e fragmentos.

Objetos e efeitos:

6. **A_entulho_1, A_entulho_2, A_entulho_3**: objetos 1024 × 1024 de pedaços de teto metálico do laboratório (placas com vigas tortas, cabos soltos e um pouco de luz ciano rachada). Sem apoio, porque caem.
7. **A_fx_poeira**: animação de 6 quadros com uma nuvem de poeira cinza-azulada de impacto no chão, centralizada.
8. **A_fx_rachadura_teto**: animação de 4 quadros com uma rachadura que se abre no teto metálico, com faíscas e uma luz roxa vazando. Fica centralizada e com o topo reto, para encaixar no teto.

### Pacote B — Cena de abertura (Etapa 8)

**Referências a anexar:** Ficha do Daymon e Prancha de Elementos do Laboratório.

1. **B_maquina_dobra**: objeto 1024 × 1024. É a Máquina de Dobra: um anel vertical enorme sobre uma base pesada no chão, com cabos grossos, painéis e um núcleo de 4 fragmentos cristalinos brilhando em ciano no centro. Apoio: chão.
2. **B_maquina_sobrecarga**: animação de 6 quadros, loop, com a mesma máquina e a mesma escala, centralizada. O núcleo pulsa do ciano ao branco, raios roxos saltam pelo anel e os painéis piscam em vermelho.
3. **B_fx_explosao_dobra**: animação de 8 quadros. É a explosão da máquina: um clarão branco, depois um anel de energia roxo e ciano se expandindo, depois 4 fragmentos voando em direções diferentes.
4. **B_console**: objeto 1024 × 1024. Mesa de controle com monitores holográficos e um botão vermelho grande. Apoio: chão.
5. **B_daymon_console**: animação de 4 quadros do Daymon de costas e de lado, olhando para a direita, digitando no console (sem o console desenhado). Mesma escala e regras das animações do Daymon.
6. **B_daymon_acordando**: animação de 8 quadros. Daymon deitado nos escombros se apoia nos braços, se ajoelha e fica de pé. Os pés terminam na linha de chão.
7. **B_iris**: animação de 6 quadros, loop. Ícone holográfico da IA IRIS, um olho geométrico ciano dentro de um hexágono, pulsando. Centralizado.

### Pacote C — Fendas Instáveis (Etapa 9)

1. **C_fenda_entrada**: animação de 6 quadros, loop. É um rasgo vertical no ar, irregular, com bordas de vidro quebrado, interior roxo-escuro em movimento e faíscas ciano. Tem mais ou menos a altura de uma porta e fica centralizado.
2. **C_plat_fenda**: objeto 1024 × 1024. Plataforma flutuante feita de fragmentos de realidade (metade metal do laboratório, metade pedra com musgo de Verdâmia) presos por um campo de energia roxo embaixo. Apoio: o campo de energia, que deve aparecer embaixo da plataforma.
3. **C_cristal_recompensa**: animação de 6 quadros, loop. Um cristal de Célula de Fase grande, girando e brilhando em ciano.

### Pacote D — Lince-Vagalume (Etapa 10a)

**D0. Ficha do Lince-Vagalume** (faça primeiro: 1536 × 1024 em estilo de ficha, com texto permitido)
> Crie a ficha de personagem do **LINCE-VAGALUME**, que é a forma do Daymon Sagan no universo Verdâmia (floresta de fungos brilhantes em noite eterna). É um felino esguio de quatro patas, do tamanho de um lince, com pelagem azul-escura e manchas bioluminescentes verde-limão. As orelhas têm tufos. A cauda é longa, com uma lanterna de luz âmbar na ponta, como um vagalume. As garras são brancas. No peito, ele tem a **faixa ciano do Traje Âncora**, igual à da ficha do Daymon anexada, e os olhos são ciano. Mostre vista lateral (olhando para a direita), vista frontal e detalhes da cauda, das garras e da faixa do traje.

Depois, as animações (com a ficha do Lince anexada; pés na linha de chão):
1. **D_lince_idle**: 6 quadros, loop. Respira, mexe a cauda, e a lanterna pisca suave.
2. **D_lince_run**: 8 quadros, loop. Galope felino.
3. **D_lince_jump**: 3 quadros (impulso, subida, topo).
4. **D_lince_fall**: 3 quadros, caindo, com as patas abertas.
5. **D_lince_doublejump**: 4 quadros. Cambalhota no ar, com um brilho verde nas patas.
6. **D_lince_wall**: 3 quadros. Agarrado a uma parede **à direita** (as patas encostam na borda direita da célula), escorregando devagar.
7. **D_lince_claw**: 4 quadros. Golpe de garra para a frente, com um arco de corte verde-claro.
8. **D_lince_pogo**: 4 quadros. Golpe para baixo no ar, com as garras apontadas para o chão e um arco de corte embaixo.
9. **D_lince_flash**: 6 quadros. O clarão: a lanterna da cauda explode em luz âmbar e branca ao redor do corpo.
10. **D_lince_hurt**: 2 quadros de recuo.
11. **D_lince_death**: 6 quadros. Cai de lado, as manchas se apagam e a faixa ciano pisca por último.

### Pacote E — Verdâmia (Etapa 10b, opcional)

Hoje esses elementos são desenhados por código. Com sprites, ficam no mesmo nível do laboratório.

**E0. Prancha de inimigos de Verdâmia** (ficha com texto permitido), com os três:
- **Esporângio**: planta fixa, um bulbo de fungo com boca que lança esporos;
- **Mariposa Lanterna**: inseto voador com asas pálidas e luz amarela;
- **Rainha Micélia**: chefe enorme, uma figura régia feita de micélio e raízes com coroa de cogumelos, que ocupa a tela.

Depois, as animações:
1. **E_esporangio_idle** (6), **E_esporangio_attack** (4, o bulbo se contrai e cospe) e **E_esporangio_death** (6). Fundo **magenta**.
2. **E_mariposa_fly** (6, loop, centralizada) e **E_mariposa_death** (6).
3. **E_rainha_idle** (6), **E_rainha_raizes** (6, crava as mãos no chão), **E_rainha_esporos** (6, abre a coroa e solta esporos), **E_rainha_rugido** (4), **E_rainha_hurt** (2) e **E_rainha_death** (8). Para a Rainha, use uma célula maior: a imagem continua com 1536 × 1024, mas a grade é de **2 colunas × 1 linha** (células de 768 × 1024), com 2 quadros por imagem. Divida cada animação em várias imagens numeradas, por exemplo `E_rainha_idle_1.png`, `E_rainha_idle_2.png` e `E_rainha_idle_3.png`.

**E1. Objetos de cenário de Verdâmia** (1024 × 1024 cada):
- cogumelo gigante (chão);
- tufo de grama bioluminescente (chão);
- raiz pendurada (teto);
- tronco caído servindo de plataforma (chão);
- pedra com musgo;
- arco do templo de raízes (chão);
- altar do fragmento (chão).

### Pacote F — Hidrópolis: personagem e inimigos (Etapa 10c)

**F0. Ficha do Cefalóide** (ficha com texto permitido)
> Crie a ficha do **CEFALÓIDE**, a forma do Daymon Sagan no universo Hidrópolis (ruínas de uma cidade de vidro no fundo do mar). É uma criatura parecida com um polvo, com manto azul-petróleo translúcido, 8 tentáculos com ventosas turquesa, olhos ciano grandes e expressivos, e a **faixa ciano do Traje Âncora** em volta do manto. Mostre vista lateral (nadando para a direita), vista frontal e detalhes dos tentáculos e da nuvem de tinta.

Animações (centralizadas na célula, porque ele nada):
1. **F_cefaloide_swim**: 8 quadros, loop, nadando para a direita com propulsão dos tentáculos.
2. **F_cefaloide_idle**: 6 quadros, loop, flutuando parado.
3. **F_cefaloide_dash**: 4 quadros, jato rápido com o corpo esticado.
4. **F_cefaloide_tentacle**: 4 quadros, chicotada de tentáculo para a frente.
5. **F_cefaloide_ink**: 6 quadros, soltando uma nuvem de tinta escura para trás.
6. **F_cefaloide_land**: 6 quadros, rastejando devagar fora da água (pés na linha de chão).
7. **F_cefaloide_hurt** (2) e **F_cefaloide_death** (6).

**F1. Prancha de inimigos de Hidrópolis** (ficha com texto):
- **Enguia Voltaica**: enguia longa com placas que brilham em amarelo elétrico;
- **Guardião de Coral**: criatura blindada por um escudo de coral na frente;
- **Leviatã Custódio**: chefe, uma serpente marinha colossal e antiga, com escamas de vidro.

Depois:
- **F_enguia_swim** (6, loop), **F_enguia_shock** (6) e **F_enguia_death** (6);
- **F_guardiao_swim** (6), **F_guardiao_block** (3) e **F_guardiao_death** (6);
- Leviatã: grade de 2 × 1, como a da Rainha. Animações **swim**, **bite**, **roar** e **death**.

### Pacote G — Hidrópolis: cenário (Etapa 10c)

Objetos (1024 × 1024 cada):
- coluna de vidro rachada (chão);
- arco de ruína submersa (chão);
- coral grande (chão);
- alga longa (chão, ondulando em 6 quadros como animação);
- bolhas (animação de 6 quadros, loop);
- lampião de vidro pendurado (teto);
- plataforma de vidro (chão);
- concha-alavanca (parede);
- corrente de água, uma faixa horizontal translúcida com setas de fluxo sutis (animação de 6 quadros, loop).

---

## 5. Áudio

Não precisa criar nada: os sons e as músicas são gerados por código (`tools/gen_audio.py`). Se quiser algo mais realista mais tarde, use bancos gratuitos CC0, como Freesound (filtro CC0) e Kenney. Envie arquivos `.ogg` ou `.wav` nomeados pela ação, por exemplo `eco_rosnado.ogg`.

---

## 6. Resumo do que entregar por etapa

| Etapa | Arquivos | Quantidade aproximada |
|---|---|---|
| 7 Fuga do Eco | Ficha do Eco + 5 animações + 3 entulhos + 2 efeitos | 11 imagens |
| 8 Abertura | 2 estados da máquina + explosão + console + 2 animações do Daymon + IRIS | 7 imagens |
| 9 Fendas | Entrada + plataforma + cristal | 3 imagens |
| 10a Lince | Ficha + 11 animações | 12 imagens |
| 10b Verdâmia | Prancha + cerca de 15 animações + 7 objetos | cerca de 23 imagens |
| 10c Hidrópolis | 2 fichas + cerca de 15 animações + 9 objetos | cerca de 26 imagens |

**Prioridade sugerida:** Pacote A, depois D, depois B, depois C. O Eco e o Lince são o que o jogador mais vê.
