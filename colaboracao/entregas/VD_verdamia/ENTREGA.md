# Verdâmia — entrega de arte

**Produção:** 55/64 imagens presentes neste commit.
**Estado:** assets originais gerados; integração na Godot e revisão final do responsável pendentes.

O responsável solicitou produzir todos os assets, incluindo a elaboração das especificações que faltavam, e manter commits ao longo da produção. A direção segue a DA-01 e os pacotes D/E do guia. As extensões do inventário cobrem elementos já usados pelo mapa e pelo código, sem introduzir novas mecânicas.

## Arquivos de apoio

- `ESPECIFICACOES.md`: escopo, paleta, dimensões, grade e continuidade.
- `PROMPTS.json`: instruções de produção por imagem e referências utilizadas.
- `MANIFESTO.json`: tamanho real, alpha, bytes, SHA-256 e bboxes por célula; não é certificado de qualidade estética.
- `SHA256_ORIGINAIS.json`: hashes de todos os PNGs, incluindo versões preservadas. O manifesto principal seleciona a versão mais recente de cada asset.
- `verificar_assets.py` e `registrar_entrega.py`: inspeção sem modificar as imagens e atualização desta lista.

## Uso e limites

As três pranchas de referência têm fundo escuro de propósito. Sprites, objetos e efeitos são entregues em PNG com alpha; o fundo distante e o preenchimento de subsolo são opacos de propósito. O original não foi recomprimido nem editado por script.

As dimensões solicitadas não garantem alinhamento exato dos desenhos dentro da grade. Conferir os bboxes e avisos antes de usar o importador automático. É necessário calibrar origem, escala, duração, hitboxes e apoios no motor. Não marcar INTEGRADO nem substituir assets existentes antes dessa revisão. Folhas com vazamento ou células extras precisam de correção ou atlas com recorte específico por quadro; não usar cegamente a grade padrão.

Alguns objetos foram gerados em canvas nativo maior ou mais largo que o 1024×1024 solicitado. As dimensões reais e os bboxes estão no manifesto; preservar estes originais e preparar a escala e a origem a partir dessas medidas. Esses arquivos não devem ser tratados como exports de tamanho padronizado já prontos para um importador que assuma 1024×1024.

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
| D_lince_wall | [D_lince_wall_v2.png](D_lince_wall_v2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_claw | [D_lince_claw_v2.png](D_lince_claw_v2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_pogo | [D_lince_pogo.png](D_lince_pogo.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| D_lince_flash | [D_lince_flash_v2.png](D_lince_flash_v2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
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
| E_rainha_esporos_1 | [E_rainha_esporos_1.png](E_rainha_esporos_1.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_esporos_2 | [E_rainha_esporos_2.png](E_rainha_esporos_2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_esporos_3 | [E_rainha_esporos_3.png](E_rainha_esporos_3.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_rugido_1 | [E_rainha_rugido_1.png](E_rainha_rugido_1.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_rugido_2 | [E_rainha_rugido_2.png](E_rainha_rugido_2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_hurt_1 | [E_rainha_hurt_1.png](E_rainha_hurt_1.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_death_1 | [E_rainha_death_1.png](E_rainha_death_1.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_death_2 | [E_rainha_death_2.png](E_rainha_death_2.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_death_3 | [E_rainha_death_3.png](E_rainha_death_3.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E_rainha_death_4 | [E_rainha_death_4.png](E_rainha_death_4.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| E1_cogumelo_gigante | [E1_cogumelo_gigante.png](E1_cogumelo_gigante.png) | 1254×1254 | sim | Revisar avisos |
| E1_grama | [E1_grama.png](E1_grama.png) | 1254×1254 | sim | Revisar avisos |
| E1_raiz_pendurada | [E1_raiz_pendurada.png](E1_raiz_pendurada.png) | 1254×1254 | sim | Revisar avisos |
| E1_tronco_plataforma | [E1_tronco_plataforma.png](E1_tronco_plataforma.png) | 1774×887 | sim | Revisar avisos |
| E1_pedra_musgo | [E1_pedra_musgo.png](E1_pedra_musgo.png) | 1254×1254 | sim | Revisar avisos |
| E1_arco_templo | [E1_arco_templo.png](E1_arco_templo.png) | 1254×1254 | sim | Revisar avisos |
| E1_altar | [E1_altar.png](E1_altar.png) | 1254×1254 | sim | Revisar avisos |
| VD_checkpoint | [VD_checkpoint.png](VD_checkpoint.png) | 1254×1254 | sim | Revisar avisos |
| VD_barreira_arena | [VD_barreira_arena.png](VD_barreira_arena.png) | 1254×1254 | sim | Revisar avisos |
| VD_fragmento | [VD_fragmento.png](VD_fragmento.png) | 1254×1254 | sim | Revisar avisos |
| VD_esporo_verde | [VD_esporo_verde.png](VD_esporo_verde.png) | 1254×1254 | sim | Revisar avisos |
| VD_esporo_violeta | [VD_esporo_violeta.png](VD_esporo_violeta.png) | 1254×1254 | sim | Revisar avisos |
| VD_chao_musgo | [VD_chao_musgo.png](VD_chao_musgo.png) | 2172×724 | sim | Revisar avisos |
| VD_subsolo | [VD_subsolo.png](VD_subsolo.png) | 1254×1254 | opaco | Revisar avisos |
| VD_parede_escalada | [VD_parede_escalada.png](VD_parede_escalada.png) | 1254×1254 | sim | Revisar avisos |
| VD_canto_esquerdo | [VD_canto_esquerdo.png](VD_canto_esquerdo.png) | 1254×1254 | sim | Revisar avisos |
| VD_canto_direito | [VD_canto_direito.png](VD_canto_direito.png) | 1254×1254 | sim | Revisar avisos |
| VD_espinhos | [VD_espinhos.png](VD_espinhos.png) | 1254×1254 | sim | Revisar avisos |
| VD_plataforma_raizes | [VD_plataforma_raizes.png](VD_plataforma_raizes.png) | 1774×887 | sim | Revisar avisos |
| VD_bg_distante | — | — | — | Ainda em produção |
| VD_bg_intermediario | [VD_bg_intermediario.png](VD_bg_intermediario.png) | 1536×1024 | sim | Sem alerta automático; revisão visual necessária |
| VD_fg_vegetacao | — | — | — | Ainda em produção |
| VD_fx_raiz | — | — | — | Ainda em produção |
| VD_fx_aviso_raiz | — | — | — | Ainda em produção |
| VD_fx_impacto_esporo | — | — | — | Ainda em produção |
| VD_fx_invocacao | — | — | — | Ainda em produção |
| VD_fx_poeira | — | — | — | Ainda em produção |
| VD_fx_garras | — | — | — | Ainda em produção |
| VD_fx_clarao | — | — | — | Ainda em produção |

## Alertas de enquadramento

- **E1_cogumelo_gigante**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **E1_grama**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **E1_raiz_pendurada**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **E1_tronco_plataforma**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **E1_pedra_musgo**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **E1_arco_templo**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **E1_altar**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_checkpoint**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_barreira_arena**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_fragmento**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_esporo_verde**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_esporo_violeta**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_chao_musgo**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_subsolo**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_parede_escalada**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_canto_esquerdo**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_canto_direito**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_espinhos**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
- **VD_plataforma_raizes**: Canvas nativo difere do solicitado; usar dimensoes reais e calibrar escala na importacao. Original preservado.
