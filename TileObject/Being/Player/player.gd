extends Friend
class_name Player


@export var deck_display: DeckDisplay


func _ready() -> void:
	super()
	deck_display.set_up(deck)
	deck.hand_init()


func on_death() -> void:
	super()
	print("Game Over!")
