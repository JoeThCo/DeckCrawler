extends Control
class_name Deck


var all_actions: Array[Action] = []

var mana: int = 0
var max_mana_count = 7

var max_hand_size = 5
var deck: Array[Action] = []


func set_up() -> void:
	%DeckUI.set_up()
	
	all_actions.append_array(get_all_in_folder("res://Deck/Card/Resources/Damage"))
	all_actions.append_array(get_all_in_folder("res://Deck/Card/Resources/Shield"))
	
	#deck_add_card_by_name("Bolt")
	#deck_add_card_by_name("Punch")
	#deck_add_cards(2)
	
	SignalBus.player_turn_complete.connect(player_turn_complete)
	SignalBus.player_play_a_card.connect(player_play_a_card)
	SignalBus.player_remove_a_card.connect(player_remove_a_card)
	SignalBus.player_meditate.connect(player_meditate)
	print(deck)
	

func get_all_in_folder(path):
	var items = []
	var dir = DirAccess.open(path)
	if not dir:
		push_error("Invalid dir: " + path)
		return items  # Return an empty list if the directory is invalid

	# print("Opening directory: ", path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		# print("Found file: ", file_name)
		if !file_name.begins_with(".") and !file_name.ends_with(".import"):
			var full_path = path + "/" + file_name
			# Remove .remap extension if present
			if full_path.ends_with(".remap"):
				full_path = full_path.substr(0, full_path.length() - 6)
			# print("Checking path: ", full_path)
			if ResourceLoader.exists(full_path):
				# print("Path exists: ", full_path)
				var res = ResourceLoader.load(full_path)
				if res:
					# print("Loaded resource: ", full_path)
					items.append(res)
				else:
					push_error("Failed to load resource: ", full_path)
			else:
				push_error("Resource does not exist: ", full_path)
		file_name = dir.get_next()
	dir.list_dir_end()
	return items


func deck_add_card() -> void:
	if len(deck) < max_hand_size:
		var action: Action = all_actions.pick_random()
		deck.append(action)
		SignalBus.emit_deck_card_added(action)
	
	
func deck_add_card_by_name(action_name: String) -> void:
	for action: Action in all_actions:
		if action.action_name == action_name:
			deck.append(action)
			SignalBus.emit_deck_card_added(action)
			return
	
	
func deck_add_cards(count: int) -> void:
	for i in range(count):
		deck_add_card()
		
	
func deck_remove_card(card: Card) -> void:
	for i in range(len(deck)):
		if card.action == deck[i]:
			deck.remove_at(i)
			SignalBus.emit_deck_card_removed(card)
			return


func player_play_a_card(card: Card) -> void:
	deck_remove_card(card)
	mana -= card.action.cost
	SignalBus.emit_mana_changed(mana)
	

func player_remove_a_card(card: Card) -> void:
	deck_remove_card(card)


func player_turn_complete() -> void:
	add_mana()

	
func player_meditate() -> void:
	deck_add_card()


func add_mana() -> void:
	if mana < max_mana_count:
		mana += 1
		SignalBus.emit_mana_changed(mana)
		SignalBus.emit_deck_ui_update()
	
	
func has_mana(card: Card) -> bool:
	return mana >= card.action.cost
