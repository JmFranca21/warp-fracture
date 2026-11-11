"""Atualiza documentacao do lote a partir dos arquivos efetivamente presentes."""
from pathlib import Path
import json
import runpy
import html

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

Alguns objetos foram gerados em canvas nativo maior ou mais largo que o 1024×1024 solicitado. As dimensões reais e os bboxes estão no manifesto; preservar estes originais e preparar a escala e a origem a partir dessas medidas. Esses arquivos não devem ser tratados como exports de tamanho padronizado já prontos para um importador que assuma 1024×1024.

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
cards = []
for row in present:
    label = html.escape(row['id'])
    name = html.escape(row['arquivo'], quote=True)
    note = ' · revisar enquadramento' if row['avisos'] else ''
    cards.append(f'<article><a href="{name}" target="_blank"><img src="{name}" alt="{label}" loading="lazy"></a><h2>{label}</h2><p>{row["tamanho"][0]} × {row["tamanho"][1]}{note}</p></article>')
gallery = '''<!doctype html><html lang="pt-BR"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Verdâmia — galeria de assets</title><style>
*{box-sizing:border-box}body{margin:0;background:#0a1716;color:#e6eeda;font:16px system-ui,sans-serif}header{padding:40px 5vw 24px;border-bottom:1px solid #29443d}h1{font-size:clamp(28px,5vw,50px);margin:8px 0;color:#c5ed70}header p{max-width:800px;line-height:1.6;color:#b5c9c1}button{background:#1d5248;color:white;border:1px solid #5c8a79;border-radius:8px;padding:10px 16px;cursor:pointer}main{padding:30px 5vw;display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:22px}article{border:1px solid #29443d;border-radius:12px;overflow:hidden;background:#10221f}img{width:100%;height:250px;object-fit:contain;display:block;background:var(--preview,#142622)}h2{font-size:15px;margin:16px 16px 4px;overflow-wrap:anywhere}article p{font-size:13px;color:#adc4ba;margin:0 16px 18px}a{color:#39e6ff}.light{--preview:#eee}footer{padding:24px 5vw;color:#adc4ba}
</style><header><p>WARP FRACTURE · DIREÇÃO DE ARTE</p><h1>Verdâmia</h1><p>Galeria dos PNGs originais selecionados. Clique numa imagem para abrir em tamanho completo. As versões anteriores estão preservadas na pasta. As artes ainda precisam de integração e revisão no jogo.</p><button onclick="document.body.classList.toggle('light')">Alternar fundo claro / escuro</button></header><main>'''
gallery += '\n'.join(cards) + '</main><footer>Referências, animações, cenário e efeitos · Consulte ENTREGA.md e MANIFESTO.json para especificações e alertas.</footer></html>'
(ROOT / 'GALERIA.html').write_text(gallery)
print('ENTREGA.md atualizado')
