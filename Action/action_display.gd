extends Control
class_name ActionDisplay


signal action_selected(action: Action)


@export_category("Labels")
@export var name_label: Label
@export var cost_label: Label
@export var target_label: Label


var action: Action
var is_mouse_over: bool = false


func set_up(_a: Action) -> void:
	action = _a
	name_label.text = Helper.get_resource_name(action) 
	cost_label.text = "Cost: " + str(action.cost)
	target_label.text = Helper.get_resource_name(action)


func _on_mouse_entered() -> void:
	is_mouse_over = true
	#print(is_mouse_over)


func _on_mouse_exited() -> void:
	is_mouse_over = false
	#print(is_mouse_over)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and is_mouse_over:
		action_selected.emit(action)
