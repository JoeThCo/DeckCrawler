extends CanvasLayer


@onready var demo: PackedScene = preload("res://game.tscn")


func _ready() -> void:
	$Version.text = ProjectSettings.get_setting("application/config/version")
	$Title.text = ProjectSettings.get_setting("application/config/name")


func _on_play_button_down() -> void:
	get_tree().change_scene_to_packed(demo)
