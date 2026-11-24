"""Gera colaboracao/pedidos/DF_refacao_cena.md: a refação do Deserto de Ferrugem pela DA-03.

uso: python tools/gen_pedidos_deserto_refacao.py

Primeiro o cenário (o que mais separa o Deserto do Laboratório e de Verdâmia), na ordem: DF00 v2
(prancha com a estrutura de valores da DA-03) e as peças DF200–DF210. O Autômato e os inimigos
dependem das fichas DF02 v2 e DF01 v2 (pedido DA02_regua_e_fichas_v2.md); o retoque da Forja-Mãe
vem por último. Mesmo formato de troca com o ChatGPT dos outros pedidos (bloco ````markdown).
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "colaboracao/pedidos/DF_refacao_cena.md"

INTRO = ("Você é o diretor de arte do Warp Fracture. Siga a DA-01 (`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`), "
         "a DA-02 (`DA-02_CONSISTENCIA.md`) e a **receita de cena DA-03** (`DA-03_RECEITA_DE_CENA.md`, aprovada pelo João em 24/11/2026), "
         "as três na mesma pasta, na branch `dev/neve`. O João avaliou que o Deserto de Ferrugem está bem abaixo do Laboratório Hélix e de "
         "Verdâmia. Medido no jogo: a tela chega a 0,57 de luma nas Dunas (as referências ficam entre 0,09 e 0,18), o terço de cima a 0,67 "
         "(limite 0,15) e, nas Dunas, o Daymon fica mais escuro que o fundo; as paredes são painéis chapados de ferrugem e as peças vêm em "
         "escalas que não conversam. A comparação está em `docs/auditoria_cena/comparacao_cenas.png` e a auditoria anterior em "
         "`docs/auditoria_deserto/`. **Não use a DF00 nem os fundos DF10–DF24 como referência de valor ou de composição**; use-os só como "
         "referência de materiais.")
UNIV = ("**Deserto de Ferrugem (Ferrumgrado):** um deserto de sucata onde uma fábrica autônoma nunca parou de trabalhar. Zonas: "
        "**Dunas de sucata** (exterior, x 0–1.700), **Fábrica autônoma** (interior, 1.700–3.580), **Salão do Núcleo** (galeria alta, "
        "3.580–6.990), **Câmara da Forja** (arena do chefe, 1.440 × 620 px) e a **Saída**. Nova direção de luz pela DA-03: o exterior passa "
        "a um **crepúsculo de tempestade de ferrugem** (céu ferrugem escuro, sol baixo velado pela poeira); o interior é escuro, iluminado "
        "pelas lâmpadas âmbar, pelo brilho das fornalhas e pelas faíscas. Família escura dominante: **ferrugem escura**; acento do universo: "
        "**âmbar**; sombras profundas no azul-marinho comum do jogo.")
REGUA = ("Receita DA-03 (resumo): cinco funções em cada zona (fundo distante, fundo intermediário, estrutura de fundo, plano do jogo, "
         "primeiro plano escuro) mais luzes e partículas; luma da tela 0,08–0,18, terço de cima ≤ 0,15, o personagem mais claro que o entorno "
         "e separado do fundo em pelo menos 2/3 da borda, nenhuma mancha clara grande competindo com ele; estrutura que organiza o espaço "
         "(algo desce do alto ou uma massa dá a moldura); decoração em três escalas (pequena 0,15–0,5 D, média 1–2 D, grande 3–6 D; "
         "D = altura do Daymon, ~91 px no jogo); terreno com linha de apoio legível, borda variada e subsolo distinto; plataformas suspensas "
         "mostram o que as segura; 1–3 focos de luz por tela. Contornos e tons pela DA-02 (contorno escuro só nas cores frias, nunca preto "
         "nem marrom-preto).")
DF00V2 = ("A **DF00 v2** (aprovada pelo João em 24/11/2026; `colaboracao/entregas/DF00/` na `main`: `DF00_prancha_deserto_v2.png`, "
          "`DF00_v2_cena.png` e `ENTREGA_v2.md`) é a referência de valores, materiais e paleta desta peça.")
CONFIRA_CENA = ("monte `{id}_cena.png`: um painel de 1.280 × 720 por cena, com a peça nova numa tela do Deserto (Daymon/Autômato a ~91 px) "
                "ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`), na mesma escala visual, "
                "sem esticar; a tela fica escura como as referências, o personagem é o mais claro e nada flutua sem mostrar o que segura;")


DF205_EXTRA = """**Onde o terreno entra no jogo** (`scripts/desert.gd`; coordenadas do mundo; a colisão é sempre retangular e não muda):

- **Dunas:** chão de areia em x −120–780 e 1180–1700, com o topo em y 700 e 360 px de altura. Entre eles, o fosso das Dunas (dano em y 850).
- **Fábrica:** a esteira DF26 cobre o chão de 1700 a 2780 (topo em y 700, faixa de 60 px; fica). Embaixo dela não há nada desenhado hoje. Em seguida há duas plataformas de máquina sobre o fosso longo: x 2870–3015 (topo y 625, 26 px de altura) e x 3100–3340 (topo y 545, 28 px). As máquinas DF53 ficam em cima delas, e hoje nada as segura.
- **Salão do Núcleo:** passarelas suspensas em x 3580–4010 e 4410–4860 (topo em y 415, 40 px); fosso longo de 2780 a 4980 (dano em y 900); chão de chapa em x 4980–5490 e 6030–8900 (topo em y 770, 320 px), com um fosso entre eles (dano em y 900).
- **Câmara da Forja e Saída:** paredes de 60 px em x 6990 e 8490 (do alto até y 580, onde ficam as portas DF38 de 60 × 190 px); teto da Câmara com a face de baixo em y 150 (x 7050–8490); teto da Saída em y 400 (x 8550–8900); parede final em x 8900.
- **Rampas:** não existem; todos os apoios são horizontais.

