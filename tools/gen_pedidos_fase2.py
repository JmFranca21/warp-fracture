"""Gera os pedidos de arte da Fase 2 (lotes 1 a 3) em colaboracao/pedidos/.
Cada prompt é autossuficiente: pode ser copiado sozinho para o ChatGPT."""
import os, sys
ROOT = sys.argv[1]

DA01 = ("Você é o diretor de arte do Warp Fracture. Siga a diretriz DA-01 "
        "(`colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md`): arte 2D cartunizada, simplificada e "
        "minimalista, com contornos limpos, sombreamento econômico de aspecto cel, poucos tons por superfície e silhueta "
        "legível na escala do jogo. Os efeitos devem ser contidos. Nada de pixel art, realismo ou pintura conceitual. "
        "A peça precisa parecer desenhada pelo mesmo artista das referências oficiais do projeto.")
REF_D = "`arte_original/00_Referencias_oficiais/Ficha de Personagem Daymon Sagan.png` (escala e traço de personagem)"
REF_LAB = "`arte_original/00_Referencias_oficiais/Prancha de Elementos do Laboratório Hélix.png` (traço de objetos e máquinas)"
REF_INIM = "`arte_original/00_Referencias_oficiais/Folha de Inimigos do Laboratório Hélix.png` (traço de robôs)"
REF_DF00 = "`colaboracao/entregas/DF00/DF00_prancha_deserto.png` (paleta e materiais do Deserto)"
REF_DF01 = "`colaboracao/entregas/DF01/DF01_ficha_inimigos_deserto.png` (Robô e Drone do Deserto, escala D = 400 px)"
REF_DF50 = "`colaboracao/entregas/DF50/DF50_previa_montagem.png` (prensa: faixas de perigo e montagem em peças)"
REF_DF57 = "`colaboracao/entregas/DF57/DF57_ponto_gancho.png` (argola com anel ciano)"
REF_DF38 = "`colaboracao/entregas/DF38/DF38_porta_saida_fechada.png` (porta do Salão)"
REF_DF24 = "`colaboracao/entregas/DF24/DF24_parede_salao_nucleo.png` (parede do Salão do Núcleo)"
REF_FRAG = "`colaboracao/entregas/VD_verdamia/VD_fragmento.png` (fragmento da Máquina de Dobra)"
REF_DF02 = "`colaboracao/entregas/DF02/DF02_ficha_automato.png` (ficha do Autômato, depois de aprovada)"
REF_DF03 = "`colaboracao/entregas/DF03/DF03_ficha_forja_mae.png` (ficha da Forja-Mãe, depois de aprovada)"
REF_PT00 = "`colaboracao/entregas/PT00/PT00_ficha_portais.png` (ficha dos portais, depois de aprovada)"
REF_LINCE = "`colaboracao/entregas/VD_verdamia/D0_lince.png` (forma de Verdâmia; o Autômato precisa ser diferente dela)"

PAL_AUT = ("cobre e bronze gastos #B8743A, #8A4B2C, sombra #4A2A1C; chapa clara #C9C2B4; cinza metálico #7C7F86; "
           "traje azul-marinho #1B2340 (o mesmo do Traje Âncora); faixa e marca **ciano #2EC7E6**; vidro do visor #9FE3F0 "
           "com olhos escuros #1A1E2B. **Não use âmbar nem vermelho no rosto**: essas cores são dos inimigos")
PAL_FM = ("ferro escuro #3A2116 e #5A3A2A; ferrugem #A8552E e #8A4B2C; cinza metálico #7C7F86; perigo vermelho #C8402F; "
          "lente âmbar #F2B24C (repouso) e vermelha #C8402F (feixe); fornalha #E8963A e #F7E3BE; "
          "fragmento ciano-menta #8FF0E8 com lascas roxas #8E6AD8 (como o VD_fragmento); âncoras ciano #2EC7E6")
PAL_PT = ("metal do Hélix: azul-marinho #141B26 e #1E2A3A, aço #3A4A5E e #5B6B80, detalhes claros #E8F4FF; "
          "energia ciano #2EC7E6 e roxo #7A5CFF; destinos: ciano #2EC7E6 (Hélix), verde-lima #A6E05A (Verdâmia), "
          "âmbar #F2B24C (Deserto)")
PAL_MEMB = ("tons claros e neutros, para o jogo tingir: branco #F4FAFF, azul muito claro #BFE8F5 e lavanda clara #D9CCFF. "
            "Nada saturado")

GRID = ("PNG de **1536 × 1024 px**, grade **invisível** de 4 colunas × 2 linhas (células de 384 × 512 px), quadros em ordem "
        "de leitura (da esquerda para a direita, de cima para baixo). Células que sobrarem ficam **totalmente vazias**")
FUNDO = ("**transparente** (RGBA), sem névoa nem sujeira de alfa em volta. Se não for possível, verde chapado #00FF00 "
         "uniforme, e avise no ENTREGA.md")
SHEET_RULES = ("Mesma escala em todos os quadros. Nenhum quadro encosta na borda da célula nem invade a vizinha (margem mínima "
               "de 12 px). Sem texto, grade, chão ou sombra projetada")

ENTREGA = ("Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Depois, coloque o PNG em "
           "`colaboracao/entregas/{id}/`, com um `ENTREGA.md` contendo: lista de quadros ou estados, ponto de apoio ou "
           "âncora medidos em pixels, cores usadas, confirmação da aprovação, SHA-256 do PNG e qualquer regra que não "
           "conseguiu cumprir. Mude a linha {id} do `colaboracao/STATUS.md` para `ENTREGUE`. Commit com prefixo `[arte]`.")


def prompt(a):
    L = [f"**[{a['id']}] {a['nome']}**", "", DA01, "",
         f"- **ID:** {a['id']}",
         f"- **Arquivo(s):** {a['arquivo']}",
         f"- **Finalidade no jogo:** {a['finalidade']}",
         "- **Referências obrigatórias do repositório:** " + "; ".join(a["refs"]) + ".",
         f"- **Escala:** {a['escala']}",
         f"- **Orientação:** {a['orientacao']}",
         f"- **Paleta:** {a['paleta']}.",
         f"- **Dimensões e formato:** {a['dim']}.",
         f"- **Fundo:** {a.get('fundo', FUNDO)}.",
         f"- **Âncora e apoio:** {a['ancora']}"]
    if a.get("quadros"):
        L.append("- **Quadros (ordem, ação e loop):**")
        L += [f"  {q}" for q in a["quadros"]]
    if a.get("codigo"):
        L.append(f"- **Quadros e estados que o código usa:** {a['codigo']}")
    if a.get("repeticao"):
        L.append(f"- **Repetição e encaixe:** {a['repeticao']}")
    L.append(f"- **Conteúdo e desenho:** {a['desc']}")
    if a.get("regras"):
        L.append(f"- **Regras técnicas:** {a['regras']}")
    L.append("- **Antes de apresentar, confira:** " + "; ".join(a["verif"]) + ".")
    L.append("- **Entrega:** " + ENTREGA.format(id=a["id"]))
    return "\n".join(L)


