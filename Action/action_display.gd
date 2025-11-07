extends Control
class_name ActionDisplay


@export_category("Values")
@export var card_lerp_time: float = 0.15


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
	
	icon_texture.texture = action.icon
	icon_texture.self_modulate = action.particle_color
	name_label.text = action.action_name
	cost_label.text = str(action.cost)
	description_label.text = action.description


func selected() -> void:
	#print("Card Border ON")
	SFXManager.play_one_shot_sfx("ActionSelect")
	selected_texture.visible = true
	

func un_selected() -> void:
	#print("Card Border OFF")
	selected_texture.visible = false


func _on_mouse_entered() -> void:
	SFXManager.play_one_shot_sfx("ActionMouseOver")
	is_mouse_over = true
	z_index = 1
	to_mouse_enter()


func _on_mouse_exited() -> void:
	is_mouse_over = false
	z_index = 0
	to_mouse_exit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("selection") and is_mouse_over:
		tile_object.selection.selection_start.emit(self)


func to_mouse_enter() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(control_offset, "position", Vector2(0, -125), card_lerp_time)


func to_mouse_exit() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(control_offset, "position", Vector2.ZERO, card_lerp_time)
