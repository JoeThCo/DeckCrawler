extends Being
class_name Baddie


@export var damage_action: DamageAction


func set_up(in_world: World) -> void:
	super(in_world)
	self.world = in_world
	SignalBus.deck_card_being_selected.connect(deck_card_being_selected)


func deck_card_being_selected(player: Player, being: Being, card: Card) -> void:
	if !can_execute_card(player, being, card): return
	card.action.execute(being)
	SignalBus.emit_player_play_a_card(card)
	SignalBus.emit_player_turn_complete()
	print("Baddie!")


func move_towards_player(player_coords: Vector2i) -> void:
	var distance_away: int = world.get_distance_away(grid_coords, player_coords)
	if distance_away > 1:
		await move(player_coords)


func can_attack_player() -> bool:
	var distance_away: int = world.get_distance_from_player(grid_coords)
	return damage_action.distance.is_correct_distance(distance_away)
	
	
func attack_player(player: Player) -> void:
	player.take_damage(damage_action)


func on_death() -> void:
	%DeathTimer.start()
	%Dead.visible = true
	await %DeathTimer.timeout


func _on_death_timer_timeout() -> void:
	world.set_point_empty(grid_coords)
	queue_free()