O arquivo `docs/auditoria_cena/DF205_gabarito_colisoes.png` desenha tudo isso em 1:1, numa grade de 64 px, com sete recortes nas emendas. Ciano é a linha de apoio, vermelho é o fosso, âmbar são as peças que ficam e branco é o Autômato.

**As 22 peças** (PNG RGBA; arquivo em 2×, jogo em 1×; y é medido a partir do alto do arquivo):

| # | Arquivo | Uso no jogo | Arquivo (px) | No jogo (px) | Repete | Linha de referência |
|---|---|---|---|---|---|---|
| 1 | `areia_chao.png` | faixa do topo das Dunas | 1.024 × 320 | 512 × 160 | horizontal | apoio em y 50; acima dele, só relevo esparso (pontas de sucata, torrões) de até 24 px e em no máximo 1/3 da largura |
| 2 | `areia_subsolo.png` | corpo das Dunas, até 360 px abaixo do apoio | 1.024 × 1.024 | 512 × 512 | horizontal e vertical | — |
| 3 | `areia_borda.png` | lateral exposta da areia (bordas do fosso em x 780 e 1180) | 144 × 1.024 | 72 × 512 | vertical | face da colisão em x 6; desenhe o lado esquerdo (o jogo espelha para o direito), sem luz direcional forte |
| 4–5 | `areia_canto_esquerdo.png`, `areia_canto_direito.png` | quina de cima das bordas do fosso | 180 × 260 | 90 × 130 | — | quina marcada; apoio na mesma altura da peça 1 |
| 6 | `chapa_chao.png` | piso do Salão, da Câmara e da Saída | 1.024 × 192 | 512 × 96 | horizontal | apoio em y 16 (topo reto de chapa); uniões a cada 256 px, com rebites só nelas |
| 7 | `estrutura_subsolo.png` | corpo dos pisos de chapa, subsolo da Fábrica sob a esteira e massa das paredes e dos tetos | 1.024 × 1.024 | 512 × 512 | horizontal e vertical | vigas, tubos e vãos escuros, sem painel liso |
| 8 | `chapa_borda.png` | laterais expostas da chapa (fossos em x 4980, 5490 e 6030; paredes em 6990, 8490 e 8900) | 144 × 1.024 | 72 × 512 | vertical | face da colisão em x 6; lado esquerdo, espelhado pelo jogo |
| 9–10 | `chapa_canto_esquerdo.png`, `chapa_canto_direito.png` | quinas de cima dos pisos de chapa | 180 × 260 | 90 × 130 | — | quina marcada; apoio na mesma altura da peça 6 |
| 11 | `transicao_areia_estrutura.png` | emenda vertical das Dunas com a Fábrica, em x 1700, sob a ponta da esteira | 256 × 768 | 128 × 384 | — | eixo central em x 1700 do jogo; topo em y 690 do jogo |
| 12 | `teto_chapa.png` | face de baixo dos tetos (Câmara em y 150; Saída em y 400) | 1.024 × 192 | 512 × 96 | horizontal | colisão em y 160; abaixo dela, só flanges e parafusos de até 24 px |
| 13–14 | `teto_canto_esquerdo.png`, `teto_canto_direito.png` | cantos internos entre teto e parede: (7050, 150), (8490, 150) e (8900, 400) | 192 × 192 | 96 × 96 | — | ponto de encontro marcado |
| 15 | `verga_porta.png` | fim das paredes de 60 px sobre as portas (y 580 em x 6990 e 8490) | 144 × 96 | 72 × 48 | — | borda de baixo em y 96 (= y 580 do jogo); o batente da DF38 encaixa embaixo |
| 16–18 | `passarela_ponta_esquerda.png`, `passarela_meio.png`, `passarela_ponta_direita.png` | passarelas do Salão (colisão de 40 px) e plataformas de máquina (26–28 px) | pontas 96 × 128; meio 256 × 128 | pontas 48 × 64; meio 128 × 64 | o meio, horizontal | apoio em y 8; tabuleiro de 52 px (26 do jogo) e treliça embaixo até o fim da peça. O meio tem 4 painéis de treliça de 64 px (32 do jogo), com a junção dos painéis nas bordas do módulo. A ponta tem, do lado de dentro, uma chapa de junção de 32 px (16 do jogo) que se sobrepõe ao meio |
| 19 | `tirante.png` | barra ou cabo que segura a passarela e sobe até sair da tela | 32 × 256 | 16 × 128 | vertical | eixo no centro |
| 20 | `fixacao.png` | olhal do tirante, no tabuleiro e na viga de cima | 48 × 48 | 24 × 24 | — | furo no centro |
| 21 | `coluna_trelica.png` | sustenta as plataformas de máquina sobre o fosso (de y 651 até abaixo de y 960) | 96 × 512 | 48 × 256 | vertical | eixo no centro |
| 22 | `fosso_fundo.png` | fundo dos fossos com dano (y 850 nas Dunas; y 900 na Fábrica e no Salão) | 1.024 × 192 | 512 × 96 | horizontal | linha de dano em y 32; acima dela, só pontas de sucata de até 32 px |

