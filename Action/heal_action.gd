extends Action
class_name HealAction


@export var heal_amount: int


func set_up(_to: TileObject) -> void:
	super(_to)


func do_action(tile_object: TileObject) -> void:
	if tile_object is Being:
		tile_object.health.heal_health(self)
