# Revisão e integração: pacote VD_verdamia

**Resultado:** 61 assets **INTEGRADOS** e verificados no jogo; 3 pranchas ficam como referência de arte; nenhum pendente.
**Revisor:** Claude (desenvolvimento) · **Versão do jogo:** v0.6 · **Data:** 11/11/2026
**Entrega revisada:** `colaboracao/entregas/VD_verdamia/` no commit `f93d5d1` (64 assets em 67 PNGs)
**Teste:** Godot 4.3 stable, renderer Compatibility, Linux, câmera do jogo (zoom 1,1)

Os PNGs entregues não foram alterados. As três versões antigas (`D_lince_wall.png`, `D_lince_claw.png`, `D_lince_flash.png`) continuam na pasta e não são usadas: vale a versão `_v2` apontada pelo manifesto. Tudo o que foi corrigido acontece na importação (`tools/import_verdamia.py`).

## O que a importação precisou resolver

| Problema encontrado | Solução na importação |
|---|---|
| As folhas do Lince não vieram na mesma escala (a de garras é cerca de 27% menor que a parada) | Fator por folha: run 1,12; jump 1,07; fall 1,06; doublejump 1,13; wall 1,07; claw 1,27; pogo 1,10; flash 1,12; hurt 1,00; death 1,09 |
| Os pés não estão em y 472 como pedido (idle 427, run 411, claw 391, flash 404, hurt 439) | Linha do chão medida em cada folha; no ar a âncora é o centro do corpo; na parede, as patas |
| As 16 folhas da Rainha variam de tamanho | Escala pela largura da base de raízes (normalizada em 700 px); âncora no centro da base |
| Esporângio: folhas de ataque e de morte menores que a parada | Escala pela largura da base |
| Névoa quase invisível (alfa 1 a 10) em volta de quase todas as figuras | Zerada antes do recorte |
| 19 objetos e terrenos com canvas fora do padrão | Recorte pelos limites visuais reais e escala própria por peça |
| `VD_subsolo`, `VD_chao_musgo` e `VD_espinhos` não emendam nas bordas | Subsolo em mosaico espelhado; chão e espinhos com fusão das bordas |
| A arte olha para a direita | Rainha espelhada (fica no canto direito); inimigos viram para o jogador |

Não foi aplicado o "despill" de verde usado no Eco: em Verdâmia o verde faz parte da paleta e a correção acinzentaria o musgo.

## Destino de cada asset

