extends Resource
class_name Target


var target_name: String
var owner: TileObjectComponent


func set_up(tile_object: TileObjectComponent) -> void:
	owner = tile_object


func _to_string() -> String:
	return Helper.get_resource_name(self)
