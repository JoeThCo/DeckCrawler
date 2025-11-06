extends SelectionComponent
class_name PlayerSelectionComponent


func _unhandled_input(event: InputEvent) -> void:
	if selection_action != null:
		if selection_action.selection == Selection.SELF:
			selection_complete.emit(tile_object)
			await selection_action.action_complete
			selection_action = null

	if event.is_action_pressed("selection"):
		var temp_selection: TileObjectComponent = TileObjectManager.get_tile_object_at_global_coords(get_global_mouse_position())
		if temp_selection != null:
			selection_complete.emit(temp_selection)
			await selection_action.action_complete
			selection_action = null
	
	if event.is_action_pressed("cancel"):
		selection_action = null
		selection_cancel.emit()

# Left Click on a card
# Left Click with mouse
# Start Selection
# If there is a TileObject at mouse and meets conditions for play, play action: End selection
# Right Click: End Selection
