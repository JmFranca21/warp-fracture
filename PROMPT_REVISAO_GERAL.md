# Prompt: revisão geral do Warp Fracture (mecânicas, lógica, hitboxes, assets e visual)

> Para colar inteiro num agente Claude (Claude Code, com acesso ao repositório e a um terminal). Escrito em 26/11/2026 a partir da branch `dev/deserto` (commit `e80d7af`) e da `main` (commit `ef2d879`, Forja-Mãe v3). O agente **não gera imagens**: arte nova vira pedido escrito (seção 2).

---

Você é o revisor técnico e de arte do **Warp Fracture**, um metroidvania 2D de rolagem lateral feito em **Godot 4.3** (GDScript). O autor é o João Marcelo. Seu trabalho é fazer uma **revisão completa do jogo**, de ponta a ponta, e **corrigir você mesmo** o que encontrar, na cena e/ou no código.

Você não tem como desenhar arte nova. Para arte você pode:
- corrigir o uso no jogo (escala, âncora, recorte, ordem de desenho, posição);
- tratar os PNGs existentes sem desenhar nada novo (limpar pixels soltos, recortar, recompor a partir de peças que já existem);
- e, quando precisar de desenho novo, **escrever o pedido de arte**.

Além disso, **verifique e integre a Forja-Mãe v3** (seção 3.6), que acabou de chegar na `main`.

Não pare para pedir aprovação a cada item. Só pare e pergunte antes de uma mudança que altere o design do jogo de forma grande e difícil de desfazer (por exemplo, trocar o que um botão faz). Ainda assim, faça a parte de investigação e deixe a proposta pronta.

O João resumiu assim o que quer: "uma revisão completa no jogo, tanto em mecânicas e lógicas quanto em assets e visuais".

## 1. Antes de mexer em qualquer coisa

1. **Clone e prepare a branch de trabalho.**
   - Repositório `warp-fracture` no GitHub. A branch `dev/revisao-geral` já existe e está igual à `dev/deserto`, a mais atual: tem o Deserto em cena com a arte v2 e a Nivária do Caio. Trabalhe nela.
   - Antes de tudo, faça **merge da `main` em `dev/revisao-geral`** para trazer a Forja-Mãe v3 (commit `ef2d879`, só arquivos em `colaboracao/entregas/DF100`–`DF112`).
   - Nunca faça merge **na** `main` nem trabalhe na `dev/neve-fase` (é do Caio).
2. **Leia nesta ordem:**
   - `HANDOFF.md`: histórico técnico completo, decisões e armadilhas.
   - `LEIA-ME.md` e `README.md`.
   - `docs/CENAS_DAS_FASES.md`: como cada fase vira cena. Algumas cenas são geradas por script; leia o aviso sobre não rodar o gerador de novo depois de editar no Godot.
   - `docs/DOCUMENTO_DE_ARTE.md` e as diretrizes de arte `colaboracao/pedidos/DA02_regua_e_fichas_v2.md`, `DA03_receita_de_cena.md` e `DA04_assinatura_de_estilo.md`.
   - `colaboracao/pedidos/DF_pacote_completo_v2.md`, seção 2 (bíblia DF-BASE): é o padrão de estilo atual de todo o jogo.
   - `colaboracao/PROTOCOLO.md` e `colaboracao/STATUS.md`.
   - `docs/fases/deserto_ferrugem/integracao_arte_v2.md` e `auditoria_pacotes_11_20.md`: defeitos de arte já conhecidos.
