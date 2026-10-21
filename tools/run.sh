#!/bin/bash
cd "$(dirname "$0")/.."
timeout ${TO:-60} xvfb-run -a -s "-screen 0 1280x720x24" ${GODOT:-godot} --rendering-driver opengl3 --audio-driver Dummy --path . -- "$@" 2>&1 | grep -vE "^$|Godot Engine|OpenGL API|V-Sync|set_use_vsync" | head -40
