extends CanvasLayer
class_name PauseMenu


func _on_resume_button_down() -> void:
	Game.resume_game()


func _on_quit_button_down() -> void:
	get_tree().change_scene_to_file("res://Menus/MainMenu/main_menu.tscn")


func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://Game/game.tscn")


func _on_settings_button_down() -> void:
	MenuManager.display_menu("Settings")
