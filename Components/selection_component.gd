extends Node2D
class_name SelectionComponent


signal selection_start(action: Action)
signal selection_complete(tile_object: TileObjectComponent)
signal selection_cancel


enum Selection
{
	SELF,
	OTHER
}

var is_selecting: bool:
	get:
		return selection_action != null


var selection_action: Action = null


func _ready() -> void:
	selection_start.connect(on_selection_start)


func on_selection_start(action: Action) -> void:
	selection_action = action
