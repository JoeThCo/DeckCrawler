extends Node2D
class_name MovementComponent


@export var base_node: Node2D
signal moved


var grid_coords: Vector2i:
	get:
		return Room.local_to_map(base_node.global_position)


func _ready() -> void:
	Room.move_tiles(grid_coords, grid_coords)


func move(coords: Vector2i) -> void:
	await _move_tile_object_to(coords)
	moved.emit()


func _move_tile_object_to(to: Vector2i) -> void:
	var path: PackedVector2Array = Room.get_astar_path(grid_coords, to)
	if Room.is_valid_path(path):
		var next_position: Vector2i = path[1]
		Room.move_tiles(grid_coords, Room.local_to_map(next_position))
		await movement_tween(next_position)
		base_node.global_position = next_position


func movement_tween(next_pos: Vector2) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(base_node, "global_position", next_pos, 0.1)
	await tween.finished
