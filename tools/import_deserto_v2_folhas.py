"""Importa as folhas v2 do Deserto (pacotes 11–20, aprovadas em 25/11/2026) para assets/deserto/, sem tocar nos originais.

uso: python tools/import_deserto_v2_folhas.py

- Robô e Drone (DF60–DF71, DF64b, DF69b, DF69c), efeitos (DF80–DF85), Autômato (DF87–DF99), Forja-Mãe
  (DF100–DF112) e objetos do Deserto (DF210): meia resolução (0,5) em webp sem perdas, com o mesmo nome que o
  jogo já usa (DFxx.webp). A grade das folhas é a mesma da v1 (4 × 2 de 384 × 512, ou a do pedido), então o
  recorte por grade fixa não muda; âncoras e escala ficam no código (DFArt.K = 0,214, nó a 0,428).
- Peças das máquinas (DF222–DF225): cópia byte a byte para assets/deserto/v2/ (2×, escala 0,5 no jogo).
- O SHA-256 é conferido contra o ENTREGA_v2 quando ele traz o valor; sem valor, o script avisa.
- Sempre o arquivo _v2 quando existe; DF64b e DF69c só chegaram com o nome sem sufixo.
- Forja-Mãe (DF100–DF108, DF110–DF112): a v3 (main ef2d879, 26/11/2026), com o nome completo `_v3.png`
  (o import_fase2.py antigo pega o primeiro PNG com o prefixo e não serve para a Forja). A redução a 50 %
  dá o mesmo resultado que os *_jogo_v3.webp da entrega (conferido por tools/auditar_forja_v3.py).
"""
import hashlib
import re
import shutil
from pathlib import Path

from PIL import Image

import sys
sys.path.insert(0, str(Path(__file__).resolve().parent))
from tratar_arte_revisao import tratar

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "colaboracao/entregas"
OUT = ROOT / "assets/deserto"
V2 = OUT / "v2"

FOLHAS = {
    "DF60": "DF60_robo_idle_v2.png", "DF61": "DF61_robo_andar_v2.png", "DF62": "DF62_robo_aviso_v2.png",
    "DF63": "DF63_robo_tiro_v2.png", "DF64": "DF64_robo_dano_v2.png", "DF64b": "DF64b_robo_paralisado.png",
    "DF65": "DF65_robo_destruido_v2.png", "DF66": "DF66_drone_voo_v2.png", "DF67": "DF67_drone_aviso_v2.png",
    "DF68": "DF68_drone_tiro_v2.png", "DF69": "DF69_drone_dano_v2.png", "DF69b": "DF69b_drone_destruido_v2.png",
    "DF69c": "DF69c_drone_derrubado.png", "DF70": "DF70_projetil_robo_v2.png", "DF71": "DF71_projetil_drone_v2.png",
    "DF80": "DF80_fumaca_chamine_v2.png", "DF81": "DF81_jato_vapor_v2.png", "DF82": "DF82_faiscas_prensa_v2.png",
    "DF83": "DF83_poeira_areia_v2.png", "DF84": "DF84_explosao_maquina_v2.png", "DF85": "DF85_impacto_projetil_v2.png",
    "DF87": "DF87_rebite_v2.png", "DF88": "DF88_disparo_rebite_v2.png", "DF90": "DF90_automato_parado_v2.png",
    "DF91": "DF91_automato_andar_v2.png", "DF92": "DF92_automato_pulo_v2.png", "DF93": "DF93_automato_queda_v2.png",
    "DF94": "DF94_automato_arranque_v2.png", "DF95": "DF95_automato_dano_v2.png",
    "DF96": "DF96_automato_derrota_v2.png", "DF97": "DF97_automato_braco_v2.png", "DF98": "DF98_feixe_ima_v2.png",
    "DF99": "DF99_pulso_magnetico_v2.png",
    "DF100": "DF100_forja_corpo_v3.png", "DF101": "DF101_forja_lente_v3.png", "DF102": "DF102_forja_peito_v3.png",
    "DF103": "DF103_forja_carrinho_v3.png", "DF104": "DF104_forja_segmento_v3.png",
    "DF105": "DF105_forja_martelo_v3.png", "DF106": "DF106_forja_nucleo_pistao_v3.png",
    "DF107": "DF107_forja_escotilha_v3.png", "DF108": "DF108_forja_grade_v3.png", "DF110": "DF110_forja_feixe_v3.png",
    "DF111": "DF111_forja_carga_lente_v3.png", "DF112": "DF112_forja_explosao_nucleo_v3.png",
}
OBJETOS = {"DF210_objetos": ("DF210", "DF210_objetos.png"), "DF210_coletaveis": ("DF210", "DF210_coletaveis.png"),
           # a ponta da DF98 v2 é um ímã pequeno, não a garra de luz: o jogo usa a ponta da v1 até a correção
           "DF98_v1": ("DF98", "DF98_feixe_ima.png")}
