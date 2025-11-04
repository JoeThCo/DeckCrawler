extends Node2D
class_name Movement


#TODO Do we need the movement class? Player move with mouse, baddie/friend with AI. Seems like a wrapper
@warning_ignore("unused_signal")
signal moved


var tile_object: TileObject


var grid_coords: Vector2i:
	get: return tile_object.grid_coords


func set_up(_to: TileObject) -> void:
	tile_object = _to


func move(coords: Vector2i) -> void:
	await tile_object.move_tile_object_to(coords)
