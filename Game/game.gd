extends Node2D
class_name Game

@export_category("TileMapLayers")
@export var room: TileMapLayer
@export var display: TileMapLayer
@export var mouse_highlight: TileMapLayer


@export_category("Node2D")
@export var tile_objects_parent: Node2D

static var turn_count: int = 0

func _ready() -> void:
	World.set_up()
	Room.set_up(room)
	
	Display.set_up(display)
	MouseHighlight.set_up(mouse_highlight)
	
	TileObjectManager.set_up(tile_objects_parent)
	turn_count = 0


static func player_turn() -> void:
	turn_count += 1
	print("Turn #", turn_count)
