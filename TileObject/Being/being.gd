extends TileObject
class_name Being


@export var health: Health
@export var health_bar: HealthBar


func _ready() -> void:
	super()
	health.set_up()
	health_bar.set_up(health)
