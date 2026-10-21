"""Gera todos os efeitos sonoros (WAV) e músicas (OGG) do Warp Fracture por síntese.
Sem amostras externas: tudo é oscilador + ruído + filtro + envelope.
uso: python gen_audio.py <pasta_projeto>
"""
import os, sys, subprocess
import numpy as np
from scipy.signal import butter, lfilter

SR = 44100
OUT = sys.argv[1] if len(sys.argv) > 1 else "."
SFX = os.path.join(OUT, "assets/audio/sfx")
MUS = os.path.join(OUT, "assets/audio/music")
os.makedirs(SFX, exist_ok=True)
os.makedirs(MUS, exist_ok=True)
rng = np.random.default_rng(7)


# ------------------------------------------------------------------ utilitários
def t_(d):
    return np.arange(int(SR * d)) / SR


def env(n, a=0.005, d=0.1, s=0.0, r=0.05, total=None):
    """ADSR simples (em segundos)."""
    total = total or n / SR
    t = np.arange(n) / SR
    e = np.zeros(n)
    a = max(a, 1e-4)
    e = np.where(t < a, t / a, e)
    dk = (t >= a) & (t < a + d)
    e = np.where(dk, 1 - (1 - s) * (t - a) / max(d, 1e-4), e)
    sus = (t >= a + d) & (t < total - r)
    e = np.where(sus, s, e)
    rel = t >= total - r
    start = s if a + d < total - r else 1.0
    e = np.where(rel, start * np.clip((total - t) / max(r, 1e-4), 0, 1), e)
    return e


def expdec(n, tau):
    return np.exp(-np.arange(n) / SR / tau)


def sweep(f0, f1, d, kind="sine", curve=1.0):
    t = t_(d)
    k = (t / d) ** curve
    f = f0 + (f1 - f0) * k
    ph = 2 * np.pi * np.cumsum(f) / SR
    if kind == "sine":
        return np.sin(ph)
    if kind == "square":
        return np.sign(np.sin(ph))
    if kind == "saw":
        return 2 * ((ph / (2 * np.pi)) % 1.0) - 1
    if kind == "tri":
        return 2 * np.abs(2 * ((ph / (2 * np.pi)) % 1.0) - 1) - 1


def osc(f, d, kind="sine", detune=0.0):
    return sweep(f * (1 + detune), f * (1 + detune), d, kind)


def noise(d):
    return rng.uniform(-1, 1, int(SR * d))


def lp(x, fc, order=2):
    fc = min(fc, SR / 2 * 0.95)
    b, a = butter(order, fc / (SR / 2), "low")
    return lfilter(b, a, x)


def hp(x, fc, order=2):
    b, a = butter(order, fc / (SR / 2), "high")
    return lfilter(b, a, x)


def bp(x, f0, f1, order=2):
    b, a = butter(order, [f0 / (SR / 2), min(f1, SR / 2 * 0.95) / (SR / 2)], "band")
    return lfilter(b, a, x)


def lp_sweep(x, f0, f1, steps=24):
    """filtro passa-baixa varrendo de f0 a f1 (em blocos)."""
    out = np.zeros_like(x)
    n = len(x)
    for i in range(steps):
        a, b = i * n // steps, (i + 1) * n // steps
        fc = f0 * (f1 / f0) ** (i / max(1, steps - 1))
        out[a:b] = lp(x[max(0, a - 512):b], fc)[-(b - a):]
    return out


def mix(*parts):
    n = max(len(p) for p in parts)
    o = np.zeros(n)
    for p in parts:
        o[: len(p)] += p
    return o


def pad(x, d):
    n = int(SR * d)
    return np.concatenate([x, np.zeros(max(0, n - len(x)))])[:n] if n > len(x) else x


def delay(x, t, fb=0.35, mixv=0.3, n_rep=5):
    out = np.copy(x)
    k = int(t * SR)
    out = np.concatenate([out, np.zeros(k * n_rep)])
    for i in range(1, n_rep + 1):
        out[k * i: k * i + len(x)] += x * (fb ** i) * mixv / fb
    return out


