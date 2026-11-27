#!/usr/bin/env bash
# Roda a bateria inteira de testes da revisão geral, um por vez (o test_fuga é sensível ao tempo e
# precisa rodar sozinho), e escreve um resumo. uso: tools/rodar_testes.sh [pasta_de_logs]
# Cada teste sai com código 0 quando passa; o log de cada um fica em <pasta>/<teste>.log.
cd "$(dirname "$0")/.." || exit 1
LOGS="${1:-/tmp/testes_wf}"
mkdir -p "$LOGS"
TESTES=(
	"test_deserto -- save at=999"
	"test_forja -- save at=999"
	"test_df205"
	"test_cenas_fases"
	"test_verdamia"
	"test_passagem"
	"test_fragmento"
	"test_nivaria -- level=nivaria arpao at=999"
	"test_portal -- level=lab terminals pos=6500,690 at=999"
	"test_gancho -- fps=30"
	"test_gancho -- fps=60"
	"test_gancho -- fps=144"
	"test_pulso"
	"test_ponto_seguro"
	"test_fuga -- level=lab terminals arpao pos=4250,790 save at=999"
)
falhas=0
: > "$LOGS/resumo.txt"
for t in "${TESTES[@]}"; do
	set -- $t
	nome=$1; shift
	log="$LOGS/$nome${2:+_${2//[^a-z0-9]/}}.log"
	ini=$(date +%s)
	timeout 1200 godot --headless --audio-driver Dummy --path . --script "res://tools/$nome.gd" "$@" > "$log" 2>&1
	cod=$?
	# o vazamento ao fechar o harness ("still in use at exit") não é erro do jogo
	erros=$(grep -E 'SCRIPT ERROR|^ERROR' "$log" | grep -vc 'at exit')
	[ -n "$2" ] && nome="$nome $2"
	linha=$(printf '%-24s código %-3s %3ss  erros no console: %s' "$nome" "$cod" "$(( $(date +%s) - ini ))" "$erros")
	echo "$linha" | tee -a "$LOGS/resumo.txt"
	[ "$cod" -ne 0 ] && falhas=$((falhas + 1))
done
echo "testes com falha: $falhas" | tee -a "$LOGS/resumo.txt"
exit $falhas
