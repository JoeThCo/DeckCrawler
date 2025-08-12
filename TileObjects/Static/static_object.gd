extends TileObject
class_name StaticObject

@export var static_text: String = "Press [Space] to win!"
var is_player_overlap: bool = false


signal player_entered
signal player_exited


func set_up(input_world: World) -> void:
	super(input_world)
	SignalBus.player_turn_complete.connect(player_turn_complete)


func player_turn_complete() -> void:
	var to: Vector2i = world.player.grid_coords
	var last_overlap: bool = is_player_overlap
	is_player_overlap = grid_coords == to
	
	if is_player_overlap and grid_coords == to:
		player_entered.emit()
	
	if last_overlap and grid_coords != to:
		player_exited.emit()
