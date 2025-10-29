extends Movement
class_name BaddieMovement


var player: Player


func set_up(_to: TileObject) -> void:
	super(_to)


func baddie_set_up(_p: Player) -> void:
	player = _p


func move() -> void:
	tile_object.move_tile_object_to(TileObjectManager.player.grid_coords)
	print("Baddie Move")
