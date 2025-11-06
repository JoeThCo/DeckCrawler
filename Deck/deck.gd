extends Node
class_name Deck


signal action_added(action: Action)
signal action_removed(action: Action)
signal action_played(action: Action)


@export var tile_object: TileObjectComponent
@export var hand_display: HandDisplay


#TODO move somewhere else
var all_actions: Array[Action] = []
var hand: Array[Action] = []


func _ready() -> void:
	hand = []
	all_actions.append_array(Helper.get_all_in_folder("res://Action/TestActions/"))
	
	if hand_display != null:
		hand_display.set_up(self)
	hand_init()
	print_hand()


func hand_init() -> void:
	add_action("Heal_Other")
	add_action("Heal_Self")
	add_action("Bolt_Other")
	add_action("Damage_Self")
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
	tile_object.selection.selection_start.emit(action)
	var other_tile_object: TileObjectComponent = await tile_object.selection.selection_complete
	remove_action(action)
	await action.execute(other_tile_object)
	action_played.emit(action)


func print_hand() -> void:
	for action: Action in hand:
		print(action)
