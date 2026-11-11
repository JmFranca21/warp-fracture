# Verdâmia — pacote completo de produção de arte

Data: 10/11/2026. Direção e produção: ChatGPT, assumindo também a especificação técnica solicitada pelo responsável enquanto Claude está indisponível.

## Fontes e escopo

DA-01; `docs/GUIA_PROXIMOS_PASSOS_E_ASSETS.md`, pacotes D e E; mapa atual em `scripts/level_data.gd`; comportamento de `player.gd`, `spore_plant.gd`, `moth.gd`, `queen.gd`, `spike.gd`, `gate.gd`, `checkpoint.gd`, `fragment.gd`, `terrain.gd`, `bg_layer.gd` e `fg_layer.gd`.

Produzir arte para a fase existente, sem adicionar mecânicas ou alterar o mapa. A integração e a validação em jogo são uma etapa distinta. Este pacote não implica que os sprites já estejam rodando na Godot.

## Direção visual

Mesmo artista das fichas oficiais de Daymon e Laboratório Hélix: cartoon 2D de silhueta clara, anatomia compacta, formas definidas, contornos limpos, duas ou três faces de sombra, sem pintura realista, sem pixel art, sem 3D. Verdâmia: floresta em noite eterna, verde-azulado escuro, fungos verde-limão e âmbar. A faixa ciano identifica Daymon na forma Lince.

Paleta de produção: contorno #101923, azul do Lince #1B2946, luz do pelo #2A3C5D, ciano #39E6FF, verde-limão #C5ED70, âmbar #F1BB55, floresta #0A1716, musgo #1D5248, micélio pálido #C7CEC0, violeta de perigo #8D62BD. O violeta já pertence aos perigos e à Rainha no código; não substitui a paleta da floresta.

## Contrato técnico

- Referências D0, E0 e VD00: pranchas 1536×1024; podem ter títulos, paleta e fundo escuro.
- Animações comuns: PNG com alpha real, 1536×1024, grade invisível 4×2, células 384×512. Ordem por linhas, células excedentes vazias. Pés em y local 472; corpo de voadores centralizado. Sem texto, chão, sombra projetada, grade ou cenário. Personagens laterais para a direita, espelhados na integração quando necessário.
- Lince: largura de desenho aproximadamente 300 px incluindo cauda em pose neutra; escala fixa entre ações. Animações aéreas usam o mesmo tamanho anatômico e preservam espaço de movimento.
- Rainha: PNG com alpha real, 1536×1024, grade 2×1, células 768×1024, dois quadros por imagem. Base em y=984, altura neutra aproximada 760 px. Escala fixa entre folhas e ações. A Rainha fica enraizada; não ganha locomoção. Vista lateral com leve abertura de rosto para legibilidade.
- Objetos: PNG 1024×1024, um objeto por arquivo, cerca de 70% da tela, apoios explícitos; cenário sem perspectiva isométrica. Não confundir pranchas de referência com sprites recortáveis.
- Terrenos: PNG 1024×1024, preenchimento até as bordas que serão repetidas; sem margens nessas bordas. Transições e cantos precisam de revisão de emenda antes da integração.
- Parallax: 1536×1024. Camada distante opaca, camadas intermediária e próxima com alpha. Não embutir terreno jogável nem personagens.
- Efeitos: grade comum, origem fixa; brilho localizado com alpha, sem placa cinza ou quadriculado desenhado.

## Inventário de produção

| Grupo | Arquivos / ações | Quadros |
|---|---|---|
| Referências | D0_lince, E0_inimigos, VD00_ambiente | pranchas |
| Lince | D_lince_idle, run, jump, fall, doublejump, wall, claw, pogo, flash, hurt, death | 6,8,3,3,4,3,4,4,6,2,6 |
| Esporângio | E_esporangio_idle, attack, death | 6,4,6 |
| Mariposa | E_mariposa_fly, death | 6,6 |
| Rainha | E_rainha_idle, raizes, esporos, rugido, hurt, death | 6,6,6,4,2,8; 16 folhas |
| Objetos E1 | cogumelo gigante, grama, raiz pendurada, tronco plataforma, pedra com musgo, arco do templo, altar | 7 PNGs |
| Terreno | chão com musgo, preenchimento subterrâneo, parede de escalada, canto esquerdo, canto direito, espinhos, plataforma de raízes | 7 PNGs |
| Parallax | floresta distante, fungos intermediários, vegetação de primeiro plano | 3 PNGs |
| Ataques e FX | raiz irrompendo, aviso de raiz, impacto de esporo, invocação, poeira de pouso, corte de garras, clarão | 6,4,4,6,4,4,6 |
| Projéteis | esporo verde, esporo violeta | 2 PNGs |
| Sistemas locais | checkpoint orgânico, barreira de raízes da arena, fragmento da Dobra | 3 PNGs |

Total planejado: 64 imagens. Itens de cura, energia, células e tablets reutilizam a identidade existente; não criar moedas ou interfaces novas.

## Continuidade das ações

Lince idle→run→jump/fall, salto duplo em cambalhota, wall encosta patas na borda direita, claw projeta garras para a direita, pogo projeta garras para baixo, flash usa a lanterna âmbar. Dano recua; morte apaga manchas e por último a faixa ciano.

Esporângio tem base enraizada e um único bulbo que se contrai para cuspir. Mariposa tem asas pálidas e abdômen âmbar; não ganha ataque à distância. Rainha usa raizes para o ataque do chão, esporos para chuva e rajada, rugido para invocação e enfurecimento. Não criar um novo golpe que não exista no código. Raízes perigosas e seus avisos são assets separados da chefe, pois surgem na posição do jogador.

## Entrega e revisão

Os prompts finais serão preservados em `PROMPTS.json`; o inventário com dimensões, transparência e SHA-256 em `MANIFESTO.json`. Originais preservados sem recompressão. Não marcar INTEGRADO sem teste no motor. Registrar divergências de dimensão, enquadramento e grade em vez de afirmar conformidade sem medição. Emendas de terreno e continuidade temporal exigem revisão visual; dimensões corretas sozinhas não provam que uma folha está pronta.
