extends Node2D
class_name Game

@export_category("TileMapLayers")
@export var room: TileMapLayer
@export var display: TileMapLayer
@export var mouse_highlight: TileMapLayer


@export_category("Node2D")
@export var tile_objects_parent: Node2D

@export_category("Control")
@export var all_menus: Control


static var is_paused: bool = false
static var turn_count: int = 0

func _ready() -> void:
	World.set_up()
	Room.set_up(room)
	
	MenuManager.set_up(all_menus)
	Display.set_up(display)
	MouseHighlight.set_up(mouse_highlight)
	
	TileObjectManager.set_up(tile_objects_parent)
	turn_count = 0


static func player_turn() -> void:
	turn_count += 1
	print("Turn #", turn_count)


static func pause_game() -> void:
	MenuManager.display_menu("Pause")
	is_paused = true
	SignalBus.emit_game_paused()


static func resume_game() -> void:
	MenuManager.display_menu("Game")
	is_paused = false
	SignalBus.emit_game_resumed()
