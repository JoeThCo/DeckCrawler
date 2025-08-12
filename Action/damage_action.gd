extends Action
class_name DamageAction


@export var damage_amount: int = 1


func execute(being: Being) -> void:
	being.health.take_damage(self)
