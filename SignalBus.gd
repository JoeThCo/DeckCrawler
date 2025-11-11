extends Node


signal game_paused
signal game_resumed


func emit_game_paused() -> void:
	game_paused.emit()


func emit_game_resumed() -> void:
	game_resumed.emit()
