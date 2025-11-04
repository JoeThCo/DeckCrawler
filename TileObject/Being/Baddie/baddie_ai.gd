extends BeingAI
class_name BaddieAI


func set_up(_b: Being) -> void:
	super(_b)


func do_best_action() -> void:
	super()
	if not can_do_action(): return
	if being is Baddie:
		await being.movement.move(TileObjectManager.get_closest_friend(being.grid_coords).grid_coords)
