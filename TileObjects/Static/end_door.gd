extends StaticObject
class_name EndDoor


func set_up(input_world: World) -> void:
	super(input_world)
	player_entered.connect(on_player_entered)
	player_exited.connect(on_player_exited)
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_E and is_player_overlap:
			SignalBus.emit_game_won()


func on_player_entered() -> void:
	%Label.text = static_text
	
	
func on_player_exited() -> void:
	%Label.text = ""
