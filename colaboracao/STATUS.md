# Quadro de pedidos de arte

Atualizado pelos agentes. Leia `PROTOCOLO.md` e `FLUXO_AUTOMATICO.md` antes de começar. Estados: `SUSPENSO`, `ABERTO`, `ENTREGUE`, `AJUSTE`, `APROVADO`, `AGUARDA JOÃO` (fichas novas), `INTEGRADO`.

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| 00_padrao_visual | Diretriz oficial de arte DA-01 | APROVADO (diretriz) | — | [DA-01](entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md) | — |
| DA-02 | Régua numérica de consistência visual (complementa a DA-01; saída da auditoria do Deserto) | APROVADO (diretriz, 17/11/2026; revisada pelo ChatGPT) | [pedido](pedidos/DA02_regua_e_fichas_v2.md) | [DA-02 proposta](entregas/00_padrao_visual/DA-02_CONSISTENCIA.md) | — |
| DA-03 | Receita de cena (camadas, valores, estrutura, escala da decoração, terreno, luz) medida no Laboratório e em Verdâmia | APROVADO (diretriz, 24/11/2026; revisada pelo ChatGPT) | [pedido](pedidos/DA03_receita_de_cena.md) | [DA-03 proposta](entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md) | — |
| A0_ficha_eco | Ficha de personagem do Eco (referência para A1–A5 e A9) | APROVADO (referência oficial) | [pedido](pedidos/A0_ficha_eco.md) | [entrega](entregas/A0_ficha_eco/) | [revisão](revisoes/A0_ficha_eco.md) |
| A1_eco_appear | Materialização do Eco, 8 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A1_eco_appear.md) | [entrega](entregas/A1_eco_appear/) | [revisão](revisoes/A1_eco_appear.md) |
| A2_eco_float | Eco pairando (loop), 6 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A2_eco_float.md) | [entrega](entregas/A2_eco_float/) | [revisão](revisoes/A2_eco_float.md) |
| A3_eco_avanco | Avanço flutuante agressivo (loop), 6 quadros. Substitui a A3_eco_run, que foi cancelada | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A3_eco_avanco.md) | [entrega](entregas/A3_eco_avanco/) | [revisão](revisoes/A3_eco_avanco.md) |
| A4_eco_grab | Agarrão no ar, 6 quadros (reescrito conforme a D01) | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A4_eco_grab.md) | [entrega](entregas/A4_eco_grab/) | [revisão](revisoes/A4_eco_grab.md) |
| A5_eco_vanish | Eco se desfazendo, 6 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A5_eco_vanish.md) | [entrega](entregas/A5_eco_vanish/) | [revisão](revisoes/A5_eco_vanish.md) |
| A9_fx_dobra_eco | Fenda da Dobra espectral (o Eco reaparece por ela), 8 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A9_fx_dobra_eco.md) | [entrega](entregas/A9_fx_dobra_eco/) | [revisão](revisoes/A9_fx_dobra_eco.md) |
| A6_entulho | 3 pedaços de teto do laboratório que caem | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A6_entulho.md) | [entrega](entregas/A6_entulho/) | [revisão](revisoes/A6_entulho.md) |
| A7_fx_poeira | Nuvem de poeira de impacto, 6 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A7_fx_poeira.md) | [entrega](entregas/A7_fx_poeira/) | [revisão](revisoes/A7_fx_poeira.md) |
| A8_fx_rachadura_teto | Rachadura se abrindo no teto, 4 quadros | INTEGRADO (v0.7, Fuga do Eco) | [pedido](pedidos/A8_fx_rachadura_teto.md) | [entrega](entregas/A8_fx_rachadura_teto/) | [revisão](revisoes/A8_fx_rachadura_teto.md) |

**Todos os pedidos seguem a DA-01** (e a DA-02, depois de aprovada). Propostas anteriores e rejeitadas do Eco não são referência.

