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

func _ready() -> void:
	pass
