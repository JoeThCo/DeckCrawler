extends TileObjectComponent
class_name PlayerThree


@export var deck: Deck


func _ready() -> void:
	health.on_dead.connect(on_player_dead)


func on_player_dead() -> void:
	Game.game_over()
	SFXManager.play_one_shot_sfx("Death")
