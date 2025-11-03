extends TileObject
class_name Being


@export var health: Health
@export var health_bar: HealthBar


func _ready() -> void:
	super()
	health.set_up()
	health.on_dead.connect(on_death)
	health_bar.set_up(health)


func on_death() -> void:
	TileObjectManager.delete_tile_object(self)
