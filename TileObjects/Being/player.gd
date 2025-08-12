extends Being
class_name Player


@export var deck: Deck
var can_do_player_action: bool = true


func set_up(_world: World) -> void:
	super(_world)
	deck.set_up()
	
	health.on_death.connect(on_player_death)
	SignalBus.deck_card_being_selected.connect(deck_card_being_selected)
	SignalBus.baddie_controller_completed.connect(baddie_controller_completed)


func deck_card_being_selected(player: Player, being: Being, card: Card) -> void:
	if !can_do_player_action: return
	if !deck.has_mana(card): return
	if !can_execute_card(player, being, card): return
	card.action.execute(being)
	SignalBus.emit_player_play_a_card(card)
	SignalBus.emit_player_turn_complete()
	print("Player!")


func _input(event: InputEvent) -> void:
	if !can_do_player_action: return
	
	if event.is_action("up"):
		move_player(Vector2.UP)
	if event.is_action("down"):
		move_player(Vector2.DOWN)
	if event.is_action("left"):
		move_player(Vector2.LEFT)
	if event.is_action("right"):
		move_player(Vector2.RIGHT)
		
	if event.is_action_pressed("space"):
		player_meditate()
		
		
func player_meditate() -> void:
	SignalBus.emit_player_meditate()
	SignalBus.emit_player_turn_complete()
	can_do_player_action = true


func move_player(direction: Vector2i) -> void:
	can_do_player_action = false;
	if(is_valid_move(grid_coords + direction)):
		await move(grid_coords + direction)
		SignalBus.emit_player_moves(grid_coords)
		SignalBus.emit_player_turn_complete()
	else:
		can_do_player_action = true;
	
	
func is_valid_move(to: Vector2i) -> bool:
	var path: PackedVector2Array = get_pathfinding_path(to) #pathfind twice to move
	return len(path) != 1


func on_player_death() -> void:
	SignalBus.emit_game_over()


func baddie_controller_completed() -> void:
	can_do_player_action = true
