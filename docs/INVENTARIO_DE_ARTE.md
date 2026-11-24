# Inventário de arte das quatro fases

**Atualizado em 24/11/2026** (branch `dev/neve`). Um lugar só para ver, por fase e por função da [DA-03](../colaboracao/entregas/00_padrao_visual/DA-03_RECEITA_DE_CENA.md), o que existe, o que está no padrão e o que falta. O estado de cada pedido continua no [quadro de status](../colaboracao/STATUS.md); o catálogo detalhado das peças, no [documento de arte](DOCUMENTO_DE_ARTE.md).

**Legenda:**
- ✅ **no padrão:** arte final, no nível do Laboratório e de Verdâmia (avaliação do João).
- 🟡 **fora do padrão:** arte final, mas refazer ou retocar.
- 🔶 **provisório:** recorte de ficha ou desenho por código, que funciona no jogo até a arte chegar.
- ❌ **falta:** não existe nada.

## Cena (DA-03)

| Função | Laboratório | Verdâmia | Deserto | Nivária |
|---|---|---|---|---|
| Fundo distante | ✅ desenho por código (BgLayer) | ✅ `bg_distante` | ✅ **DF200** (integrada na `dev/deserto`) | 🔶 céu por código → **GL50** |
| Fundo intermediário | ✅ BgLayer | ✅ `bg_intermediario` | ✅ **DF201** (duas camadas, integrada na `dev/deserto`) | 🔶 cordilheiras por código → **GL51** |
| Estrutura de fundo | ✅ BackWall (colunas, janelas, canos) | ✅ troncos e cogumelos gigantes | 🟡 painéis chapados DF22–DF24 → **DF202**; ❌ peças grandes → **DF204** | 🔶 pinheiros, ruínas e pilares por código → **GL52–GL54** |
| Terreno | ✅ | ✅ 8 peças | ✅ **DF205** (22 peças, com o retoque dos cantos; integrada na `dev/deserto`) | 🔶 por código → **GL55** |
| Decoração média e pequena | ✅ 37 peças no mapa | ✅ | ❌ → **DF206** | 🔶 tufos, pedras e rochas por código → **GL56** |
| Moldura (o que desce do alto) | ✅ cabos | ✅ cipós e raízes | ❌ → **DF207** | 🔶 correntes por código → **GL57** |
| Primeiro plano | ✅ entulho | ✅ `fg_vegetacao` | ❌ → **DF208** | 🔶 silhuetas por código → **GL58** |
| Luzes e partículas | ✅ 63 brilhos, 2 sistemas | ✅ | 🟡 2 brilhos, poeira DF86 → **DF209** | 🔶 neve e brilho de cristal por código → **GL59** |
| Fundo de arena do chefe | ✅ (Rainha em Verdâmia) | ✅ | 🟡 → **DF203** | 🔶 retângulo escuro → **GL53** |
| Prancha do universo (paleta e valores) | ✅ fichas oficiais | ✅ | 🟡 DF00 → **DF00 v2** | ✅ GL00 |

## Figuras e objetos

| Item | Laboratório | Verdâmia | Deserto | Nivária |
|---|---|---|---|---|
| Herói (ficha) | ✅ Daymon | ✅ Lince | 🟡 DF02 → **DF02 v2** (pedido aberto) | ✅ GL01 v2 |
| Herói (animações) | ✅ 7 + braço | ✅ | 🟡 DF90–DF97 → depois da DF02 v2 | 🔶 corpo do laboratório + cachecol por código → **GL10–GL14** |
| Inimigos (ficha) | ✅ | ✅ | 🟡 DF01 → **DF01 v2** (depois da DF02 v2) | ✅ GL02 v2 |
| Inimigos (animações) | ✅ | ✅ | 🟡 DF60–DF71 → depois da DF01 v2 | 🔶 recortes estáticos → **GL30–GL32** |
| Chefe | ✅ | ✅ Rainha Micélia | 🟡 DF03, DF100–DF112 → retoque **DF03 v2** | 🔶 frontal e poses ampliadas da GL03 → **GL100–GL102** |
| Perigos e máquinas | ✅ | ✅ | ✅/🟡 DF50–DF57 (ficam; ajuste na integração) | 🔶 recortes da GL04 → **GL70** |
| Objetos de interação e coletáveis | ✅ | ✅ | 🟡 placa, estação e célula do Laboratório → **DF210** | 🔶 recortes da GL04 → **GL71** |
| Portais (Arco, Fenda, Receptáculo) | ✅ PT10–PT23 | — | — | 🔶 glifo por código → **GL90** |

## Som

| Item | Laboratório | Verdâmia | Deserto | Nivária |
|---|---|---|---|---|
| Música | ✅ | ✅ | ✅ | ❌ (toca a do menu) |
| Efeitos próprios | ✅ | ✅ | ✅ | ❌ (usa os de outras fases) |

## Quantidades

- **Nivária:** 24 pedidos ([lote 2](../colaboracao/pedidos/GL_lote2_producao.md)): cenário GL50–GL59, Daymon GL10–GL14, inimigos GL30–GL32, objetos GL70–GL71, interface GL90 e Guardião GL100–GL102.
- **Deserto:** 13 pedidos de cena ([refação](../colaboracao/pedidos/DF_refacao_cena.md)), mais as fichas DF02 v2 e DF01 v2 ([pedido](../colaboracao/pedidos/DA02_regua_e_fichas_v2.md)) e, depois delas, as folhas do Autômato e dos inimigos.

## Ordem recomendada com o ChatGPT

Alternar os dois cenários: o cenário é o que mais separa as duas fases das de referência.

1. Ficha do Autômato (**DF02 v2**, já aberta) e paleta do Deserto (**DF00 v2**).
2. Terreno de Nivária (**GL55**) e terreno do Deserto (**DF205**).
3. Fundos: **GL50–GL51** e **DF200–DF202**.
4. Estrutura, decoração, moldura e primeiro plano: **GL54, GL56–GL58** e **DF204, DF206–DF208**.
5. Interiores e arenas: **GL52–GL53** e **DF203**.
6. Efeitos e objetos: **GL59, GL70, GL71** e **DF209, DF210**.
7. Figuras: Daymon de inverno, inimigos de Nivária, ficha **DF01 v2**, folhas do Autômato e dos inimigos do Deserto.
8. Chefes: **GL100–GL102** e **DF03 v2**.
