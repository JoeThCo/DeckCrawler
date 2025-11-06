extends Node2D
class_name SelectionComponent


@export var tile_object: TileObjectComponent


@warning_ignore("unused_signal")
signal selection_start(action_display: ActionDisplay)
@warning_ignore("unused_signal")
signal selection_complete(tile_object: TileObjectComponent)
@warning_ignore("unused_signal")
signal selection_cancel(action_display: ActionDisplay)


enum Selection
{
	SELF,
	OTHER
}

var is_selecting: bool:
	get:
		return selected_action_display != null


var selected_action_display: ActionDisplay = null