| ID | Arquivo usado | Destino | Onde aparece e observações |
|---|---|---|---|
| D0_lince | D0_lince.png | Referência de arte | Comparação visual do Lince. Não entra no jogo. |
| E0_inimigos | E0_inimigos.png | Referência de arte | Comparação visual dos inimigos e da Rainha. Não entra no jogo. |
| VD00_ambiente | VD00_ambiente.png | Referência de arte | Comparação visual do cenário. Não entra no jogo. |
| D_lince_idle | D_lince_idle.png | INTEGRADO | Parado no chão. Base de escala das outras folhas. |
| D_lince_run | D_lince_run.png | INTEGRADO | Corrida (velocidade da animação segue a do personagem). O quadro 3 serve de pose da esquiva. |
| D_lince_jump | D_lince_jump.png | INTEGRADO | Quadro 1 no pouso (agachamento), 2 na subida rápida, 3 perto do topo do salto. |
| D_lince_fall | D_lince_fall.png | INTEGRADO | Quadros 1 a 3 conforme a velocidade de queda. |
| D_lince_doublejump | D_lince_doublejump.png | INTEGRADO | Cambalhota do segundo pulo (0,28 s). |
| D_lince_wall | D_lince_wall_v2.png | INTEGRADO | Versão `_v2`. Deslizar na parede; patas alinhadas à borda da colisão. |
| D_lince_claw | D_lince_claw_v2.png | INTEGRADO | Versão `_v2`. Golpe lateral no chão. No ar o corpo mantém a pose de salto e só o corte aparece. |
| D_lince_pogo | D_lince_pogo.png | INTEGRADO | Golpe para baixo no ar. |
| D_lince_flash | D_lince_flash_v2.png | INTEGRADO | Versão `_v2`. Clarão (especial). |
| D_lince_hurt | D_lince_hurt.png | INTEGRADO | Dano com recuo (0,3 s). |
| D_lince_death | D_lince_death.png | INTEGRADO | Morte. Os quadros 5 e 6 vieram mais altos na célula; a importação apoia cada quadro no chão. |
| E_esporangio_idle | E_esporangio_idle.png | INTEGRADO | Parado; vira para o lado do jogador. |
| E_esporangio_attack | E_esporangio_attack.png | INTEGRADO | Quadros 1–2 enquanto carrega, 3 ao cuspir, 4 ao recolher. O esporo sai da boca do bulbo. |
| E_esporangio_death | E_esporangio_death.png | INTEGRADO | Murcha no lugar e some. |
| E_mariposa_fly | E_mariposa_fly.png | INTEGRADO | Voo; vira para o lado em que voa. |
| E_mariposa_death | E_mariposa_death.png | INTEGRADO | O corpo cai e some. |
| E_rainha_idle_1 | E_rainha_idle_1.png | INTEGRADO | Animação idle (parada). |
| E_rainha_idle_2 | E_rainha_idle_2.png | INTEGRADO | Animação idle (parada). |
| E_rainha_idle_3 | E_rainha_idle_3.png | INTEGRADO | Animação idle (parada). |
| E_rainha_raizes_1 | E_rainha_raizes_1.png | INTEGRADO | Animação raizes (ataque de raízes; o chão racha no quadro 5, quando a primeira raiz é criada). |
| E_rainha_raizes_2 | E_rainha_raizes_2.png | INTEGRADO | Animação raizes (ataque de raízes; o chão racha no quadro 5, quando a primeira raiz é criada). |
| E_rainha_raizes_3 | E_rainha_raizes_3.png | INTEGRADO | Animação raizes (ataque de raízes; o chão racha no quadro 5, quando a primeira raiz é criada). |
| E_rainha_esporos_1 | E_rainha_esporos_1.png | INTEGRADO | Animação esporos (chuva e rajada). |
| E_rainha_esporos_2 | E_rainha_esporos_2.png | INTEGRADO | Animação esporos (chuva e rajada). |
| E_rainha_esporos_3 | E_rainha_esporos_3.png | INTEGRADO | Animação esporos (chuva e rajada). |
| E_rainha_rugido_1 | E_rainha_rugido_1.png | INTEGRADO | Animação rugido (despertar, enfurecer e invocação). |
| E_rainha_rugido_2 | E_rainha_rugido_2.png | INTEGRADO | Animação rugido (despertar, enfurecer e invocação). |
| E_rainha_hurt_1 | E_rainha_hurt_1.png | INTEGRADO | Animação hurt (ao levar dano fora de um ataque). |
| E_rainha_death_1 | E_rainha_death_1.png | INTEGRADO | Animação death (derrota). |
| E_rainha_death_2 | E_rainha_death_2.png | INTEGRADO | Animação death (derrota). |
| E_rainha_death_3 | E_rainha_death_3.png | INTEGRADO | Animação death (derrota). |
| E_rainha_death_4 | E_rainha_death_4.png | INTEGRADO | Animação death (derrota). Ressalva: os dois últimos quadros mostram um chapéu inteiro depois do desmoronamento. |
| E1_cogumelo_gigante | E1_cogumelo_gigante.png | INTEGRADO | Cenário de fundo em 3 pontos (x 330, 1345, 3130). |
| E1_grama | E1_grama.png | INTEGRADO | Tufos no chão e no topo do paredão (9 pontos). |
| E1_raiz_pendurada | E1_raiz_pendurada.png | INTEGRADO | Sob as duas plataformas do vale de espinhos. |
| E1_tronco_plataforma | E1_tronco_plataforma.png | INTEGRADO | As duas plataformas da arena. Linha de apoio medida no topo do tronco. |
| E1_pedra_musgo | E1_pedra_musgo.png | INTEGRADO | Cenário no chão (x 705, 2495, 3330). |
| E1_arco_templo | E1_arco_templo.png | INTEGRADO | Entrada da arena (x 3760) e, maior e mais escuro, atrás da Rainha. |
| E1_altar | E1_altar.png | INTEGRADO | Na arena, atrás do ponto em que o fragmento aparece. |
| VD_checkpoint | VD_checkpoint.png | INTEGRADO | Santuário de recarga (x 2570). |
| VD_barreira_arena | VD_barreira_arena.png | INTEGRADO | Barreira da arena. Três trechos empilhados cobrem os 500 px da colisão; os de cima usam a peça sem a base de musgo. |
| VD_fragmento | VD_fragmento.png | INTEGRADO | Fragmento da Dobra; coletá-lo leva à vitória. |
| VD_esporo_verde | VD_esporo_verde.png | INTEGRADO | Projétil do Esporângio e da rajada da Rainha. |
| VD_esporo_violeta | VD_esporo_violeta.png | INTEGRADO | Chuva de esporos da Rainha; aparece translúcido no alto como aviso antes de cair. |
| VD_chao_musgo | VD_chao_musgo.png | INTEGRADO | Topo de todos os blocos de chão. Bordas fundidas para repetir; a terra esmaece para o subsolo. |
| VD_subsolo | VD_subsolo.png | INTEGRADO | Preenchimento dos blocos. A peça não emenda sozinha: usado em mosaico 2×2 espelhado. |
| VD_parede_escalada | VD_parede_escalada.png | INTEGRADO | Usada só a borda com musgo (72 px) nas laterais expostas de paredes, pilar e fossos. O miolo de rocha não foi usado, para não destoar do subsolo. |
| VD_canto_esquerdo | VD_canto_esquerdo.png | INTEGRADO | Quina dos cantos superiores esquerdos expostos (recorte de 90×130 px com esmaecimento). |
| VD_canto_direito | VD_canto_direito.png | INTEGRADO | Quina dos cantos superiores direitos expostos. |
| VD_espinhos | VD_espinhos.png | INTEGRADO | Os dois fossos de espinhos. Faixa repetida com bordas fundidas; linha do musgo na base do perigo. |
| VD_plataforma_raizes | VD_plataforma_raizes.png | INTEGRADO | As duas plataformas do vale de espinhos. |
| VD_bg_distante | VD_bg_distante.png | INTEGRADO | Parallax distante (substitui o céu e as silhuetas por código). |
| VD_bg_intermediario | VD_bg_intermediario.png | INTEGRADO | Parallax intermediário, escurecido para o Lince se destacar; cópias vizinhas espelhadas. |
| VD_fg_vegetacao | VD_fg_vegetacao.png | INTEGRADO | Primeiro plano na borda de baixo da tela, abaixo do nível dos fossos. |
| VD_fx_raiz | VD_fx_raiz.png | INTEGRADO | Raiz da Rainha: sobe (1–2), fica de pé (3–4) e recolhe (5–6). O dano vale enquanto está de pé. |
| VD_fx_aviso_raiz | VD_fx_aviso_raiz.png | INTEGRADO | Aviso de 0,6 s no chão antes da raiz. |
| VD_fx_impacto_esporo | VD_fx_impacto_esporo.png | INTEGRADO | Quando um esporo estoura (tingido de violeta na chuva). |
| VD_fx_invocacao | VD_fx_invocacao.png | INTEGRADO | Onde cada mariposa invocada vai surgir, 0,2 s antes. |
| VD_fx_poeira | VD_fx_poeira.png | INTEGRADO | Pouso do Lince. |
| VD_fx_garras | VD_fx_garras.png | INTEGRADO | Corte das garras; girado para golpes para cima e para baixo. |
| VD_fx_clarao | VD_fx_clarao.png | INTEGRADO | Anel do Clarão; o diâmetro máximo coincide com o alcance do golpe. |

