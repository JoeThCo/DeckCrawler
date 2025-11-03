extends Resource
class_name Action


signal action_complete


@export_category("Values")
@export var cost: int
@export var target: Target


@export_category("Meta Data")
@export_multiline var description: String = "No Description"
@export var icon: Texture2D


var owner_object: TileObject

func set_up(_to: TileObject) -> void:
	owner_object = _to


func execute() -> void:
	if target is SelfTarget:
		do_action(owner_object)
	elif target is OtherTarget:
		var other: TileObject = await SignalBus.tile_object_selection
		do_action(other)
	action_complete.emit()


func _to_string() -> String:
	return "({0}, {1})".format([Helper.get_resource_name(self), cost])


func do_action(_tile_object: TileObject) -> void:
	print("Action!")
