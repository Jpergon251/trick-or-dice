extends Node

enum Phase {
	FIRST,
	SECOND,
	THIRD,
	FOURTH,
	FIFTH,
	SIXTH,
	SEVENTH,
	EIGHTH,
	NINTH,
	TENTH
}
# La fase actual del juego
var phase: Phase = Phase.FIRST

var currently_selected_enemy: Node3D = null
var selected_attack_name: String = ""
var selected_attack_icon: Texture = null

var enemies_spawned: int = 0
var enemies_defeated: int = 0

func _ready() -> void:
	pass
