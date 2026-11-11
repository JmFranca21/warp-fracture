# DF69 — animação do Deserto de Ferrugem

Estado: ENTREGUE. Aprovação autorizada pelo responsável nesta conversa: “pode ir fazendo tudo sem parar para pedir minha aprovação, tudo que voce fizer, pode assumir que esteja aprovado (a menos que eu peça o contrario depois)”.

## Arquivos e quadros

- `DF69_drone_dano.png` — 2 quadros: Tranco no drone e faíscas contidas. SHA-256 `f2e9baedd9c40a90ab49dd49083f00addd1886dd2d1b602449d0b7d0883fe199`.
- `DF69b_drone_destruido.png` — 6 quadros: Hélice para, corpo tomba e cai, terminando em sucata. SHA-256 `4c77947c4b732cc7b59b9055333996e364fa07eccd8ecae7f984251e781bc565`.

## Formato e verificação

PNG 1536 × 1024, grade invisível de 4 × 2 células de 384 × 512, ordem de leitura. Células excedentes transparentes. Desenho criado por geração de imagem, com recorte, limpeza de alfa residual e normalização técnica por ImageMagick. PNGs são derivados técnicos dos originais gerados. Arquivos `_metadados.json` registram contagem, limites e escalas efetivas de cada quadro.

Robô com linha de apoio local em y=472 (40 pixels inferiores livres); silhueta centralizada em x=192. Drone normalizado pelo centro da carcaça em (192,256), com oscilação na animação de voo; queda é exceção intencional ao apoio/centro. Projéteis centrados na célula. Robô, drone e projéteis sem chão ou sombra projetada. Avisos e efeitos luminosos contidos no quadro. O olho do Robô é âmbar; o do Drone é vermelho; o cano do Robô aponta à direita, e o emissor do Drone aponta para baixo. Apoio do Robô: pés; Drone: sustentação pela hélice; projéteis/queda: suspensão intencional.

## Referências e limites

DA-01, DF01 aprovada, pedido DF. Ferrugem #6B3A22 / #8A4B2C / #A8552E, metal #7C7F86, sombra #3A2116, âmbar #F2B24C e vermelho #C8402F, com tons auxiliares. Animações desenhadas, não rig vetorial: a normalização registra as variações e eventuais ajustes de envelope acima. Dimensões, vazio das células e limites foram conferidos; aparência e continuidade foram inspecionadas. Ainda dependem da revisão de integração e teste em Godot pelo desenvolvedor; esta entrega não altera código nem declara testes de gameplay.

## Conferência para publicação — 10/11/2026

Dimensões 1536 × 1024, grade 4 × 2, contagem de quadros, células excedentes totalmente transparentes e SHA-256 conferidos sobre os PNGs desta entrega. Inspeção conjunta dos quadros em fundo escuro e das prévias de correção em fundo claro/escuro. Publicação autorizada pelo responsável: “commite tudo”. A integração e a revisão no Godot continuam pendentes.
