extends Control
class_name Card


var action: Action

var is_mouse_over: bool = false
var is_deleting: bool = false
var can_interact_with: bool = false


func set_up(input_action: Action, mana: int) -> void:
	self.action = input_action
	
	SignalBus.mana_changed.connect(mana_changed)
	
	%Cost.text = str(action.cost)
	%Name.text = action.action_name
	%Description.text = action.description
	%Icon.texture = action.icon
	%Highlight.visible = false
	mana_changed(mana)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and is_mouse_over:
		if can_interact_with and event.button_index == MOUSE_BUTTON_LEFT:
			SignalBus.emit_deck_card_selected(self)
		if  event.button_index == MOUSE_BUTTON_MIDDLE:
			is_deleting = true
			SignalBus.emit_player_remove_a_card(self)
			SignalBus.emit_player_turn_complete()


func _on_mouse_entered() -> void:
	is_mouse_over = true
	if can_interact_with:
		%Highlight.visible = true
	
	
func _on_mouse_exited() -> void:
	is_mouse_over = false
	if !can_interact_with: return #something about this feels weird...
	if !is_deleting:
		%Highlight.visible = false


func mana_changed(mana: int) -> void:
	can_interact_with = mana >= action.cost
	%NotEnoughMana.visible = !can_interact_with
