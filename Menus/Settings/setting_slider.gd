extends HBoxContainer
class_name SettingSlider


signal setting_slider_value_changed(value: float)


@export var slider_name: String


@export_category("Controls")
@export var hslider: HSlider
@export var name_label: Label
@export var value_label: Label


func _ready() -> void:
	name_label.text = slider_name


func _on_h_slider_value_changed(value: float) -> void:
	value_label.text = str(int(value * 100))
	setting_slider_value_changed.emit(value)


func set_value(value: float) -> void:
	hslider.value = value
