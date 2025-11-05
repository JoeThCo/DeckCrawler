extends Movement
class_name StaticMovement


var overlap_tile_object: TileObject = null


func set_up(_to: TileObject) -> void:
	super(_to)


func update() -> void:
	var output: TileObject = TileObjectManager.try_and_get_overlapping_tile_object(tile_object)
	if output != null:
		if overlap_tile_object == null:
			print("Overlap Enter!")
			overlap_tile_object = output
	else:
		if overlap_tile_object != null:
			print("Overlap Exit!")
			overlap_tile_object = null
