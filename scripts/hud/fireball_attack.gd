extends HBoxContainer

enum AttackType {
	FIREBALL,
	ICE_SHARD,
	LIGHTNING_BOLT
}

@export var attack_type: AttackType 
@export var damage: int

func _ready() -> void:
	calc_damage()


func calc_damage():
	match attack_type:
		AttackType.FIREBALL:
			damage = 10
		AttackType.ICE_SHARD:
			damage = 8
		AttackType.LIGHTNING_BOLT:
			damage = 12
