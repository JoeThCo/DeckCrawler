extends Control
class_name ActionDisplay


@export_category("Labels")
@export var name_label: Label
@export var cost_label: Label
@export var target_label: Label


var action: Action


func set_up(_a: Action) -> void:
	action = _a
	name_label.text = action.action_name
	cost_label.text = "Cost: " + str(action.cost)
	target_label.text = Helper.get_resource_name(action)
