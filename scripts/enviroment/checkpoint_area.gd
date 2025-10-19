extends Area3D
#Script para el area a la que el jugador llega y cuando entra spawnean los enemigos del numero de fase que sea

@export var spawn_zone: Area3D
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var enemies_spawned: bool = false
var enemies_defeated: bool = false

@export var enemies_to_spawn := 2
@export var enemy_scene: PackedScene

func _ready() -> void:
	pass

func spawn_enemies() -> void:
	if not enemies_spawned:
		for i in range(enemies_to_spawn):
			var enemy_instance = enemy_scene.instantiate()
			var spawn_position = get_random_point_in_spawn_zone()
			enemy_instance.global_position = spawn_position
			get_parent().add_child(enemy_instance)
			GameManager.enemies_spawned += 1
			print("Spawning enemies for phase FIRST:", i)

# Función para obtener un punto aleatorio dentro de la zona de spawn
func get_random_point_in_spawn_zone() -> Vector3:
	var spawn_position = spawn_zone.global_position
	var spawn_radius = spawn_zone.get_child(0).shape.radius
	var random_offset = Vector3(
		randf_range(-spawn_radius, spawn_radius),
		0,
		randf_range(-spawn_radius, spawn_radius)
	)
	return spawn_position + random_offset

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player" and not enemies_spawned:
		print("El jugador ha entrado")
		collision_shape_3d.call_deferred("set_disabled", true)
		spawn_enemies()
		enemies_spawned = true
		spawn_zone.queue_free()
		  # Desactivar el área para que no se active de nuevo

		# Aquí puedes agregar lógica adicional, como iniciar un temporizador para verificar si los enemigos han sido derrotados