A = []
# ============================================================ LOTE 1: fichas
A.append(dict(lote=1, grupo="DF02_ficha_automato", id="DF02", nome="Ficha de personagem: Autômato (forma de Daymon no Deserto)",
    arquivo="`DF02_ficha_automato.png`",
    finalidade="referência oficial da forma de Daymon no Deserto de Ferrugem. Ela define a silhueta, as proporções, as cores e o braço-ímã que todas as animações do Autômato (DF87–DF99) vão seguir. Não entra no jogo",
    refs=[REF_D, REF_DF00, REF_DF01, REF_DF57, REF_LINCE, REF_INIM],
    escala="D = 400 px é a altura de Daymon. O Autômato mede **1,05 D (420 px) de altura e 0,8 D (320 px) de largura**, sem contar o braço",
    orientacao="vista frontal e vista lateral olhando para a **direita**",
    paleta=PAL_AUT,
    dim="PNG de 1536 × 1024 px, ficha com texto permitido (títulos e medidas), no mesmo layout da DF01",
    fundo="azul-marinho escuro chapado, como as outras fichas (DF01, A0)",
    ancora="pés apoiados numa linha de chão comum em todas as vistas. Marque com uma cruz pequena o **ombro do braço-ímã** na vista lateral: o braço gira em torno desse ponto no jogo",
    desc=("Daymon atravessou o portal e o Traje Âncora o revestiu com placas de sucata magnetizadas do deserto. Ele virou uma máquina "
          "**amigável e pesada**, claramente o herói, nunca parecido com os robôs inimigos (que são escuros, quadrados e de olho âmbar). "
          "Monte a ficha com: (1) **vista frontal** e (2) **vista lateral** de corpo inteiro; (3) o **braço-ímã** sozinho, de lado, "
          "apontando para a direita, com o eletroímã em forma de ferradura na ponta e a faixa ciano; (4) um detalhe do **visor**; "
          "(5) uma pose de ação: braço estendido, soltando um feixe ciano curto; (6) **paleta**; (7) faixa de escala, com Daymon "
          "humano em silhueta (400 px) ao lado do Autômato (420 px), como na DF01. "
          "**Corpo:** cúpula de cabeça grande e arredondada, na mesma proporção cabeça/corpo de Daymon. Visor de vidro claro que mostra "
          "**os olhos e a franja de Daymon** em formas simples. Tronco em barril, com placas rebitadas e a **faixa ciano diagonal** do "
          "Traje Âncora atravessando o peito. Pernas curtas e grossas, com pés largos e **duas rodinhas no calcanhar** (usadas no "
          "Arranque). O braço esquerdo, de trás, é curto e simples. O **braço da frente (direito) é o braço-ímã**, separado do corpo "
          "na lateral. "
          "**Leitura:** pesado, lento e confiável. A silhueta precisa ser bem diferente do Lince-Vagalume (D0_lince), que é baixo, "
          "rápido e felino."),
    verif=["vistas lado a lado com a ficha de Daymon: mesma linguagem de cabeça, traço e sombreamento",
           "reduzido a ~90 px de altura, o Autômato ainda se lê como Daymon (faixa ciano e olhos no visor) e se distingue do Robô da DF01",
           "medidas de 420 × 320 px na faixa de escala",
           "nenhum âmbar ou vermelho no rosto"]))

A.append(dict(lote=1, grupo="DF03_ficha_forja_mae", id="DF03", nome="Ficha do chefe: Forja-Mãe (e esquema da Câmara da Forja)",
    arquivo="`DF03_ficha_forja_mae.png`",
    finalidade="referência oficial do chefe do Deserto e da sua arena. Define a silhueta, a escala e as peças separadas (corpo, lente, peito, braços e martelos) que o código anima. As peças finais (DF100–DF112) seguirão esta ficha. Não entra no jogo",
    refs=[REF_DF00, REF_DF01, REF_DF50, REF_DF57, REF_DF24, REF_FRAG, REF_LAB, REF_INIM],
    escala="D = 400 px. Corpo de **3,5 D (1400 px) de altura e 3 D (1200 px) de largura**. Cada braço-guindaste tem cerca de 2 D, do carrinho ao martelo. Cabeça do martelo: **1,4 D (560 px) de largura × 0,6 D (240 px) de altura**",
    orientacao="o corpo é visto **de frente** (está embutido na parede do fundo). Os braços aparecem de frente, pendurados num trilho de teto",
    paleta=PAL_FM,
    dim="PNG de 1536 × 1024 px, ficha com texto permitido (títulos, medidas e setas)",
    fundo="azul-marinho escuro chapado, como as outras fichas",
    ancora="o corpo se apoia no chão (base plana da fornalha) e na parede do fundo (flanges parafusadas nas laterais). Os braços pendem de carrinhos com rodinhas encaixadas num trilho de teto. **Nada flutua**",
    desc=("A Forja-Mãe é a IA da fábrica autônoma. O fragmento da Máquina de Dobra virou o núcleo dela. É uma **fábrica viva, pesada e "
          "paciente**, sem rosto humano. "
          "Monte a ficha com: "
          "(1) **corpo inteiro** de frente: forno de ferro com ombros largos, uma **grade de fornalha** brilhando embaixo, uma **única "
          "lente-olho** grande e redonda no alto, com íris mecânica de lâminas, e, no peito, a **câmara do núcleo** fechada por **três "
          "placas blindadas**, com o fragmento ciano visível pelas frestas; nos ombros, duas **escotilhas** fechadas, de onde saem drones; "
          "(2) **um braço-guindaste** de frente: carrinho no trilho, dois segmentos articulados com pistões, **cabeça de martelo** com "
          "faixas de perigo vermelho e cinza na face de baixo (como a prensa DF50) e, em cima do martelo, uma **placa de âncora ciano** "
          "redonda, no mesmo estilo da argola DF57; mostre também o **núcleo do pistão** laranja na junta de cima do martelo; "
          "(3) **lente em 4 estados**, pequenos: repouso âmbar, aviso âmbar forte, mira vermelha (íris fechada em um ponto) e apagada; "
          "(4) **peito em 2 estados**: fechado, e com as três placas arrancadas, mostrando o fragmento; "
          "(5) **esquema da arena**, pequeno, em vista lateral: sala de 1500 × 760 px no jogo, corpo no centro da parede do fundo, trilho "
          "no teto com os dois braços, faixa de esteira no centro do chão, duas âncoras de teto e duas válvulas nas laterais, porta à "
          "esquerda (entrada) e porta à direita (saída); "
          "(6) faixa de escala com Daymon humano em silhueta (400 px) e o Autômato (420 px) diante do corpo; "
          "(7) paleta. "
          "Ela precisa parecer **feita da mesma fábrica** das prensas, portas e robôs do Deserto (DF00, DF01, DF38, DF50). A ameaça vem "
          "do tamanho, da lente e da grade, e não de detalhe excessivo (DA-01)."),
    verif=["lado a lado com DF00, DF01 e DF50: mesmos materiais, rebites, faixas de perigo e sombreamento",
           "corpo, braço e martelo desenhados como peças separáveis (o código os move separadamente)",
           "a placa de âncora ciano é o elemento mais fácil de achar em cima do martelo",
           "reduzida à escala do jogo (corpo com ~300 px de altura), a lente e as placas do peito continuam legíveis"]))

