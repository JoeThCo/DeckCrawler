extends Node
class_name TurnModulusComponent


@export var modulus: int = 1


func is_turn() -> bool:
	return Game.turn_count % modulus == 0
