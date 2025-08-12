extends CanvasLayer


var world: World
var card: Card


func set_up(input_world: World) -> void:
	world = input_world
	SignalBus.deck_card_selected.connect(deck_action_selected)
	SignalBus.deck_card_removed.connect(deck_card_removed)
	SignalBus.deck_card_cancelled.connect(deck_card_cancelled)
	%Selection.visible = false


func _physics_process(_delta: float) -> void:
	%Mouse.clear()
	%Mouse.set_cell(world.get_mouse_grid_coords(), 1, Vector2i(39,14), 0)


func _input(event: InputEvent) -> void:
	if !world.player.can_do_player_action: return
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if card != null:
				var being: Being = world.get_being_at_coords(world.get_local_mouse_position())
				if being != null:
					SignalBus.emit_deck_card_being_selected(world.player, being, card)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			SignalBus.emit_deck_card_cancelled(card)


func deck_action_selected(input_card: Card) -> void:
	self.card = input_card
	Display.clear_reachable_tiles()
	%Selection.visible = true
	
	if card.action is DamageAction:
	#	%SelectionLabel.text = "Select a Baddie to Damage"
		Display.display_reachable_tiles(world.player.grid_coords, card.action.distance.get_distance())
	#elif card.action is ShieldAction:
	#	%SelectionLabel.text = "Select a Player to Shield"


func deck_card_cancelled(_card: Card) -> void:
	reset_selection()
	
	
func deck_card_removed(_card: Card) -> void:
	reset_selection()


func reset_selection() -> void:
	card = null
	%Selection.visible = false
	Display.clear_reachable_tiles()
