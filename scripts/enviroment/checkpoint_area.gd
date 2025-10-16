extends Area3D

#Script para el area a la que el jugador llega y cuando entra spawnean los enemigos del numero de fase que sea

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

@export var phase: Phase = Phase.FIRST
@export var spawn_zone: Area3D

var enemies_spawned: bool = false
var enemies_defeated: bool = false


@export var enemies_to_spawn := 3
@export var enemy_scene: PackedScene

func _ready() -> void:
	pass

func spawn_enemies() -> void:
	match phase:
		Phase.FIRST:
			print("Spawning enemies for phase FIRST")

			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase FIRST
		Phase.SECOND:
			print("Spawning enemies for phase SECOND")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase SECOND
		Phase.THIRD:
			print("Spawning enemies for phase THIRD")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase THIRD
		Phase.FOURTH:
			print("Spawning enemies for phase FOURTH")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase FOURTH
		Phase.FIFTH:
			print("Spawning enemies for phase FIFTH")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase FIFTH
		Phase.SIXTH:
			print("Spawning enemies for phase SIXTH")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase SIXTH
		Phase.SEVENTH:
			print("Spawning enemies for phase SEVENTH")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase SEVENTH
		Phase.EIGHTH:
			print("Spawning enemies for phase EIGHTH")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase EIGHTH
		Phase.NINTH:
			print("Spawning enemies for phase NINTH")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase NINTH
		Phase.TENTH:
			print("Spawning enemies for phase TENTH")
			# Aquí puedes agregar la lógica para spawnear los enemigos de la fase TENTH

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not enemies_spawned:
		spawn_enemies()
		enemies_spawned = true
		$CollisionShape3D.disabled = true  # Desactivar el área para que no se active de nuevo

		# Aquí puedes agregar lógica adicional, como iniciar un temporizador para verificar si los enemigos han sido derrotados
