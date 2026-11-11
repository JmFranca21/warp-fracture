"""Inspeciona originais sem editar ou recomprimir imagens."""
from pathlib import Path
import hashlib
import json
import re
import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parent
tasks = json.loads((ROOT / 'PROMPTS.json').read_text())
rows = []
for task in tasks:
    path = ROOT / (task['id'] + '.png')
    original = path
    versions = sorted(ROOT.glob(task['id'] + '_v[0-9]*.png'), key=lambda p: int(p.stem.rsplit('_v', 1)[1]))
    if versions:
        path = versions[-1]
    row = {'id': task['id'], 'arquivo': path.name, 'gerado': path.exists()}
    if path != original:
        row['original_preservado'] = original.name
    if not path.exists():
        rows.append(row)
        continue
    im = Image.open(path)
    row.update(tamanho=list(im.size), modo=im.mode, bytes=path.stat().st_size,
               sha256=hashlib.sha256(path.read_bytes()).hexdigest())
    alpha = np.array(im.getchannel('A')) if im.mode == 'RGBA' else np.full((im.height, im.width), 255, dtype=np.uint8)
    row['alpha_min_max'] = [int(alpha.min()), int(alpha.max())]
    row['fracao_transparente'] = round(float(np.mean(alpha == 0)), 5)
    row['exige_alpha'] = task['transparent']
    row['alpha_presente'] = bool(alpha.min() < 255)
    row['avisos'] = []
    if task['transparent'] and not row['alpha_presente']:
        row['avisos'].append('Sem transparencia real; corrigir antes de integrar.')
    animation = task['id'].startswith(('D_lince_', 'E_esporangio_', 'E_mariposa_', 'E_rainha_', 'VD_fx_'))
    if animation:
        cols, nr = (2, 1) if task['id'].startswith('E_rainha_') else (4, 2)
        cw, ch = im.width // cols, im.height // nr
        row['grade'] = [cols, nr]
        row['celulas'] = []
        for y in range(nr):
            for x in range(cols):
                mask = alpha[y*ch:(y+1)*ch, x*cw:(x+1)*cw] > 64
                yy, xx = np.where(mask)
                cell = {'quadro': y*cols+x+1, 'pixels_alpha_maior_64': int(mask.sum())}
                if len(xx):
                    box = [int(xx.min()), int(yy.min()), int(xx.max()+1), int(yy.max()+1)]
                    cell['bbox_local'] = box
                    cell['base_visual_local'] = box[3]
                    if box[0] == 0 or box[1] == 0 or box[2] == cw or box[3] == ch:
                        row['avisos'].append(f'Quadro {cell["quadro"]}: desenho toca borda; revisar recorte.')
                row['celulas'].append(cell)
        if im.size != (1536, 1024):
            row['avisos'].append('Dimensao da folha difere de 1536x1024.')
        expected = 2 if cols == 2 else None
        if cols == 4:
            match = re.search(r'(\d+) (?:frames|distinct sequential frames)', task['prompt'])
            if match:
                expected = int(match.group(1))
            if task['id'].startswith('E_mariposa_'):
                expected = 6
        row['quadros_previstos'] = expected
        if expected:
            for cell in row['celulas'][expected:]:
                if cell['pixels_alpha_maior_64'] > 64:
                    row['avisos'].append(f'Celula excedente {cell["quadro"]} contem pixels: verificar vazamento.')
        row['observacao'] = 'Bboxes medidos nao provam continuidade, anatomia, apoio ou quantidade correta de poses. Revisao visual e teste em Godot pendentes.'
    rows.append(row)
(ROOT / 'MANIFESTO.json').write_text(json.dumps(rows, ensure_ascii=False, indent=2) + '\n')
all_files = []
for path in sorted(ROOT.glob('*.png')):
    all_files.append({'arquivo': path.name, 'bytes': path.stat().st_size, 'sha256': hashlib.sha256(path.read_bytes()).hexdigest()})
(ROOT / 'SHA256_ORIGINAIS.json').write_text(json.dumps(all_files, ensure_ascii=False, indent=2) + '\n')
generated = sum(r['gerado'] for r in rows)
print(f'{generated}/{len(rows)} originais presentes')
for row in rows:
    if row.get('avisos'):
        print(row['id'] + ': ' + '; '.join(row['avisos']))
