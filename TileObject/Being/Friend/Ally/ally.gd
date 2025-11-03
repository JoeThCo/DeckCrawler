extends Friend
class_name Ally


@export var ally_ai: AllyAI


func  _ready() -> void:
	super()
	ally_ai.set_up()
