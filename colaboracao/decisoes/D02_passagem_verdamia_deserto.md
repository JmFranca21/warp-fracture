# D02: Passagem entre Verdâmia (Fase 1) e o Deserto de Ferrugem (Fase 2)

**Estado:** PROPOSTA. Aguarda decisão do João Marcelo.
**Autor:** Claude (design e desenvolvimento) · 11/11/2026
**Base:** `main` em `e731e1a`; GDD v2 (págs. 2, 4 e 7); `scripts/main.gd`, `level.gd`, `portal.gd`, `calibration.gd`, `save_game.gd`.

## O que existe hoje

- Pegar o fragmento abre a **tela de vitória** e grava o save em Verdâmia (`main.collect_fragment`).
- Verdâmia **não tem saída**. Não há portal de volta ao Laboratório.
- **Defeito confirmado:** ao continuar um save gravado depois da vitória, o fragmento reaparece no altar, porque a fase recria o fragmento sempre que a Rainha consta como derrotada (`level.gd`, `boss_done`). Pegá-lo de novo leva o contador a 2/4. Testado com Godot 4.3 em 11/11/2026.
- O GDD diz (pág. 2): "Ao recuperar cada fragmento, ele volta ao laboratório com uma nova habilidade para a arma, o que permite alcançar o portal seguinte." O Laboratório funciona como hub.

## Opção A (recomendada): retorno ao Hélix e o Receptáculo da Máquina

O fragmento abre uma fenda de volta para o Laboratório. Lá, Daymon instala o fragmento no Receptáculo da Máquina de Dobra. Com essa energia, IRIS sintoniza o portal em um segundo sinal, e o jogador escolhe o novo destino e calibra.

**Por que recomendo:** segue o fluxo de hub que o GDD descreve e reaproveita o Laboratório, IRIS, o portal e a calibração que já funcionam. Cria o retorno a Verdâmia, que hoje não existe, e só pede arte nova para os portais (D05) e o Receptáculo. Ainda é possível implementar tudo com peças provisórias antes da arte final.

## Opção B: ressonância no templo

O fragmento reage ao altar e foge flutuando pelo templo. O Lince o persegue por um trecho curto, de cerca de 30 s, com plataformas que surgem do altar, até o fragmento rasgar uma fenda direta para o Deserto. Não há volta ao Laboratório.

**Contras:** exige um trecho novo de fase em Verdâmia, com layout e arte. O Lince passaria direto para outra forma, sem passar pelo Traje Âncora no Hélix. Deixa o Laboratório sem papel de hub e mantém Verdâmia sem saída para revisitas.

## Sequência da Opção A, do ponto de vista do jogador

