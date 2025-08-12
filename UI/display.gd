extends Node2D
class_name Display


static var tile_map_layer: TileMapLayer
static var world: World


static func set_up(tile_map: TileMapLayer, input_world: World) -> void: 
	tile_map_layer = tile_map
	world = input_world
	SignalBus.player_turn_complete.connect(player_turn_complete)


static func disconnect_signals() -> void:
	SignalBus.player_turn_complete.disconnect(player_turn_complete)


static func player_turn_complete() -> void:
	clear_reachable_tiles()


static func display_reachable_tiles(coord: Vector2i, distance: int) -> void:
	tile_map_layer.clear()
	var reachable_cells: PackedVector2Array = world.get_reachable_cells(coord, distance)
	for cell in reachable_cells:
		tile_map_layer.set_cell(cell, 1, Vector2i(39, 14))
		
		
static func clear_reachable_tiles() -> void:
	tile_map_layer.clear()
