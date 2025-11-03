extends Action
class_name HealAction


@export var heal_amount: int


func set_up(_to: TileObject) -> void:
	super(_to)


func other_action(_other_tile_object: TileObject) -> void:
	print("Heal")
