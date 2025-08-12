extends Control


@export var deck: Deck


func set_up() -> void:
	clear_ui()
	
	SignalBus.deck_card_added.connect(deck_card_added)
	SignalBus.deck_card_removed.connect(deck_card_removed)
	SignalBus.player_turn_complete.connect(player_turn_complete)
	SignalBus.player_play_a_card.connect(player_play_a_card)
	SignalBus.deck_ui_update.connect(deck_ui_update)
	
	deck_ui_update()


func deck_ui_update() -> void:
	%Mana.text = str(deck.mana)
	

func deck_card_added(action: Action) -> void:
	var card_prefab = load("res://Deck/Card/Card.tscn")
	var card_instance: Card = card_prefab.instantiate() as Card
	card_instance.set_up(action, deck.mana)
	%DeckUI.add_child(card_instance)
	
	
func player_play_a_card(_card: Card) -> void:
	SignalBus.emit_deck_ui_update()
	
	
func deck_card_removed(card: Card) -> void:
	remove_card(card)


func remove_card(card: Card) -> void:
	for n in self.get_children():
		if n is not Card: continue
		var current_card: Card = n as Card
		if current_card == card:
			n.queue_free()
			return
	

func player_turn_complete() -> void:
	SignalBus.emit_deck_ui_update()
	
	
func clear_ui() -> void:
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
