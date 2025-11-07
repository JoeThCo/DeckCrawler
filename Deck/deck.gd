extends Control
class_name Deck


signal action_played
signal action_added(action: Action)
signal action_removed(action: Action)


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
	add_action("Heal")
	add_action("Heal")
	add_action("Bolt")
	add_action("Fireball")
	add_action("Damage")
	add_action("Damage")


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


func play_action(action_display: ActionDisplay, other_tile_object: TileObjectComponent) -> void:
	remove_action(action_display.action)
	await action_display.action.execute(other_tile_object)
	action_played.emit()


func print_hand() -> void:
	for action: Action in hand:
		print(action)
