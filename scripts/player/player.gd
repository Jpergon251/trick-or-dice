extends CharacterBody3D

# Script para el jugador, maneja el movimiento y las interacciones con el entorno

var health: int = 100
var max_health: int = 100
var is_alive: bool = true
var damage: int = 10
var player_name: String = ""

@export var speed: float = 5.0
@export var rotation_speed: float = 3.0

func _ready() -> void:
	pass
