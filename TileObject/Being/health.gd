extends Node
class_name Health

signal health_changed
signal on_dead

var is_dead: bool:
	get: return health <= 0


@export var health: int
var max_health: int


func set_up() -> void:
	max_health = health


func take_damage(action: DamageAction) -> void:
	health -= action.damage_amount
	health_changed.emit()
	if is_dead:
		on_dead.emit()


func heal_health(action: HealAction) -> void:
	health += action.heal_amount
	health = clamp(health, 0, max_health)
	health_changed.emit()
