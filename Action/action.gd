extends Resource
class_name Action


@export var cost: int
@export var distance: Distance

var action_name: String:
	get:
		return resource_path.get_file().trim_suffix('.tres')
		
		
@export_multiline var description: String = "No Description"
@export var icon: Texture2D


func execute(_being: Being) -> void:
	push_error("Base Action.execute called, should be overridden")


func _to_string() -> String:
	return "({0}, {1})".format([action_name, cost])
