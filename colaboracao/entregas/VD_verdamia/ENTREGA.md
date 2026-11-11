# Verdâmia — entrega de arte

**Produção:** 25/64 imagens presentes neste commit.
**Estado:** assets originais gerados; integração na Godot e revisão final do responsável pendentes.

O responsável solicitou produzir todos os assets, incluindo a elaboração das especificações que faltavam, e manter commits ao longo da produção. A direção segue a DA-01 e os pacotes D/E do guia. As extensões do inventário cobrem elementos já usados pelo mapa e pelo código, sem introduzir novas mecânicas.

## Arquivos de apoio

- `ESPECIFICACOES.md`: escopo, paleta, dimensões, grade e continuidade.
- `PROMPTS.json`: instruções de produção por imagem e referências utilizadas.
- `MANIFESTO.json`: tamanho real, alpha, bytes, SHA-256 e bboxes por célula; não é certificado de qualidade estética.
- `verificar_assets.py` e `registrar_entrega.py`: inspeção sem modificar as imagens e atualização desta lista.

## Uso e limites

As três pranchas de referência têm fundo escuro de propósito. Sprites, objetos e efeitos são entregues em PNG com alpha; o fundo distante e o preenchimento de subsolo são opacos de propósito. O original não foi recomprimido nem editado por script.

As dimensões solicitadas não garantem alinhamento exato dos desenhos dentro da grade. Conferir os bboxes e avisos antes de usar o importador automático. É necessário calibrar origem, escala, duração, hitboxes e apoios no motor. Não marcar INTEGRADO nem substituir assets existentes antes dessa revisão. Folhas com vazamento ou células extras precisam de correção ou atlas com recorte específico por quadro; não usar cegamente a grade padrão.

A Rainha usa 16 folhas 2×1; raízes, esporos e invocação são peças separadas. A animação de esporos atende chuva e rajada; rugido atende invocação e enfurecimento. Itens de cura, energia, células e tablets mantêm os assets existentes do jogo.

## Inventário deste commit

| Asset | Arquivo | Dimensão real | Alpha | Revisão técnica |
|---|---|---|---|---|
| D0_lince | [D0_lince.png](D0_lince.png) | 1536×1024 | opaco | Sem alerta automático; revisão visual necessária |
| E0_inimigos | [E0_inimigos.png](E0_inimigos.png) | 1536×1024 | opaco | Sem alerta automático; revisão visual necessária |
| VD00_ambiente | [VD00_ambiente.png](VD00_ambiente.png) | 1536×1024 | opaco | Sem alerta automático; revisão visual necessária |
| D_lince_idle | [D_lince_idle.png](D_lince_idle.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_run | [D_lince_run.png](D_lince_run.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_jump | [D_lince_jump.png](D_lince_jump.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_fall | [D_lince_fall.png](D_lince_fall.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_doublejump | [D_lince_doublejump.png](D_lince_doublejump.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_wall | [D_lince_wall.png](D_lince_wall.png) | 1536×1024 | sim | Revisar avisos |
| D_lince_claw | [D_lince_claw.png](D_lince_claw.png) | 1536×1024 | sim | Revisar avisos |
| D_lince_pogo | [D_lince_pogo.png](D_lince_pogo.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_flash | [D_lince_flash.png](D_lince_flash.png) | 1536×1024 | sim | Revisar avisos |
| D_lince_hurt | [D_lince_hurt.png](D_lince_hurt.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_death | [D_lince_death.png](D_lince_death.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_esporangio_idle | [E_esporangio_idle.png](E_esporangio_idle.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_esporangio_attack | [E_esporangio_attack.png](E_esporangio_attack.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_esporangio_death | [E_esporangio_death.png](E_esporangio_death.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_mariposa_fly | [E_mariposa_fly.png](E_mariposa_fly.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_mariposa_death | [E_mariposa_death.png](E_mariposa_death.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_idle_1 | [E_rainha_idle_1.png](E_rainha_idle_1.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_idle_2 | [E_rainha_idle_2.png](E_rainha_idle_2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_idle_3 | [E_rainha_idle_3.png](E_rainha_idle_3.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_raizes_1 | [E_rainha_raizes_1.png](E_rainha_raizes_1.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_raizes_2 | [E_rainha_raizes_2.png](E_rainha_raizes_2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_raizes_3 | [E_rainha_raizes_3.png](E_rainha_raizes_3.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_esporos_1 | — | — | — | Ainda em produção |
| E_rainha_esporos_2 | — | — | — | Ainda em produção |
| E_rainha_esporos_3 | — | — | — | Ainda em produção |
| E_rainha_rugido_1 | — | — | — | Ainda em produção |
| E_rainha_rugido_2 | — | — | — | Ainda em produção |
| E_rainha_hurt_1 | — | — | — | Ainda em produção |
| E_rainha_death_1 | — | — | — | Ainda em produção |
| E_rainha_death_2 | — | — | — | Ainda em produção |
| E_rainha_death_3 | — | — | — | Ainda em produção |
| E_rainha_death_4 | — | — | — | Ainda em produção |
| E1_cogumelo_gigante | — | — | — | Ainda em produção |
| E1_grama | — | — | — | Ainda em produção |
| E1_raiz_pendurada | — | — | — | Ainda em produção |
| E1_tronco_plataforma | — | — | — | Ainda em produção |
| E1_pedra_musgo | — | — | — | Ainda em produção |
| E1_arco_templo | — | — | — | Ainda em produção |
| E1_altar | — | — | — | Ainda em produção |
| VD_checkpoint | — | — | — | Ainda em produção |
| VD_barreira_arena | — | — | — | Ainda em produção |
| VD_fragmento | — | — | — | Ainda em produção |
| VD_esporo_verde | — | — | — | Ainda em produção |
| VD_esporo_violeta | — | — | — | Ainda em produção |
| VD_chao_musgo | — | — | — | Ainda em produção |
| VD_subsolo | — | — | — | Ainda em produção |
| VD_parede_escalada | — | — | — | Ainda em produção |
| VD_canto_esquerdo | — | — | — | Ainda em produção |
| VD_canto_direito | — | — | — | Ainda em produção |
| VD_espinhos | — | — | — | Ainda em produção |
| VD_plataforma_raizes | — | — | — | Ainda em produção |
| VD_bg_distante | — | — | — | Ainda em produção |
| VD_bg_intermediario | — | — | — | Ainda em produção |
| VD_fg_vegetacao | — | — | — | Ainda em produção |
| VD_fx_raiz | — | — | — | Ainda em produção |
| VD_fx_aviso_raiz | — | — | — | Ainda em produção |
| VD_fx_impacto_esporo | — | — | — | Ainda em produção |
| VD_fx_invocacao | — | — | — | Ainda em produção |
| VD_fx_poeira | — | — | — | Ainda em produção |
| VD_fx_garras | — | — | — | Ainda em produção |
| VD_fx_clarao | — | — | — | Ainda em produção |

## Alertas de enquadramento

- **D_lince_wall**: Quadro 1: desenho toca borda; revisar recorte.; Quadro 2: desenho toca borda; revisar recorte.; Quadro 3: desenho toca borda; revisar recorte.; Quadro 4: desenho toca borda; revisar recorte.; Celula excedente 4 contem pixels: verificar vazamento.
- **D_lince_claw**: Quadro 3: desenho toca borda; revisar recorte.; Quadro 4: desenho toca borda; revisar recorte.
- **D_lince_flash**: Quadro 3: desenho toca borda; revisar recorte.; Quadro 4: desenho toca borda; revisar recorte.