## Relação entre desenho e colisão

| Elemento | Desenho no jogo | Colisão | Observação |
|---|---|---|---|
| Lince | cerca de 58 × 55 px (com cauda e orelhas) | 32 × 34 px (inalterada) | O corpo fica sobre a colisão; cauda, orelhas e lanterna ficam fora dela, como no desenho antigo |
| Raiz da Rainha | cerca de 100 × 140 px | 56 × 140 px (era 40) | Alargada para acompanhar o tronco das raízes |
| Barreira | 90 × 500 px | 50 × 500 px (inalterada) | Os espinhos passam 20 px de cada lado |
| Espinhos | 37 px de altura | 32 a 36 px (inalterada) | |
| Rainha | cerca de 295 × 280 px | área de dano 150 × 220 px (inalterada) | Tronco e chapéu ficam dentro da área de dano |
| Esporos | 30 a 34 px | raio 8 a 9 px (inalterado) | |

## Pedidos de ajuste para a direção de arte (não bloqueiam)

1. **Escala entre folhas do Lince.** Nas próximas entregas, manter o personagem do mesmo tamanho em todas as folhas (a parada tem 325 px de altura). Hoje a diferença é compensada por fatores estimados.
2. **Garras no ar.** Não há pose de garras em salto; no ar o corpo fica na pose de salto ou queda e só o corte aparece. Uma folha `D_lince_claw_air` de 4 quadros resolveria.
3. **Esquiva do Lince.** Não há animação; usa o quadro 3 da corrida com rastro.
4. **Morte da Rainha, folha 4.** Os dois últimos quadros mostram um cogumelo inteiro depois do desmoronamento da folha 3. Sugestão: restos caídos, sem chapéu.
5. **Folha `esporos_3` da Rainha.** Tem contorno escuro mais grosso que as outras.
6. **Subsolo repetível.** Uma versão que emende nas quatro bordas dispensaria o espelhamento.
7. **Miolo da parede de escalada.** A rocha azulada destoa do subsolo esverdeado; por isso só a borda foi usada.
