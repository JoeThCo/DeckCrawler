extends Node


signal tile_object_selection(tile_object: TileObject)


func emit_tile_object_selection(tile_object: TileObject) -> void:
	tile_object_selection.emit(tile_object)