**Fuga do Eco integrada na v0.7 (13/11/2026):** A1–A9 estão em uso no jogo e verificadas por `tools/test_fuga.gd` e por capturas. Detalhes na seção 13 do `HANDOFF.md`.

**Decisões:** [D01: locomoção do Eco](decisoes/D01_locomocao_eco.md), **DECIDIDA**: avanço flutuante; o Eco contorna o cenário pelo rastro do jogador e usa a Dobra espectral (A5, depois A9, depois A1) em vez de atravessar paredes.

**Escala do Eco:** todas as animações do Eco usam a **mesma escala de desenho da A2** (figura de 380 px na pose de pairar). Veja a [revisão da A2](revisoes/A2_eco_float.md).

**Continuidade entre pedidos:** o quadro 8 da A1 e o quadro 1 da A5 são iguais ao quadro 1 da A2. A A3 sai da pose da A2, e a A4 começa e termina na pose da A3.

## Fase Deserto de Ferrugem (pedido [DF](pedidos/DF_deserto_ferrugem.md))

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| DF00 | Prancha de referência do Deserto (paleta, materiais, amostras) | ENTREGUE (aprovado pelo responsável) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF01 | Ficha do Robô e do Drone do deserto | REFAZER (auditoria 17/11/2026); v2 SUSPENSA até aprovar a DF02 v2 | [DF](pedidos/DF_deserto_ferrugem.md) · [v2](pedidos/DA02_regua_e_fichas_v2.md) | — | — |
| DF10–DF12 | Fundos das Dunas em parallax | INTEGRADO (v0.8); A REFAZER (DF200, DF201) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF20–DF28 | Terreno, paredes, piso, esteira, trilho e cabo | INTEGRADO (v0.8); DF20, DF21 e DF25 substituídos pela DF205; paredes DF22–DF24 A REFAZER (DF202) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF30–DF39 | Objetos de cenário e portas | INTEGRADO (v0.8, 17/11/2026) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF50–DF57 | Prensas, serra, plataformas, válvulas e gancho | INTEGRADO (v0.8, 17/11/2026) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF60–DF71 | Robôs, drones e seus projéteis | INTEGRADO (v0.8, 17/11/2026) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |
| DF80–DF86 | Efeitos de máquinas, areia, impacto e vento | INTEGRADO (v0.8, 17/11/2026) | [DF](pedidos/DF_deserto_ferrugem.md) | — | — |

Todos os assets do pedido DF foram **integrados na campanha principal na v0.8** (17/11/2026), em `assets/deserto/`, pelo `tools/import_deserto.py` (layout e máquinas vindos da branch do protótipo, reescritos na `main`). Nenhum asset do DF ficou sem uso. As entregas DF ainda não têm revisão cruzada registrada em `revisoes/`.

## Fase 2: Deserto de Ferrugem (proposta de campanha, 11/11/2026)

Visão geral, divergências e plano: [proposta da Fase 2](../docs/fases/deserto_ferrugem/proposta_fase2.md). **D02–D05 decididas em 12/11/2026 (recomendações aceitas).** Fichas novas (DF02, DF03, PT00) só viram referência depois da aprovação do João Marcelo; os lotes 2 e 3 esperam a ficha correspondente.