def norm(x, peak=0.9):
    m = np.max(np.abs(x)) + 1e-9
    return x / m * peak


def save_wav(name, x, peak=0.85):
    x = norm(x, peak)
    # fade de 3 ms nas pontas para evitar clique
    f = min(len(x) // 4, int(0.003 * SR))
    x[:f] *= np.linspace(0, 1, f)
    x[-f:] *= np.linspace(1, 0, f)
    data = (x * 32767).astype("<i2").tobytes()
    path = os.path.join(SFX, name + ".wav")
    with open(path, "wb") as fh:
        n = len(data)
        fh.write(b"RIFF" + (36 + n).to_bytes(4, "little") + b"WAVEfmt ")
        fh.write((16).to_bytes(4, "little") + (1).to_bytes(2, "little") + (1).to_bytes(2, "little"))
        fh.write(SR.to_bytes(4, "little") + (SR * 2).to_bytes(4, "little") + (2).to_bytes(2, "little") + (16).to_bytes(2, "little"))
        fh.write(b"data" + n.to_bytes(4, "little") + data)


# ------------------------------------------------------------------ efeitos
def sfx():
    d = 0.14
    save_wav("tiro", mix(sweep(2100, 520, d, "square", 0.5) * expdec(int(SR * d), 0.05) * 0.35,
                         sweep(1600, 400, d, "sine", 0.6) * expdec(int(SR * d), 0.06),
                         hp(noise(0.03), 3000) * expdec(int(SR * 0.03), 0.008) * 0.6))
    d = 0.45
    save_wav("tiro_carregado", mix(sweep(900, 120, d, "saw", 0.5) * expdec(int(SR * d), 0.15) * 0.5,
                                   sweep(220, 50, d) * expdec(int(SR * d), 0.2),
                                   lp(noise(d), 2500) * expdec(int(SR * d), 0.08) * 0.8))
    save_wav("acerto", mix(bp(noise(0.09), 400, 2500) * expdec(int(SR * 0.09), 0.02),
                           sweep(260, 120, 0.09) * expdec(int(SR * 0.09), 0.03) * 0.8))
    d = 0.4
    save_wav("inimigo_morre", mix(lp_sweep(noise(d), 4000, 300) * expdec(int(SR * d), 0.12),
                                  sweep(500, 90, d, "square", 0.7) * expdec(int(SR * d), 0.1) * 0.25))
    d = 1.3
    save_wav("explosao", mix(lp_sweep(noise(d), 3500, 120, 30) * expdec(int(SR * d), 0.35),
                             sweep(90, 35, d) * expdec(int(SR * d), 0.4) * 1.2,
                             hp(noise(d), 2000) * expdec(int(SR * d), 0.05) * 0.4), 0.95)
    d = 0.5
    parts = [osc(f, d) * expdec(int(SR * d), tau) * a for f, tau, a in [(620, 0.12, 0.6), (1370, 0.08, 0.4), (2450, 0.05, 0.3), (3900, 0.03, 0.2)]]
    save_wav("caixa_quebra", mix(*parts, bp(noise(0.25), 800, 5000) * expdec(int(SR * 0.25), 0.05)))
    d = 0.16
    save_wav("pulo", mix(bp(noise(d), 600, 3000) * env(int(SR * d), 0.01, 0.15) * 0.5,
                         sweep(280, 520, d) * env(int(SR * d), 0.005, 0.15) * 0.4))
    save_wav("pulo_duplo", mix(bp(noise(0.2), 1500, 6000) * env(int(SR * 0.2), 0.005, 0.18) * 0.4,
                               sweep(700, 1400, 0.2, "sine") * expdec(int(SR * 0.2), 0.08) * 0.5,
                               osc(2100, 0.2) * expdec(int(SR * 0.2), 0.05) * 0.2))
    save_wav("pouso", mix(lp(noise(0.1), 500) * expdec(int(SR * 0.1), 0.02), sweep(110, 60, 0.1) * expdec(int(SR * 0.1), 0.03)))
    d = 0.26
    save_wav("esquiva", bp(noise(d), 500, 4000) * np.sin(np.linspace(0, np.pi, int(SR * d))) * 0.9)
    d = 0.3
    save_wav("dano", mix(sweep(330, 110, d, "square", 0.6) * expdec(int(SR * d), 0.1) * 0.5,
                         lp(noise(d), 1800) * expdec(int(SR * d), 0.05)))
    d = 1.1
    tones = np.concatenate([osc(f, 0.22, "tri") * expdec(int(SR * 0.22), 0.15) for f in [440, 349, 294, 220]])
    save_wav("morte", mix(tones, lp(noise(d), 900) * expdec(int(SR * d), 0.3) * 0.4))
    save_wav("celula", mix(pad(osc(1320, 0.08) * expdec(int(SR * 0.08), 0.04), 0.2),
                           np.concatenate([np.zeros(int(SR * 0.05)), osc(1980, 0.15) * expdec(int(SR * 0.15), 0.06)])), 0.6)
    arp = np.concatenate([osc(f, 0.09, "tri") * expdec(int(SR * 0.09), 0.08) for f in [523, 659, 784, 1047]])
    save_wav("cura", delay(arp, 0.11, 0.3, 0.3, 3))
    save_wav("energia", mix(sweep(400, 1800, 0.45, "sine", 2.0) * env(int(SR * 0.45), 0.02, 0.4) * 0.6,
                            sweep(405, 1810, 0.45, "saw", 2.0) * env(int(SR * 0.45), 0.02, 0.4) * 0.15))
    b1 = osc(880, 0.08, "square") * env(int(SR * 0.08), 0.002, 0.07) * 0.4
    b2 = osc(1320, 0.14, "square") * env(int(SR * 0.14), 0.002, 0.13) * 0.4
    save_wav("terminal", np.concatenate([b1, np.zeros(int(SR * 0.04)), b2]))
    d = 1.4
    servo = osc(70, d, "saw") * (0.6 + 0.4 * np.sin(2 * np.pi * 9 * t_(d)))
    save_wav("porta", mix(lp(servo, 600) * env(int(SR * d), 0.1, 0.2, 0.8, 0.3) * 0.7,
                          lp(noise(d), 1200) * env(int(SR * d), 0.1, 0.2, 0.6, 0.3) * 0.3,
                          np.concatenate([np.zeros(int(SR * 1.25)), lp(noise(0.15), 400) * expdec(int(SR * 0.15), 0.04)]) * 1.4))
    save_wav("alavanca", mix(lp(noise(0.12), 1500) * expdec(int(SR * 0.12), 0.03),
                             osc(180, 0.2, "square") * expdec(int(SR * 0.2), 0.05) * 0.3,
                             np.concatenate([np.zeros(int(SR * 0.08)), osc(900, 0.1) * expdec(int(SR * 0.1), 0.03) * 0.4])))
    d = 0.9
    buzz = osc(110, d, "saw") * (0.5 + 0.5 * np.sign(np.sin(2 * np.pi * 30 * t_(d))))
    save_wav("campo_desliga", mix(sweep(1400, 90, d, "saw", 0.6) * expdec(int(SR * d), 0.3) * 0.4, lp(buzz, 900) * expdec(int(SR * d), 0.25) * 0.5))
    d = 1.6
    f = 650 + 250 * np.sign(np.sin(2 * np.pi * 2.5 * t_(d)))
    siren = np.sin(2 * np.pi * np.cumsum(f) / SR)
    save_wav("alarme", lp(siren + 0.3 * np.sign(siren), 3000) * env(int(SR * d), 0.02, 0.1, 0.9, 0.2), 0.7)
    save_wav("laser_liga", mix(osc(160, 0.25, "saw") * expdec(int(SR * 0.25), 0.1) * 0.5, hp(noise(0.05), 3000) * expdec(int(SR * 0.05), 0.01)), 0.5)
    d = 0.8
    save_wav("turreta_carrega", mix(sweep(300, 2400, d, "sine", 2.0) * env(int(SR * d), 0.05, 0.7, 0.9, 0.05) * 0.5,
                                    sweep(303, 2420, d, "square", 2.0) * env(int(SR * d), 0.05, 0.7, 0.9, 0.05) * 0.08), 0.6)
    d = 0.6
    beam = osc(120, d, "saw") + 0.6 * osc(181, d, "square")
    save_wav("turreta_feixe", mix(lp(beam, 2500) * env(int(SR * d), 0.005, 0.1, 0.8, 0.2) * 0.6, lp(noise(d), 4000) * env(int(SR * d), 0.005, 0.1, 0.5, 0.2) * 0.4))
    save_wav("drone_tiro", mix(sweep(2600, 900, 0.1, "square", 0.5) * expdec(int(SR * 0.1), 0.03) * 0.3, sweep(1900, 700, 0.1) * expdec(int(SR * 0.1), 0.04)), 0.6)
    save_wav("drone_carrega", sweep(500, 1600, 0.5, "sine", 1.5) * env(int(SR * 0.5), 0.05, 0.45) * 0.5, 0.45)
    d = 1.6
    sh = np.sin(2 * np.pi * np.cumsum(np.linspace(80, 900, int(SR * d)) * (1 + 0.05 * np.sin(2 * np.pi * 6 * t_(d)))) / SR)
    save_wav("portal", mix(sh * env(int(SR * d), 0.6, 0.6, 0.5, 0.4) * 0.5, lp_sweep(noise(d), 300, 6000) * env(int(SR * d), 0.6, 0.6, 0.5, 0.4) * 0.5))
    chord = mix(*[osc(f, 1.4, "sine") * expdec(int(SR * 1.4), 0.6) * a for f, a in [(523, 0.5), (659, 0.4), (784, 0.35), (1047, 0.2)]])
    save_wav("estacao", delay(chord, 0.18, 0.3, 0.25, 3), 0.6)
    save_wav("ui_mover", osc(1200, 0.04, "tri") * expdec(int(SR * 0.04), 0.012), 0.35)
    save_wav("ui_ok", np.concatenate([osc(880, 0.06, "tri") * expdec(int(SR * 0.06), 0.03), osc(1320, 0.1, "tri") * expdec(int(SR * 0.1), 0.04)]), 0.5)
    save_wav("ui_volta", np.concatenate([osc(880, 0.06, "tri") * expdec(int(SR * 0.06), 0.03), osc(587, 0.1, "tri") * expdec(int(SR * 0.1), 0.04)]), 0.45)
    save_wav("calibra_ok", delay(np.concatenate([osc(f, 0.1, "sine") * expdec(int(SR * 0.1), 0.08) for f in [784, 988, 1175, 1568]]), 0.12, 0.3, 0.3, 3), 0.6)
    save_wav("negado", osc(140, 0.22, "square") * env(int(SR * 0.22), 0.005, 0.05, 0.7, 0.05) * 0.4, 0.45)
    save_wav("garras", bp(noise(0.14), 1500, 7000) * env(int(SR * 0.14), 0.003, 0.12) * 1.0, 0.7)
    save_wav("clarao", mix(sweep(300, 3000, 0.35, "sine", 0.5) * expdec(int(SR * 0.35), 0.15) * 0.5, hp(noise(0.35), 2500) * expdec(int(SR * 0.35), 0.1) * 0.6))
    d = 1.6
    growl = osc(55, d, "saw") * (0.7 + 0.3 * np.sin(2 * np.pi * 7 * t_(d)))
    save_wav("rainha_ruge", mix(lp(growl, 400) * env(int(SR * d), 0.15, 0.4, 0.7, 0.5), lp(noise(d), 700) * env(int(SR * d), 0.15, 0.4, 0.5, 0.5) * 0.6), 0.95)
    save_wav("raiz", mix(lp(noise(0.35), 1200) * expdec(int(SR * 0.35), 0.08), sweep(140, 50, 0.35) * expdec(int(SR * 0.35), 0.1)))
    save_wav("esporo", mix(sweep(300, 900, 0.09) * expdec(int(SR * 0.09), 0.03), bp(noise(0.06), 800, 3000) * expdec(int(SR * 0.06), 0.015)), 0.5)
    save_wav("rastejador_tiro", mix(sweep(1200, 300, 0.16, "square", 0.6) * expdec(int(SR * 0.16), 0.05) * 0.3, sweep(800, 250, 0.16) * expdec(int(SR * 0.16), 0.06)), 0.55)
    save_wav("plataforma_quebra", mix(lp(noise(0.6), 2500) * expdec(int(SR * 0.6), 0.15), sweep(200, 60, 0.6) * expdec(int(SR * 0.6), 0.2) * 0.6))
    save_wav("elevador", lp(osc(90, 1.2, "saw") * (0.6 + 0.4 * np.sin(2 * np.pi * 5 * t_(1.2))), 500) * env(int(SR * 1.2), 0.2, 0.2, 0.7, 0.4), 0.6)
    save_wav("arpao", mix(sweep(600, 2400, 0.14, "saw", 0.6) * expdec(int(SR * 0.14), 0.08) * 0.3,
                          bp(noise(0.14), 2000, 8000) * expdec(int(SR * 0.14), 0.05) * 0.6), 0.6)
    save_wav("arpao_prende", mix(osc(1800, 0.2) * expdec(int(SR * 0.2), 0.05) * 0.5, osc(2700, 0.2) * expdec(int(SR * 0.2), 0.03) * 0.3,
                                 lp(noise(0.05), 3000) * expdec(int(SR * 0.05), 0.01)), 0.6)
    fan = np.concatenate([osc(f, d2, "tri") * expdec(int(SR * d2), 0.25) for f, d2 in [(523, 0.12), (659, 0.12), (784, 0.12), (1047, 0.5)]])
    save_wav("modulo", delay(mix(fan, np.concatenate([np.zeros(int(SR * 0.36)), osc(1568, 0.5) * expdec(int(SR * 0.5), 0.3) * 0.4])), 0.15, 0.3, 0.3, 3), 0.7)
    save_wav("passo", lp(noise(0.05), 900) * expdec(int(SR * 0.05), 0.01), 0.3)


# ------------------------------------------------------------------ música
NOTE = {"C": 0, "C#": 1, "D": 2, "D#": 3, "E": 4, "F": 5, "F#": 6, "G": 7, "G#": 8, "A": 9, "A#": 10, "B": 11}


def hz(n, octv):
    return 440.0 * 2 ** ((NOTE[n] + 12 * (octv + 1) - 69) / 12)


# progressão i–VI–III–VII em Lá menor (o "tema do Daymon")
PROG = [("A", [0, 3, 7]), ("F", [0, 4, 7]), ("C", [0, 4, 7]), ("G", [0, 4, 7])]
MELODY = [  # (grau em semitons a partir de A4, duração em batidas) — usado só na versão Verdâmia
    (0, 1), (3, 0.5), (5, 0.5), (7, 2), (5, 1), (3, 1), (0, 2), (-2, 1), (0, 1),
    (3, 1), (5, 1), (7, 1.5), (10, 0.5), (7, 2), (5, 1), (3, 1), (5, 2), (3, 2),
]


def chord_freqs(root, ints, octv):
    base = hz(root, octv)
    return [base * 2 ** (i / 12) for i in ints]


def render_track(name, bpm, bars_per_chord, layers, total_loops=2, master=0.8):
    beat = 60.0 / bpm
    bar = beat * 4
    dur = bar * bars_per_chord * len(PROG) * total_loops
    n = int(SR * dur)
    out = np.zeros(n + SR * 4)
    for li in layers:
        li(out, beat, bar, bars_per_chord)
    out = out[:n] + np.concatenate([out[n:n + SR * 4], np.zeros(max(0, n - SR * 4))])[:n]  # emenda o rabo do delay no início (loop sem corte)
    out = lp(out, 9000)
    # emenda do loop: mistura os últimos 60 ms com o começo (crossfade), sem clique
    m = int(0.06 * SR)
    fade = np.linspace(0, 1, m)
    head = out[:m] * fade + out[-m:] * (1 - fade)
    out = np.concatenate([head, out[m:-m]])
    out = norm(out, master)
    wav = os.path.join(MUS, name + ".wav")
    data = (out * 32767).astype("<i2").tobytes()
    with open(wav, "wb") as fh:
        nn = len(data)
        fh.write(b"RIFF" + (36 + nn).to_bytes(4, "little") + b"WAVEfmt ")
        fh.write((16).to_bytes(4, "little") + (1).to_bytes(2, "little") + (1).to_bytes(2, "little"))
        fh.write(SR.to_bytes(4, "little") + (SR * 2).to_bytes(4, "little") + (2).to_bytes(2, "little") + (16).to_bytes(2, "little"))
        fh.write(b"data" + nn.to_bytes(4, "little") + data)
    ogg = os.path.join(MUS, name + ".ogg")
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", wav, "-c:a", "libvorbis", "-q:a", "4", ogg], check=True)
    os.remove(wav)
    print("música", name, f"{dur:.1f}s")


def chords_iter(beat, bar, bpc, loops=2):
    t = 0.0
    for _ in range(loops):
        for root, ints in PROG:
            yield t, root, ints, bar * bpc
            t += bar * bpc


def add(out, t0, x):
    i = int(t0 * SR)
    j = min(len(out), i + len(x))
    out[i:j] += x[: j - i]


def L_pad(vol=0.25, octv=3, cutoff=1400, kind="saw"):
    def f(out, beat, bar, bpc):
        for t0, root, ints, d in chords_iter(beat, bar, bpc):
            n = int(SR * (d + 1.0))
            sig = np.zeros(n)
            for fr in chord_freqs(root, ints, octv):
                for det in (-0.004, 0.0, 0.005):
                    sig += sweep(fr * (1 + det), fr * (1 + det), (d + 1.0), kind)
            sig = lp(sig, cutoff) * env(n, 0.9, 0.3, 0.8, 1.0)
            add(out, t0, sig * vol / 6)
    return f


def L_bass(vol=0.35, pattern=(1, 0, 1, 1, 0, 1, 0, 1), kind="saw", cutoff=500):
    def f(out, beat, bar, bpc):
        step = beat / 2
        for t0, root, ints, d in chords_iter(beat, bar, bpc):
            fr = hz(root, 1)
            k = 0
            while k * step < d - 1e-6:
                if pattern[k % len(pattern)]:
                    x = lp(osc(fr, step * 0.95, kind), cutoff) * env(int(SR * step * 0.95), 0.005, 0.12, 0.5, 0.05)
                    add(out, t0 + k * step, x * vol)
                k += 1
    return f


def L_arp(vol=0.12, octv=5, kind="tri", div=4, tau=0.18, dly=True):
    def f(out, beat, bar, bpc):
        step = beat / div
        seq = [0, 1, 2, 1, 2, 0, 2, 1]
        for t0, root, ints, d in chords_iter(beat, bar, bpc):
            fr = chord_freqs(root, ints + [12], octv)
            k = 0
            while k * step < d - 1e-6:
                x = osc(fr[seq[k % len(seq)] % len(fr)], 0.4, kind) * expdec(int(SR * 0.4), tau)
                if dly:
                    x = delay(x, beat * 0.75, 0.35, 0.35, 3)
                add(out, t0 + k * step, x * vol)
                k += 1
    return f


def L_drums(vol=0.5, kick=(1, 0, 0, 0, 1, 0, 0, 0), hat=(0, 0, 1, 0, 0, 0, 1, 0), shaker=False, snare=(0, 0, 0, 0, 0, 0, 0, 0)):
    def f(out, beat, bar, bpc):
        step = beat / 2
        total = bar * bpc * len(PROG) * 2
        k = 0
        kk = sweep(110, 40, 0.25) * expdec(int(SR * 0.25), 0.08)
        hh = hp(noise(0.05), 7000) * expdec(int(SR * 0.05), 0.012)
        sh = bp(noise(0.09), 3000, 9000) * np.sin(np.linspace(0, np.pi, int(SR * 0.09)))
        sn = mix(bp(noise(0.18), 1200, 6000) * expdec(int(SR * 0.18), 0.05), osc(190, 0.1) * expdec(int(SR * 0.1), 0.04) * 0.6)
        while k * step < total:
            i = k % 8
            if kick[i]:
                add(out, k * step, kk * vol)
            if hat[i]:
                add(out, k * step, hh * vol * 0.35)
            if snare[i]:
                add(out, k * step, sn * vol * 0.5)
            if shaker:
                add(out, k * step + step * 0.5, sh * vol * 0.12)
            k += 1
    return f


def L_melody(vol=0.18, octv=4, flute=True):
    def f(out, beat, bar, bpc):
        total = bar * bpc * len(PROG) * 2
        t = bar * bpc * len(PROG)  # a melodia entra na segunda volta
        base = hz("A", octv)
        for semi, b in MELODY:
            d = b * beat
            if t + d > total:
                break
            fr = base * 2 ** (semi / 12)
            n = int(SR * (d + 0.3))
            tt = np.arange(n) / SR
            vib = 1 + 0.006 * np.sin(2 * np.pi * 5.2 * tt) * np.clip(tt / 0.3, 0, 1)
            ph = 2 * np.pi * np.cumsum(fr * vib) / SR
            sig = np.sin(ph) + 0.15 * np.sin(2 * ph)
            if flute:
                sig += lp(noise(n / SR), 1800) * 0.006 * np.clip(tt / 0.08, 0, 1) * np.exp(-tt / 0.15)
            sig *= env(n, 0.06, 0.1, 0.8, 0.25)
            add(out, t, delay(sig, beat * 0.5, 0.3, 0.25, 3) * vol)
            t += d
    return f


def L_marimba(vol=0.16):
    def f(out, beat, bar, bpc):
        step = beat / 2
        seq = [0, 2, 1, 2, 0, 1, 2, 1]
        for t0, root, ints, d in chords_iter(beat, bar, bpc):
            fr = chord_freqs(root, ints, 4)
            k = 0
            while k * step < d - 1e-6:
                if k % 3 != 2:
                    p = fr[seq[k % 8] % 3]
                    x = (osc(p, 0.5) + 0.3 * osc(p * 4, 0.5)) * expdec(int(SR * 0.5), 0.12)
                    add(out, t0 + k * step, x * vol)
                k += 1
    return f


def music():
    render_track("laboratorio", 84, 2, [
        L_pad(0.30, 3, 1200), L_bass(0.30, (1, 0, 0, 1, 0, 0, 1, 0)), L_arp(0.10, 5, "tri", 4, 0.15),
        L_drums(0.35, kick=(1, 0, 0, 0, 0, 0, 1, 0), hat=(0, 0, 1, 0, 0, 0, 1, 1)),
    ], master=0.75)
    render_track("verdamia", 76, 2, [
        L_pad(0.22, 3, 900, "tri"), L_marimba(0.14), L_melody(0.16, 5),
        L_drums(0.28, kick=(1, 0, 0, 0, 1, 0, 0, 0), hat=(0, 0, 0, 0, 0, 0, 0, 0), shaker=True),
    ], master=0.7)
    render_track("chefe", 128, 1, [
        L_pad(0.22, 3, 1800), L_bass(0.45, (1, 1, 0, 1, 1, 0, 1, 1), "square", 700), L_arp(0.10, 5, "square", 4, 0.08, False),
        L_drums(0.6, kick=(1, 0, 0, 1, 1, 0, 0, 0), hat=(1, 1, 1, 1, 1, 1, 1, 1), snare=(0, 0, 1, 0, 0, 0, 1, 0)),
    ], master=0.8)
    render_track("menu", 70, 2, [L_pad(0.35, 3, 900), L_arp(0.07, 5, "sine", 2, 0.4)], master=0.6)


sfx()
print("efeitos:", len(os.listdir(SFX)))
music()
