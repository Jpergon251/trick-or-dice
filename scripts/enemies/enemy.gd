extends Node3D

var is_selected: bool = false
var enemy_type: EnemyType
var health: int = 100
var enemy_name: String = ""
var enemy_lvl: int

#TEMATICA DE HALLOWEEN
enum EnemyType {
	ZOMBIE,
	GHOST,
	WITCH,
	VAMPIRE,
	FRANKENSTEIN
}

@onready var hover_highlight: Sprite3D = $HoverHighlight
@onready var selected_highlight: Sprite3D = $SelectedHighlight
@onready var enemy_name_label: Label3D = $EnemyNameLabel


func _ready() -> void:
	hover_highlight.visible = false
	selected_highlight.visible = false
	enemy_type = get_random_enemytype()
	set_enemy_level()
	set_enemy_name()
	
	print("Spawned enemy of type:", enemy_type)

func _process(delta: float) -> void:
	if is_selected and GameManager.currently_selected_enemy != self:
		is_selected = false
		selected_highlight.visible = false

func _on_area_3d_mouse_entered() -> void:
	hover_highlight.visible = true

func _on_area_3d_mouse_exited() -> void:
	hover_highlight.visible = false
	

#Solo puede estar seleccionado un enemigo a la vez
func _on_enemy_area_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		select_enemy(self)
		selected_highlight.visible = true
		is_selected = true
		hover_highlight.visible = false

func select_enemy(enemy: Node3D) -> void:
	is_selected = true
	selected_highlight.visible = true
	GameManager.currently_selected_enemy = enemy


	print("Selected enemy:", GameManager.currently_selected_enemy.name)

func set_enemy_name():
	match enemy_type:
		EnemyType.ZOMBIE:
			enemy_name = "Zombie Lv." + str(enemy_lvl)
		EnemyType.GHOST:
			enemy_name = "Ghost Lv." + str(enemy_lvl)
		EnemyType.WITCH:
			enemy_name = "Witch Lv." + str(enemy_lvl)
		EnemyType.VAMPIRE:
			enemy_name = "Vampire Lv." + str(enemy_lvl)
		EnemyType.FRANKENSTEIN:
			enemy_name = "Frankenstein Lv." + str(enemy_lvl)
	enemy_name_label.text = enemy_name

#Devuelve un tipo de enemigo aleatorio en string para asignarlo al nombre
func get_random_enemytype() -> EnemyType:
	var types = EnemyType.values()
	var random_index = randi() % types.size()
	return types[random_index]

func set_enemy_level():
	match GameManager.phase:
		GameManager.Phase.FIRST:
			enemy_lvl = randi_range(1, 3)
		GameManager.Phase.SECOND:
			enemy_lvl = randi_range(2, 4)
		GameManager.Phase.THIRD:
			enemy_lvl = randi_range(3, 6)
		GameManager.Phase.FOURTH:
			enemy_lvl = randi_range(5, 8)
		GameManager.Phase.FIFTH:
			enemy_lvl = randi_range(8, 10)
		GameManager.Phase.SIXTH:
			enemy_lvl = randi_range(8, 12)
		GameManager.Phase.SEVENTH:
			enemy_lvl = randi_range(10, 14)
		GameManager.Phase.EIGHTH:
			enemy_lvl = randi_range(12, 16)
		GameManager.Phase.NINTH:
			enemy_lvl = randi_range(14, 18)
		GameManager.Phase.TENTH:
			enemy_lvl = randi_range(16, 20)


func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		die()

func die() -> void:
	print(enemy_name + " has been defeated!")
	if GameManager.currently_selected_enemy == self:
		GameManager.currently_selected_enemy = null
		GameManager.enemies_defeated += 1
	queue_free()