3. **Rode o jogo e todos os testes antes de mudar nada**, para ter a linha de base. Se o ambiente não tiver o Godot, baixe o **Godot 4.3 stable** (a versão do projeto) do GitHub oficial `godotengine/godot`; para capturas use `xvfb-run`.
   - Jogo: `godot --path .`. F6 numa cena de fase entra direto nela.
   - Testes: `godot --headless --audio-driver Dummy --path . --script res://tools/<teste>.gd -- <args>`. Para capturas, use `xvfb-run -a -s "-screen 0 1280x720x24" godot --rendering-driver opengl3 ...`.
   - Testes e argumentos:
     - `test_deserto -- save at=999`
     - `test_forja -- save at=999`
     - `test_df205`
     - `test_cenas_fases`
     - `test_verdamia`
     - `test_passagem`
     - `test_fragmento`
     - `test_nivaria -- level=nivaria arpao at=999`
     - `test_portal -- level=lab terminals pos=6500,690 at=999`
     - `test_fuga -- level=lab terminals arpao pos=4250,790 save at=999` (é sensível ao tempo; rode sozinho)
   - Depois de criar um `class_name` novo, rode `godot --headless --path . --import` para atualizar o cache de classes.
4. **Jogue cada fase inteira** com teclado, com cada forma do personagem, antes de decidir o que corrigir:
   - Laboratório Hélix
   - Fuga do Eco
   - Verdâmia
   - Deserto de Ferrugem (inclui a luta com a Forja-Mãe)
   - Nivária

## 2. Regras de trabalho

- **Commits pequenos, um assunto por commit**, com prefixo `[dev]` e mensagem em português explicando o porquê. Arte nova também vai num commit separado.
- **A jogabilidade só muda de propósito.** Toda mudança de física, alcance, dano ou tempo precisa ter o motivo escrito no relatório (seção 5). Os testes existentes devem continuar passando. Se um teste ficar errado por causa de uma correção legítima, ajuste o teste e explique por quê.
- **Cenas e código.** Cenas `.tscn` editáveis são a fonte da verdade quando existem; as que vêm de gerador estão documentadas em `docs/CENAS_DAS_FASES.md`. Não rode um gerador de cena que apague edições feitas no editor. Corrija na cena ou na montagem por código, e mantenha os dois iguais quando o projeto exigir (há `tools/dump_fase.gd` para comparar a cena com a montagem por código).
- **Arte com escala uniforme.** Nenhum sprite esticado em um eixo só. Cada peça usa a âncora do seu ENTREGA, e folhas de animação são recortadas por grade fixa.
- **Assinatura de estilo.**
  - Contorno escuro só nas figuras (personagens, inimigos, objetos de interação), frio e parcial; o cenário não tem contorno.
  - Sombreamento chapado em 2–3 tons, detalhe crescendo do fundo para a frente.
  - Uma cor-assinatura por universo: Laboratório ciano, Verdâmia verde-limão, Deserto âmbar `#EFAA55`, Nivária conforme a pasta dela.
- **Arte: o que você pode e o que não pode fazer.**
  - **Não altere os originais** em `colaboracao/entregas/`. Eles são a fonte e têm SHA registrado.
  - **Tratamento sem desenho é permitido**, sempre gerado por script versionado em `tools/` a partir do original, com saída em `assets/`:
    - apagar pixels soltos e fragmentos;
    - recortar;
    - corrigir margem ou âncora;
    - recompor uma peça com partes de folhas que já existem;
    - espelhar, só quando a luz do desenho continuar coerente.
  - **Ajustes no jogo são permitidos:** cor, brilho, tinta (`modulate`) e efeitos por código. Use para sinais de jogabilidade (aviso, alvo, dano) quando a arte não mostrar o estado. Registre como paliativo.
  - **Desenho novo não.** Quando a arte faltar ou estiver errada, escreva o pedido em `colaboracao/pedidos/REV_pedidos_de_arte.md`. Para cada peça, informe:
    - ID;
    - o problema, com captura;
    - formato, grade, quadros e âncoras;
    - onde entra no jogo.
  - O pedido segue a bíblia DF-BASE e o padrão dos pedidos de `colaboracao/pedidos/`, para que outro artista possa produzir depois sem perguntar nada.
