extends Node2D
class_name Game


@export var room_tile_map_layer: TileMapLayer
@export var tile_object_spawn_parent: Node2D


func _ready() -> void:
	World.generate_world(1, 250)
	World.print_floorplan()
	Room.set_up(room_tile_map_layer)
	TileObjectManager.set_up(tile_object_spawn_parent)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var tile_object: TileObject = TileObjectManager.get_tile_object_at_global_coords(get_global_mouse_position())
		if tile_object != null:
			print(tile_object)
		else:
			print("None!")
