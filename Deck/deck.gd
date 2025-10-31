extends Node
class_name Deck


signal action_added(action: Action)
signal action_removed(action: Action)


#move somewhere else
var all_actions: Array[Action] = []

var hand: Array[Action] = []
var owner_object: TileObject


func set_up(_to: TileObject) -> void:
	owner_object = _to
	hand = []
	all_actions.append_array(Helper.get_all_in_folder("res://Action/TestActions/"))
	print_hand()
	
	
func hand_init() -> void:
	add_action("Test_Action")
	add_action("Test_Action")
	add_action("Test_Action")


func add_action(action_name: String) -> void:
	for action: Action in all_actions:
		if Helper.get_resource_name(action) == action_name:
			hand.append(action)
			action_added.emit(action)
			return
	assert(action_name, " was not found!")


func remove_card(action: Action) -> void:
	hand.erase(action)
	action_removed.emit(action)


func print_hand() -> void:
	for action: Action in hand:
		print(action)
