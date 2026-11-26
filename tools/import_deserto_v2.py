"""Importa a arte v2 aprovada do Deserto (pacotes 3–10) de colaboracao/entregas/ para assets/deserto/.

Os PNGs de produção são copiados byte a byte (o SHA-256 de cada um é conferido contra o ENTREGA quando ele
traz o valor). Recorte, âncora e escala ficam no código (scripts/desert.gd, scripts/df_v2.gd).
Exceção: DF200_ceu_diurno.png chegou corrompido na main (o 6º bloco IDAT tem CRC inválido; só as linhas
0–579 decodificam). Enquanto a entrega não é refeita, o jogo usa uma recomposição: as linhas 0–579 do
arquivo entregue e, abaixo, a fonte dele, DF10_fundo_ceu.png a 1,25 com 53 px de deslocamento (diferença
média de 1 nível de cor nas linhas que as duas têm em comum).
O terreno DF205 v2 é importado por tools/import_df205.py (mesmos nomes do jogo, sem o sufixo _v2).
uso: python tools/import_deserto_v2.py
"""
import hashlib
import re
import shutil
import struct
import zlib
from pathlib import Path

import numpy as np
from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "colaboracao/entregas"
FUNDO = ROOT / "assets/deserto/fundo"
V2 = ROOT / "assets/deserto/v2"

# (entrega, arquivo, destino)
COPIAS = [
    ("DF201", "DF201_distante_v2.png", FUNDO), ("DF201", "DF201_proximo_v2.png", FUNDO),
    ("DF202", "DF202_fabrica.png", FUNDO), ("DF202", "DF202_salao.png", FUNDO),
    ("DF203", "DF203_camara.png", FUNDO),
    ("DF204", "DF204_estrutura.png", V2),
    ("DF206", "DF206_media.png", V2), ("DF206", "DF206_pequena.png", V2),
    ("DF207", "DF207_moldura.png", V2),
    ("DF208", "DF208_primeiro_plano.png", V2), ("DF208", "DF208_primeiro_plano_interior.png", V2),
    ("DF209", "DF209_poeira.png", V2), ("DF209", "DF209_faiscas.png", V2), ("DF209", "DF209_vapor.png", V2),
    ("DF209", "DF209_brilho_lampada.png", V2),
    ("DF220", "DF31_mastro_viga_v2.png", V2), ("DF220", "DF32_chamine_v2.png", V2),
    ("DF220", "DF33_porta_fabrica_v2.png", V2), ("DF220", "DF34_engrenagem_fundo_v2.png", V2),
    ("DF220", "DF35_abertura_parede_v2.png", V2), ("DF220", "DF36_torre_nucleo_v2.png", V2),
    ("DF221", "DF37_lampada_v2.png", V2), ("DF221", "DF37b_lampada_apagada_v2.png", V2),
    ("DF221", "DF39_painel_v2.png", V2), ("DF221", "DF39b_canos_v2.png", V2), ("DF221", "DF28_cabo_v2.png", V2),
]


def manifesto(pasta: Path) -> dict:
    out = {}
    for md in pasta.glob("ENTREGA*.md"):
        t = md.read_text(encoding="utf-8")
        for h, f in re.findall(r"([0-9a-f]{64})\s+`?([\w.\-]+\.(?:png|gif))`?", t):
            out[f] = h
        for f, h in re.findall(r"`([\w.\-]+\.(?:png|gif))`\s+—\s+`([0-9a-f]{64})`", t):
            out[f] = h
    return out


def sha(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()


def linhas_validas(p: Path) -> np.ndarray:
    """Decodifica um PNG RGB 8 bits até onde os dados comprimidos permitem."""
    d = p.read_bytes()
    pos, idat, ihdr = 8, b"", None
    while pos < len(d):
        ln = struct.unpack(">I", d[pos:pos + 4])[0]
        tipo = d[pos + 4:pos + 8]
        if tipo == b"IHDR":
            ihdr = d[pos + 8:pos + 8 + ln]
        elif tipo == b"IDAT":
            idat += d[pos + 8:pos + 8 + ln]
        elif tipo not in (b"sRGB", b"gAMA", b"pHYs", b"tEXt", b"iTXt", b"cHRM"):
            break
        pos += 12 + ln
    w, h, bd, ct = struct.unpack(">IIBB", ihdr[:10])
    assert bd == 8 and ct == 2, "esperado RGB 8 bits"
    dec, raw = zlib.decompressobj(), b""
    for i in range(0, len(idat), 256):
        try:
            raw += dec.decompress(idat[i:i + 256])
        except zlib.error:
            break
    stride = w * 3 + 1
    n = len(raw) // stride
    out = np.zeros((n, w * 3), np.int32)
    prev = np.zeros(w * 3, np.int32)
    for r in range(n):
        f = raw[r * stride]
        ln = np.frombuffer(raw[r * stride + 1:(r + 1) * stride], np.uint8).astype(np.int32)
        cur = np.zeros(w * 3, np.int32)
        if f == 0:
            cur = ln
        elif f == 2:
            cur = (ln + prev) & 255
        else:
            for x in range(w * 3):
                a = cur[x - 3] if x >= 3 else 0
                b = prev[x]
                c = prev[x - 3] if x >= 3 else 0
                if f == 1:
                    cur[x] = (ln[x] + a) & 255
                elif f == 3:
                    cur[x] = (ln[x] + ((a + b) >> 1)) & 255
                else:
                    pa, pb, pc = abs(b - c), abs(a - c), abs(a + b - 2 * c)
                    cur[x] = (ln[x] + (a if pa <= pb and pa <= pc else (b if pb <= pc else c))) & 255
        out[r] = cur
        prev = cur
    return out.reshape(n, w, 3).astype(np.uint8)


def ceu_diurno() -> None:
    src = SRC / "DF200/DF200_ceu_diurno.png"
    dst = FUNDO / "DF200_ceu_diurno.png"
    try:
        Image.open(src).load()
        shutil.copyfile(src, dst)
        print("DF200_ceu_diurno.png        cópia fiel")
        return
    except Exception:
        pass
    topo = linhas_validas(src)
    fonte = np.asarray(Image.open(SRC / "DF10/DF10_fundo_ceu.png").convert("RGB")
                      .resize((2560, 1280), Image.Resampling.LANCZOS))
    desloc = 53
    out = np.zeros((1440, 2560, 3), np.uint8)
    out[desloc:desloc + 1280] = fonte
    out[:desloc] = fonte[0]
    out[desloc + 1280:] = fonte[-1]
    out[:len(topo)] = topo
    Image.fromarray(out).save(dst)
    print(f"DF200_ceu_diurno.png        RECOMPOSTO: entrega corrompida, linhas 0–{len(topo) - 1} originais")


def main() -> None:
    FUNDO.mkdir(parents=True, exist_ok=True)
    V2.mkdir(parents=True, exist_ok=True)
    cache = {}
    for pasta, nome, dst in COPIAS:
        src = SRC / pasta / nome
        man = cache.setdefault(pasta, manifesto(SRC / pasta))
        h = sha(src)
        conf = "SHA ok" if man.get(nome) == h else ("SHA DIFERENTE" if nome in man else "sem SHA no ENTREGA")
        assert conf != "SHA DIFERENTE", f"{pasta}/{nome}: SHA-256 não confere"
        shutil.copyfile(src, dst / nome)
        print(f"{nome:36s} {conf}")
    ceu_diurno()


if __name__ == "__main__":
    main()
