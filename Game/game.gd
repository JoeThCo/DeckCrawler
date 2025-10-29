extends Node2D
class_name Game


@export var room_tile_map_layer: TileMapLayer


func _ready() -> void:
	World.generate_world(2, 250)
	World.print_floorplan()
	
	Room.set_up(room_tile_map_layer)
