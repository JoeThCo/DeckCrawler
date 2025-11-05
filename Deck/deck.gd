extends Node
class_name Deck


signal action_added(action: Action)
signal action_removed(action: Action)
signal action_played(action: Action)

@export var tile_object: TileObjectComponent

#TODO move somewhere else
var all_actions: Array[Action] = []
var hand: Array[Action] = []

var waiting_for_selection: bool = false

func _ready() -> void:
	hand = []
	all_actions.append_array(Helper.get_all_in_folder("res://Action/TestActions/"))
	print_hand()
	hand_init()


func hand_init() -> void:
	add_action("Heal_Other")
	add_action("Heal_Self")
	add_action("Bolt_Other")
	add_action("Damage_Other")
	add_action("Damage_Other")
	add_action("Damage_Other")


func add_action(action_name: String) -> void:
	for action: Action in all_actions:
		if Helper.get_resource_name(action) == action_name:
			action.set_up(tile_object)
			hand.append(action)
			action_added.emit(action)
			return
	assert(action_name, " was not found!")


func remove_action(action: Action) -> void:
	hand.erase(action)
	action_removed.emit(action)


func play_action(action: Action) -> void:
	remove_action(action)
	waiting_for_selection = true
	await action.execute()
	waiting_for_selection = false
	action_played.emit(action)


func print_hand() -> void:
	for action: Action in hand:
		print(action)
