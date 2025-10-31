extends Resource
class_name Action


@export_category("Values")
@export var cost: int
@export var target: Target


@export_category("Meta Data")
@export_multiline var description: String = "No Description"
@export var icon: Texture2D


var owner_object: TileObject

func set_up(_to: TileObject) -> void:
	owner_object = _to


func execute(_tile_object: TileObject) -> void:
	if target is SelfTarget:
		print("Self")
	elif target is OtherTarget:
		print("Other")


func _to_string() -> String:
	return "({0}, {1})".format([Helper.get_resource_name(self), cost])
