extends TileObjectComponent
class_name BaddieThree


@export var baddie_ai: BaddieAIComponent


func _on_health_component_on_dead() -> void:
	TileObjectManager.delete_tile_object(self)
