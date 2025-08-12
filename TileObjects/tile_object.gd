extends Node2D
class_name TileObject


var world: World

const ACTION_PAUSE_TIME: float = 0.125


var tile_object_id: String:
	get:
		return str(get_instance_id()).sha256_text()


var grid_coords: Vector2i:
	get:
		return world.local_to_map(position)


func set_up(input_world: World) -> void:
	world = input_world


func wait_action_pause_time() -> void:
	await get_tree().create_timer(ACTION_PAUSE_TIME).timeout
