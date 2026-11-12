# A1_eco_appear

Estado ENTREGUE para revisão técnica. Aprovado artisticamente por João Marcelo nesta sessão em 10/11/2026 com “aprovados, podemos seguir o commitar essas ai”. A4 previamente aceita para uso provisório.

## Arquivos

- A1_eco_appear.png, PNG RGBA 1536 × 1024, grade 4 × 2 e células 384 × 512.
- SHA-256 447eb8b26a9be5d499e3899d088b54fca46fcde258bbb68b4f663383b231c039.
- 1576776 bytes.
- A1_eco_appear.gif, prévia sobre fundo cinza.

## Quadros

1. Rachadura inicial e fragmentos.
2. Rachadura cresce e fragmentos se reúnem.
3. Silhueta escura.
4. Preenchimento inferior.
5. Corpo formado e jaleco incompleto.
6. Jaleco formado e olho aceso.
7. Assentamento.
8. Quadro 1 original da A2.

## Verificação e ressalvas

Dimensões, RGBA e contagem de células conferidos. Revisar escala e registro anatômico entre quadros, halos semitransparentes e transições na Godot. Quadro 8 idêntico pixel a pixel à A2. A contração do quadro 7 é discreta. Aprovação artística registrada, integração e testes de gameplay pendentes.

Arte gerada com referência às poses aprovadas A2/A3 e diretriz DA-01. PNGs publicados preservam os arquivos apresentados e aprovados.


## v2 (ciclo 2)

12/11/2026. ENTREGUE para revisao.

Quadros 3-7 reduzidos proporcionalmente com LANCZOS para 380-381 px, base y=393 e centro da caixa x=156, correspondente ao quadro de referencia. Quadros 1-2 transladados +43/+32 px: mediana vertical da rachadura ciano em y=210. Quadro 8 preservado byte a byte em RGBA.

Nenhuma arte nova foi gerada; somente transformacoes dos quadros originais com Python, Pillow e LANCZOS. RGB de pixels totalmente transparentes zerado nos quadros transformados. Originais preservados e SHA-256 original reconferido. GIF existente continua sendo a previa da v1.

Arquivo: `A1_eco_appear_v2.png`; PNG RGBA 1536 x 1024, grade 4 x 2, celulas 384 x 512.

SHA-256: `5e89cd5234a132003489d188e6bca4b0e266f74c25559e378ab5be2c718e22f2`.

### Medidas por quadro

Caixa de conteudo com alfa > 16, mesma convencao do check_art; limites superiores exclusivos. Inclui fragmentos/efeitos, nao segmentacao anatomica independente.

| Quadro | Altura (px) | Topo y | Base y | Largura (px) |
|---|---:|---:|---:|---:|
| 1 | 286 | 103 | 389 | 124 |
| 2 | 304 | 88 | 392 | 146 |
| 3 | 380 | 13 | 393 | 186 |
| 4 | 381 | 12 | 393 | 183 |
| 5 | 380 | 13 | 393 | 185 |
| 6 | 381 | 12 | 393 | 204 |
| 7 | 380 | 13 | 393 | 198 |
| 8 | 380 | 13 | 393 | 212 |
Continuidade: quadro 8 = A2 quadro 1; 0 pixels diferentes em 196608 pixels, diferenca maxima RGBA = 0.

### check_art

`python tools/fluxo/check_art.py colaboracao/entregas/A1_eco_appear/A1_eco_appear_v2.png --grid 4x2 --cell 384x512`

```text
arquivo: colaboracao/entregas/A1_eco_appear/A1_eco_appear_v2.png
tamanho: 1536x1024  modo: RGBA
alfa: min 0 max 255
quadro 1: caixa x105-229 y103-389
quadro 2: caixa x60-206 y88-392
quadro 3: caixa x63-249 y13-393
quadro 4: caixa x64-247 y12-393
quadro 5: caixa x64-249 y13-393
quadro 6: caixa x54-258 y12-393
quadro 7: caixa x57-255 y13-393
quadro 8: caixa x50-262 y13-393
OK
```

### Verificacao visual e ressalvas

Resultado final visualizado. A rachadura dos quadros 1-2 foi ancorada pelo nucleo ciano; a caixa inclui os fragmentos, portanto sua base nao representa a altura do peito.
