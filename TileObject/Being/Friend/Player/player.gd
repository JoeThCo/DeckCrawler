extends Friend
class_name Player


@export var hand_display: HandDisplay


func set_up() -> void:
	super()
	hand_display.set_up(deck)
	deck.hand_init()


func on_death() -> void:
	super()
	print("Game Over!")
	Game.game_over()
