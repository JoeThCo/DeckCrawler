extends Movement
class_name PlayerMovement


func set_up(_to: TileObject) -> void:
	super(_to)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var mouse_grid_coords: Vector2i = Room.local_to_map(get_global_mouse_position())
		tile_object.move_tile_object_to(mouse_grid_coords)
		moved.emit()
