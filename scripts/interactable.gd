class_name Interactable
extends Area2D
## Base para objetos com que o jogador interage (E).

var main
var theme := "lab"
var prompt := ""
var size := Vector2(90, 110)
var t := 0.0
var player_near := false


func _ready() -> void:
	collision_layer = 64
	collision_mask = 2
	_setup()
	var cs := CollisionShape2D.new()
	var r := RectangleShape2D.new()
	r.size = size
	cs.shape = r
	cs.position = Vector2(0, -size.y / 2.0)
	add_child(cs)
	body_entered.connect(_on_enter)
	body_exited.connect(_on_exit)


func _setup() -> void:
	pass


func _on_enter(b: Node) -> void:
	if b is Player:
		player_near = true
		if prompt != "":
			main.interact_target = self
			main.hud.set_prompt(prompt)


func _on_exit(b: Node) -> void:
	if b is Player:
		player_near = false
		if main.interact_target == self:
			main.interact_target = null
			main.hud.set_prompt("")


func refresh_prompt() -> void:
	if not player_near:
		return
	if prompt == "":
		if main.interact_target == self:
			main.interact_target = null
		main.hud.set_prompt("")
	else:
		main.interact_target = self
		main.hud.set_prompt(prompt)


func interact() -> void:
	pass


func _process(dt: float) -> void:
	t += dt
	queue_redraw()