**Montagem das passarelas e das plataformas de máquina** (é assim que o jogo vai montar): as pontas ficam nas extremidades da colisão, sem escala. O meio se repete sem escala e é recortado por região de textura num número inteiro de painéis de 32 px do jogo. Ele fica centralizado no vão entre as pontas, e a sobra (até 17 px nas quatro larguras) fica sob as chapas de junção das pontas, que são desenhadas por cima. Vãos entre as pontas: 49 px (plataforma de 145), 144 px (240), 334 px (430) e 354 px (450). A linha de apoio, a altura do tabuleiro e as colisões não mudam.

**Valores e cores** (medidos na DF00 v2 aprovada; Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′):

- **Faixa do topo** (os 25 px do jogo logo abaixo do apoio): luma média 0,20–0,25. Na DF00 v2 ficou entre 0,21 e 0,25.
- **Subsolo e bordas:** 0,09–0,13 logo abaixo do topo, escurecendo até ~0,06 perto de 300 px de profundidade, em direção ao azul-marinho `#0F1422`.
- **Fundo do fosso:** ≤ 0,10, com poucos pontos de perigo `#E0303A`.
- **Brilho:** nenhuma área de mais de 8 × 8 px do jogo acima de 0,45 de luma. O Autômato tem média de ~0,36 e deve continuar o mais claro.
- **Estrutura:** nenhum bloco de 40 × 40 px do jogo (80 × 80 do arquivo) sem detalhe.
- **Cores:** areia de ferrugem `#3A2929 / #59403A / #806050`; chapa `#253045 / #493736 / #654947`; viga `#1D2A3C / #3B3237 / #615457`; fornalha e escória `#422D31 / #754035 / #B36341` (só no fosso e no piso da Câmara).
- **Âmbar e ciano:** sem âmbar e sem ciano no terreno; âmbar é energia e luz, ciano é o gancho e o traje."""


DF200_EXTRA = """**Como o céu entra no jogo** (`scripts/desert.gd` e `scripts/verd_bg.gd`; o desenvolvimento ajusta a camada para estas medidas):

- **Parallax 0,06:** atravessando a fase inteira (8.900 px), o céu anda só ~460 px. Ele é quase um pano fixo atrás de tudo.
- **Faixa útil vertical:** linhas 210–1.230 do arquivo. O resto é folga e só continua o céu.
- **Terço de cima da tela:** cai nas linhas 210–550. É o trecho que mais pesa na régua da DA-03.
- **Centro da câmera:** fica entre x 1.070 e 1.490 do arquivo. Nas Dunas a tela mostra de x ~170 a ~2.080; no vão do Salão, de ~450 a ~2.390.
- **Na frente do céu:** o fundo intermediário (DF201: dunas, carcaças e chaminés, parallax 0,20 e 0,38) e o terreno da DF205. A linha do chão fica por volta das linhas 900–1.000 do arquivo, e o céu deve continuar, enevoado, até a borda de baixo.

**Valores** (medidos no céu das Dunas da DF00 v2 aprovada; Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′):

| Faixa do arquivo | Luma média | Na DF00 v2 |
|---|---|---|
| Linhas 210–550 (terço de cima da tela) | ≤ 0,11 | 0,09–0,11 |
| Linhas 550–900 (horizonte e sol velado) | 0,12–0,15 | 0,12–0,14 |
| Linhas 900–1.230 (atrás das dunas) | 0,11–0,14 | — |

- **Sol:** baixo e velado pela poeira, com centro entre x 1.150 e 1.450 e entre as linhas 600 e 800; disco com no máximo 120 px de diâmetro. Nenhuma área acima de 0,25 de luma com mais de 0,5% da imagem; o disco pode chegar a 0,35.
- **Poeira:** faixas de poeira e nuvens de tempestade em 2–3 tons de ferrugem escura, `#3A2929`, `#59403A` e `#493736`. O topo vai para o azul-marinho comum, `#253045` a `#0F1422`.
- **Sem âmbar puro:** nada de âmbar `#EFAA55`, que fica para as luzes e a energia. O brilho do sol é ferrugem clara velada, não um disco branco."""


DF201_EXTRA = """**Como as camadas entram no jogo** (`scripts/desert.gd`; o parallax põe cada camada em câmera × (1 − profundidade); zoom 1,1; o desenvolvimento monta pelas contas abaixo):

| | `DF201_distante.png` | `DF201_proximo.png` |
|---|---|---|
| Parallax | 0,20 | 0,38 |
| Conteúdo | horizonte: dunas distantes, a silhueta do complexo da fábrica e chaminés, em névoa | carcaças (escavadeira, robô gigante tombado, vagões), guindastes, torres de transmissão e dunas próximas |
| Repetição | nenhuma: imagem única, com a coluna 686 do arquivo no x 0 da camada | repete na horizontal sem espelhar (período de 2.560 px); **sem marco único**, porque ele apareceria de novo |
| O que as Dunas mostram | x ~220–1.600 do arquivo | toda a largura |
| O que o vão do Salão mostra | x ~800–2.330 | toda a largura |
| Altura máxima das silhuetas | 1–3 D (91–270 px) acima da base; a fábrica pode chegar a 3 D | 2–3 D (180–270 px) acima da base |
| Nada acima da linha | 190 | 190 |

