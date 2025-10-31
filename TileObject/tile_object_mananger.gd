extends Node2D
class_name TileObjectManager




static var spawn_parent: Node2D


static var spawn_dict = {
	"Player" : "res://TileObject/Player/player.tscn",
	"Baddie" : "res://TileObject/Baddie/baddie.tscn"
}

static var player: Player
static var tile_objects: Array[TileObject] = []


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var to_at_coords: TileObject = TileObjectManager.get_tile_object_at_global_coords(get_global_mouse_position())
		if to_at_coords != null:
			print(to_at_coords != null)
			SignalBus.emit_tile_object_selection(to_at_coords)


static func set_up(_sp: Node2D) -> void:
	spawn_parent = _sp
	tile_objects = []
	
	player = spawn_tile_object("Player", Vector2i.ZERO)
	player.movement.moved.connect(on_player_move)
	player.deck.action_played.connect(on_player_action)
	
	spawn_tile_object("Baddie", Vector2i.ONE * 4)
	#spawn_tile_object("Baddie", Vector2i.ONE * -4)


static func on_player_move() -> void:
	do_non_player_actions()


static func on_player_action(_action: Action) -> void:
	do_non_player_actions()


static func do_non_player_actions() -> void:
	for baddie: Baddie in get_baddies():
		baddie.movement.move()


static func get_baddies() -> Array[Baddie]:
	var output: Array[Baddie] = []
	for current in tile_objects:
		if current is Baddie:
			output.append(current)
	return output


static func spawn_tile_object(spawn_name: String, coords: Vector2i) -> TileObject:
	var prefab: PackedScene = load(spawn_dict[spawn_name])
	var new_tile_obj: TileObject = prefab.instantiate() as TileObject
	spawn_parent.add_child(new_tile_obj)
	new_tile_obj.global_position = Room.map_to_global(coords)
	tile_objects.append(new_tile_obj)
	return new_tile_obj


static func get_tile_object_at_global_coords(global: Vector2) -> TileObject:
	var search_grid_coords: Vector2i = Room.local_to_map(global)
	for current: TileObject in tile_objects:
		print(current.grid_coords)
		if current.grid_coords == search_grid_coords:
			return current
	return null
