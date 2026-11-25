# Fases em cena: Laboratório Hélix e Verdâmia

**Desde 24/11/2026** (branch `dev/cenas`), o Laboratório e Verdâmia são cenas do Godot. Para mudá-las, abra a cena no editor e mexa nos nós; não há mais nada a mudar no código.

| Fase | Cena |
|---|---|
| Laboratório Hélix | `scenes/fases/lab.tscn` |
| Verdâmia | `scenes/fases/verdamia.tscn` |

O Deserto de Ferrugem e Nivária continuam montados pelo código (`scripts/desert.gd`, `scripts/nivaria.gd`).

## Como a cena está organizada

A raiz é o nó da fase (`Laboratorio` ou `Verdamia`, script `level.gd`). No inspetor dela ficam os dados gerais:

| Campo | O que é |
|---|---|
| `nome` e `subtitulo` | título mostrado ao entrar e no mapa |
| `tema` | `lab` ou `verd` (escolhe a arte de terreno, parede e fundos) |
| `forma` | forma do jogador na fase |
| `limites` | retângulo da câmera |
| `kill_y` | abaixo disso, o jogador morre |
| `salas` | salas do mapa (TAB) |
| `porta_requer` | terminais que destravam a porta |
| `chefe` | início da luta, portão e ponto do fragmento |

Os filhos da raiz, na ordem em que são desenhados:

- **Fundo do jogo**
  - `Ceu` (gradiente);
  - `Fundo_01…` (camadas de parallax);
  - `ParedeDeFundo` (paredes, colunas e canos do Laboratório);
  - `Particulas_01…` (partículas de ambiente).
- **Plano do jogo**
  - `Terreno`, que desenha os sólidos;
  - `Solido_01…`, um `StaticBody2D` com a `Colisao` de cada pedaço de chão, parede e teto;
  - `Decoracao`, com os sprites de cenário (`Deco_janela_01`, `Deco_cogumelo_gigante_01`…), brilhos e luzes de alerta;
  - `Perigo_01…` (piso eletrificado, espinhos);
  - `Plataforma_01…` (suspensas, móveis, quebráveis).
- **`Objetos`:** placas, checkpoints, terminais, porta, portal, receptáculo, fenda de chegada, itens (`Item_lab_c1`… pelo id do item), lasers, alavanca, campo de força, trava, banco, ganchos do Arpão e câmera de segurança.
- **`Entidades`:** caixas, inimigos (`Rastejador_01`, `Drone_01`, `Mariposa_01`…) e a `RainhaMicelia`.
- **`Efeitos`:** vazio na cena; recebe tiros e partículas durante o jogo.
- **`FugaDoEco`:** só no Laboratório; a configuração da fuga fica no inspetor (`cfg`).
- **`PrimeiroPlano`:** entulho e vegetação na frente.
- **`Marcadores`:** só para edição; o jogo remove ao carregar.
  - `Inicio`: o ponto de partida da fase.
  - `FendaDeRetorno`: onde a fenda de volta ao Hélix abre, em Verdâmia.
  - `PreviaEditor`: desenha no editor o que só aparece com o jogo rodando: itens, inimigos, plataformas, perigos, objetos, salas, a Fuga do Eco e a luta, com o nome de cada nó. Desligue `mostrar` no inspetor dela para esconder.

## O que dá para editar

- **Posição:** de qualquer nó, arrastando no editor.
- **Configuração de cada objeto:** no inspetor, por exemplo:
  - placa: `text`;
  - item: `kind`, `pid` e `respawn`;
  - plataforma: `kind`, `rect`, `travel`, `hang_y`, `sid` e `period`;
  - terminal: `tid`;
  - porta: `rect`;
  - perigo: `rect`;
  - gancho: `ceil_y`;
  - câmera de segurança: `side` e `spawns`.
- **Sólidos:** mova o `Solido_…` ou mude o tamanho da `Colisao` dele. O `Terreno` e o entulho do `PrimeiroPlano` leem os sólidos da cena e se redesenham sozinhos, também no editor, enquanto você arrasta. Para um chão novo, duplique um `Solido_…` e, na `Colisao` da cópia, clique na forma e use **Tornar Único** (Make Unique); sem isso, as duas colisões dividem a mesma forma e mudam de tamanho juntas. Em Verdâmia, as plataformas finas (24 px) usam a arte da lista `thin_art` do `Terreno`, na ordem em que aparecem.
- **Acrescentar e remover:** duplique um nó parecido (Ctrl+D) e ajuste. Os itens precisam de um `pid` único, porque é por ele que o jogo lembra o que já foi pego.

**Atenção:** a arte de cada objeto (sprite, colisão interna, brilho) é criada quando o jogo roda. Por isso, no editor, itens, inimigos e objetos aparecem pela `PreviaEditor`, não pela arte final. O terreno, a parede de fundo, os fundos, o primeiro plano e a decoração aparecem como no jogo; os fundos ficam sem o parallax.

## O estado salvo do jogo

Ao carregar a cena, o `Level.preparar()` aplica o que está no save:
- tira os itens já pegos;
- tira a Rainha vencida e deixa o fragmento, se ele ainda não foi pego;
- tira a Fuga do Eco já feita.

Depois, abre a porta se os terminais já foram ativados e abre a fenda de retorno se o fragmento já foi pego.

## Conferência

- `tools/test_cenas_fases.gd`: confere que o que a cena descreve (o dicionário que o mapa, o salvamento e o resto do jogo leem) bate campo por campo com a descrição da v0.9 em código (`tools/referencia_fases_v09.gd`). Depois de uma edição de propósito, as falhas mostram exatamente o que mudou.
- `tools/dump_fase.gd`: faz o retrato da fase carregada, nó por nó, para comparar duas versões.
- `tools/gerar_cenas_fases.gd`: gerou as cenas a partir do código da v0.9. **Não rode de novo**: ele sobrescreve as cenas e apaga o que foi editado no Godot.
