extends TileObjectComponent
class_name PlayerThree


@export var deck: Deck


func _on_health_component_on_dead() -> void:
	Game.game_over()
