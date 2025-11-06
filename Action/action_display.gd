extends Control
class_name ActionDisplay


@export_category("Nodes")
@export var control_offset: Control


@export_category("Textures")
@export var icon_texture: TextureRect
@export var selected_texture: TextureRect


@export_category("Labels")
@export var name_label: Label
@export var cost_label: Label
@export var target_label: Label
@export var description_label: Label


var tile_object: TileObjectComponent
var action: Action
var is_mouse_over: bool = false


func set_up(_a: Action, _to: TileObjectComponent) -> void:
	action = _a
	tile_object = _to
	
	_to.selection.selection_start.connect(selection_start)
	_to.selection.selection_cancel.connect(selection_cancel)
	
	if action.icon != null:
		icon_texture.texture = action.icon
	name_label.text = action.action_name
	cost_label.text = str(action.cost)
	target_label.text = Helper.enum_to_proper_string(SelectionComponent.Selection.keys()[action.selection])  
	description_label.text = action.description


func selection_start(action_display: ActionDisplay) -> void:
	if action_display != self: return #FIXME remove this?
	selected_texture.visible = true
	#print("Card Border ON")
	

func selection_cancel(action_display: ActionDisplay) -> void:
	if action_display != self: return #FIXME remove this?
	selected_texture.visible = false
	#print("Card Border OFF")


func _on_mouse_entered() -> void:
	is_mouse_over = true
	to_mouse_enter()


func _on_mouse_exited() -> void:
	is_mouse_over = false
	to_mouse_exit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("selection") and is_mouse_over:
		tile_object.selection.selection_start.emit(self)


func to_mouse_enter() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(control_offset, "position", Vector2(0, -100), 0.1)


func to_mouse_exit() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(control_offset, "position", Vector2.ZERO, 0.1)
