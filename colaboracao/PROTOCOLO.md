# Protocolo de colaboração: Desenvolvimento (Claude) × Arte (ChatGPT)

Toda a comunicação entre os dois agentes acontece **dentro deste repositório**. O João Marcelo só passa um prompt curto avisando que há algo novo. Ninguém precisa copiar relatórios de um agente para o outro.

## Papéis

| Quem | Responsável por |
|---|---|
| **Claude (desenvolvedor-chefe)** | Código, fases, mecânicas, testes, builds, integração dos assets, `HANDOFF.md`, `ROTEIRO.md`, `LEIA-ME.md` |
| **ChatGPT (diretor de arte)** | Toda a arte: fichas de personagem, spritesheets, objetos de cenário, efeitos, UI e ilustrações |
| **João Marcelo** | Decisões finais e avisos de "tem novidade" entre os dois. Também sobe os arquivos se algum agente não conseguir gravar no GitHub |

## Pastas

```
colaboracao/
  PROTOCOLO.md            este arquivo (regras)
  STATUS.md               quadro com todos os pedidos e o estado de cada um
  pedidos/<ID>.md         pedidos de arte escritos pelo Claude
  entregas/<ID>/          imagens + ENTREGA.md, colocados pelo ChatGPT
  revisoes/<ID>.md        resultado da verificação feita pelo Claude (aprovado / ajustes)
```

O `<ID>` segue o guia de assets (`docs/GUIA_PROXIMOS_PASSOS_E_ASSETS.md`), por exemplo `A0_ficha_eco` ou `A1_eco_appear`.

## Fluxo

1. **Claude cria o pedido** em `pedidos/<ID>.md`, com a especificação técnica completa e as referências a usar. O pedido entra no `STATUS.md` como `ABERTO`.
2. **ChatGPT lê** `PROTOCOLO.md`, `STATUS.md` e os pedidos em `ABERTO`. Depois gera a arte.
3. **ChatGPT entrega** em `entregas/<ID>/`:
   - as imagens, com os nomes de arquivo definidos no pedido;
   - um `ENTREGA.md` com a lista dos quadros (o que há em cada um), as decisões tomadas e qualquer regra que não conseguiu cumprir.

   Em seguida, muda o estado no `STATUS.md` para `ENTREGUE`.
4. **Claude verifica** as entregas. Confere tamanho, grade, fundo, linha dos pés, se algum quadro invade a célula vizinha e se o design bate com as fichas. Depois escreve o resultado em `revisoes/<ID>.md`:
   - se a arte estiver certa, marca `APROVADO`, integra no jogo e põe capturas do resultado na revisão;
   - se precisar de correção, marca `AJUSTE`, lista exatamente o que refazer (quadro, problema e como corrigir) e devolve o pedido ao estado `ABERTO`.
5. Repetir até tudo estar aprovado.

**Estados possíveis:** `ABERTO` → `ENTREGUE` → `APROVADO` (ou `AJUSTE`, que volta para `ABERTO`). Há também `INTEGRADO`, quando a arte já está rodando no jogo.

## Regras para o ChatGPT

- **Nunca altere** arquivos fora de `colaboracao/entregas/` e da coluna de estado do `STATUS.md`. Código, assets do jogo e documentos são do Claude.
- Não apague nem sobrescreva entregas anteriores. Versões novas recebem o sufixo `_v2`, `_v3` e assim por diante.
- Siga as regras técnicas do pedido à risca, porque o recorte é automático. Se não for possível cumprir alguma, escreva isso no `ENTREGA.md` em vez de improvisar.
- **Diretriz de estilo obrigatória:** `colaboracao/entregas/00_padrao_visual/PADRAO_VISUAL_OFICIAL.md` (DA-01). Ela prevalece sobre qualquer descrição de estilo em pedidos ou guias.
- As referências oficiais estão em `arte_original/00_Referencias_oficiais/`. Fichas aprovadas viram referência também e são copiadas para `arte_original/referencias_aprovadas/`.
- Só suba um asset depois da **aprovação explícita do João Marcelo** (passo 6 da DA-01).

## Regras para o Claude

- Todo pedido deve seguir a DA-01 e citá-la.
- Todo pedido precisa ser autossuficiente. Ele traz o tamanho, a grade, o fundo, os quadros, o apoio, as referências e o nome dos arquivos.
- Revisões devem ser objetivas e verificáveis, por exemplo "quadro 5: pé 18 px acima da linha" em vez de "está estranho".
- Ao integrar um asset, atualize `arte_original/USADAS_NO_JOGO.md` e marque `INTEGRADO`.

## Commits

Cada agente começa a mensagem de commit pelo papel:
- `[arte] A0 ficha do Eco entregue`
- `[dev] revisão A0: aprovado`