A.append(dict(lote=1, grupo="PT00_ficha_portais", id="PT00", nome="Ficha dos portais: Arco de Dobra, Fenda e Receptáculo",
    arquivo="`PT00_ficha_portais.png`",
    finalidade="referência oficial da linguagem dos portais em todas as fases: o Arco de Dobra do Laboratório Hélix (hub), a Fenda que se abre nos universos e o Receptáculo da Máquina, onde os fragmentos são instalados. As peças PT10–PT23 seguirão esta ficha. Não entra no jogo",
    refs=[REF_LAB, REF_D, REF_FRAG, REF_DF00, "`colaboracao/decisoes/D05_portais.md` (regras de leitura: cor, glifo e movimento)"],
    escala="D = 400 px. **Arco:** 1,7 D (680 px) de largura × 2,3 D (920 px) de altura, base de 2,0 D (800 px) de largura e **abertura útil de 1,0 D × 1,5 D (400 × 600 px)**. **Fenda:** oval de 1,1 D × 1,6 D. **Receptáculo:** 1,2 D de altura × 1,0 D de largura",
    orientacao="todas as peças **de frente**",
    paleta=PAL_PT,
    dim="PNG de 1536 × 1024 px, ficha com texto permitido",
    fundo="azul-marinho escuro chapado, como as outras fichas",
    ancora="o Arco e o Receptáculo apoiam a base plana no chão. A Fenda nasce de uma rachadura no chão, com lascas de cristal, e nunca flutua solta",
    desc=("O portal é a máquina que Daymon construiu (Arco de Dobra) e o rasgo que um fragmento abre em outro universo (Fenda). Os dois "
          "compartilham a mesma **membrana** interna, clara, translúcida e oval. "
          "Monte a ficha com: "
          "(1) **Arco de Dobra** em 3 estados lado a lado: **bloqueado** (diafragma fechado: 8 lâminas metálicas formam um disco que "
          "tapa a abertura; glifo apagado), **calibrando** (lâminas meio recolhidas, membrana cortada e instável) e **aberto** (lâminas "
          "recolhidas dentro do anel, membrana inteira, partículas sendo puxadas para o centro). O arco tem anel grosso de metal do "
          "Hélix, base larga em degrau, dois pilares na frente e, no topo, um **painel de destino** com três encaixes de glifo; "
          "(2) os **três glifos de destino**, grandes e simples: hexágono com ponto central (Hélix, ciano #2EC7E6), folha-cogumelo "
          "com chapéu sobre um caule (Verdâmia, verde-lima #A6E05A) e engrenagem de seis dentes (Deserto, âmbar #F2B24C); "
          "(3) a **membrana** tingida nas três cores, com setas pequenas indicando o movimento de cada destino: pulsos para dentro "
          "(Hélix), espiral anti-horária (Verdâmia) e ondulação horizontal de calor (Deserto); "
          "(4) a **Fenda** em 3 estados: rachadura dormente (linha fina vertical saindo do chão), abrindo e aberta (oval com bordas "
          "rasgadas e lascas de cristal roxo-ciano, apoiada numa base de chão rachado); "
          "(5) o **Receptáculo da Máquina**: pedestal de laboratório com **quatro soquetes** em losango, um deles com o fragmento "
          "encaixado, e um cabo grosso saindo pela direita (no jogo, o cabo vai até o Arco); "
          "(6) **escala**: Daymon (400 px), o Autômato (420 px) e o Lince ao lado do Arco, mostrando que a abertura útil comporta "
          "os três; "
          "(7) paleta. "
          "Leitura: **fechado = parado; tremendo = instável; partículas para dentro = pode atravessar**."),
    verif=["lado a lado com a Prancha de Elementos do Laboratório: mesmo metal, contorno e luz",
           "os três glifos se distinguem pela forma, mesmo em tons de cinza",
           "a abertura útil de 400 × 600 px comporta Daymon, o Autômato e o Lince",
           "a Fenda tem apoio visível no chão"]))

# ============================================================ LOTE 2a: Autômato
AUT_REFS = [REF_DF02, REF_D, REF_DF00]
AUT_ANC = ("**pés na linha y = 472** (40 px acima da borda de baixo), centro do corpo em **x = 192**, iguais em todos os quadros. "
           "O **braço-ímã não aparece** nestas folhas (é a peça DF97). Marque no ENTREGA.md, em pixels da célula, onde fica o **ombro** "
           "do braço-ímã em cada quadro")
AUT_ESC = "Autômato com **420 px de altura** na pose parada (1,05 D, D = 400 px), igual à ficha DF02 aprovada, em todos os quadros e folhas"


def aut(id_, arq, nome, fin, quadros, desc, extra_verif=None, ancora=AUT_ANC):
    A.append(dict(lote=2, grupo="DF87-DF99_automato", id=id_, nome=nome, arquivo=f"`{arq}`", finalidade=fin,
                  refs=AUT_REFS + ([REF_LINCE] if id_ in ("DF91", "DF92") else []), escala=AUT_ESC,
                  orientacao="olhando para a **direita**", paleta=PAL_AUT, dim=GRID, ancora=ancora,
                  quadros=quadros, desc=desc, regras=SHEET_RULES,
                  verif=["mesma escala e linha dos pés de DF90 (sobreponha os quadros em transparência)",
                         "corpo sem o braço-ímã", "lido como o Autômato da DF02 a ~90 px de altura"] + (extra_verif or [])))


