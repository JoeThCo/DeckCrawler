extends Node2D
class_name TriggerComponent

signal trigger_enter
signal trigger_exit


@export var tile_object: TileObjectComponent


var trigger_object: TileObjectComponent


func update_trigger() -> void:
	var update_to: TileObjectComponent = TileObjectManager.get_tile_object_at_grid_coords(tile_object, tile_object.movement.grid_coords)
	if update_to != null and trigger_object == null:
		trigger_object = update_to
		trigger_enter.emit()
		print("Enter!")
	
	if update_to == null and trigger_object != null:
		trigger_object = null
		trigger_exit.emit()
		print("Exit!")
