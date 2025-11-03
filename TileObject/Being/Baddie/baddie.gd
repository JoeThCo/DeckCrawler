extends Being
class_name Baddie


func _ready() -> void:
	super()

func on_death() -> void:
	super()
	TileObjectManager.delete_tile_object(self)
