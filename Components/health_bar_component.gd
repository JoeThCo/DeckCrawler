extends ProgressBar
class_name HealthBarComponent


@export var health: HealthComponent
@export var health_label: Label


func _ready() -> void:
	on_health_changed()
	health.health_changed.connect(on_health_changed)


func on_health_changed() -> void:
	health_label.text = "{0}/{1}".format([health.health, health.max_health])
