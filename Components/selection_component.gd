extends Node2D
class_name SelectionComponent


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
	SignalBus.selection_init.connect(selection_init)


func selection_init(action: Action) -> void:
	selection_action = action


func _unhandled_input(event: InputEvent) -> void:
	if selection_action == null: return
	if event.is_action_pressed("selection"):
		var temp_selection: TileObjectComponent = TileObjectManager.get_tile_object_at_global_coords(get_global_mouse_position())
		if temp_selection != null:
			#FIXME this one works if we await. Do we care? Proably should fix regardless
			SignalBus.emit_tile_object_selection(temp_selection)
			await selection_action.action_complete
			selection_action = null
