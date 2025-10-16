extends Area3D

enum Phase {
	FIRST, SECOND, THIRD, FOURTH, FIFTH, SIXTH, SEVENTH, EIGHTH, NINTH, TENTH
}

@export var phase: Phase = Phase.FIRST
@export var spawn_zone: Area3D
@export var enemies_to_spawn := 3
@export var enemy_scene: PackedScene = preload("res://Scenes/Enemy.tscn")

var enemies_spawned := false
var enemies_defeated := false


func spawn_enemies() -> void:
	if enemies_spawned:
		return
	enemies_spawned = true

	print("Spawning enemies for phase %s" % [phase])
	
	var enemies = []
	for i in range(enemies_to_spawn):
		var e = enemy_scene.instantiate()
		get_tree().current_scene.add_child(e)
		e.global_position = get_random_point_in_spawn_zone()
		enemies.append(e)

	await _wait_until_all_dead(enemies)
	enemies_defeated = true


func get_random_point_in_spawn_zone() -> Vector3:
	if not spawn_zone:
		return global_position

	var shape = spawn_zone.get_node_or_null("CollisionShape3D")
	if shape and shape.shape is BoxShape3D:
		var extents = shape.shape.extents
		var origin = spawn_zone.global_position
		return origin + Vector3(
			randf_range(-extents.x, extents.x),
			0,
			randf_range(-extents.z, extents.z)
		)
	else:
		return spawn_zone.global_position


func _wait_until_all_dead(enemies: Array) -> void:
	while true:
		enemies = enemies.filter(func(e): return is_instance_valid(e))
		if enemies.is_empty():
			break
		await get_tree().create_timer(0.5).timeout