aut("DF90", "DF90_automato_parado.png", "Autômato parado (loop)",
    "pose padrão quando o jogador não se move. O braço-ímã (DF97) é desenhado por cima pelo jogo",
    ["1–6: respiração mecânica. O tronco sobe e desce 4 px, o visor pisca de leve no quadro 4. **Loop**: o quadro 6 volta ao 1 sem salto"],
    "Postura estável, pés afastados, peso no chão. Movimento mínimo e calmo.")
aut("DF91", "DF91_automato_andar.png", "Autômato andando (loop)",
    "andar no chão (272 px/s, mais lento que Daymon humano)",
    ["1–8: ciclo de passos curtos e pesados. Contato do pé da frente nos quadros 1 e 5; o corpo desce 6 px nos contatos. **Loop** de 8 para 1"],
    "Passos curtos, pesados e ritmados, com o tronco quase rígido. Bem diferente da corrida felina do Lince.")
aut("DF92", "DF92_automato_pulo.png", "Autômato pulando (impulso e subida)",
    "início do pulo e subida. O quadro 1 também é usado como agachamento no pouso",
    ["1: agachamento (corpo 30 px mais baixo, pés no chão)", "2: impulso (pernas esticadas, pés deixando o chão)",
     "3: subida (pernas recolhidas)", "4: topo do pulo (pose neutra no ar). **Sem loop**; o jogo segura o quadro 4"],
    "Pulo curto e pesado: o corpo não estica muito. Nos quadros 2 a 4, a âncora (x = 192, y = 472) indica onde os pés estariam se tocassem o chão; o corpo pode subir dentro da célula.")
aut("DF93", "DF93_automato_queda.png", "Autômato caindo",
    "queda depois do topo do pulo",
    ["1: começo da queda (braço livre para cima)", "2: queda (pernas se estendendo para o pouso)",
     "3: queda rápida (pés juntos, pronto para o impacto). **Sem loop**; o jogo escolhe o quadro pela velocidade"],
    "Queda de peso: sensação de bloco caindo, sem planar.")
aut("DF94", "DF94_automato_arranque.png", "Autômato: Arranque (esquiva)",
    "esquiva curta com invulnerabilidade, sobre as rodinhas dos calcanhares",
    ["1: inclina para a frente e as rodinhas descem", "2–3: desliza (corpo baixo e inclinado, faísca pequena nas rodinhas)",
     "4: freia e volta à pose parada. **Sem loop**"],
    "Avanço rápido e baixo, sem sair do chão. As rodinhas dos calcanhares aparecem.")
aut("DF95", "DF95_automato_dano.png", "Autômato levando dano",
    "reação ao dano. O Autômato **não recua**, então o tranco é só visual",
    ["1: tranco (corpo vibra, visor pisca em branco)", "2: volta (2 faíscas pequenas saindo de uma placa). **Sem loop**"],
    "Os pés não saem do lugar.")
aut("DF96", "DF96_automato_derrota.png", "Autômato derrotado",
    "morte do jogador nesta forma, antes de voltar à estação",
    ["1–2: perde força, joelhos dobram", "3–4: cai sentado, o visor apaga", "5–6: tomba de lado, com uma fumacinha. **O quadro 6 fica parado**"],
    "Desliga como uma máquina, sem desmontar e sem violência. No quadro 6 os pés (ou o corpo caído) continuam na linha y = 472.")
A.append(dict(lote=2, grupo="DF87-DF99_automato", id="DF97", nome="Braço-ímã do Autômato (gira para mirar)",
    arquivo="`DF97_automato_braco.png`",
    finalidade="braço separado que o jogo gira em 360° para mirar a Rebitadeira e o Ímã. Encaixa no ombro marcado nas folhas DF90–DF96",
    refs=[REF_DF02, REF_D], escala="na mesma escala da DF02: braço com cerca de **0,55 D (220 px)** do ombro à ponta do ímã",
    orientacao="braço **na horizontal, apontando para a direita**, com o ombro à esquerda",
    paleta=PAL_AUT, dim=GRID,
    ancora="**centro do ombro (pivô) em x = 60, y = 256** em todos os quadros. O braço vai na direção +x",
    quadros=["1: braço em repouso", "2: disparo (recua 10 px para o ombro; o ímã brilha ciano)", "3: volta (recuo de 4 px)",
             "4: feixe magnético ativo (garras da ferradura abertas, brilho ciano mais forte). **Sem loop**"],
    desc="Eletroímã em forma de ferradura na ponta, faixa ciano no antebraço e cotovelo rebitado. É a mesma peça da ficha DF02. A ponta do ímã deve ficar em x ≈ 280; informe a posição exata no ENTREGA.md, porque é de lá que saem o tiro e o feixe.",
    regras=SHEET_RULES, verif=["pivô idêntico nos 4 quadros", "a ponta da ferradura fica bem visível"]))
A.append(dict(lote=2, grupo="DF87-DF99_automato", id="DF87", nome="Rebite (projétil do jogador no Deserto)",
    arquivo="`DF87_rebite.png`", finalidade="projétil da Rebitadeira. O jogo gira o sprite na direção do tiro",
    refs=[REF_DF02, "`colaboracao/entregas/DF70/` (projétil do robô, para **não** ser confundido com ele)"],
    escala="rebite de **0,1 D (40 px)** de comprimento", orientacao="apontando para a **direita**", paleta=PAL_AUT, dim=GRID,
    ancora="centro do rebite no centro da célula (192, 256)",
    quadros=["1–4: rebite metálico girando, com rastro ciano curto atrás. **Loop**"],
    desc="Rebite de metal claro com cabeça arredondada e um contorno de energia ciano. Precisa ser lido como tiro do jogador (ciano) e nunca como o projétil âmbar do robô.",
    regras=SHEET_RULES, verif=["ciano, sem âmbar nem vermelho", "legível a ~10 px no jogo"]))
A.append(dict(lote=2, grupo="DF87-DF99_automato", id="DF88", nome="Clarão de disparo da Rebitadeira",
    arquivo="`DF88_disparo_rebite.png`", finalidade="clarão na ponta do braço-ímã quando o rebite sai",
    refs=[REF_DF02, "`arte_original/USADAS_NO_JOGO.md` (o efeito `arma/disparo` do Daymon humano)"],
    escala="clarão com até **0,3 D (120 px)**", orientacao="saindo para a **direita**", paleta=PAL_AUT, dim=GRID,
    ancora="origem do clarão em **x = 40, y = 256** em todos os quadros (encaixa na ponta do ímã)",
    quadros=["1: estouro ciano", "2: anel se abrindo", "3: se apaga. **Sem loop**"],
    desc="Estouro curto, ciano e branco, com 2 ou 3 lascas metálicas pequenas.", regras=SHEET_RULES,
    verif=["origem fixa nos 3 quadros"]))
