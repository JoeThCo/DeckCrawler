extends Control
class_name Deck


signal action_played
signal action_added(action: Action)
signal action_removed(action: Action)

@export var deck_to_load: SavedDeck

@export var tile_object: TileObjectComponent
@export var hand_display: HandDisplay
@export var mana: ManaComponent

const ACTION_PATH: String = "res://Action/TestActions/"

#TODO move somewhere else
var all_actions: Array[Action] = []
var hand: Array[Action] = []


func _ready() -> void:
	hand = []
	
	if hand_display != null:
		hand_display.set_up(self)
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


func can_play_action(action: Action) -> bool:
	return mana.current_mana >= action.cost
	

func play_action(action_display: ActionDisplay, other_tile_object: TileObjectComponent) -> void:
	remove_action(action_display.action)
	mana.lose_mana(action_display.action.cost)
	await action_display.action.execute(other_tile_object)
	action_played.emit()


func print_hand() -> void:
	for action: Action in hand:
		print(action)
