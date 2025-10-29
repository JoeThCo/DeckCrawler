extends Movement
class_name BaddieMovement


func set_up(_to: TileObject) -> void:
	super(_to)


func move() -> void:
	tile_object.move_tile_object_to(TileObjectManager.player.grid_coords)