A.append(dict(lote=2, grupo="DF87-DF99_automato", id="DF98", nome="Feixe do Ímã de Fase (segmento repetível e ponta)",
    arquivo="`DF98_feixe_ima.png`",
    finalidade="feixe magnético entre o braço do Autômato e a âncora ou o drone. O jogo estica o segmento até a distância certa e gira tudo na direção do alvo",
    refs=[REF_DF02, REF_DF57], escala="feixe com **0,12 D (48 px) de espessura**",
    orientacao="na horizontal, indo para a **direita**", paleta=PAL_AUT,
    dim="PNG de **1024 × 512 px** com duas faixas: linhas 0–255 = **segmento repetível** (4 quadros de 256 × 256 px lado a lado, em loop); linhas 256–511 = **ponta** (4 quadros de 256 × 256 px: o feixe se fecha numa garra de luz)",
    ancora="eixo do feixe em **y = 128** (faixa de cima) e **y = 384** (faixa de baixo) em todos os quadros. Na ponta, o ponto de contato fica em x = 200 de cada quadro",
    quadros=["segmento 1–4: ondas de energia correndo para a direita. **Loop**", "ponta 1–4: garra de luz pulsando. **Loop**"],
    repeticao="o **segmento repete na horizontal**: a borda esquerda de cada quadro do segmento continua exatamente a direita. Teste com três cópias lado a lado: a emenda não pode aparecer",
    desc="Linhas de força ciano e brancas, com pequenos anéis magnéticos, e não um laser liso. Contido (DA-01).",
    regras="Sem texto nem grade. Fundo transparente.", verif=["emenda invisível com três cópias lado a lado", "eixo na mesma altura em todos os quadros"]))
A.append(dict(lote=2, grupo="DF87-DF99_automato", id="DF99", nome="Pulso Magnético (habilidade da forma)",
    arquivo="`DF99_pulso_magnetico.png`",
    finalidade="onda do Pulso Magnético. O jogo escala o efeito para o alcance de 150 px de raio",
    refs=[REF_DF02, "`colaboracao/entregas/VD_verdamia/VD_fx_clarao.png` (clarão do Lince, para não repetir a forma)"],
    escala="no último quadro, o anel ocupa a célula inteira (diâmetro de 360 px)", orientacao="radial", paleta=PAL_AUT, dim=GRID,
    ancora="centro da onda no centro da célula (192, 256)",
    quadros=["1: o peito acende (ponto ciano)", "2–4: anel de linhas de força se expandindo, com pequenos arcos de ímã",
             "5–6: o anel se desfaz em fiapos. **Sem loop**"],
    desc="Anel de **linhas de campo magnético** (arcos entre dois polos, como num desenho de ímã), ciano e branco. Diferente do clarão do Lince, que é um anel de luz cheio.",
    regras=SHEET_RULES, verif=["anel centrado em todos os quadros", "não se confunde com o VD_fx_clarao"]))

