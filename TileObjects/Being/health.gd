extends Node2D
class_name Health


signal on_health_change
signal on_shield_change


signal on_death


@export var current_shield: int
@export var current_health: int
var max_health: int


var is_dead: bool:
	get: return current_health <= 0


func _ready() -> void:
	max_health = current_health
	on_health_change.connect(health_change)
	on_shield_change.connect(shield_change)
	health_change()
	shield_change()
	

func take_damage(action: DamageAction) -> void:
	var remaining_damage: int = max(action.damage_amount - current_shield, 0)
	var shield_used: int = min(action.damage_amount, current_shield)
	
	current_shield -= shield_used
	if shield_used > 0:
		on_shield_change.emit()
	
	current_health -= remaining_damage
	if remaining_damage > 0:
		on_health_change.emit()
		
	if is_dead:
		on_death.emit()


func give_shield(action: ShieldAction) -> void:
	current_shield += action.shield_amount
	on_shield_change.emit()


func health_change() -> void:
	%HealthLabel.text = "{0}/{1}".format([current_health, max_health])
	%HealthBar.value = (float(current_health) / float(max_health))


func shield_change() -> void:
	%ShieldLabel.text = str(current_shield)
	%ShieldHBox.visible = current_shield > 0
