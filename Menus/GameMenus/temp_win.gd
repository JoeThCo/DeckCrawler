extends CanvasLayer
class_name TempWin


func _on_play_again_button_down() -> void:
	get_tree().change_scene_to_file("res://Game/game.tscn")


func _on_main_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Menus/MainMenu/main_menu.tscn")
