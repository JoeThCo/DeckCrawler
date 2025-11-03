extends Action
class_name DamageAction


@export var damage_amount: int


func set_up(_to: TileObject) -> void:
	super(_to)


func do_action(tile_object: TileObject) -> void:
	if tile_object is Being:
		print("Damage!")
		tile_object.health.take_damage(self)
