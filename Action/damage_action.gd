extends Action
class_name DamageAction


@export var damage_amount: int


func set_up(_to: TileObject) -> void:
	super(_to)


func other_action(_other_tile_object: TileObject) -> void:
	print("Damage")
