extends Node2D


@onready var main_menu: PackedScene = load("res://MainMenu/main_menu.tscn")


func _ready() -> void:
	%World.set_up()
	Display.set_up(%Display, %World)
	%Selection.set_up(%World)
	%Baddies.set_up(%World)
	
	SignalBus.game_over.connect(game_over)
	SignalBus.game_won.connect(game_won)
	


func game_over() -> void:
	get_tree().change_scene_to_packed(main_menu)
	Display.disconnect_signals()


func game_won() -> void:
	get_tree().change_scene_to_packed(main_menu)
	Display.disconnect_signals()


func _on_home_button_button_down() -> void:
	game_over()
