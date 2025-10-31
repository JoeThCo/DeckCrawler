extends Node2D
class_name Game


@export var room_tile_map_layer: TileMapLayer
@export var tile_object_spawn_parent: Node2D


func _ready() -> void:
	World.generate_world(1, 250)
	World.print_floorplan()
	Room.set_up(room_tile_map_layer)
	TileObjectManager.set_up(tile_object_spawn_parent)
