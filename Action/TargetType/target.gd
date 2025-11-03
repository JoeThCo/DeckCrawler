extends Resource
class_name Target


var target_name: String
var owner: TileObject


func set_up(tile_object: TileObject) -> void:
	owner = tile_object


func _to_string() -> String:
	return Helper.get_resource_name(self)
