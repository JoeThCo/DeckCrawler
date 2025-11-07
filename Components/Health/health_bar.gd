extends ProgressBar
class_name HealthBarComponent


@export var health: HealthComponent
@export var health_label: Label


func _ready() -> void:
	max_value = health.max_health
	min_value = 0
	step = 1
	
	on_health_changed()
	health.health_changed.connect(on_health_changed)


func on_health_changed() -> void:
	value = health.current_health
	health_label.text = "{0}/{1}".format([health.current_health, health.max_health])
