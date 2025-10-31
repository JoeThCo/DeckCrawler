extends Movement
class_name PlayerMovement


func set_up(_to: TileObject) -> void:
	super(_to)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not tile_object.deck.waiting_for_selection: #TODO move to base?
		var mouse_grid_coords: Vector2i = Room.local_to_map(get_global_mouse_position())
		var distance: int = Room.get_distance(tile_object.grid_coords, mouse_grid_coords)
		if Room.is_valid_distance(distance):
			move(mouse_grid_coords)
			moved.emit()
