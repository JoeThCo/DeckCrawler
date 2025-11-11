extends Node
class_name BaddieAIComponent


@export var movement: MovementComponent
@export var modulus: TurnModulusComponent


func do_best_action() -> void:
	if not modulus.is_turn(): return
	var best_ally: TileObjectComponent = get_best_tile_object()
	await movement.move(best_ally.movement.grid_coords)


func get_best_tile_object() -> TileObjectComponent:
	return TileObjectManager.get_closest(movement.grid_coords, [PlayerThree])
