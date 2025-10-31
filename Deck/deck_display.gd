extends HBoxContainer
class_name DeckDisplay


var action_displays: Array[ActionDisplay] = []
var deck: Deck


func set_up(_d: Deck) -> void:
	deck = _d
	action_displays = []
	deck.action_added.connect(action_added)
	deck.action_removed.connect(action_removed)


func action_added(action: Action) -> void:
	var display_prefab: PackedScene = load("res://Action/action_display.tscn")
	var action_display: ActionDisplay = display_prefab.instantiate() as ActionDisplay
	action_display.set_up(action)
	add_child(action_display)
	action_displays.append(action_display)
	action_display.action_selected.connect(action_selected)


func action_removed(action: Action) -> void:
	for current: ActionDisplay in action_displays:
		if current.action == action:
			remove_action(current)
			return


func remove_action(action_display: ActionDisplay) -> void:
	action_display.action_selected.disconnect(action_selected)
	action_displays.erase(action_display)
	action_display.queue_free()


func action_selected(action: Action) -> void:
	deck.remove_card(action)
	pass