| Decisão | Tema | Estado |
|---|---|---|
| [D02](decisoes/D02_passagem_verdamia_deserto.md) | Passagem entre Verdâmia e o Deserto, e save | DECIDIDA (12/11/2026) |
| [D03](decisoes/D03_forma_deserto.md) | Forma de Daymon no Deserto (Autômato recomendado) | DECIDIDA (12/11/2026) |
| [D04](decisoes/D04_chefe_deserto.md) | Chefe do Deserto (Forja-Mãe recomendada) | DECIDIDA (12/11/2026) |
| [D05](decisoes/D05_portais.md) | Portais: linguagem, peças e integração | DECIDIDA (12/11/2026) |

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| DF02 | Ficha do Autômato (lote 1) | REFAZER (auditoria 17/11/2026); v2 ABERTA (prompt 2) | [pedido](pedidos/DF02_ficha_automato.md) · [v2](pedidos/DA02_regua_e_fichas_v2.md) | [entrega](entregas/DF02/) | — |
| DF03 | Ficha da Forja-Mãe e esquema da arena (lote 1) | ENTREGUE (AGUARDA JOÃO; pacote Revisão v2 de 13/11/2026) | [pedido](pedidos/DF03_ficha_forja_mae.md) | [entrega](entregas/DF03/) | — |
| PT00 | Ficha dos portais e do Receptáculo (lote 1) | ENTREGUE (AGUARDA JOÃO; pacote Revisão v2 de 13/11/2026) | [pedido](pedidos/PT00_ficha_portais.md) | [entrega](entregas/PT00/) | — |
| DF87–DF99 | Autômato: 7 folhas do corpo, braço, rebite, disparo, feixe e pulso (lote 2) | INTEGRADO (v0.8, 17/11/2026; a ficha DF02 ainda aguarda o João) | [pedido](pedidos/DF87-DF99_automato.md) | entregas DF87, DF88, DF90–DF99 | — |
| PT10–PT23 | Arco de Dobra, glifos, Receptáculo, membrana e Fenda (lote 2) | INTEGRADO (v0.8, 17/11/2026; a ficha PT00 ainda aguarda o João) | [pedido](pedidos/PT10-PT23_portais.md) | entregas PT10–PT13, PT15, PT20–PT23 | — |
| DF100–DF112 | Forja-Mãe: corpo, lente, peito, braço, martelo, núcleo, escotilha, grade e efeitos (lote 3) | INTEGRADO (v0.8, 17/11/2026; a ficha DF03 ainda aguarda o João) | [pedido](pedidos/DF100-DF112_forja_mae.md) | entregas DF100–DF108, DF110–DF112 | — |

## Fase Verdâmia

Pacote completo em [VD_verdamia](entregas/VD_verdamia/) (64 assets em 67 PNGs). **Integrado ao jogo na v0.6 (11/11/2026).** Revisão, medidas e destino de cada asset: [revisão VD_verdamia](revisoes/VD_verdamia.md).

| ID | O que é | Estado |
|---|---|---|
| D0 / E0 / VD00 | Referências do Lince, inimigos e ambiente | APROVADO (referência; não entra no jogo) |
| D | 11 animações do Lince-Vagalume (wall, claw e flash na versão `_v2`) | INTEGRADO |
| E | Esporângio (3), Mariposa (2), Rainha Micélia (16 folhas) e 7 objetos de cenário | INTEGRADO |
| VD | Terreno (7), parallax (3), efeitos (7), projéteis (2), checkpoint, barreira e fragmento | INTEGRADO |

**61 assets integrados e verificados no jogo, 3 referências, nenhum pendente.** A revisão lista 7 pedidos de ajuste que não bloqueiam (escala entre folhas do Lince, garras no ar, esquiva, fim da morte da Rainha, contorno de `esporos_3`, subsolo repetível e miolo da parede).

## Fase 3: Nivária (universo de gelo)

