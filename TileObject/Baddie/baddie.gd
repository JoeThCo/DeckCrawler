extends TileObject
class_name Baddie


func _ready() -> void:
	super()
	movement.baddie_set_up(TileObjectManager.player)
