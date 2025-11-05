extends Action
class_name DamageAction


@export var damage_amount: int


func set_up(_to: TileObjectComponent) -> void:
	super(_to)


func do_action(tile_object: TileObjectComponent) -> void:
	print("Damage!")
	tile_object.health_component.take_damage(self)
