extends PathFollow3D

@onready var player: CharacterBody3D = $Player
@export var checkpoints: Array[Area3D]  # Lista de checkpoints en orden
@export var stop_distance: float = 0.5

var current_checkpoint_index := 0
var is_moving := true

func _process(delta: float) -> void:
	if not player or not is_moving:
		return

	var player_speed = player.speed
	progress += player_speed * delta

	# Mover al jugador según el PathFollow
	player.global_position = global_position

	# Comprobar si llegamos al siguiente checkpoint
	var target_checkpoint = checkpoints[current_checkpoint_index]
	var distance = player.global_position.distance_to(target_checkpoint.global_position)

	if distance <= stop_distance:
		_reach_checkpoint(target_checkpoint)


func _reach_checkpoint(area: Area3D) -> void:
	is_moving = false  # Detener al jugador

	# Girar hacia el centro de la spawn zone
	if area.spawn_zone:
		var direction = (area.spawn_zone.global_position - player.global_position).normalized()
		var target_rotation = atan2(direction.x, direction.z)
		player.rotation.y = target_rotation

	# Esperar hasta que todos los enemigos de esta zona estén derrotados
	await check_enemies_defeated(area)

	# Continuar al siguiente checkpoint si existe
	current_checkpoint_index += 1
	if current_checkpoint_index < checkpoints.size():
		is_moving = true


func check_enemies_defeated(area: Area3D) -> void:
	while not area.enemies_defeated:
		await get_tree().create_timer(0.5).timeout