- **Antes e depois.** Toda correção visual tem captura antes/depois em 1280 × 720, com a câmera do jogo e em movimento quando o problema for de parallax ou emenda. Toda correção de mecânica tem teste automatizado novo ou ajustado.

## 3. O que revisar (escopo completo)

### 3.1 Mecânicas do personagem principal

O herói é Daymon Sagan. Ele muda de forma por fase: humano no Laboratório, **Lince** em Verdâmia, **Autômato** no Deserto, **Yeti** em Nivária. O código está quase todo em `scripts/player.gd`; cada forma tem um `_build_*` e um `_update_*`.

Para cada forma, verifique e corrija:
- pulo, coyote time, buffer de pulo, pulo extra, arranque (dash), queda, pouso;
- ataque, mira, cadência, de onde o tiro sai (`gun_tip()`), dano, recuo;
- dano recebido, invencibilidade, knockback, morte e respawn;
- energia e especial;
- se o controle responde bem e se cada habilidade é **compreensível para quem joga pela primeira vez**.

**Autômato: o João não entendeu a habilidade especial dele.** Hoje:
- **Especial:** é o **Pulso Magnético**, função `_magnet_pulse()`. Custa 33 de energia e é uma onda de 150 px a partir do peito. Ela derruba drones, paralisa robôs por 2 s, destrói projéteis inimigos e abre as placas imantadas do peito da Forja-Mãe.
- **Botão do gancho:** vira o **Ímã** (`hook_candidate()` e `_magnet_drone()`). Ele puxa o Autômato até os pontos de gancho ou puxa um drone para perto.

Avalie se essas duas habilidades fazem sentido juntas, se são distinguíveis e se o jogo as ensina. Isso inclui:
- placas e tutoriais;
- ícone e nome no HUD;
- feedback visual e sonoro;
- situações em que a fase **obriga** a usar cada uma (sem isso o jogador nunca descobre para que serve);
- o momento da luta da Forja em que o Pulso abre o peito.

Proponha e implemente o que for preciso para ficar claro:
- texto das placas;
- primeira aparição guiada;
- indicador de alcance (anel de 150 px ao segurar o botão, por exemplo);
- feedback forte ao acertar;
- leitura dos alvos que reagem ao Pulso;
- ajuste de custo e tempo de recarga, se o especial for fraco ou caro demais para valer o uso.

Se a sua conclusão for que a habilidade precisa mudar de função, documente a proposta e implemente a versão mais simples que resolva. Explique a mudança no relatório.

### 3.2 Gancho (Arpão de Fase) e Ímã: física e usabilidade

O João relata comportamento estranho do gancho em várias situações. Também relata que, ao atravessar um buraco, **o jogador precisa pular num instante muito exato enquanto o gancho puxa, senão não chega do outro lado**.

O código atual (`scripts/player.gd`):
- **Escolha do alvo:** `HOOK_RANGE = 380` px. Exige linha de visão (raio na camada 1). Prefere o gancho na direção da mira com peso 0,4. Ignora alvos a menos de 30 px e o último gancho usado por 0,5 s.
- **Disparo:** 0,09 s de corda esticando, com a velocidade multiplicada por 0,85 a cada quadro nesse tempo.
- **Puxão:** velocidade constante `HOOK_SPEED = 980` px/s em linha reta até um ponto **46 px abaixo do gancho**.
- **Fim do puxão:** a menos de 22 px desse ponto, o gancho solta e a velocidade cai para **55 %** de 980, ainda na direção da reta. Pular durante o puxão solta com 60 % e um impulso para cima.
- Ao soltar: devolve o pulo extra e o arranque no ar e dá 0,08 s de coyote.

Causa provável do problema relatado:
- O puxão termina parado embaixo do gancho, com o momento apontando para ele e não para o outro lado do buraco.
- Só um pulo dentro de uma janela curta transforma esse momento em travessia.

