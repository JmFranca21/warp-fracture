# D01: Locomoção do Eco na Fuga (corrida no chão × avanço flutuante)

**Estado:** **DECIDIDO em 23/10/2026 pelo responsável (João Marcelo): opção B, avanço flutuante.**
**Resultado nos pedidos:**
- A3_eco_run foi cancelado e substituído pelo [A3_eco_avanco](../pedidos/A3_eco_avanco.md).
- O [A4_eco_grab](../pedidos/A4_eco_grab.md) foi reescrito para acontecer no ar.
- Foi criado o [A9_fx_dobra_eco](../pedidos/A9_fx_dobra_eco.md).
- A A2 continua como idle. A1 e A5 não mudam.

## A dúvida

O Eco é uma entidade espectral que já paira na A1, na A2 e na A5. Faz sentido que a perseguição seja uma **corrida no chão** (como a A3 está pedindo hoje) ou um **avanço flutuante rasante**?

## Impacto na implementação da Fuga do Eco

A rota da fuga passa pelo que já existe no laboratório: o fosso eletrificado, as plataformas suspensas e quebradiças, o elevador, os ganchos do Arpão e os desníveis entre as salas.

| Aspecto | A. Corrida no chão (A3 atual) | B. Avanço flutuante (proposta) |
|---|---|---|
| Seguir o jogador pela rota | Difícil. Ele precisaria pular buracos, subir plataformas e usar o elevador. Como não tem Arpão, ficaria preso nos trechos de gancho ou exigiria "teleportes" para alcançar, o que fica artificial | Natural. Ele **segue o rastro do jogador pelo ar**, com atraso, e atravessa plataformas e vãos |
| Complexidade do código | Alta: IA de plataforma com pulos, detecção de borda e casos especiais por sala | Baixa e robusta: segue um rastro gravado das posições do jogador, com velocidade ajustada à distância |
| Justiça para o jogador | Dá para pular por cima dele, mas a IA pode ficar presa e quebrar a tensão | A escapatória precisa ser clara. A esquiva atravessa o Eco (invulnerabilidade da esquiva) e o golpe é avisado antes (A4) |
| Coerência com o personagem | Contradiz a A1, a A2 e a A5, onde ele paira, e o conceito espectral | Coerente com a ficha A0 e com a DA-01: ameaça pela postura e pelo gesto |
| Leitura na tela | Silhueta de corrida parecida com a do Daymon (pode confundir) | Silhueta diferente do jogador (inclinado, sem passos): fácil distinguir quem é quem |
| Interação com o desabamento | Entulho poderia bloquear o caminho dele | Ignora o entulho, que continua sendo um perigo só para o jogador |
| Arte necessária | 8 quadros de corrida e um ajuste na A4 | 6 quadros de avanço em loop e a A4 refeita no ar (menos quadros no total) |

## Recomendação do desenvolvimento: opção B

Substituir a A3 por uma animação de **avanço flutuante agressivo** e ajustar a A4 para ser feita no ar. A A2 continua como idle e observação. A1 e A5 já são compatíveis.

### Como o Eco se comportaria (opção B)

- **Altura:** paira na altura do tronco do Daymon. Ele segue o rastro do jogador cerca de 0,6 s atrás e atravessa plataformas e paredes finas (é espectral).
- **Velocidade elástica:**
  - Se o jogador abre distância, o Eco acelera um pouco. Assim a fuga nunca fica fácil demais.
  - Se o jogador está perto, o Eco não acelera. Assim a fuga nunca fica impossível, e quem corre bem consegue escapar.
- **Estados:** observar (A2) → avançar (nova A3) → agarrar (A4, quando estiver a menos de cerca de 90 px) → voltar a avançar.
- **Aviso antes do golpe:** os quadros 1 a 3 da A4 servem de aviso. Uma esquiva nesse momento atravessa o Eco sem dano.
- **Fim:** quando o jogador entra no portal, o Eco toca a A5 (se desfaz).

## Especificação proposta (só vira pedido depois da decisão)

### Nova A3: `A3_eco_avanco` (substitui a `A3_eco_run`)

