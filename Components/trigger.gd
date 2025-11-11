extends Node2D
class_name TriggerComponent

@export var team: TeamComponent.Team
@export var movement: MovementComponent

var tile_object: TileObjectComponent

func update_trigger() -> void:
	var trigger_to: TileObjectComponent = TileObjectManager.get_closest(movement.grid_coords, team)
	if tile_object != null:
		tile_object = trigger_to
