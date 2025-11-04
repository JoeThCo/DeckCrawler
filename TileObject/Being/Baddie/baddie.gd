extends Being
class_name Baddie


func set_up() -> void:
	super()


func on_death() -> void:
	super()
	TileObjectManager.delete_tile_object(self)
