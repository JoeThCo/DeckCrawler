extends Control
class_name ActionDisplay


signal action_played(action: Action)


@export_category("Nodes")
@export var control_offset: Control

@export_category("Textures")
@export var icon_texture: TextureRect

@export_category("Labels")
@export var name_label: Label
@export var cost_label: Label
@export var target_label: Label
@export var description_label: Label


const DO_TWEENS: bool = true

var action: Action
var is_mouse_over: bool = false


func set_up(_a: Action) -> void:
	action = _a
	
	if action.icon != null:
		icon_texture.texture = action.icon
	name_label.text = action.action_name
	cost_label.text = str(action.cost)
	target_label.text = Helper.enum_to_proper_string(SelectionComponent.Selection.keys()[action.selection])  
	description_label.text = action.description


func _on_mouse_entered() -> void:
	is_mouse_over = true
	if not DO_TWEENS: return
	to_mouse_enter()
	

func _on_mouse_exited() -> void:
	is_mouse_over = false
	if not DO_TWEENS: return
	to_mouse_exit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("selection") and is_mouse_over:
		action_played.emit(action)


func to_mouse_enter() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(control_offset, "position", Vector2(0, -100), 0.1)


func to_mouse_exit() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(control_offset, "position", Vector2.ZERO, 0.1)	