**Enquadramento vertical** (o mesmo nas duas camadas):

| Câmera | Linha 490 (base) na tela | Faixa do arquivo que aparece |
|---|---|---|
| Dunas, normal | y ≈ 496 de 720 | 39–693 |
| Dunas, câmera no ponto mais baixo (dentro do fosso) | y ≈ 412–452 | até a linha 770 |
| Vão do Salão (câmera alta) | y ≈ 558–613 | até a linha 637 |

O chão das Dunas (DF205) fica em y ≈ 541 da tela, logo abaixo da base: o horizonte das camadas fica por trás do plano do jogo. A parte de cima da tela (até ~y 240) continua sendo só o céu. Telas mais largas que 16:9 mostram até 120 px a mais de cada lado.

**Valores** (Y′ = 0,2126 R′ + 0,7152 G′ + 0,0722 B′; o céu atrás fica entre 0,10 e 0,13 nessa altura):

- **`DF201_distante`:** silhuetas com luma média 0,10–0,13, quase da cor da névoa, com pouco contraste interno (desvio ≤ 0,03). Dois tons, sem contorno escuro (é distante). Abaixo da base, chão de dunas 0,09–0,11.
- **`DF201_proximo`:** silhuetas mais escuras e mais definidas, luma média 0,07–0,11, com recorte nítido. Detalhe interno legível (vãos, vigas, rebites, cabos) para dar estrutura: densidade de bordas da camada sozinha entre 0,05 e 0,10. Luz de borda ferrugem nas arestas viradas para o sol (x ~1.150–1.450 do céu), pequena e com no máximo 0,20 de luma. Abaixo da base, dunas próximas escurecendo até ~0,06 na borda de baixo.
- **Em profundidade:** a camada de trás tem menos contraste e menos saturação que a da frente (DA-03, C2). Nenhuma das duas é mais clara que a faixa do topo do terreno (0,20–0,25), nem que o Autômato (~0,36).
- **Escala (DA-03, C4):** as carcaças e os guindastes são a faixa **grande** (3–6 D) vista à distância. Nada de painel chapado, nem de forma repetida em fila.
- **Cores:** ferrugem escura (`#3A2929`, `#59403A`, `#493736`), viga (`#1D2A3C`, `#3B3237`) e o azul-marinho comum nas sombras (`#253045`, `#0F1422`). No máximo uma lâmpada âmbar pequena em cada 1.280 px da `DF201_proximo`, sem halo grande; o foco principal da tela continua sendo o sol velado."""


def prompt(p: dict) -> str:
    pasta = p["id"].split(" ")[0]                    # "DF00 v2" entrega em DF00/, com sufixo _v2
    nome = p["id"].replace(" ", "_")
    intro = INTRO if p["id"] == "DF00 v2" else INTRO + " " + DF00V2
    if p["id"] not in ("DF00 v2", "DF205"):        # enviados antes da branch do Deserto existir
        intro = intro.replace("na branch `dev/neve`", "na branch `dev/deserto`")
    lines = [
        f"**[{p['id']}] {p['titulo']}**", "", intro, "", UNIV, "", REGUA, "",
        *([p["extra"], ""] if p.get("extra") else []),
        f"- **ID:** {p['id']}",
        f"- **Arquivo(s):** {p['arquivos']}",
        f"- **Finalidade no jogo:** {p['finalidade']}",
        f"- **Referências obrigatórias do repositório:** {p['ref']}",
        f"- **Escala:** {p['escala']}",
        f"- **Orientação:** {p['orientacao']}",
        f"- **Âncora e pivô:** {p['ancora']}",
        f"- **Estados e quadros:** {p['estados']}",
        f"- **Dimensões e grade:** {p['grade']}",
        f"- **Fundo:** {p.get('fundo', 'transparente (PNG RGBA), sem sombra projetada e sem texto.')}",
        f"- **Antes de apresentar, confira:** {p.get('confira', CONFIRA_CENA.format(id=nome)).rstrip(';')}" + ("" if p.get('confira', CONFIRA_CENA).rstrip(';').endswith('.') else "."),
        (f"- **Entrega:** Apresente ao João Marcelo (peças + `{nome}_cena.png`) e **só suba depois da aprovação explícita dele**. "
         f"Coloque os PNGs em `colaboracao/entregas/{pasta}/` com um `ENTREGA{'_v2' if ' v2' in p['id'] else ''}.md` (lista de peças e quadros, âncoras em pixels, "
         f"faixa de escala e função na cena de cada peça pela DA-03, cores por material, confirmação da aprovação, SHA-256 e o que não "
         f"conseguiu cumprir). Atualize a linha {p['id']} do `colaboracao/STATUS.md` para `ENTREGUE` e faça o commit `[arte]` na `main`."),
    ]
    head = f"## {p['id']}: {p['titulo']}\n\n" + (f"> {p['nota']}\n\n" if p.get("nota") else "")
    return head + "````markdown\n" + "\n".join(lines) + "\n````\n"


PECAS = [
    dict(id="DF00 v2", titulo="Prancha de referência do Deserto com a estrutura de valores da DA-03",
         nota="Primeiro pedido: as outras peças usam a paleta e as faixas aprovadas nesta prancha.",
         arquivos="`DF00_prancha_deserto_v2.png` e `DF00_v2_cena.png`",
         finalidade="redefine a paleta e os valores do Deserto. A DF00 v1 pôs o exterior claro e quente e a parede de fábrica como painel chapado; daí vieram os problemas medidos no jogo.",
         ref="`colaboracao/entregas/GL00/GL00_prancha_nivaria.png` (como a prancha de Nivária resolveu valores e faixas de cena), `colaboracao/entregas/DF00/DF00_prancha_deserto.png` (só materiais), `docs/auditoria_cena/comparacao_cenas.png`.",
         escala="amostras de material e de plataforma na escala D = 400 px, com a silhueta do Autômato (ficha DF02 v2, quando aprovada) ou do Daymon.",
         orientacao="cenas vistas de lado, como o jogo.",
         ancora="topo das plataformas de amostra alinhado com os pés da silhueta.",
         estados="(1) quatro faixas de cena (~700 × 160 px): Dunas no crepúsculo de tempestade, Fábrica, Salão do Núcleo e Câmara da Forja, cada uma com as cinco funções da DA-03; (2) materiais com 2–3 tons: areia de ferrugem, chapa, viga, cobre, vidro de lâmpada, fornalha; (3) cores de função: âmbar (energia do universo e lâmpadas), vermelho (perigo), ciano (gancho e Traje Âncora), azul-marinho comum (sombras); (4) uma faixa **em cinza** das quatro cenas para provar os valores.",
         grade="PNG de 1.536 × 1.024 px, prancha com texto permitido.",
         fundo="azul-marinho escuro chapado nas áreas de amostra.",
         confira="cada faixa com luma média ≤ 0,18 e terço de cima ≤ 0,15; a silhueta do personagem se lê em todas; o âmbar só nas luzes e detalhes; nada de painel liso enorme;"),
    dict(id="DF200", titulo="Fundo distante: céu do crepúsculo de tempestade",
         extra=DF200_EXTRA,
         arquivos="`DF200_ceu.png` e `DF200_cena.png`",
         finalidade="camada mais distante do exterior (parallax 0,06), no lugar de DF10. Aparece nas Dunas (x 0–1.700) e no vão aberto do Salão sobre o fosso longo (x 3.580–4.980); no resto da fase as paredes cobrem.",
         ref="DF00 v2 (o céu das Dunas na faixa e na montagem de 1.280 × 720 é a referência de valor); DF205 aprovada (`colaboracao/entregas/DF205/DF205_cena.png`, o terreno que fica na frente); `assets/verdamia/fundo/bg_distante.png` (acabamento de um fundo distante aprovado).",
         escala="o jogo mostra a imagem a 0,645 (1 px do arquivo = 0,645 px do mundo, ~0,71 px de tela). Na tela cabem ~1.800 × 1.015 px do arquivo de uma vez (70% da largura e da altura).",
         orientacao="paisagem lateral.",
         ancora="sem repetição nem espelhamento: o jogo usa a imagem inteira, centralizada no percurso da câmera.",
         estados="1 imagem: só céu e poeira (sem chão, sem dunas, sem construções: isso vem na DF201, na frente).",
         grade="2.560 × 1.440 px.",
         fundo="opaco.",
         confira=("(1) os valores da tabela acima, medidos em Y′ sRGB na faixa útil; "
                  "(2) monte `DF200_cena.png`: dois painéis de 1.280 × 720 (centro da câmera em x 1.120 e em x 1.420 do arquivo, linhas 210–1.230 reduzidas a 0,71), com o terreno da DF205 e o Autômato ou o Daymon a ~91 px na frente, ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`) na mesma escala visual, sem esticar; o personagem é o mais claro da tela e o sol não compete com ele.")),
    dict(id="DF201", titulo="Fundo intermediário: dunas, carcaças e chaminés",
         extra=DF201_EXTRA,
         arquivos="`DF201_distante.png` (parallax 0,20), `DF201_proximo.png` (parallax 0,38) e `DF201_cena.png`",
         finalidade="as duas camadas entre o céu (DF200) e o terreno (DF205), no lugar de DF11 e DF12, nas Dunas e no vão aberto do Salão. Dão estrutura à paisagem: hoje, sem as camadas antigas, as Dunas medem 0,025 de densidade de bordas e 0,74 de área lisa (limites 0,04 e 0,60).",
         ref="DF200 (o céu, prévia aprovada para teste em 24/11/2026; `docs/auditoria_cena/DF200_ceu_no_jogo.jpg`, coluna do meio: o lugar exato destas camadas); DF00 v2 (escarpas, guindastes e torres das Dunas na montagem de 1.280 × 720); DF205 (o terreno na frente); `assets/verdamia/fundo/bg_intermediario.png` (acabamento de uma camada intermediária aprovada).",
         escala="1 px do arquivo = 1 px do mundo (~1,1 px de tela, como o intermediário de Verdâmia). D = 91 px.",
         orientacao="paisagem lateral.",
         ancora="linha de base (onde as silhuetas encontram o chão delas) na linha 490 do arquivo, nas duas camadas.",
         estados="1 imagem por camada.",
         grade="2.560 × 840 px cada.",
         fundo="PNG RGBA: transparente acima das silhuetas (alpha 0, borda suavizada de 1–2 px); opaco e contínuo da linha 490 até a borda de baixo.",
         confira=("(1) os valores e as medidas acima, em Y′ sRGB; (2) a `DF201_proximo.png` repete sem emenda (as colunas 0 e 2.559 continuam uma na outra, sem coluna desbotada); "
                  "(3) monte `DF201_cena.png`: três painéis de 1.280 × 720 com DF200 + DF201 + DF205 e o Autômato ou o Daymon a ~91 px, nas três câmeras da tabela de enquadramento, montados com as contas acima, ao lado das capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`) na mesma escala visual, sem esticar; "
                  "(4) nas Dunas, sem primeiro plano, a tela inteira fica com luma 0,08–0,18, terço de cima ≤ 0,15, densidade de bordas ≥ 0,04 e área lisa ≤ 0,60, pelas regras da DA-03.")),
    dict(id="DF202", titulo="Fundos internos: Fábrica e Salão do Núcleo",
         arquivos="`DF202_fabrica.png` e `DF202_salao.png`",
         finalidade="substituem os painéis chapados DF22–DF24: paredes de fundo com **estrutura** (vigas, pilares, tubulações, janelas altas com luz âmbar, engrenagens grandes **escuras** atrás, passarelas ao longe). Fábrica: x 1.700–3.580, cerca de 1.000 px de altura; Salão do Núcleo: galeria alta, x 3.580–6.990, com pontes e correntes ao fundo.",
         ref="DF00 v2; as paredes do Laboratório (colunas, janelas e painéis escuros) como referência de função: estrutura escura e quieta que dá ritmo sem competir.",
         escala="pilares e vigas de 3–6 D; janelas de 1–2 D; entregue a 2× da escala do jogo.",
         orientacao="lateral.", ancora="repetíveis na horizontal; o chão no pé da imagem.",
         estados="1 imagem por ambiente, com variação a cada ~1.000 px de jogo (duas variantes de módulo em cada imagem). Luzes âmbar pontuais, nunca grandes áreas claras.",
         grade="2.048 × 2.048 px cada (2×).", fundo="opaco."),
    dict(id="DF203", titulo="Fundo da Câmara da Forja",
         arquivos="`DF203_camara.png`",
         finalidade="o salão do chefe (1.440 × 620 px de jogo, x 7.050–8.490, teto em y 150 e chão em y 770): fornalha ao fundo, trilho dos braços no teto, tubulações, mais escuro que a Forja-Mãe para ela se destacar.",
         ref="DF00 v2, `colaboracao/entregas/DF03/` (a Forja) e `docs/auditoria_deserto/5_chefes.png`.",
         escala="na escala do jogo, entregue a 2× (2.880 × 1.240 px).", orientacao="lateral, chão no pé da imagem.",
         ancora="as portas da esquerda e da direita nas bordas (60 × 190 px de jogo cada).",
         estados="1 imagem; o brilho da fornalha contido, sem tirar o destaque da lente e do núcleo da Forja.",
         grade="2.880 × 1.240 px.", fundo="opaco."),
    dict(id="DF204", titulo="Estrutura de fundo (peças grandes)",
         arquivos="`DF204_estrutura.png` (folha de peças)",
         finalidade="camada 3 da DA-03 no plano do jogo: guindastes, chaminés, tanques, carcaças de máquinas gigantes, colunas de aço e esqueletos de galpão, atrás do jogador.",
         ref="DF00 v2; `assets/verdamia/objetos/cogumelo_gigante.png` e `arco_templo.png` (função de peça grande de fundo aprovada).",
         escala="faixa grande da DA-03: 3–6 D de altura. Peças da mesma família na mesma escala.",
         orientacao="lateral.", ancora="base no chão de cada peça.",
         estados="10 peças: 2 guindastes, 2 chaminés, tanque, carcaça de escavadeira, carcaça de robô gigante tombado, coluna de aço com vigas, esqueleto de galpão, engrenagem gigante enterrada. Mais escuras que o plano do jogo.",
         grade="células de 1.024 × 1.536 px, 5 colunas."),
    dict(id="DF205", titulo="Terreno completo do Deserto",
         nota="Segundo pedido. O formato é o do terreno de Verdâmia, que o jogo já monta por código; o gabarito de colisões mostra onde cada peça encosta.",
         extra=DF205_EXTRA,
         arquivos="22 PNGs separados, com os nomes da tabela acima, mais `DF205_encaixes.png` e `DF205_cena.png`.",
         finalidade="substitui DF20 (areia), DF21 (fundo do fosso) e DF25 (chapa), e cobre o que hoje é retângulo de cor chapada (corpo dos pisos, paredes e teto da Câmara) ou vazio (o subsolo da Fábrica, sob a esteira). A esteira DF26, as máquinas DF53, a coluna do elevador DF27, o trilho DF55b e as portas DF38 ficam.",
         ref="DF00 v2 (as amostras Areia de ferrugem, Aço suspenso e Piso de fornalha e as quatro montagens); `assets/verdamia/terreno/` (o conjunto de terreno aprovado que serve de modelo de formato: `chao_musgo.png`, `subsolo.png`, `parede_borda.png`, `canto_esquerdo.png`, `canto_direito.png`, `plataforma_raizes.png`); o gabarito `docs/auditoria_cena/DF205_gabarito_colisoes.png` (na `dev/neve`).",
         escala="tudo em 2× do jogo (1 px do jogo = 2 px do arquivo). O Autômato tem ~91 px de altura no jogo e caixa de colisão de 30 × 62 px; a faixa visível do topo do chão fica entre 18 e 30 px do jogo.",
         orientacao="lateral, como o jogo.",
         ancora="as linhas de apoio e de colisão ficam nas alturas da tabela, iguais em todas as peças do mesmo material, para que chão, borda e canto se encontrem sem degrau. Marque a quina dos cantos e diga a posição dela em pixels do arquivo no `ENTREGA.md`.",
         estados="1 quadro por peça; nenhuma animação.",
         grade="as dimensões da tabela, exatas; tamanhos pares.",
         confira=("(1) monte `DF205_encaixes.png`: os sete recortes do gabarito remontados com as peças em 2×, com a linha de colisão ciano de 1 px por cima: o apoio de cada peça cai sobre a linha (±1 px do jogo); as faces laterais batem com as bordas da colisão (±2 px); o tabuleiro das passarelas cobre a colisão e a treliça fica só embaixo; as quatro larguras (145, 240, 430 e 450 px) montadas como o jogo vai montar, e a junção do meio com cada ponta sem treliça cortada visível; os tirantes saem do quadro pelo alto e as colunas descem até o fosso; "
                  "(2) as peças repetíveis, lado a lado e deslocadas de 1/3, sem costura visível na escala do jogo, e as pontas e cantos encaixam no chão sem degrau; "
                  "(3) monte `DF205_cena.png`: um painel de 1.280 × 720 por cena (Dunas, Fábrica, Salão e Câmara), com o terreno novo sobre as montagens da DF00 v2, o Autômato ou o Daymon a ~91 px e as capturas do Laboratório e de Verdâmia (`docs/auditoria_cena/comparacao_cenas.png`) na mesma escala visual, sem esticar; "
                  "(4) os valores e as cores acima, medidos em Y′ sRGB.")),
    dict(id="DF206", titulo="Decoração média e pequena",
         arquivos="`DF206_media.png` e `DF206_pequena.png`",
         finalidade="as faixas média e pequena da DA-03, que o Deserto nunca teve: ferramentas, tambores, caixas, carrinhos, painéis de controle, parafusos, porcas, cabos soltos, lâmpadas de chão, placas de aviso (só onde há perigo de verdade).",
         ref="DF00 v2; `assets/laboratorio/` (barril, caixa, cabos, alerta) e `assets/verdamia/objetos/` como referência de acabamento e densidade.",
         escala="médias 1–2 D; pequenas 0,15–0,5 D.", orientacao="lateral.", ancora="base no chão de cada peça.",
         estados="médias (10) e pequenas (14), sem listras de aviso decorativas.",
         grade="médias em células de 512 × 512 px, 5 colunas; pequenas em 256 × 256 px, 7 colunas."),
    dict(id="DF207", titulo="Moldura: o que desce do alto",
         arquivos="`DF207_moldura.png`",
         finalidade="DA-03, C3: correntes, ganchos de guindaste, cabos, mangueiras e lâmpadas penduradas descendo do teto (interior) e das gruas (exterior).",
         ref="DF00 v2; os cabos do Laboratório e `assets/verdamia/objetos/raiz_pendurada.png` (função).",
         escala="1–3 D de comprimento.", orientacao="penduradas, de frente.", ancora="ponto de fixação no topo da célula.",
         estados="8 peças.", grade="células de 512 × 768 px, 4 colunas."),
    dict(id="DF208", titulo="Primeiro plano",
         arquivos="`DF208_primeiro_plano.png` e `DF208_primeiro_plano_interior.png`",
         finalidade="camada 5 da DA-03, que o Deserto nunca teve: silhuetas de sucata, areia e engrenagens na borda de baixo da tela, quase pretas.",
         ref="`assets/verdamia/fundo/fg_vegetacao.png` (altura, densidade e escurecimento).",
         escala="até 1/5 da altura da tela no jogo.", orientacao="lateral.", ancora="base reta; repetível na horizontal.",
         estados="exterior e interior.", grade="2.048 × 512 px cada.", fundo="transparente acima da silhueta."),
    dict(id="DF209", titulo="Efeitos de ambiente",
         arquivos="`DF209_poeira.png`, `DF209_faiscas.png`, `DF209_vapor.png`, `DF209_brilho_lampada.png`",
         finalidade="DA-03, C6: poeira de ferrugem (partícula) no exterior, faíscas e vapor no interior e o brilho âmbar das lâmpadas no entorno.",
         ref="DF00 v2 e os efeitos de Verdâmia em `assets/verdamia/efeitos/`.",
         escala="poeira e faíscas de 4–14 px no jogo; vapor com ~1–2 D; brilho em gradiente radial.",
         orientacao="lateral.", ancora="centro da célula.",
         estados="poeira 4 grãos · faíscas 6 quadros · vapor 8 quadros (loop) · brilho 1.",
         grade="células de 256 × 256 px, uma folha por efeito."),
    dict(id="DF210", titulo="Objetos do universo: placa, estação, célula, núcleo e registro",
         arquivos="`DF210_objetos.png`",
         finalidade="hoje o Deserto usa a placa holográfica, a estação de recarga e o kit/célula do Laboratório. Pedido da auditoria: versões próprias de Ferrumgrado, mantendo a forma que o jogador já conhece (como a GL04 fez em Nivária).",
         ref="`colaboracao/entregas/GL04/GL04_prancha_objetos_v2.png` (como Nivária resolveu célula, núcleo e registro), `assets/laboratorio/celula_suporte.png` e DF00 v2.",
         escala="estação 0,9–1,2 D; placa 0,6 D; célula 0,25 D; núcleo e registro 0,35 D.",
         orientacao="lateral.", ancora="base no chão (estação e placa); centro (coletáveis).",
         estados="estação apagada e ativa (luz âmbar), placa, célula (6 quadros de brilho), núcleo (6), registro (4).",
         grade="células de 512 × 512 px, 4 colunas."),
    dict(id="DF03 v2", titulo="Retoque da Forja-Mãe (DF03 e folhas DF100–DF108)",
         nota="Último do lote: depende da DF203 (o fundo da Câmara) para conferir o contraste.",
         arquivos="`DF03_ficha_forja_v2.png` e as folhas DF100–DF108 com sufixo `_v2`, mesma grade e mesmas âncoras",
         finalidade="a auditoria pediu retoque, não redesenho: contorno escuro em no máximo metade da borda e só nas cores frias (hoje é fechado e preto-marrom, #2c1c1b), menos chanfros, aros e rebites repetidos (DA-02, R9 e R10), listras de aviso só onde há perigo (as dos ombros saem), e o corpo mais escuro que a lente e o núcleo.",
         ref="`colaboracao/entregas/DF03/` e `DF100`–`DF108` (v1), `colaboracao/entregas/GL03/GL03_ficha_guardiao_v2.png` (o chefe de Nivária aprovado: acabamento e leitura), `docs/auditoria_deserto/5_chefes.png`.",
         escala="a mesma das folhas v1 (o jogo monta as peças pelas âncoras atuais; nada muda de lugar).",
         orientacao="a mesma das folhas v1.", ancora="as âncoras das folhas v1, sem mudança.",
         estados="os mesmos quadros das folhas v1.", grade="a mesma das folhas v1.",
         confira="sobreponha cada folha v2 à v1: âncoras e silhueta no mesmo lugar; monte a Forja inteira sobre a DF203 com o Autômato a ~91 px;"),
]


def main() -> None:
    head = """# Pedido DF (refação): cena do Deserto de Ferrugem pela DA-03