Proposta e decisões: [proposta da Fase 3](../docs/fases/nivaria/proposta_fase3.md). D07 e D08 aprovadas pelo João (19/11/2026); D06 (lugar na campanha) em aberto. Pedidos do lote 1: [GL](pedidos/GL_lote1_fichas.md). Lote 2: [GL lote 2](pedidos/GL_lote2_producao.md).

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| GL00 | Prancha de referência de Nivária (paleta, materiais, cenas, valores) | ENTREGUE | [GL](pedidos/GL_lote1_fichas.md) | [Prancha e aferição](entregas/GL00/ENTREGA.md) | — |
| GL01 | Ficha do Daymon de inverno (camada polar, cachecol) | ENTREGUE (v2, aprovada) | [GL](pedidos/GL_lote1_fichas.md) | [Ficha e comparação](entregas/GL01/ENTREGA_v2.md) | — |
| GL02 | Ficha dos inimigos: Gelinho, Drone Gélido, Morcego-de-Cristal | ENTREGUE (v2, aprovada) | [GL](pedidos/GL_lote1_fichas.md) | [Ficha, comparação e aferição DA-02](entregas/GL02/ENTREGA_v2.md) | — |
| GL03 | Ficha do Guardião Glacial e esquema da arena | ENTREGUE (v2, aprovada) | [GL](pedidos/GL_lote1_fichas.md) | [Ficha, arena e comparação](entregas/GL03/ENTREGA_v2.md) | — |
| GL04 | Prancha de objetos, perigos e coletáveis | ENTREGUE (v2, aprovada) | [GL](pedidos/GL_lote1_fichas.md) | [Prancha e comparação](entregas/GL04/ENTREGA_v2.md) | — |
| GL10 | Daymon de inverno: folhas do corpo (7 animações) | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL11 | Braço armado de inverno | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL12 | Cachecol em peças | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL13 | Geada e bloco de gelo | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL14 | Pulso Térmico (efeito) | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL30 | Gelinho: animação e sopro | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL31 | Drone Gélido: animação, esfera e gelo no chão | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL32 | Morcego-de-Cristal: animação | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL50 | Fundo distante: céu da noite polar | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL51 | Fundo intermediário: cordilheira e encostas | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL52 | Fundos da Caverna de Cristal | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL53 | Fundo da Arena do Guardião | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL54 | Estrutura de fundo (peças grandes) | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL55 | Terreno completo | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL56 | Decoração média e pequena | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL57 | Moldura (o que desce do alto) | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL58 | Primeiro plano | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL59 | Efeitos de ambiente | ABERTO (DA-03 aprovada) | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL70 | Objetos animados: perigos | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL71 | Objetos animados: interação e coletáveis | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL90 | Glifo de Nivária e ícone de Geada | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL100 | Guardião Glacial: poses (lote 3) | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL101 | Guardião Glacial: placas e núcleo (lote 3) | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |
| GL102 | Guardião Glacial: efeitos (lote 3) | ABERTO | [GL lote 2](pedidos/GL_lote2_producao.md) | — | — |

## Deserto de Ferrugem: refação da cena (DA-03)

Pedido: [DF refação](pedidos/DF_refacao_cena.md) (24/11/2026). Inventário de arte das quatro fases: [docs/INVENTARIO_DE_ARTE.md](../docs/INVENTARIO_DE_ARTE.md).

| ID | O que é | Estado | Pedido | Entrega | Revisão |
|---|---|---|---|---|---|
| DF00 v2 | Prancha do Deserto com os valores da DA-03 | APROVADO pelo João (24/11/2026) e publicado na `main` (`9aae70b`) | [DF refação](pedidos/DF_refacao_cena.md) | [entregas/DF00](entregas/DF00/ENTREGA_v2.md) | Claude: Autômato atual sobre as Dunas pintadas, com o halo do jogo, 71–76% de separação (ver DF205) |
| DF200 | Fundo distante: céu do crepúsculo de tempestade | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF201 | Fundo intermediário: dunas de sucata e a fábrica ao longe | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF202 | Fundos internos: Fábrica e Salão do Núcleo | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF203 | Fundo da Câmara da Forja | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF204 | Estrutura de fundo (peças grandes) | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF205 | Terreno completo (22 peças no formato do terreno de Verdâmia; gabarito de colisões) | APROVADO pelo João (24/11/2026), publicado na `main` (`cbdd27c`); INTEGRADO na `dev/deserto` (HANDOFF 15.3; retoque pendente nos cantos de areia) | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF206 | Decoração média e pequena | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF207 | Moldura | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF208 | Primeiro plano | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF209 | Efeitos de ambiente | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF210 | Placa, estação, célula, núcleo e registro do Deserto | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
| DF03 v2 | Retoque da Forja-Mãe (DF03, DF100–DF108) | ABERTO | [DF refação](pedidos/DF_refacao_cena.md) | — | — |
