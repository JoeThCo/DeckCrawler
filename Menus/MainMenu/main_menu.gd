extends Control
class_name MainMenu


@export var version_label: Label
const PRE_VERSION: String = "dc_"

func _ready() -> void:
	version_label.text = PRE_VERSION + ProjectSettings.get_setting("application/config/version")


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Game/game.tscn")


func _on_settings_button_down() -> void:
	get_tree().change_scene_to_file("res://Menus/Settings/settings.tscn")
