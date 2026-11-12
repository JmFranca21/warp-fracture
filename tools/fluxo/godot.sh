#!/bin/bash
# Roda o harness do jogo nesta máquina Windows (Git Bash).
# Uso: tools/fluxo/godot.sh level=lab pos=645,790 at=1 shot=C:/caminho/captura.png
#      tools/fluxo/godot.sh --import          (reimporta assets)
#      tools/fluxo/godot.sh --script res://tools/test_verdamia.gd -- save at=999
# Defina GODOT para usar outro executável.
GODOT="${GODOT:-/c/Users/joao.marcelo/AreaJM/Ferramentas/godot-4.3/Godot_v4.3-stable_win64_console.exe}"
cd "$(dirname "$0")/../.." || exit 1
if [ "$1" = "--import" ]; then
  exec timeout "${TO:-300}" "$GODOT" --headless --import --path .
fi
if [ "$1" = "--script" ]; then
  exec timeout "${TO:-300}" "$GODOT" --headless --audio-driver Dummy --path . "$@"
fi
timeout "${TO:-60}" "$GODOT" --rendering-driver opengl3 --audio-driver Dummy --path . -- "$@" 2>&1 \
  | grep -vE "^$|Godot Engine|OpenGL API|resources still in use"
