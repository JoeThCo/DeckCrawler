extends Node2D
class_name TileObject


@export var movement: Movement


var tile_object_id: String:
	get:
		return str(get_instance_id()).sha256_text()


var grid_coords: Vector2i:
	get:
		return Room.local_to_map(position)


func _ready() -> void:
	movement.set_up(self)


func move_tile_object_to(to: Vector2i) -> void:
	var path: PackedVector2Array = Room.get_astar_path(grid_coords, to)
	if path.size() > 1:
		global_position = path[1]


func move_tile_object_direction(direction: Vector2i) -> void:
	move_tile_object_to(grid_coords + direction)
