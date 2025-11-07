extends TileMapLayer
class_name MouseHighlight


static var tile_map: TileMapLayer


static func set_up(_tm: TileMapLayer) -> void:
	tile_map = _tm


func _unhandled_input(_event: InputEvent) -> void:
	tile_map.clear()
	var grid_coords: Vector2i = Room.local_to_map(get_global_mouse_position())
	tile_map.set_cell(grid_coords, 0, Vector2i(39, 14))