Requisitos para a versão corrigida:
1. **Travessia sem timing exato.** Segurando a direção do outro lado do buraco e apertando o gancho uma vez, o jogador deve chegar ao outro lado em todos os fossos que o level design espera atravessar com gancho. Opções, em ordem de preferência; escolha e documente:
   - **Atravessar o gancho com o momento:** ao chegar, preserva a velocidade horizontal na direção segurada e dá um impulso para cima e para a frente.
   - **Balanço tipo pêndulo** com corda de comprimento fixo.
   - **Janela de pulo generosa:** buffer de pulo antes e depois de chegar, de 0,15–0,2 s.
2. **Previsível.** O mesmo input dá sempre o mesmo resultado, sem depender do FPS. Use `dt` em tudo e teste a 30, 60 e 144 FPS (`Engine.physics_ticks_per_second` e `max_fps`).
3. **Sem comportamentos estranhos.** Investigue e corrija:
   - **Escolha do alvo:** o gancho pega um alvo diferente do que o jogador está olhando; ou pega um alvo atrás de parede ou plataforma de mão única. A linha de visão usa só a camada 1: confira as one-way (camada 256) e as plataformas móveis.
   - **Colisão durante o puxão:** prende na quina ao passar por um teto ou parede; atravessa colisão, porque o puxão usa velocidade fixa sem tratar o choque.
   - **Alvos que mudam:** o gancho some ou muda durante o puxão (o martelo da Forja só é gancho enquanto está preso no chão); gancho em plataforma móvel.
   - **Interação com outros estados:** soltar o gancho no meio do arranque, do dano ou do knockback; o Ímã do Autômato disputando o mesmo botão entre gancho e drone.
   - **Feedback:** mostrar qual gancho vai ser pego antes de apertar (realce do alvo), som e linha da corda coerentes.
4. **Teste automatizado novo.** Em cada fase com gancho (Laboratório com o Arpão, Fuga do Eco, Deserto, Nivária), para cada gancho que serve para atravessar um vão:
   - simule o jogador vindo da borda segurando a direção e apertando o gancho uma vez, em alguns instantes diferentes;
   - confira que ele chega ao outro lado sem cair;
   - inclua o caso "aperta pular sem querer no meio".
   - Os testes atuais `test_fuga`, `test_nivaria` e `test_deserto` já usam o gancho e podem servir de base.

### 3.3 Hitboxes, colisões e origem dos ataques

Ligue a visualização de colisões (Depuração > Formas de Colisão Visíveis). Crie também uma ferramenta de captura que desenhe as hitboxes sobre a arte. Em todas as fases, confira que:
- a **hurtbox** de cada personagem, inimigo e chefe cobre o desenho atual, sem sobrar nem faltar. Várias artes mudaram de tamanho na v2: o Robô do Deserto agora tem 49 × 68 px no jogo e o Drone 58 × 37;
- a **área de ataque** de cada golpe, tiro, feixe, martelo, prensa, serra, jato de vapor, espinho e perigo é a área que a arte mostra;
- **projéteis saem do cano ou da mão**, na altura e no lado certos, também com o personagem virado para a esquerda;
- colisão do terreno, plataformas de mão única, quinas, degraus e paredes são confiáveis: não prende em quina, não atravessa, não escorrega em degrau baixo;
- `kill_y`, fossos e perigos matam ou ferem onde a arte mostra o perigo.

**Problema já confirmado: o tiro do Robô do Deserto sai baixo.** Em `scripts/desert_enemy.gd`, `fire()` cria o tiro em `position + Vector2(direction * 30, -27)`; a origem do robô são os pés. Medido nas folhas DF60 e DF63 v2, a ponta do cano está em **(+24, −51)** no jogo, ou seja, 24 px acima de onde o tiro nasce. Corrija o Robô e confira a origem dos tiros de **todos** os inimigos e chefes:
- Turreta, Drone e Rastejador do Laboratório;
- Esporângio, Mariposa e Rainha Micélia de Verdâmia;
- Drone do Deserto, que atira para baixo;
- Forja-Mãe: rajada, feixe da lente e martelos;
- inimigos e chefe de Nivária.

