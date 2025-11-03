extends Node


signal tile_object_selection(tile_object: TileObject)

signal game_paused
signal game_resumed


func emit_tile_object_selection(tile_object: TileObject) -> void:
	tile_object_selection.emit(tile_object)


func emit_game_paused() -> void:
	game_paused.emit()


func emit_game_resumed() -> void:
	game_resumed.emit()
