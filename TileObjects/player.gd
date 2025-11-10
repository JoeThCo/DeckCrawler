extends TileObjectComponent
class_name PlayerThree

@export_category("Player")
@export var health: HealthComponent
@export var mana: ManaComponent
@export var movement: MovementComponent

@export var deck: Deck
@export var hand_display: HandDisplay


func _ready() -> void:
	health.on_dead.connect(on_player_dead)
	
	movement.moved.connect(on_player_moved)
	deck.action_played.connect(on_action_played)
	
	hand_display.set_up(deck)
	deck.set_up()


func on_player_dead() -> void:
	Game.game_over()
	SFXManager.play_one_shot_sfx("Death")


func on_player_moved() -> void:
	mana.gain_action_mana()


func on_action_played(action_display: ActionDisplay) -> void:
	print(action_display == null)
	mana.lose_mana(action_display.action.cost)
