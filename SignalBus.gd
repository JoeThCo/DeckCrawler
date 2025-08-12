extends Node

signal player_moves(gridcords: Vector2i)
signal player_meditate
signal player_play_a_card(card: Card)
signal player_remove_a_card(card: Card)

signal player_turn_complete
signal baddie_controller_completed

signal mana_changed(mana: int)
signal deck_card_added(action: Action)
signal deck_card_removed(action: Action)

signal deck_card_selected(card: Card)
signal deck_card_cancelled(card: Card)
signal deck_card_being_selected(player: Player, being: Being, card: Card)

signal deck_ui_update

signal static_object_entered(tile_object: TileObject)
signal static_object_exited(tile_object: TileObject)

signal game_paused
signal game_over
signal game_won


#region Player Actions
func emit_player_turn_complete() -> void:
	player_turn_complete.emit()
	
	
func emit_player_moves(gridcords: Vector2i) -> void:
	player_moves.emit(gridcords)


func emit_player_meditate() -> void:
	player_meditate.emit()	


func emit_player_play_a_card(card: Card) -> void:
	player_play_a_card.emit(card)
	
	
func emit_player_remove_a_card(card: Card) -> void:
	player_remove_a_card.emit(card)
	
	
func emit_baddie_controller_completed() -> void:
	baddie_controller_completed.emit()
#endregion	
	
#region Deck
func emit_mana_changed(mana: int) -> void:
	mana_changed.emit(mana)


func emit_deck_card_added(action: Action) -> void:
	deck_card_added.emit(action)
	

func emit_deck_card_removed(card: Card) -> void:
	deck_card_removed.emit(card)


func emit_deck_card_cancelled(card: Card) -> void:
	deck_card_cancelled.emit(card)


func emit_deck_card_selected(card: Card) -> void:
	deck_card_selected.emit(card)
	

func emit_deck_card_being_selected(player: Player, being: Being, card: Card) -> void:
	deck_card_being_selected.emit(player, being, card)


func emit_deck_ui_update() -> void:
	deck_ui_update.emit()

#endregion
	
#region Static
func emit_static_object_entered(static_object: StaticObject) -> void:
	static_object_entered.emit(static_object)
	
	
func emit_static_object_exited(static_object: StaticObject) -> void:
	static_object_exited.emit(static_object)
#endregion

#region Game State
func emit_game_over() -> void:
	game_over.emit()


func emit_game_paused() -> void:
	game_paused.emit()


func emit_game_won() -> void:
	game_won.emit()
	
#endregion
