extends Static
class_name Door


@export var trigger: TriggerComponent
var is_player_over: bool = false


func _ready() -> void:
	trigger.trigger_enter.connect(trigger_enter)
	trigger.trigger_exit.connect(trigger_exit)


func trigger_enter() -> void:
	print("Door Enter!")
	is_player_over = true
	
	
func trigger_exit() -> void:
	is_player_over = false
	print("Door Exit!")
	

func _input(event: InputEvent) -> void:
	if is_player_over and event.is_action_pressed("use_door") :
		print("Door Used!")
