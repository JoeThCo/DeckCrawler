extends Node
class_name Deck

#move somewhere else
var all_actions: Array[Action] = []

var hand: Array[Action] = []


func set_up() -> void:
	hand = []
	all_actions.append_array(Helper.get_all_in_folder("res://Action/TestActions/"))
	add_action("Test_Action")
	print_hand()


func add_action(action_name: String) -> void:
	for action: Action in all_actions:
		if Helper.get_resource_name(action) == action_name:
			hand.append(action)
			return
	assert(action_name, " was not found!")


func deck_remove_card(action: Action) -> void:
	for current: Action in hand:
		if current == action:
			hand.erase(current)
			return
	assert(action, " was not found!")


func print_hand() -> void:
	for action: Action in hand:
		print(action)
