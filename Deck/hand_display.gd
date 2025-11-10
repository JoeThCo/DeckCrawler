extends HBoxContainer
class_name HandDisplay


@export var selection: SelectionComponent


var action_displays: Array[ActionDisplay] = []
var deck: Deck


func set_up(_d: Deck) -> void:
	deck = _d
	action_displays = []
	
	deck.action_added.connect(action_added)
	deck.action_removed.connect(action_removed)
	
	SignalBus.game_paused.connect(on_game_paused)
	SignalBus.game_resumed.connect(on_game_resumed)


func on_game_paused() -> void:
	visible = false


func on_game_resumed() -> void:
	visible = true


func action_added(action: Action) -> void:
	var display_prefab: PackedScene = load("res://Action/action_display.tscn")
	var action_display: ActionDisplay = display_prefab.instantiate() as ActionDisplay
	action_display.set_up(action, selection)
	add_child(action_display)
	action_displays.append(action_display)


func action_removed(action: Action) -> void:
	#print("Hand Action Removed")
	for current: ActionDisplay in action_displays:
		if current.action == action:
			remove_action(current)
			return


func remove_action(action_display: ActionDisplay) -> void:
	#print("Hand Remove Action")
	action_displays.erase(action_display)
	action_display.queue_free()