Onde fizer sentido, leia a posição do cano da própria arte (âncora no ENTREGA) em vez de número fixo.

### 3.4 Lógica geral e implementação básica

Revise e corrija:
- **Progressão:** save e load, checkpoints e estações, respawn depois da morte (posição segura, `_update_safe`), coletáveis que não voltam depois de pegos, portas e comportas, fragmentos, portais e calibração, seleção de destino, módulos e upgrades;
- **Interface:** HUD (vida, energia, ícones), menu, pausa, configurações, remapeamento de teclas se existir;
- **Câmera:** limites, salas, zoom da luta, tremor;
- **Inimigos:** IA (patrulha, aviso antes do ataque, recarga), queda de itens;
- **Chefes:** fases e vida;
- **Áudio:** sons que faltam ou se repetem.

Procure erros e avisos no console durante uma partida completa (aba Depurador). Hoje o editor mostra 27 mensagens ao abrir o projeto: veja o que são e resolva as que forem reais.

### 3.5 Assets, contornos e visual

Percorra cada tela de cada fase com a câmera do jogo e corrija:
- **Contornos:** figuras com contorno de cor ou espessura diferente das outras da mesma fase, ou cenário com traço escuro onde não deveria ter. Personagem, inimigos e chefes de todas as fases precisam parecer do mesmo artista.
- **Qualidade e distorção:**
  - sprites esticados, com escala não uniforme (procure `scale = Vector2(a, b)` com a ≠ b no código e nas cenas);
  - borrados por reamostragem, cortados na borda da célula, ou com pixels soltos ou fragmentos;
  - quadros de animação repetidos que fazem a animação parecer parada;
  - escala de personagem incoerente com a das outras figuras.
- **Elementos "sem contexto" ou jogados:**
  - objetos flutuando sem apoio;
  - peças penduradas sem corrente ou tirante até o alto;
  - decoração em cima de perigos, esteiras, fendas ou caminhos;
  - objetos de interação que não se leem como interativos;
  - placas e estações enterradas ou flutuando.
- **Terreno:**
  - peças distorcidas;
  - emendas que não fecham;
  - cantos sem a peça de canto;
  - friso da borda de apoio fora da linha de colisão;
  - **o mesmo padrão se repetindo de forma evidente**. Quebre a repetição com variações, peças de detalhe ou deslocamento do início da trama.
- **Fundo e parallax:** costuras, faixas escuras, camadas que andam na velocidade errada, névoa, ordem de desenho (`z_index`), primeiro plano cobrindo o jogo.

**Defeitos de arte do Deserto já conhecidos** (fora da Forja, que tem seção própria). Estão em `docs/fases/deserto_ferrugem/auditoria_pacotes_11_20.md`. Trate o que der com os PNGs existentes e escreva pedido para o resto:

| Peça | Problema |
|---|---|
| DF98 | Feixe do Ímã: ímã em cada célula da faixa e ponta errada. Hoje o jogo recorta o feixe e usa a ponta da v1. |
| DF91 e DF96 | Autômato: fragmentos soltos (dá para limpar por script). |
| DF87 e DF210 | Rebite e coletáveis: animações paradas. |
| DF200 | Céu: PNG corrompido na `main`; o jogo usa uma recomposição. |
| DF22 e DF53 | Fachada da Fábrica e correntes das plataformas: ainda na v1. |

Faça a mesma auditoria nas outras fases. `tools/auditar_entregas_deserto.py` serve de modelo para medir grade, âncora, pixels soltos, quadros iguais e emendas.

### 3.6 Forja-Mãe v3: verificar todas as artes novas e integrar

O commit `ef2d879` da `main` recria a Forja-Mãe em 12 ativos (DF100–DF108 e DF110–DF112). Para cada ID há:
- o mestre `*_v3.png`;
- a textura de jogo já reduzida a 50 %, `*_jogo_v3.webp`;
- `ENTREGA_v3.md` com o formato, os quadros, as âncoras e o SHA-256.

