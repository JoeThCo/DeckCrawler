extends Action
class_name ShieldAction


@export var shield_amount: int = 1


func execute(being: Being) -> void:
	being.health.give_shield(self)
