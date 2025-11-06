extends Node
class_name HealthComponent


signal health_changed()
signal damaged
signal healed
signal on_dead


var is_dead: bool:
	get: return health <= 0


@export var health: int
var max_health: int


func _ready() -> void:
	max_health = health
	health_changed.emit()


func take_damage(action: DamageAction) -> void:
	if action.damage_amount <= 0: return
	health -= action.damage_amount
	damaged.emit()
	health_changed.emit()
	if is_dead:
		on_dead.emit()


func heal_health(action: HealAction) -> void:
	if action.heal_amount <= 0: return
	health += action.heal_amount
	health = clamp(health, 0, max_health)
	healed.emit()
	health_changed.emit()
