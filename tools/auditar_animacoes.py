"""Revisão geral: audita os quadros exportados por tools/exportar_quadros.gd (Laboratório, Verdâmia, Daymon,
Eco, efeitos) com o critério de tools/auditar_entregas_deserto.py:
- quadros iguais seguidos (diferença média < 0,5 nível) e animações paradas (todos os quadros iguais);
- pixels soltos: componentes opacos (alfa > 40) com 4 px ou mais e menos de 0,4 % do maior componente,
  sem contar os que estão a até 6 px do maior (detalhe colado ao corpo);
- corte na borda: desenho opaco encostado na borda do quadro (o desenho continua fora da célula);
- pés: linha mais baixa com desenho, para ver se a figura "pula" entre quadros (só animações de figura).
uso: python -I tools/auditar_animacoes.py /pasta_dos_quadros > relatorio.md
"""
import json
import sys
from collections import defaultdict
from pathlib import Path

import numpy as np
from PIL import Image
from scipy import ndimage

pasta = Path(sys.argv[1] if len(sys.argv) > 1 else "/tmp/quadros")
indice = json.loads((pasta / "indice.json").read_text())
grupos = defaultdict(list)
for q in indice:
    grupos[(q["tres"], q["anim"])].append(q)

print("# Auditoria das animações (Laboratório, Verdâmia, Daymon, efeitos)\n")
print("Gerado por `tools/exportar_quadros.gd` + `tools/auditar_animacoes.py`.\n")
print("| Recurso | Animação | Quadros | Iguais seguidos | Pixels soltos | Corte na borda | Pés (min–máx y) |")
print("|---|---|---|---|---|---|---|")
achados = []
for (tres, anim), qs in sorted(grupos.items()):
    qs.sort(key=lambda q: q["quadro"])
    imgs = [np.array(Image.open(pasta / q["arquivo"]).convert("RGBA")).astype(np.int16) for q in qs]
    iguais = []
    for i in range(1, len(imgs)):
        if imgs[i].shape == imgs[i - 1].shape and np.abs(imgs[i] - imgs[i - 1]).mean() < 0.5:
            iguais.append(f"{i - 1}={i}")
    parada = len(imgs) > 1 and len(iguais) == len(imgs) - 1
    soltos, cortes, pes = [], [], []
    for i, a in enumerate(imgs):
        alpha = a[:, :, 3] > 40
        if not alpha.any():
            continue
        lab, n = ndimage.label(alpha)
        if n > 1:
            sizes = ndimage.sum(np.ones_like(lab), lab, range(1, n + 1))
            big = int(np.argmax(sizes)) + 1
            perto = ndimage.binary_dilation(lab == big, iterations=6)
            for k, s in enumerate(sizes):
                if 4 <= s < sizes.max() * 0.004 and not (perto & (lab == k + 1)).any():
                    soltos.append(i)
                    break
        h, w = alpha.shape
        borda = alpha[0, :].sum() + alpha[-1, :].sum() + alpha[:, 0].sum() + alpha[:, -1].sum()
        if borda > 2:
            cortes.append(f"{i}({int(borda)})")
        pes.append(int(np.nonzero(alpha.any(axis=1))[0].max()))
    nome = tres.replace("res://assets/", "")
    pe = f"{min(pes)}–{max(pes)}" if pes else "-"
    flags = []
    if parada:
        flags.append("PARADA")
    print(f"| {nome} | {anim} | {len(imgs)} | {('**PARADA** ' if parada else '') + ', '.join(iguais) or '-'} | "
          f"{', '.join(map(str, sorted(set(soltos)))) or '-'} | {', '.join(cortes) or '-'} | {pe} |")
    if parada or soltos or cortes:
        achados.append((nome, anim, parada, iguais, sorted(set(soltos)), cortes))

print(f"\n{len(achados)} animação(ões) com achado, de {len(grupos)}.")
