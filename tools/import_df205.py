"""Importa o terreno DF205 (colaboracao/entregas/DF205/) para assets/deserto/terreno/.

As 22 peças são copiadas sem alteração, com uma exceção: nas peças repetíveis cuja coluna (ou linha) da
ponta veio com transparência menor que a vizinha, a cópia do jogo repete a vizinha na ponta. Sem isso,
as duas pontas desbotadas formam, na repetição, uma faixa de 2 px por onde o fundo aparece
(fosso_fundo, nas colunas, e coluna_trelica, nas linhas). A entrega original fica como está.
Desde 25/11/2026 usa a versão v2 aprovada (`<peça>_v2.png`) quando ela existe; o jogo continua lendo o
nome sem sufixo em assets/deserto/terreno/.
uso: python tools/import_df205.py
"""
from pathlib import Path
import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "colaboracao/entregas/DF205"
DST = ROOT / "assets/deserto/terreno"
PECAS = ["areia_chao", "areia_subsolo", "areia_borda", "areia_canto_esquerdo", "areia_canto_direito",
         "chapa_chao", "estrutura_subsolo", "chapa_borda", "chapa_canto_esquerdo", "chapa_canto_direito",
         "transicao_areia_estrutura", "teto_chapa", "teto_canto_esquerdo", "teto_canto_direito", "verga_porta",
         "passarela_ponta_esquerda", "passarela_meio", "passarela_ponta_direita", "tirante", "fixacao",
         "coluna_trelica", "fosso_fundo"]
# só onde a faixa aparece no jogo (conferido com tools/df205_encaixes.gd); nas bordas de areia e de chapa a
# transparência menor das pontas é o próprio recorte da rocha e trocá-la criaria um degrau na emenda
REPETE_H = ["fosso_fundo"]
REPETE_V = ["coluna_trelica"]
LIMIAR = 0.95     # coluna (ou linha) com alpha médio abaixo de 95% do interior conta como desbotada
REF = 8           # o interior de referência fica a 8 px da ponta


def _fix(a: np.ndarray, axis: int) -> list:
    """Nas duas pontas do eixo, troca as fileiras desbotadas (até 6) pela primeira íntegra. Devolve o que trocou."""
    view = a if axis == 0 else a.transpose(1, 0, 2)   # fileiras = linhas (axis 0) ou colunas (axis 1)
    n = view.shape[0]
    out = []
    for sign in (1, -1):
        start = 0 if sign > 0 else n - 1
        ref = view[start + sign * REF, :, 3].mean()
        k = 0
        while k < 6 and view[start + sign * k, :, 3].mean() < LIMIAR * ref:
            k += 1
        if k:
            good = view[start + sign * k].copy()
            for j in range(k):
                view[start + sign * j] = good
            idx = sorted(start + sign * j for j in range(k))
            out.append(f"{idx[0]}–{idx[-1]}")
    return out


def main() -> None:
    DST.mkdir(parents=True, exist_ok=True)
    for n in PECAS:
        src = SRC / f"{n}_v2.png"
        if not src.exists():
            src = SRC / f"{n}.png"
        a = np.asarray(Image.open(src).convert("RGBA")).copy()
        fixes = []
        if n in REPETE_H:
            fixes += [f"colunas {c}" for c in _fix(a, axis=1)]
        if n in REPETE_V:
            fixes += [f"linhas {c}" for c in _fix(a, axis=0)]
        Image.fromarray(a).save(DST / f"{n}.png")
        print(f"{src.name:34s} {'ponta refeita: ' + ', '.join(fixes) if fixes else 'cópia fiel'}")


if __name__ == "__main__":
    main()
