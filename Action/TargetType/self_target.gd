extends Target
class_name SelfTarget


func set_up(tile_object: TileObjectComponent) -> void:
	super(tile_object)
	target_name = "Self"