PECAS = {
    "DF222": ["DF26_esteira_v2.png", "DF26b_esteira_ponta_esq_v2.png", "DF26c_esteira_ponta_dir_v2.png",
              "DF27_trilho_vertical_v2.png", "DF55b_trilho_horizontal_v2.png"],
    "DF223": ["DF50a_prensa_cabeca_v2.png", "DF50b_prensa_haste_v2.png", "DF50c_prensa_suporte_v2.png",
              "DF51a_prensa_pequena_cabeca_v2.png", "DF51b_prensa_pequena_haste_v2.png",
              "DF51c_prensa_pequena_suporte_v2.png", "DF52_serra_v2.png", "DF52b_serra_base_v2.png"],
    "DF224": ["DF54_elevador_v2.png", "DF55_carrinho_v2.png", "DF56_valvula_aviso_v2.png",
              "DF56_valvula_inativa_v2.png", "DF57_ponto_gancho_v2.png"],
    "DF225": ["DF38_porta_aberta_v2.png", "DF38_porta_fechada_v2.png"],
}


def manifesto(pasta: Path) -> dict:
    out = {}
    for md in pasta.glob("ENTREGA*.md"):
        t = md.read_text(encoding="utf-8")
        for h, f in re.findall(r"([0-9a-f]{64})\s+`?([\w.\-]+\.(?:png|gif))`?", t):
            out[f] = h
        for f, h in re.findall(r"`([\w.\-]+\.(?:png|gif))`\s+[—·]\s+`([0-9a-f]{64})`", t):
            out[f] = h
    return out


def confere(pasta: str, nome: str) -> Path:
    p = SRC / pasta / nome
    esperado = manifesto(SRC / pasta).get(nome)
    h = hashlib.sha256(p.read_bytes()).hexdigest()
    if esperado is None:
        print(f"  aviso: {pasta}/{nome} sem SHA no ENTREGA (recebido {h[:12]}…)")
    elif esperado != h:
        raise SystemExit(f"SHA diferente em {pasta}/{nome}: {h} ≠ {esperado}")
    return p


def meia(p: Path, destino: Path, code: str = "") -> None:
    img = tratar(code, Image.open(p).convert("RGBA"))     # tratamentos sem desenho (tools/tratar_arte_revisao.py)
    img = img.resize((img.width // 2, img.height // 2), Image.Resampling.LANCZOS)
    img.save(destino, lossless=True, method=5)
    print(destino.relative_to(ROOT), img.size)


for code, nome in FOLHAS.items():
    meia(confere(code, nome), OUT / f"{code}.webp", code)
for dest, (pasta, nome) in OBJETOS.items():
    meia(confere(pasta, nome), OUT / f"{dest}.webp")
V2.mkdir(exist_ok=True)
for pasta, nomes in PECAS.items():
    for nome in nomes:
        shutil.copyfile(confere(pasta, nome), V2 / nome)
        print(f"assets/deserto/v2/{nome} (cópia)")
