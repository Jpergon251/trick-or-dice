extends Control

@export var player: CharacterBody3D

@onready var progress_bar: ProgressBar = $CanvasLayer/ProgressBar

@onready var enemy_selected_label: Label = $CanvasLayer/EnemySelectedPanel/EnemySelectedLabel
@onready var enemy_icon: TextureRect = $CanvasLayer/EnemySelectedPanel/HBoxContainer/EnemyIcon
@onready var enemy_selected_panel: Panel = $CanvasLayer/EnemySelectedPanel
@onready var dice_roll_panel: Panel = $CanvasLayer/DiceRollPanel

@onready var hud_animation_player: AnimationPlayer = $HUDAnimationPlayer

@onready var back_button: Button = $CanvasLayer/EnemySelectedPanel/BackButton

@onready var attacks_list: VBoxContainer = $CanvasLayer/EnemySelectedPanel/HBoxContainer/AttacksList
@onready var fireball_attack: HBoxContainer = $CanvasLayer/EnemySelectedPanel/HBoxContainer/AttacksList/FireballAttack

@onready var attack_name_label: Label = $CanvasLayer/EnemySelectedPanel/HBoxContainer/AttacksList/FireballAttack/AttackNameLabel
@onready var attack_name_dice_label: Label = $CanvasLayer/DiceRollPanel/AttackNameDiceLabel

@onready var roll_button: Button = $CanvasLayer/DiceRollPanel/RollButton

@onready var attack_icon_dice: TextureRect = $CanvasLayer/DiceRollPanel/AttackIconDice
@onready var dice: TextureRect = $CanvasLayer/DiceRollPanel/Dice

@onready var dice_number: Label = $CanvasLayer/DiceRollPanel/Dice/DiceNumber

var dice_face: int

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	update_health_bar(player.health, player.max_health)
#Subir el panel un poco si hay un enemigo seleccionado, sino bajarlo
	if GameManager.currently_selected_enemy:
		attacks_list.visible = true
		enemy_selected_label.text = GameManager.currently_selected_enemy.enemy_name
		enemy_icon.texture = get_enemy_icon()
	else:
		attacks_list.visible = false
		enemy_selected_label.text = "No enemy selected"
		enemy_icon.texture = null

	if GameManager.selected_attack_name != "":
		dice_roll_panel.visible = true
		attack_name_dice_label.text = GameManager.selected_attack_name
	else:
		dice_roll_panel.visible = false
		attack_name_dice_label.text = "No attack selected"

func update_health_bar(current_health: int, max_health: int) -> void:
	progress_bar.max_value = max_health
	progress_bar.value = current_health

func get_enemy_icon() -> Texture:
	return GameManager.currently_selected_enemy.get_child(0).texture


func _on_fireball_attack_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameManager.selected_attack_name = "FIREBALL"
		attack_icon_dice.texture = fireball_attack.get_child(0).texture
		print("Selected attack:", GameManager.selected_attack_name)
		# Aquí puedes agregar la lógica para lanzar el ataque de bola de fuego


func _on_roll_button_pressed() -> void:
	dice_face = randi_range(1, 20)
	dice_number.text = str(dice_face)
	hud_animation_player.play("RollDice")
