extends ProgressBar
class_name HealthBar


@export var health_label: Label
var health: Health


func set_up(_h: Health) -> void:
	health = _h
	on_health_changed()
	health.health_changed.connect(on_health_changed)


func on_health_changed() -> void:
	health_label.text = "{0}/{1}".format([health.health, health.max_health])
