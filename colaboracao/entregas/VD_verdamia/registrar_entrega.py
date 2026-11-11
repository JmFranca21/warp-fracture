"""Atualiza documentacao do lote a partir dos arquivos efetivamente presentes."""
from pathlib import Path
import json
import runpy

ROOT = Path(__file__).resolve().parent
runpy.run_path(str(ROOT / 'verificar_assets.py'))
rows = json.loads((ROOT / 'MANIFESTO.json').read_text())
present = [r for r in rows if r['gerado']]
warnings = [(r['id'], r['avisos']) for r in present if r.get('avisos')]
text = f'''# Verdâmia — entrega de arte

**Produção:** {len(present)}/{len(rows)} imagens presentes neste commit.
**Estado:** assets originais gerados; integração na Godot e revisão final do responsável pendentes.

O responsável solicitou produzir todos os assets, incluindo a elaboração das especificações que faltavam, e manter commits ao longo da produção. A direção segue a DA-01 e os pacotes D/E do guia. As extensões do inventário cobrem elementos já usados pelo mapa e pelo código, sem introduzir novas mecânicas.

## Arquivos de apoio

- `ESPECIFICACOES.md`: escopo, paleta, dimensões, grade e continuidade.
- `PROMPTS.json`: instruções de produção por imagem e referências utilizadas.
- `MANIFESTO.json`: tamanho real, alpha, bytes, SHA-256 e bboxes por célula; não é certificado de qualidade estética.
- `SHA256_ORIGINAIS.json`: hashes de todos os PNGs, incluindo versões preservadas. O manifesto principal seleciona a versão mais recente de cada asset.
- `verificar_assets.py` e `registrar_entrega.py`: inspeção sem modificar as imagens e atualização desta lista.

## Uso e limites

As três pranchas de referência têm fundo escuro de propósito. Sprites, objetos e efeitos são entregues em PNG com alpha; o fundo distante e o preenchimento de subsolo são opacos de propósito. O original não foi recomprimido nem editado por script.

As dimensões solicitadas não garantem alinhamento exato dos desenhos dentro da grade. Conferir os bboxes e avisos antes de usar o importador automático. É necessário calibrar origem, escala, duração, hitboxes e apoios no motor. Não marcar INTEGRADO nem substituir assets existentes antes dessa revisão. Folhas com vazamento ou células extras precisam de correção ou atlas com recorte específico por quadro; não usar cegamente a grade padrão.

A Rainha usa 16 folhas 2×1; raízes, esporos e invocação são peças separadas. A animação de esporos atende chuva e rajada; rugido atende invocação e enfurecimento. Itens de cura, energia, células e tablets mantêm os assets existentes do jogo.

## Inventário deste commit

| Asset | Arquivo | Dimensão real | Alpha | Revisão técnica |
|---|---|---|---|---|
'''
for row in rows:
    if not row['gerado']:
        text += f'| {row["id"]} | — | — | — | Ainda em produção |\n'
        continue
    alpha = 'sim' if row['alpha_presente'] else 'opaco'
    state = 'Revisar avisos' if row['avisos'] else 'Sem alerta automático; revisão visual necessária'
    text += f'| {row["id"]} | [{row["arquivo"]}]({row["arquivo"]}) | {row["tamanho"][0]}×{row["tamanho"][1]} | {alpha} | {state} |\n'
text += '\n## Alertas de enquadramento\n\n'
if warnings:
    for ident, notes in warnings:
        text += f'- **{ident}**: ' + '; '.join(notes) + '\n'
else:
    text += 'Nenhum alerta automático nos arquivos presentes. Isso não substitui a inspeção visual ou os testes em jogo.\n'
(ROOT / 'ENTREGA.md').write_text(text)
print('ENTREGA.md atualizado')
