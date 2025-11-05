extends Action
class_name HealAction


@export var heal_amount: int


func set_up(_to: TileObjectComponent) -> void:
	super(_to)


func do_action(tile_object: TileObjectComponent) -> void:
	print("Heal!")
	tile_object.health.heal_health(self)
