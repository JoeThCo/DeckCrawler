extends Node2D
class_name Game


@export_category("TileMapLayers")
@export var room: TileMapLayer
@export var display: TileMapLayer
@export var mouse_highlight: TileMapLayer


@export_category("Node2D")
@export var _game_root: Node2D
@export var tile_objects_parent: Node2D

@export_category("Control")
@export var all_menus: Control

static var game_root: Node2D
static var player: PlayerThree


static var is_playing: bool = true
static var is_paused: bool = false
static var turn_count: int = 0


func _ready() -> void:
	game_root = _game_root
	
	World.set_up()
	Room.set_up(room)
	TileObjectManager.set_up(tile_objects_parent)
	Room.spawn_doors()
	
	player = TileObjectManager.spawn_tile_object("Player", Vector2i.ZERO)
	player.movement.moved.connect(player_move)
	player.deck.action_played.connect(action_played)
	
	TileObjectManager.spawn_tile_object("Baddie", Vector2i.ONE * 5)
	MenuManager.set_up(all_menus)
	Display.set_up(display)
	MouseHighlight.set_up(mouse_highlight)
	
	is_paused = false
	is_playing = true
	turn_count = 0


static func player_move() -> void:
	await do_non_player_actions()


static func action_played(_action_display: ActionDisplay) -> void:
	await do_non_player_actions()


static func do_non_player_actions() -> void:
	Game.player_turn()
	
	for baddie: BaddieThree in TileObjectManager._get_tile_objects([BaddieThree]):
		await baddie.baddie_ai.do_best_action()
	
	for current: Door in TileObjectManager._get_tile_objects([Door]):
		current.trigger.update_trigger()


static func player_turn() -> void:
	turn_count += 1
	#print("Turn #", turn_count)


static func pause_game() -> void:
	MenuManager.display_menu("Pause")
	is_paused = true
	SignalBus.emit_game_paused()


static func resume_game() -> void:
	MenuManager.display_menu("Game")
	is_paused = false
	SignalBus.emit_game_resumed()


static func game_over() -> void:
	MenuManager.display_menu("GameOver")
