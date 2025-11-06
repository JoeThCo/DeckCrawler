extends Node2D
class_name PlayerControlsComponent


@export var selection: SelectionComponent
@export var movement: MovementComponent


func _unhandled_input(event: InputEvent) -> void:
	if not selection.is_selecting: return
	if event.is_action_pressed("selection"):
		var mouse_grid_coords: Vector2i = Room.local_to_map(get_global_mouse_position())
		var distance: int = Room.get_distance(movement.grid_coords, mouse_grid_coords)
		if Room.is_valid_distance(distance):
			await movement.move(mouse_grid_coords)
