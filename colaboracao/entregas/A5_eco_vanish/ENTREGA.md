# A5_eco_vanish

Estado ENTREGUE para revisão técnica. Aprovado artisticamente por João Marcelo nesta sessão em 10/11/2026 com “aprovados, podemos seguir o commitar essas ai”. A4 previamente aceita para uso provisório.

## Arquivos

- A5_eco_vanish.png, PNG RGBA 1536 × 1024, grade 4 × 2 e células 384 × 512.
- SHA-256 681d525da35117a6948c1a131f3f45f20c00456ef281f881497ef609c668c32e.
- 1147936 bytes.
- A5_eco_vanish.gif, prévia sobre fundo cinza.

## Quadros

1. Quadro 1 original da A2.
2. Rachadura expandida.
3. Extremidades se desfazem.
4. Corpo parcialmente dissolvido.
5. Olho, rachadura e fragmentos.
6. Rachadura final e fragmentos.

## Verificação e ressalvas

Dimensões, RGBA e contagem de células conferidos. Células 7 e 8 totalmente transparentes. Revisar escala e registro anatômico entre quadros, halos semitransparentes e transições na Godot. Quadro 1 idêntico pixel a pixel à A2. Aprovação artística registrada, integração e testes de gameplay pendentes.

Arte gerada com referência às poses aprovadas A2/A3 e diretriz DA-01. PNGs publicados preservam os arquivos apresentados e aprovados.


## v2 (ciclo 2)

12/11/2026. ENTREGUE para revisao.

Quadros 2-4 reduzidos proporcionalmente com LANCZOS para 380-381 px, base y=393 e centro da caixa x=156. Quadro 5 reduzido a 80%, olho alinhado pela mediana dos pixels claros em y=88. Quadro 6 reduzido a 80%, rachadura ciano ancorada pela mediana em y=210. Quadros 7-8 vazios; quadro 1 preservado byte a byte em RGBA.

Nenhuma arte nova foi gerada; somente transformacoes dos quadros originais com Python, Pillow e LANCZOS. RGB de pixels totalmente transparentes zerado nos quadros transformados. Originais preservados e SHA-256 original reconferido. GIF existente continua sendo a previa da v1.

Arquivo: `A5_eco_vanish_v2.png`; PNG RGBA 1536 x 1024, grade 4 x 2, celulas 384 x 512.

SHA-256: `e96ffcaf8962001a195262367fe3e1884d54eb097096a325c5619d167e9fd453`.

### Medidas por quadro

Caixa de conteudo com alfa > 16, mesma convencao do check_art; limites superiores exclusivos. Inclui fragmentos/efeitos, nao segmentacao anatomica independente.

| Quadro | Altura (px) | Topo y | Base y | Largura (px) |
|---|---:|---:|---:|---:|
| 1 | 380 | 13 | 393 | 212 |
| 2 | 381 | 12 | 393 | 199 |
| 3 | 380 | 13 | 393 | 209 |
| 4 | 381 | 12 | 393 | 229 |
| 5 | 210 | 71 | 281 | 129 |
| 6 | 127 | 162 | 289 | 98 |
| 7 | vazio | - | - | - |
| 8 | vazio | - | - | - |
Continuidade: quadro 1 = A2 quadro 1; 0 pixels diferentes em 196608 pixels, diferenca maxima RGBA = 0.

### check_art

`python tools/fluxo/check_art.py colaboracao/entregas/A5_eco_vanish/A5_eco_vanish_v2.png --grid 4x2 --cell 384x512`

```text
arquivo: colaboracao/entregas/A5_eco_vanish/A5_eco_vanish_v2.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x50-262 y13-393
quadro 2: caixa x57-256 y12-393
quadro 3: caixa x52-261 y13-393
quadro 4: caixa x41-270 y12-393
quadro 5: caixa x115-244 y71-281
quadro 6: caixa x131-229 y162-289
quadro 7: vazio
quadro 8: vazio
OK
```

### Verificacao visual e ressalvas

Resultado final visualizado. Divergencia resolvida pela instrucao explicita do ciclo 2: quadro 4 mede 381 px com base y=393, em vez do fator 0,80 proposto na revisao para o corpo parcial. Isso conserva a altura total solicitada, mas deixa cabeca/tronco maiores que no quadro 3; requer julgamento do revisor sobre a transicao anatomica. Quadros 5-6 sao restos da dissolucao, nao figuras inteiras e nao devem medir 380 px.
