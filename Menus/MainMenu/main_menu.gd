extends Control
class_name MainMenu


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Game/game.tscn")