# ============================================================ LOTE 2b: portais
PT_REFS = [REF_PT00, REF_LAB, "`colaboracao/decisoes/D05_portais.md`"]
ARCO_DIM = "PNG de **1024 × 1024 px**"
ARCO_ANC = ("**mesmo registro em PT10, PT11 e PT12**: centro da base em **x = 512, y = 984** (40 px acima da borda de baixo) e "
            "**centro da abertura em x = 512, y = 640**. O código só sobrepõe as peças")
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT10", nome="Arco de Dobra: traseira",
    arquivo="`PT10_arco_traseira.png`",
    finalidade="parte do Arco desenhada **atrás** da membrana e do personagem: anel externo, base completa e painel de destino (sem glifos)",
    refs=PT_REFS, escala="arco de **1,7 D × 2,3 D (680 × 920 px)**, base de 2,0 D (800 px) e abertura útil de 400 × 600 px",
    orientacao="de frente", paleta=PAL_PT, dim=ARCO_DIM, ancora=ARCO_ANC + ". Base plana apoiada no chão em toda a largura",
    desc="Anel grosso de metal do Hélix, com o **interior vazio e transparente** (a membrana e as lâminas entram ali), base em degrau e, no topo, o **painel de destino** com três encaixes vazios. Os pilares da frente **não** entram (são a peça PT11). Luzes ciano apagadas, porque o código acende.",
    verif=["abertura transparente", "base plana em y = 984", "nada dos pilares da frente"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT11", nome="Arco de Dobra: frente",
    arquivo="`PT11_arco_frente.png`",
    finalidade="parte do Arco desenhada **na frente** do personagem: os dois pilares e a borda da base. Quando Daymon entra, ele fica entre a membrana e estes pilares",
    refs=PT_REFS, escala="na mesma escala da PT10", orientacao="de frente", paleta=PAL_PT, dim=ARCO_DIM, ancora=ARCO_ANC,
    desc="Só os dois pilares frontais (que cobrem as laterais do anel) e a borda dianteira da base, com no máximo **40 px de altura** sobre a linha do chão. O resto é transparente. Encaixa exatamente sobre a PT10.",
    repeticao="sobreponha PT11 à PT10 em 100%: as duas precisam formar o Arco da ficha PT00 sem frestas nem duplicação",
    verif=["sobreposição perfeita com PT10", "a borda da base não passa de 40 px de altura"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT12", nome="Lâmina do diafragma do Arco",
    arquivo="`PT12_lamina_diafragma.png`",
    finalidade="uma única lâmina. O jogo desenha 8 cópias giradas a cada 45° em torno do centro da abertura e as abre, fecha e faz tremer",
    refs=PT_REFS, escala="8 lâminas fechadas cobrem um disco de **640 px de diâmetro** (cobre a abertura de 400 × 600)",
    orientacao="lâmina apontando para **cima**, com o pivô embaixo", paleta=PAL_PT, dim="PNG de **512 × 512 px**",
    ancora="**pivô de rotação em x = 256, y = 448**, que no jogo coincide com o centro da abertura do Arco",
    desc="Lâmina curva de metal, como a íris de uma câmera, com uma linha ciano na borda. Desenhe-a de modo que 8 cópias giradas a 45° em torno do pivô formem um disco fechado, com pequena sobreposição.",
    repeticao="teste girando 8 cópias em torno de (256, 448): o disco precisa fechar sem buracos",
    verif=["disco fechado com 8 cópias", "pivô exato"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT13", nome="Glifos de destino (apagados e acesos)",
    arquivo="`PT13_glifos.png`", finalidade="os glifos que acendem no painel do Arco e no seletor de destino",
    refs=PT_REFS, escala="glifo de **0,3 D (120 px)**", orientacao="de frente", paleta=PAL_PT, dim=GRID,
    ancora="centro de cada glifo no centro da sua célula (192, 256)",
    quadros=["linha 1: Hélix, Verdâmia e Deserto **apagados** (metal escuro em relevo, sem brilho); 4ª célula vazia",
             "linha 2: os mesmos **acesos** (ciano #2EC7E6, verde-lima #A6E05A e âmbar #F2B24C, com brilho contido); 4ª célula vazia"],
    desc="Hexágono com ponto central (Hélix), folha-cogumelo com chapéu sobre um caule (Verdâmia) e engrenagem de seis dentes (Deserto), iguais à ficha PT00. Formas simples e grossas.",
    verif=["os três se distinguem em tons de cinza", "acesos e apagados com o mesmo contorno"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT15", nome="Receptáculo da Máquina de Dobra",
    arquivo="`PT15_receptaculo.png`",
    finalidade="objeto interativo da Sala G do Laboratório, onde o jogador instala os fragmentos. Funciona também como estação de save",
    refs=PT_REFS + [REF_FRAG], escala="**1,2 D (480 px) de altura × 1,0 D (400 px) de largura**", orientacao="de frente",
    paleta=PAL_PT, dim="PNG de **1024 × 1024 px**",
    ancora="base plana apoiada no chão, com o centro em **x = 512, y = 984**. O cabo sai pela **borda direita** da imagem em y ≈ 900 (o jogo prolonga o cabo até o Arco)",
    desc="Pedestal de laboratório com **quatro soquetes vazios** em losango (o jogo desenha os fragmentos encaixados). Os soquetes têm anéis ciano apagados. Informe no ENTREGA.md o centro de cada soquete, em pixels.",
    verif=["quatro soquetes vazios e iguais", "cabo saindo pela borda direita", "base apoiada"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT20", nome="Membrana do portal (loop neutro)",
    arquivo="`PT20_membrana.png`",
    finalidade="interior de todos os portais (Arco e Fenda). O jogo tinge na cor do destino e muda o movimento (pulso, espiral ou ondulação)",
    refs=PT_REFS, escala="oval de **1,0 D × 1,5 D (400 × 600 px)**; na célula de 384 × 512, desenhe-o em **320 × 480 px** (o jogo amplia)",
    orientacao="de frente", paleta=PAL_MEMB, dim=GRID, ancora="centro do oval no centro da célula (192, 256)",
    quadros=["1–8: superfície translúcida com véus de luz girando devagar, mais clara no centro. **Loop** de 8 para 1"],
    desc="Superfície de luz translúcida, com bordas suaves e alfa crescendo para o centro. **Tons claros e neutros**, sem cor de destino. Nada de estrelas nem galáxias.",
    regras=SHEET_RULES, verif=["loop sem salto", "tingível: sem cores saturadas"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT21", nome="Fenda: borda aberta (loop)",
    arquivo="`PT21_fenda_borda.png`",
    finalidade="contorno rasgado da Fenda aberta nos universos (retorno em Verdâmia e no Deserto, chegada no Deserto). A membrana PT20 fica atrás",
    refs=PT_REFS, escala="oval de **1,1 D × 1,6 D**; na célula, **340 × 490 px**", orientacao="de frente",
    paleta=PAL_PT, dim=GRID, ancora="**base da fenda em x = 192, y = 500** (onde ela toca a base PT22), igual em todos os quadros",
    quadros=["1–8: bordas rasgadas com lascas de cristal roxo e ciano tremendo de leve. **Loop**"],
    desc="Só a borda: o interior é transparente. Rasgo vertical no espaço, com bordas irregulares e lascas de cristal roxo #7A5CFF e ciano #2EC7E6.",
    regras=SHEET_RULES, verif=["interior transparente", "base fixa nos 8 quadros"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT22", nome="Fenda: base no chão",
    arquivo="`PT22_fenda_base.png`", finalidade="apoio da Fenda: chão rachado de onde ela nasce. Fica sobre o terreno de qualquer universo",
    refs=PT_REFS, escala="**1,6 D (640 px)** de largura", orientacao="de frente, levemente vista de cima", paleta=PAL_PT,
    dim="PNG de **1024 × 512 px**",
    ancora="**linha do chão em y = 380**; ponto onde a fenda nasce em **x = 512, y = 380**",
    desc="Rachaduras irradiando no chão, com 4 a 6 lascas de cristal roxo e ciano saindo do solo. Abaixo de y = 380, só as raízes das rachaduras, desvanecendo. Sem cor de terreno (precisa servir para musgo e areia).",
    verif=["neutra sobre o chão de Verdâmia e sobre a areia do Deserto"]))
A.append(dict(lote=2, grupo="PT10-PT23_portais", id="PT23", nome="Fenda: abrindo",
    arquivo="`PT23_fenda_abrindo.png`",
    finalidade="a Fenda se abre (depois do fragmento e na chegada ao Deserto). O jogo toca de trás para a frente para fechá-la. O quadro 1, parado, é a rachadura dormente",
    refs=PT_REFS, escala="como a PT21", orientacao="de frente", paleta=PAL_PT, dim=GRID,
    ancora="base em **x = 192, y = 500**, igual à PT21",
    quadros=["1: rachadura dormente (linha fina vertical de ~200 px, saindo do chão, brilho fraco)", "2–3: a linha se alarga e solta lascas",
             "4–6: rasga em oval", "7: oval quase completo", "8: igual ao quadro 1 da PT21. **Sem loop**"],
    desc="Abertura em ~0,7 s no jogo. As lascas voam para fora no quadro 3 e voltam a orbitar no 7.",
    regras=SHEET_RULES, verif=["o quadro 8 encaixa no quadro 1 da PT21", "base fixa"]))

# ============================================================ LOTE 3: Forja-Mãe
FM_REFS = [REF_DF03, REF_DF00, REF_DF50, REF_DF24]


def fm(id_, arq, nome, fin, dim, ancora, desc, quadros=None, codigo=None, refs=None, verif=None, repeticao=None, escala=None, orient="de frente"):
    A.append(dict(lote=3, grupo="DF100-DF112_forja_mae", id=id_, nome=nome, arquivo=f"`{arq}`", finalidade=fin,
                  refs=refs or FM_REFS, escala=escala or "D = 400 px, nas medidas da ficha DF03 aprovada",
                  orientacao=orient, paleta=PAL_FM, dim=dim, ancora=ancora, quadros=quadros, codigo=codigo,
                  repeticao=repeticao, desc=desc, regras=SHEET_RULES if quadros else None,
                  verif=(verif or []) + ["igual à ficha DF03", "legível na escala do jogo (corpo com ~300 px de altura)"]))


fm("DF100", "DF100_forja_corpo.png", "Forja-Mãe: corpo fixo",
   "corpo do chefe embutido na parede do fundo da Câmara da Forja. Lente, placas do peito, escotilhas e grade são peças separadas, desenhadas por cima",
   "PNG de **2048 × 2048 px**",
   "base plana da fornalha apoiada no chão, com o centro em **x = 1024, y = 2008**. Flanges parafusadas nas laterais encostam na parede",
   "Forno de ferro com ombros largos, 3,5 D (1400 px) de altura e 3 D (1200 px) de largura. Deixe **vazios e transparentes** os encaixes da lente (círculo de 360 px, centro em x = 1024, y = 900), da câmara do peito (retângulo de 420 × 360, centro em x = 1024, y = 1330), das duas escotilhas dos ombros (240 × 160, centros em x = 640 e x = 1408, y = 820) e da grade da fornalha (700 × 240, centro em x = 1024, y = 1820). Informe no ENTREGA.md os encaixes reais, se precisar mudar.",
   escala="**3,5 D × 3 D (1400 × 1200 px)**")
fm("DF101", "DF101_forja_lente.png", "Forja-Mãe: lente-olho (4 estados)",
   "olho do chefe. Os estados são os sinais de aviso dos golpes",
   GRID, "centro da lente no centro da célula (192, 256), com **diâmetro de 340 px** nos quatro estados",
   "Lente redonda com moldura de ferro e íris mecânica de lâminas.",
   quadros=["1: **repouso** (âmbar suave, íris aberta)", "2: **aviso de rajada** (âmbar forte, íris contraída pela metade)",
            "3: **mira do feixe** (vermelha, íris fechada num ponto)", "4: **apagada** (vidro escuro, sem brilho)"],
   codigo="quadro 2 = aviso da rajada de rebites (0,5 s); quadro 3 = aviso do feixe (1 s); quadro 4 = vitória e lente escura depois do feixe; quadro 1 = estado normal")
fm("DF102", "DF102_forja_peito.png", "Forja-Mãe: câmara do núcleo (peito)",
   "câmara do peito com o fragmento. As três placas são separadas para o jogo arrancá-las com o Pulso Magnético",
   GRID, "centro da câmara no centro da célula (192, 256); câmara com **400 × 340 px** ocupando a célula (pode reduzir para caber, mantendo a proporção)",
   "Use as células assim. Quadro 1: **câmara fechada completa** (placas no lugar e o fragmento visível pelas frestas). Quadro 2: **câmara aberta** (sem placas, fragmento exposto e brilhando). Quadro 3: **câmara danificada** (rachada, com o fragmento piscando). Quadros 4, 5 e 6: cada uma das **três placas sozinha**, inteira, na posição em que encaixa no quadro 1 (o jogo as faz voar). Quadros 7 e 8 vazios.",
   quadros=["1: fechada", "2: aberta", "3: danificada", "4: placa esquerda", "5: placa central", "6: placa direita"],
   codigo="quadro 1 = fases 1 e 2; quadro 2 = janela de dano da fase 3; quadro 3 = núcleo com menos da metade da vida; quadros 4–6 = placas arrancadas",
   refs=FM_REFS + [REF_FRAG])
fm("DF103", "DF103_forja_carrinho.png", "Forja-Mãe: carrinho do braço (no trilho do teto)",
   "carrinho que corre no trilho de teto e segura o braço",
   "PNG de **1024 × 512 px**",
   "as rodinhas apoiam no trilho em **y = 120** (o trilho DF55b passa por ali). O pivô do braço fica embaixo do carrinho, em **x = 512, y = 400**",
   "Carrinho de 0,9 D (360 px) de largura, com quatro rodinhas em cima, motor com luz âmbar e um olhal embaixo, de onde pende o braço.")
fm("DF104", "DF104_forja_segmento.png", "Forja-Mãe: segmento do braço",
   "segmento articulado do braço. O jogo usa duas cópias (braço e antebraço) e as gira nos pivôs",
   "PNG de **1024 × 512 px**",
   "segmento na horizontal, com **pivô de entrada em x = 112, y = 256** e **pivô de saída em x = 912, y = 256** (800 px entre as articulações)",
   "Viga de ferro com pistão hidráulico ao lado e articulações redondas com rebite grande nas pontas. 0,35 D (140 px) de espessura.",
   orient="na horizontal, apontando para a **direita**")
fm("DF105", "DF105_forja_martelo.png", "Forja-Mãe: cabeça de martelo com placa de âncora (4 estados)",
   "martelo de cada braço. Os estados são aviso, impacto e preso, e a placa de âncora em cima é onde o Autômato se prende com o ímã",
   "PNG de **2048 × 1024 px**, grade **invisível** de 2 × 2 (células de 1024 × 512 px), estados em ordem de leitura",
   "em cada célula, **ponto de encaixe no braço em x = 512, y = 96** e **face de baixo (linha de esmagamento) em y = 432**, iguais nos quatro estados. **Centro da placa de âncora** em x = 512, y = 150",
   "Bloco de 1,4 D × 0,6 D (560 × 240 px), com faixas de perigo vermelho e cinza na face de baixo (como a DF50), a **placa de âncora ciano** redonda em cima (como a DF57) e o **núcleo do pistão** laranja na junta de cima, protegido por baixo.",
   quadros=["1: **normal** (faixas apagadas, âncora apagada, núcleo laranja fraco)", "2: **aviso** (faixas acesas em vermelho)",
            "3: **preso** (âncora acesa em ciano, núcleo laranja forte e exposto, lascas de chão na face de baixo)",
            "4: **quebrado** (núcleo destruído e escuro, rachaduras, âncora apagada)"],
   codigo="estado 2 = aviso do Martelo (0,7 s na fase 1; 0,55 s na fase 2); a batida usa o estado 2 e o efeito DF82; estado 3 = janela de punição (1,6 s); volta ao estado 1 na recuperação; estado 4 = núcleo destruído (fim das fases 1 e 2)",
   refs=FM_REFS + [REF_DF57])
fm("DF106", "DF106_forja_nucleo_pistao.png", "Forja-Mãe: núcleo do pistão (3 estados, sobreposição)",
   "núcleo laranja que o jogador acerta em cima do martelo. Fica por cima do DF105 para piscar e mostrar dano",
   GRID, "centro do núcleo no centro da célula (192, 256), com **diâmetro de 160 px**",
   "Esfera laranja dentro de uma gaiola de ferro.",
   quadros=["1: **íntegro**", "2: **danificado** (rachado, luz falhando)", "3: **destruído** (escuro, gaiola torta)"],
   codigo="quadro 1 = vida acima de 50%; quadro 2 = abaixo de 50%; quadro 3 = destruído")
fm("DF107", "DF107_forja_escotilha.png", "Forja-Mãe: escotilha dos ombros",
   "escotilha que solta os drones na fase 2", GRID,
   "centro da escotilha no centro da célula (192, 256), com **240 × 160 px**",
   "Escotilha com luz vermelha de aviso.",
   quadros=["1: fechada", "2: aviso (luz vermelha acesa)", "3: abrindo", "4: aberta (vão escuro, de onde o drone sai)"],
   codigo="quadro 2 = aviso de 1 s antes dos drones; quadro 4 = momento em que o drone surge")
fm("DF108", "DF108_forja_grade.png", "Forja-Mãe: grade da fornalha (loop)",
   "grade da fornalha, embaixo do corpo. A luz do fogo indica o estado de ânimo do chefe", GRID,
   "grade com **340 × 120 px**, centro em (192, 256)",
   "Barras de ferro com fogo laranja atrás. O jogo amplia para o encaixe de 700 × 240 do DF100.",
   quadros=["1–6: fogo pulsando atrás das barras. **Loop**", "7: grade **aberta** (barras recolhidas, fogo forte) para a janela da rajada",
            "8: grade **fria** (fogo apagado) para a vitória"],
   codigo="1–6 = normal; 7 = janela de punição da rajada (0,8 s); 8 = vitória")
fm("DF110", "DF110_forja_feixe.png", "Forja-Mãe: feixe da lente",
   "feixe vermelho que varre o chão na fase 3. O jogo estica o segmento e aponta a origem para a lente",
   "PNG de **1024 × 512 px**: linhas 0–255 = **segmento repetível** (4 quadros de 256 × 256 lado a lado, em loop); linhas 256–511 = **ponto de impacto no chão** (4 quadros de 256 × 256, em loop)",
   "eixo do feixe em **y = 128** na faixa de cima; no impacto, o ponto de contato com o chão fica em **x = 128, y = 480**",
   "Feixe vermelho #C8402F com núcleo claro, de 0,15 D (60 px) de espessura, e faíscas no ponto de impacto. A forma precisa mostrar com clareza a área que fere.",
   quadros=["segmento 1–4: energia correndo. **Loop**", "impacto 1–4: faíscas e chão incandescente. **Loop**"],
   repeticao="o segmento **repete na horizontal**. Teste com três cópias lado a lado",
   orient="na horizontal, indo para a **direita**")
fm("DF111", "DF111_forja_carga_lente.png", "Forja-Mãe: carga da lente",
   "aviso de 1 s antes do feixe, sobre a lente", GRID, "centro no centro da célula (192, 256)",
   "Linhas de energia vermelha convergindo para o centro e um anel se fechando.",
   quadros=["1–6: as linhas convergem e o anel se fecha. **Sem loop**; o quadro 6 é o instante do disparo"],
   codigo="quadros 1–6 tocados durante o aviso de 1 s; o feixe DF110 começa depois do quadro 6")
fm("DF112", "DF112_forja_explosao_nucleo.png", "Forja-Mãe: explosão de núcleo",
   "explosão quando um núcleo é destruído (pistões e núcleo central)", GRID, "centro no centro da célula (192, 256)",
   "Estouro laranja e ciano, com anel de choque, lascas de ferro e um fiapo de fumaça. Maior e mais limpo que a DF84.",
   quadros=["1: clarão", "2–4: anel e lascas", "5–8: fumaça se desfazendo. **Sem loop**"],
   codigo="toca no instante em que o núcleo é destruído; o estado 4 do DF105 entra no quadro 3")


# ------------------------------------------------------------ escrita
HEAD = {
 1: ("Lote 1: fichas de referência", "SUSPENSO até o João Marcelo aprovar a decisão correspondente; depois, ABERTO"),
 2: ("Lote 2: Autômato e portais", "SUSPENSO até a aprovação das fichas DF02 e PT00"),
 3: ("Lote 3: Forja-Mãe", "SUSPENSO até a aprovação da ficha DF03"),
}
DEP = {"DF02_ficha_automato": "[D03](../decisoes/D03_forma_deserto.md)", "DF03_ficha_forja_mae": "[D04](../decisoes/D04_chefe_deserto.md)",
       "PT00_ficha_portais": "[D05](../decisoes/D05_portais.md)", "DF87-DF99_automato": "ficha DF02 aprovada",
       "PT10-PT23_portais": "ficha PT00 aprovada", "DF100-DF112_forja_mae": "ficha DF03 aprovada"}
groups = {}
for a in A:
    groups.setdefault(a["grupo"], []).append(a)
for g, items in groups.items():
    lote = items[0]["lote"]
    t, estado = HEAD[lote]
    TIT = {"DF02_ficha_automato": "DF02: ficha do Autômato", "DF03_ficha_forja_mae": "DF03: ficha da Forja-Mãe",
           "PT00_ficha_portais": "PT00: ficha dos portais", "DF87-DF99_automato": "DF87–DF99: Autômato (animações e efeitos)",
           "PT10-PT23_portais": "PT10–PT23: portais e Receptáculo", "DF100-DF112_forja_mae": "DF100–DF112: Forja-Mãe (peças e efeitos)"}
    L = [f"# Pedido {TIT[g]}", "",
         f"**{t}.** Fase 2 (Deserto de Ferrugem) e passagem entre fases.",
         f"**Estado:** {estado}.",
         f"**Depende de:** {DEP[g]}.",
         "**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento) · 11/11/2026",
         "**Diretriz obrigatória:** [DA-01](../entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md), que prevalece sobre este pedido.", "",
         "Cada bloco abaixo é um prompt completo. Copie **um por vez** para gerar a peça.", ""]
    for a in items:
        L += ["---", "", f"## {a['id']}: {a['nome']}", "", "````markdown", prompt(a), "````", ""]
    open(os.path.join(ROOT, "colaboracao/pedidos", g + ".md"), "w").write("\n".join(L))
    print(g, len(items))
print("total", len(A))
