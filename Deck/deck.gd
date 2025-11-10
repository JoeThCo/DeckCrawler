extends Control
class_name Deck


signal action_played(action_display: ActionDisplay)
signal action_added(action: Action)
signal action_removed(action: Action)

@export var deck_to_load: SavedDeck
@export var tile_object: TileObjectComponent


const ACTION_PATH: String = "res://Action/TestActions/"


var hand: Array[Action] = []


func set_up() -> void:
	hand = []
	hand_init()
	print_hand()


func hand_init() -> void:
	for action_name: String in deck_to_load.deck_actions:
		var temp_load = load(ACTION_PATH + action_name + ".tres")
		if temp_load != null and temp_load is Action:
			try_add_action(temp_load)
		

func try_add_action(action: Action) -> void:
	action.set_up(tile_object)
	hand.append(action)
	action_added.emit(action)


func remove_action(action: Action) -> void:
	hand.erase(action)
	action_removed.emit(action)


func play_action(action_display: ActionDisplay, other_tile_object: TileObjectComponent) -> void:
	action_display.visible = false
	await action_display.action.execute(other_tile_object)
	remove_action(action_display.action)
	action_played.emit(action_display)


func print_hand() -> void:
	for action: Action in hand:
		print(action)
