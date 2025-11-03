extends Being
class_name Baddie

@export var baddie_ai: BaddieAI


func _ready() -> void:
	super()
	baddie_ai.set_up()


func on_death() -> void:
	super()
	TileObjectManager.delete_tile_object(self)
