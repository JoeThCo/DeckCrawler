extends Node2D
class_name Movement


@warning_ignore("unused_signal")
signal moved


var tile_object: TileObject


func set_up(_to: TileObject) -> void:
	tile_object = _to
	

func move() -> void:
	pass
