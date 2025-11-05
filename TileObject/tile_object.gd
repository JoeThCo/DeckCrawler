extends Node2D
class_name TileObject

@export var center: Node2D
@export var movement: Movement

@export var has_collision: bool = true

var tile_object_id: String:
	get:
		return str(get_instance_id()).sha256_text()


var grid_coords: Vector2i:
	get:
		return Room.local_to_map(position)


func set_up() -> void:
	if movement != null:
		movement.set_up(self)
	Room.move_tiles(grid_coords, grid_coords, has_collision)
	print(grid_coords)


func move_tile_object_to(to: Vector2i) -> void:
	var path: PackedVector2Array = Room.get_astar_path(grid_coords, to)
	if Room.is_valid_path(path):
		var next_position: Vector2i = path[1]
		Room.move_tiles(grid_coords, Room.local_to_map(next_position), has_collision)
		await movement_tween(next_position)
		global_position = next_position
		

func movement_tween(next_pos: Vector2) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", next_pos, 0.1)
	await tween.finished


func move_tile_object_direction(direction: Vector2i) -> void:
	move_tile_object_to(grid_coords + direction)


func _to_string() -> String:
	return "{0} @ {1}".format([tile_object_id, grid_coords])
