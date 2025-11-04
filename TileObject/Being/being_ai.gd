extends Node
class_name BeingAI


var being: Being
@export var action_mod: int = 1


func set_up(_b: Being) -> void:
	being = _b


func do_best_action() -> void:
	pass


func can_do_action() -> bool:
	return Game.turn_count % action_mod == 0
