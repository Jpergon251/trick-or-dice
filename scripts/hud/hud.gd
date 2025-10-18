extends Control

@export var player: CharacterBody3D
@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar
@onready var enemy_selected_label: Label = $CanvasLayer/EnemySelectedPanel/EnemySelectedLabel
@onready var enemy_icon: TextureRect = $CanvasLayer/EnemySelectedPanel/HBoxContainer/EnemyIcon
@onready var enemy_selected_panel: Panel = $CanvasLayer/EnemySelectedPanel
@onready var hud_animation_player: AnimationPlayer = $HUDAnimationPlayer
@onready var back_button: Button = $CanvasLayer/EnemySelectedPanel/BackButton


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if player:
		var health_percentage = float(player.health) / float(player.max_health) * 100.0
		progress_bar.value = health_percentage

#Subir el panel un poco si hay un enemigo seleccionado, sino bajarlo
	if GameManager.currently_selected_enemy:
		enemy_selected_label.text = GameManager.currently_selected_enemy.enemy_name
		enemy_icon.texture = get_enemy_icon()
	else:
		enemy_selected_label.text = "No enemy selected"
		enemy_icon.texture = null

func get_enemy_icon() -> Texture:
	return GameManager.currently_selected_enemy.get_child(0).texture
