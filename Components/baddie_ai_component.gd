extends Node
class_name BaddieAIComponent


@export var movement: MovementComponent
@export var action_mod: int = 1


func can_do_action() -> bool:
	return Game.turn_count % action_mod == 0


func do_best_action() -> void:
	if not can_do_action(): return
	var best_ally: TileObjectComponent = get_best_tile_object()
	await movement.move(best_ally.movement.grid_coords)


func get_best_tile_object() -> TileObjectComponent:
	return TileObjectManager.get_closest_on_team(movement.grid_coords, TeamComponent.Team.ALLY)
