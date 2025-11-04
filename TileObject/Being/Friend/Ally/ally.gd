extends Friend
class_name Ally


@export var ally_ai: AllyAI


func set_up() -> void:
	ally_ai.set_up(self)
