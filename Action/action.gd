extends Resource
class_name Action


@export_category("Values")
@export var cost: int
@export var target: Target


@export_category("Meta Data")
@export_multiline var description: String = "No Description"
@export var icon: Texture2D


func execute(_tile_object: TileObject) -> void:
	push_error("Base Action.execute called, should be overridden")


func _to_string() -> String:
	return "({0}, {1})".format([Helper.get_resource_name(self), cost])