Também chegaram:
- `colaboracao/entregas/DF100/DF100_atlas_v3.json`, com todas as âncoras;
- as montagens `DF100_montagem_v3.png` e `DF100_montagem_aviso_v3.png`;
- as prévias em `DF100/previas_v3/`.

O jogo hoje usa a v2 (pacote 19). Antes de integrar, **verifique tudo**:

1. **Conferência técnica de cada PNG e WebP.** Use `tools/auditar_entregas_deserto.py` como base e estenda-o para a v3. Confira:
   - SHA-256 contra o ENTREGA;
   - medidas e grade;
   - quantidade de quadros ocupados e de células vazias (a entrega diz 54 ocupados e 17 reservados);
   - âncoras contra o `DF100_atlas_v3.json`;
   - pixels soltos e cortes na borda da célula;
   - quadros iguais quando deveriam mudar;
   - se cada `*_jogo_v3.webp` é exatamente o mestre reduzido a 50 % nos dois eixos.
2. **Encaixes do corpo DF100:** lente Ø 360 em (1024, 900), peito 420 × 360 em (1024, 1330), escotilhas 240 × 160 em (640, 820) e (1408, 820), grade 700 × 240 em (1024, 1820), base em (1024, 2008). Confira:
   - que os vãos têm alfa zero nessas medidas;
   - que as constantes `LENS`, `CHEST`, `HATCH` e `GRATE` de `scripts/forja.gd` batem com o mundo calculado: base (7770, 770), K = 0,214.
3. **Os defeitos da v2 foram resolvidos?** Detalhes em `auditoria_pacotes_11_20.md`, seção "Forja-Mãe … segunda verificação". Confira peça por peça, medindo e olhando:
   - **DF103:** rodas em cima, no trilho (512, 120), e pivô do braço em (512, 400). Se sim, remova o `flip_v` do carrinho em `forja.gd`.
   - **DF104:** viga com pistão e articulações, pivôs (112, 256) e (912, 256), e não uma barra fina com rodinhas.
   - **DF105:** tomada de encaixe em (512, 96), placa em (512, 150), face em y 432; âncora **ciano** no quadro 3 (preso) e faixas vermelhas no 2 (aviso).
   - **DF106:** dano visível no quadro 2.
   - **DF107:** luz vermelha no quadro 2 (aviso). Se sim, remova o paliativo que tinge as escotilhas de vermelho em `_update_drones()`.
   - **DF108:** fogo que pulsa de verdade nos quadros 1 a 6.
   - **DF101, DF102, DF110, DF111 e DF112:** estados distintos e âncoras do pedido.
4. **Coerência de estilo** com o resto do Deserto: contorno, paleta (aço azul-acinzentado, cobre ferrugem, âmbar `#EFAA55`, vermelho só para perigo, ciano só para o que o Ímã pega) e nível de detalhe, comparando com o Autômato, os robôs e o cenário DF203 da Câmara.
5. **Integração.**
   - Troque, em `tools/import_deserto_v2_folhas.py` (dicionário `FOLHAS`, hoje com os nomes `_v2`), os IDs DF100–DF112 pelos arquivos `_v3.png`. O `tools/import_fase2.py` antigo pega o primeiro PNG com o prefixo do ID e não deve ser usado para a Forja.
   - Ajuste `scripts/forja.gd` às grades, quadros e âncoras da v3.
   - Remova os paliativos que a v3 tornar desnecessários.
   - Rode `test_forja -- save at=999` e `test_deserto -- save at=999`.
   - Faça capturas da Câmara (`tools/captura_deserto.gd -- so=camara`) em repouso, no aviso, com o martelo preso e com o peito aberto, e compare com `DF100_montagem_v3.png`.
   - A entrega foi conferida pelo artista no Godot 4.7.2; o projeto é 4.3, então confirme que tudo importa e roda no 4.3.
