extends SelectionComponent
class_name PlayerSelectionComponent


@export var deck: Deck


#FIXME select multiple cards
#FIXME Do multiple (just self?) actions at once


func _ready() -> void:
	selection_start.connect(on_selection_start)
	selection_cancel.connect(on_selection_cancel)
	selection_complete.connect(on_selection_complete)


func on_selection_start(action_display: ActionDisplay) -> void:
	#print("Selection Start")
	if selected_action_display != null and selected_action_display != action_display:
		selected_action_display.un_selected()
		
		
	is_selecting = true
	selected_action_display = action_display
	selected_action_display.selected()


func on_selection_cancel(_action_display: ActionDisplay) -> void:
	SFXManager.play_one_shot_sfx("ActionCancel")
	selected_action_display.un_selected()
	is_selecting = false


func on_selection_complete(selected_tile_object: TileObjectComponent) -> void:
	#print("Selection Complete")
	if selected_action_display != null:
		selected_action_display.un_selected() #HACK not sure why I have to do this
		SFXManager.play_one_shot_sfx("ActionPlayed")
		await deck.play_action(selected_action_display, selected_tile_object)
		is_selecting = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("selection"):
		#print("Selection Mouse Down")
		var temp_to: TileObjectComponent = TileObjectManager.get_tile_object_at_global_coords(get_global_mouse_position())
		if temp_to != null:
			selection_complete.emit(temp_to)
			selected_action_display = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		#print("Cancel Mouse Down")
		if selected_action_display != null:
			selection_cancel.emit(selected_action_display)
			selected_action_display = null
