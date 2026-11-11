class_name SpriteMetaVerd
extends RefCounted
## Gerado por tools/import_verdamia.py a partir de colaboracao/entregas/VD_verdamia. Não edite à mão.
## Sprites animados: AnimatedSprite2D centered=true, offset = *_OFFSET e scale = *_SCALE.

const LINCE_FRAMES := "res://assets/verdamia/lince/lince_frames.tres"
const LINCE_OFFSET := Vector2(-7.02, -58.18)
const LINCE_SCALE := 0.5000
const LINCE_LANTERN := {
	"idle": [Vector2(-28.6, -39.2), Vector2(-28.6, -39.3), Vector2(-28.6, -40.0), Vector2(-28.7, -39.2), Vector2(-29.9, -44.2), Vector2(-28.6, -39.1)],
	"run": [Vector2(-32.5, -36.2), Vector2(-31.6, -39.7), Vector2(-32.7, -45.8), Vector2(-36.3, -39.4), Vector2(-36.6, -37.7), Vector2(-33.4, -40.4), Vector2(-33.2, -42.3), Vector2(-34.4, -46.7)],
	"jump": [Vector2(-28.4, -35.4), Vector2(-28.9, -36.3), Vector2(-29.2, -35.9)],
	"fall": [Vector2(-30.4, -39.5), Vector2(-30.9, -43.8), Vector2(-28.4, -42.8)],
	"doublejump": [Vector2(-27.5, -36.8), Vector2(-28.8, -47.4), Vector2(18.9, -7.0), Vector2(-29.9, -44.4)],
	"wall": [Vector2(-26.4, -20.7), Vector2(-28.9, -22.5), Vector2(-28.2, -24.4)],
	"claw": [Vector2(-25.8, -39.4), Vector2(-27.4, -39.5), Vector2(-29.6, -39.2), Vector2(-29.8, -39.3)],
	"pogo": [Vector2(-29.3, -37.4), Vector2(-29.3, -45.5), Vector2(-27.1, -49.8), Vector2(-30.0, -40.6)],
	"flash": [Vector2(-29.6, -37.6), Vector2(-29.5, -37.6), Vector2(-26.4, -37.6), Vector2(-9.1, -30.3), Vector2(-29.2, -37.9), Vector2(-29.6, -37.6)],
	"hurt": [Vector2(-26.8, -41.2), Vector2(-26.4, -33.6)],
	"death": [Vector2(-25.9, -38.5), Vector2(-28.5, -38.0), Vector2(-29.9, -35.6), Vector2(-32.2, -28.1), Vector2(-32.2, -23.0), Vector2(-32.2, -23.0)],
}
const ESPORANGIO_FRAMES := "res://assets/verdamia/inimigos/esporangio_frames.tres"
const ESPORANGIO_OFFSET := Vector2(3.00, -88.46)
const ESPORANGIO_SCALE := 0.5000
const MARIPOSA_FRAMES := "res://assets/verdamia/inimigos/mariposa_frames.tres"
const MARIPOSA_OFFSET := Vector2(-10.83, -2.81)
const MARIPOSA_SCALE := 0.5000
const RAINHA_FRAMES := "res://assets/verdamia/inimigos/rainha_frames.tres"
const RAINHA_OFFSET := Vector2(8.98, -226.90)
const RAINHA_SCALE := 0.6667
const FX_RAIZ_FRAMES := "res://assets/verdamia/efeitos/fx_raiz_frames.tres"
const FX_RAIZ_OFFSET := Vector2(-0.08, -140.52)
const FX_RAIZ_SCALE := 0.5000
const FX_AVISO_RAIZ_FRAMES := "res://assets/verdamia/efeitos/fx_aviso_raiz_frames.tres"
const FX_AVISO_RAIZ_OFFSET := Vector2(0.18, -29.70)
const FX_AVISO_RAIZ_SCALE := 0.5000
const FX_IMPACTO_ESPORO_FRAMES := "res://assets/verdamia/efeitos/fx_impacto_esporo_frames.tres"
const FX_IMPACTO_ESPORO_OFFSET := Vector2(-4.46, 0.72)
const FX_IMPACTO_ESPORO_SCALE := 0.5000
const FX_INVOCACAO_FRAMES := "res://assets/verdamia/efeitos/fx_invocacao_frames.tres"
const FX_INVOCACAO_OFFSET := Vector2(-0.15, -0.05)
const FX_INVOCACAO_SCALE := 0.5000
const FX_POEIRA_FRAMES := "res://assets/verdamia/efeitos/fx_poeira_frames.tres"
const FX_POEIRA_OFFSET := Vector2(0.00, -31.50)
const FX_POEIRA_SCALE := 0.5000
const FX_GARRAS_FRAMES := "res://assets/verdamia/efeitos/fx_garras_frames.tres"
const FX_GARRAS_OFFSET := Vector2(0.00, -0.25)
const FX_GARRAS_SCALE := 0.5000
const FX_CLARAO_FRAMES := "res://assets/verdamia/efeitos/fx_clarao_frames.tres"
const FX_CLARAO_OFFSET := Vector2(0.02, 0.24)
const FX_CLARAO_SCALE := 1.0000
## efeitos por nome: [SpriteFrames, offset, escala]
const FX := {
	"raiz": [FX_RAIZ_FRAMES, FX_RAIZ_OFFSET, FX_RAIZ_SCALE],
	"aviso_raiz": [FX_AVISO_RAIZ_FRAMES, FX_AVISO_RAIZ_OFFSET, FX_AVISO_RAIZ_SCALE],
	"impacto_esporo": [FX_IMPACTO_ESPORO_FRAMES, FX_IMPACTO_ESPORO_OFFSET, FX_IMPACTO_ESPORO_SCALE],
	"invocacao": [FX_INVOCACAO_FRAMES, FX_INVOCACAO_OFFSET, FX_INVOCACAO_SCALE],
	"poeira": [FX_POEIRA_FRAMES, FX_POEIRA_OFFSET, FX_POEIRA_SCALE],
	"garras": [FX_GARRAS_FRAMES, FX_GARRAS_OFFSET, FX_GARRAS_SCALE],
	"clarao": [FX_CLARAO_FRAMES, FX_CLARAO_OFFSET, FX_CLARAO_SCALE],
}
const OBJ_DIR := "res://assets/verdamia/objetos/"
const OBJ_SCALE := 0.5
const CHAO_SURF := 24.9   # linha de apoio (px do jogo a partir do topo da faixa)
const PAREDE_EDGE := 3.0   # onde começa a rocha (px do jogo a partir da esquerda)
const CANTO_ESQUERDO_QUINA := Vector2(3.3, 29.4)
const CANTO_DIREITO_QUINA := Vector2(8.4, 24.3)
const ESPINHOS_BASE := 37.4   # linha do musgo (px do jogo a partir do topo da faixa)
const PLATAFORMA_RAIZES_SURF := 1.2   # linha de apoio em px da textura
const TRONCO_PLATAFORMA_SURF := 24.8   # linha de apoio em px da textura
const TERRENO_DIR := "res://assets/verdamia/terreno/"
const FUNDO_DIR := "res://assets/verdamia/fundo/"