- **6 quadros em loop**, a cerca de 12 quadros por segundo, na mesma grade 4 × 2, com 1536 × 1024 px e fundo transparente. A escala é a do Daymon. A DA-01 e a ficha A0 continuam obrigatórias.
- **Pose:** corpo inclinado uns 35° para a frente, como se mergulhasse em direção ao alvo. A cabeça vai à frente, os braços ficam estendidos para trás ao lado do corpo, as pernas ficam juntas e arrastadas para trás, sem passos. A barra do jaleco se estica para trás e se desfaz em 2 ou 3 pontas. A rachadura ciano fica visível, e os olhos ficam fixos à frente.
- **Movimento do ciclo:** uma ondulação leve do corpo (sobe e desce no máximo ±6 px) e o jaleco ondulando, com 1 ou 2 fragmentos se soltando das costas em cada quadro. Os efeitos ficam contidos.
- **Ponto de referência (âncora):** o **centro do tronco** em (x 200, y 280) da célula, igual em todos os quadros. Nenhuma parte fica abaixo da linha a 40 px da borda de baixo.
- **Continuidade:** o quadro 1 deve sair naturalmente do quadro 1 da A2. A mudança de pose pode ser direta, porque o jogo faz uma transição curta.

### A4 ajustada: `A4_eco_grab` no ar

- Os mesmos 6 quadros e o mesmo roteiro (avanço, mão abre, garras, golpe no quadro 4, recolhe, volta), mas **flutuando**, partindo e terminando na pose da nova A3.
- **Âncora:** o centro do tronco em (x 150, y 280), deslocado para a esquerda para caber o braço esticado. Nada passa de x = 376.

## O que o responsável precisa decidir

1. **Opção A** (manter a corrida no chão) ou **Opção B** (avanço flutuante, recomendada)?
2. Se for B, o Eco pode **atravessar paredes finas e plataformas** ou deve contornar o cenário? Recomendo atravessar: é espectral, e isso evita que ele fique preso.

Quando a decisão sair, o Claude:
- atualiza os pedidos A3 e A4 (ou reabre a A3 como está, se a escolha for A);
- registra a decisão aqui;
- libera os pedidos no `STATUS.md`;
- só então implementa a locomoção final.

Enquanto isso, a Fuga do Eco pode ser programada com um Eco provisório desenhado por código, **sem fixar a locomoção**. A rota, o desabamento, o checkpoint e o portal não dependem dessa escolha.


---

## Decisão final (23/10/2026)

**Opção B: avanço flutuante.**

**Atravessar o cenário ou contornar?** O responsável observou que um Eco atravessando paredes "a seco" pareceria artificial e estranho, e que só funcionaria com animações e efeitos coerentes. A solução adotada combina as duas coisas:

1. **Por padrão, o Eco contorna o cenário.** Ele segue o **rastro do jogador**, as posições gravadas por onde o Daymon passou, cerca de 0,6 s atrás. Como esse rastro só passa por espaço aberto, o Eco contorna as paredes naturalmente, sem IA de caminho e sem atravessar nada sólido. As plataformas de passagem por baixo continuam atravessáveis, como já são para o jogador.
2. **Ele nunca atravessa uma parede de forma seca.** Quando o jogador abre muita distância com o elevador ou os ganchos do Arpão, e o rastro fica longo demais, o Eco usa uma **Dobra espectral**, que é um evento visível e com aviso:
   - se desfaz (quadros 1 a 4 da A5);
   - uma fenda ciano se abre mais perto do jogador, no ar ou rente a uma parede (A9);
   - ele reaparece por ela (quadros 1 a 4 da A1).
3. **Regras de justiça da Dobra:**
   - ela nunca aparece a menos de cerca de 250 px do jogador nem na frente dele em uma passagem estreita;
   - tem um tempo mínimo entre uma e outra, de cerca de 4 s;
   - a fenda fica visível por 0,4 s antes de o Eco sair, para o jogador poder reagir;
   - dá um som próprio, gerado em `gen_audio.py`.

Assim, o jogador sempre entende de onde o Eco veio: ele vem do rastro ou de uma fenda que acabou de ver abrir. Nunca surge do nada nem atravessa paredes sem explicação. A Dobra também reforça a identidade do Eco, que nasceu das fraturas e se move por elas.

**Sequência de estados no jogo:** observar (A2) → avançar (A3) → agarrar (A4, se estiver perto) → avançar → Dobra (A5 parcial, depois A9, depois A1 parcial, se ficar longe demais) → avançar → se desfazer no portal (A5 completa).
