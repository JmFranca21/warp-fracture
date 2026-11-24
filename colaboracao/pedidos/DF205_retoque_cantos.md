# Pedido DF205 retoque: cantos de areia

**Estado:** ABERTO (24/11/2026). Encontrado na integração da DF205 no Godot ([HANDOFF](../../HANDOFF.md), seção 15.3).
**Para:** ChatGPT (diretor de arte) · **De:** Claude (desenvolvimento)

Até o retoque chegar, o jogo desenha os dois cantos só a partir de y 42 do arquivo. Quando chegar, esse corte sai de `scripts/df_terrain.gd` (`AREIA_CANTO_TOPO`).

````markdown
**[DF205 retoque] Cantos de areia: tirar o bloco acima do apoio**

Você é o diretor de arte do Warp Fracture. A DF205 (terreno do Deserto, aprovada e publicada na `main` em `cbdd27c`) foi integrada no Godot, na branch `dev/deserto`. A conferência no jogo está em `docs/auditoria_cena/DF205_encaixes_no_jogo.jpg`, nas emendas `areia_fosso_780` e `areia_fosso_1180`.

Ficou um problema em duas peças: `areia_canto_esquerdo.png` e `areia_canto_direito.png` (180 × 260). Acima da linha de apoio (y 50), cada uma traz um bloco escuro de topo reto que começa em y 3. É um pilar de rocha cortado na horizontal, com ~50% de opacidade média entre y 8 e y 48. No jogo, isso vira um toco de 23 px acima do chão na beira dos fossos das Dunas. As outras 20 peças estão aprovadas e não mudam.

- **ID:** DF205 retoque
- **Arquivo(s):** `areia_canto_esquerdo.png` e `areia_canto_direito.png`, substituindo os atuais em `colaboracao/entregas/DF205/`.
- **Finalidade no jogo:** quina de cima da areia nas bordas do fosso das Dunas (x 780 e 1.180 do mundo).
- **Referências obrigatórias do repositório:** as próprias peças atuais; `areia_chao.png` e `areia_borda.png` (o canto continua os dois); `docs/auditoria_cena/DF205_encaixes_no_jogo.jpg`.
- **Escala:** a mesma (2× do jogo).
- **Orientação:** a mesma.
- **Âncora e pivô:** quina em (18, 50) no esquerdo e em (162, 50) no direito, como hoje.
- **Estados e quadros:** 1 quadro por peça. Acima de y 50, só o mesmo relevo esparso da `areia_chao` (torrões e pontas de sucata de até 24 px, nunca um bloco contínuo), arredondando a quina. Abaixo de y 50, mantenha a pintura atual.
- **Dimensões e grade:** 180 × 260 px, como hoje.
- **Fundo:** transparente (PNG RGBA), sem sombra projetada e sem texto.
- **Antes de apresentar, confira:** a opacidade média entre y 8 e y 48 fica abaixo de 15%. Remonte as duas emendas (`areia_fosso_780` e `areia_fosso_1180`) com `areia_chao` e `areia_borda`, sem degrau nem toco na quina.
- **Entrega:** Apresente ao João Marcelo e **só suba depois da aprovação explícita dele**. Substitua as duas peças em `colaboracao/entregas/DF205/`. Acrescente ao `ENTREGA.md` uma seção "Retoque dos cantos de areia" com a data e os novos SHA-256. Atualize a linha DF205 do `colaboracao/STATUS.md` com "retoque dos cantos ENTREGUE" e faça o commit `[arte]` na `main`.
````