**Refação do Deserto.** O João avaliou (24/11/2026) que o Deserto está bem abaixo do Laboratório e de Verdâmia; a [DA-03](../entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md) foi aprovada no mesmo dia, e a ordem aprovada é: receita, Nivária, depois o Deserto.
**Estado:** ABERTO. Comece pela **DF00 v2**; as outras peças usam a paleta e as faixas aprovadas nela.
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 24/11/2026
**Diretrizes obrigatórias:** DA-01, DA-02 e DA-03.

**O que muda e o que fica:**
- **Cenário (este pedido):** refeito pela DA-03. Ordem: **DF00 v2 → DF205 → DF200 → DF201 → DF202 → DF204 → DF206 → DF207 → DF208 → DF203 → DF209 → DF210**, e por último o retoque da Forja (**DF03 v2**).
- **Autômato e inimigos:** dependem das fichas **DF02 v2** e **DF01 v2** ([pedido](DA02_regua_e_fichas_v2.md)); as folhas de animação (no lugar de DF60–DF71 e DF90–DF97) serão pedidas depois das fichas aprovadas, com as medidas delas.
- **Máquinas e perigos atuais** (prensas, serra, esteira, válvulas, carrinhos, portas, DF50–DF57): ficam, com ajuste de escala e valor na integração; se destoarem do cenário novo, entram num lote seguinte.

Cada bloco é um prompt completo. Copie **um por vez** e mande o seguinte só depois de aprovar o anterior.

| ID | Peça | Substitui no jogo |
|---|---|---|
"""
    subs = {"DF00 v2": "DF00 (paleta e valores)", "DF200": "DF10", "DF201": "DF11 e DF12", "DF202": "DF22, DF23 e DF24 (painéis chapados)",
            "DF203": "DF24 na Câmara", "DF204": "nada (falta estrutura de fundo)", "DF205": "DF20, DF21, DF25 e os retângulos chapados",
            "DF206": "nada (falta decoração)", "DF207": "nada (falta moldura)", "DF208": "nada (falta primeiro plano)",
            "DF209": "DF86 (poeira) e brilhos por código", "DF210": "placa, estação e célula do Laboratório", "DF03 v2": "DF03 e DF100–DF108 v1"}
    for p in PECAS:
        head += f"| {p['id']} | {p['titulo']} | {subs[p['id']]} |\n"
    head += "\n---\n\n"
    OUT.write_text(head + "\n---\n\n".join(prompt(p) for p in PECAS), encoding="utf-8")
    print(OUT, len(PECAS), "pedidos")


if __name__ == "__main__":
    main()