1. **Ao pegar o fragmento.** O Lince toca o cristal. Os controles travam por cerca de 3 s. O cristal sobe, gira e entra no Traje Âncora com um anel de luz. O slot de fragmentos do HUD acende (1/4) e aparece o letreiro "FRAGMENTO RECUPERADO · 1/4". **Não há mais tela de vitória.** O jogo salva.
2. **A fenda de retorno se abre.** Atrás do altar, no fundo da arena, o chão racha e uma fenda de dobra se abre (asset PT20–PT22). O tom ciano do Hélix indica o destino. IRIS fala pelo rádio, em uma caixa de diálogo curta: *"Sinal estável. O fragmento abriu um caminho de volta ao Hélix. Quando estiver pronto, atravesse."*
3. **Retorno do controle.** O jogador controla o Lince na arena, com a barreira aberta. Pode explorar Verdâmia e pegar células e registros que deixou para trás. Nada o obriga a voltar logo.
4. **Atravessar.** Perto da fenda aparece "[E] Voltar ao Laboratório Hélix". A travessia usa o efeito de portal atual: clarão, desfoque e o banner "FORMA HUMANA". Daymon chega na Sala G (Saída), ao lado do portal do Hélix, que agora está escuro e com o diafragma fechado.
5. **No Laboratório.** O Laboratório tem mais rachaduras roxas do que antes (GDD pág. 5: "a cada retorno está mais tomado pelas fraturas"). IRIS fala: *"Bem-vindo de volta. Leve o fragmento até o Receptáculo da Máquina. Sem ele, o portal não tem força para outra travessia."* Um marcador no mapa indica o Receptáculo, sobre o bloco elevado da Sala G, entre a porta e o portal.
6. **O que ele faz: instalar o fragmento.** No Receptáculo aparece "[E] Instalar o fragmento". Ao apertar, Daymon encaixa o cristal no primeiro dos quatro soquetes. Um feixe corre pelo cabo até o portal, as lâminas do diafragma giram e o glifo de Verdâmia se acende no painel de destino. O Receptáculo também funciona como estação e salva o jogo.
7. **O que ele descobre.** IRIS, mais grave: *"Com um fragmento na máquina, consigo separar os sinais... Há um segundo: calor, metal, ferrugem. E uma fábrica que ainda funciona sozinha."* O glifo do Deserto (engrenagem) aparece no painel, ainda apagado e piscando. A vinheta do registro `log_09` (novo) conta o que IRIS sabe do Deserto.
8. **O portal do Deserto é liberado.** No portal aparece "[E] Escolher destino". Abre-se um seletor com dois glifos: **Verdâmia** (estável, atravessa direto) e **Deserto de Ferrugem** (sinal fraco, "calibração necessária").
9. **A ação consciente.** O jogador escolhe o Deserto, e abre-se a calibração atual com outro padrão: três ondas, em tom âmbar, uma delas com deriva lenta que exige acompanhar. Ao alinhar as ondas, o diafragma se abre por completo e a membrana fica âmbar, com ondulação horizontal. Aparece "[E] Atravessar". **Só esse último E inicia a viagem.** Esc cancela em qualquer ponto, e o portal continua liberado.
10. **Chegada.** Ocorre a transformação no Autômato (D03), com o banner da nova forma, e Daymon chega às Dunas de Sucata por uma fenda que se fecha atrás dele. O jogo salva.

**O que fica igual:** a primeira ida a Verdâmia continua exigindo os dois terminais e a calibração atual (o `tools/test_portal.gd` não muda). Depois que o Deserto for calibrado, as viagens seguintes não pedem nova calibração.

## Save

Formato novo: `version: 2`. Os campos antigos são mantidos e três são novos:

| Campo | Conteúdo |
|---|---|
| `frags` | fragmentos recuperados, por universo (`["verdamia"]`). O HUD continua mostrando a contagem |
| `installed` | fragmentos instalados no Receptáculo |
| `portal_cal` | destinos já calibrados no portal do Hélix (`["verdamia", "deserto"]`) |

| Onde o jogador sai | O que "Continuar" faz |
|---|---|
| Depois de pegar o fragmento, ainda em Verdâmia | Volta a Verdâmia, no santuário ou no ponto da fenda (o que foi salvo por último). O fragmento **não** reaparece, a barreira está aberta e a fenda de retorno está aberta |
| No Laboratório, com o fragmento ainda não instalado | Volta à Sala G, ao lado do portal. O Receptáculo pisca e IRIS repete a instrução |
| Depois de instalar, sem ter calibrado o Deserto | Volta ao Receptáculo. O seletor mostra Verdâmia e o Deserto pendente |
| Com o Deserto calibrado, sem ter atravessado | Volta ao Receptáculo. O portal já abre direto para o Deserto |
| Já no Deserto | Último checkpoint do Deserto (no mesmo arquivo de save; o protótipo usava um arquivo separado) |

**Saves antigos (`version` 1):**
- **Rainha derrotada e `fragments` ≥ 1:** marca `frags = ["verdamia"]`, limita o contador a 1 (corrige quem pegou o fragmento duas vezes) e abre a fenda de retorno.
- **Rainha derrotada e `fragments` = 0** (saiu entre a vitória e a coleta): o fragmento continua no altar, como hoje.
- **Saves no Laboratório ou em Verdâmia antes do chefe:** não mudam.

## O que precisa de aprovação

1. Opção A ou B.
2. **Fim do protótipo:** a tela de vitória sai do fragmento de Verdâmia. Até o Deserto estar pronto, o seletor mostra o Deserto como "sinal detectado" e a travessia fica bloqueada com uma fala de IRIS. Na versão completa, o fim passa para a vitória sobre o chefe do Deserto (D04).
3. Textos de IRIS e o registro novo `log_09` (eu escrevo; o responsável revisa).
4. **Revisitar Verdâmia:** pelo seletor, o jogador chega à fenda de retorno, no fundo da arena.
