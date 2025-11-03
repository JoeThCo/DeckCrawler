extends TileObject
class_name Being


@export var health: Health


func _ready() -> void:
	super()
	health.set_up()