6. **Relatório.** Monte uma tabela por ID (aprovado, aprovado com ajuste no código, reprovado) e escreva o pedido de arte do que for reprovado.

## 4. Método

1. **Inventário e diagnóstico primeiro.** Liste todos os problemas encontrados antes de corrigir, cada um com:
   - fase e posição (x, y);
   - captura ou passo a passo para reproduzir;
   - causa no código, na cena ou na arte;
   - severidade:
     - **A** quebra o jogo ou gera frustração injusta;
     - **B** atrapalha a leitura ou o controle;
     - **C** acabamento.
2. **Corrija na ordem A → B → C.** As mecânicas centrais (gancho, especial do Autômato, hitboxes) vêm antes do acabamento visual.
3. **Verifique cada correção** com teste automatizado ou captura, e rode a bateria inteira de testes de novo no fim de cada bloco.
4. **Mantenha o relatório atualizado** a cada commit, não só no final.

## 5. Entrega

1. **Branch `dev/revisao-geral` enviada para o GitHub**, com commits pequenos. Não faça merge.
2. **`docs/revisao_geral/RELATORIO.md`** com:
   - **Tabela de achados.** Colunas: ID, área (mecânica, lógica, hitbox, arte, cenário), fase, problema, evidência, severidade, correção feita, arquivos, teste ou captura, situação (corrigido, parcial, pendente).
   - **Decisões de design.** Gancho (modelo escolhido e números finais) e Autômato (o que mudou no especial e no ensino), com o antes e o depois.
   - **Tabela de hitboxes.** Entidade, tamanho e deslocamento antes e depois, e de onde sai cada ataque.
   - **Forja-Mãe v3.** A verificação por ID e o que foi integrado.
   - **Arte tratada por script.** ID, script, o que mudou e onde entrou.
   - **Pedidos de arte.** Lista dos pedidos escritos em `colaboracao/pedidos/REV_pedidos_de_arte.md`.
   - **Testes.** Lista dos testes e resultado de cada um; os testes novos e o que cobrem.
   - **O que não deu para fazer** e por quê. O que depende de decisão do João, com a sua recomendação.
3. **Capturas antes e depois** em `docs/revisao_geral/capturas/`, em 1280 × 720:
   - pelo menos uma por área de cada fase;
   - um GIF ou sequência de quadros mostrando a travessia com o gancho antes e depois;
   - uma do Pulso Magnético mostrando o alcance;
   - uma imagem de hitboxes de cada inimigo sobre a arte.
4. **Atualize** `HANDOFF.md` (nova seção) e `colaboracao/STATUS.md` (Forja v3 integrada e pedidos de arte abertos).

## 6. Critérios de aceite

- [ ] Todos os testes existentes passam (`test_fuga` rodado sozinho), mais os testes novos do gancho.
- [ ] Todo vão de gancho do level design é atravessável segurando a direção e apertando o gancho uma vez, a 30, 60 e 144 FPS.
- [ ] Alguém que joga o Deserto pela primeira vez entende o Pulso Magnético e o Ímã sem ler o código: a fase ensina, o HUD mostra, e há pelo menos uma situação que exige cada um.
- [ ] Todo projétil sai do cano ou da mão, dos dois lados; toda hurtbox e área de dano bate com a arte.
- [ ] Nenhum sprite com escala não uniforme; nenhum objeto flutuando sem apoio; nenhuma repetição evidente de terreno na câmera do jogo.
- [ ] Console sem erros numa partida completa do início ao fim.
- [ ] Forja-Mãe v3 verificada peça por peça e integrada; montagem no jogo conferida com `DF100_montagem_v3.png`; paliativos da v2 removidos onde a v3 resolveu.
- [ ] Todo problema de arte que exige desenho novo está no `REV_pedidos_de_arte.md`, com formato e âncoras.
- [ ] Relatório e capturas completos; nada na `main`.
