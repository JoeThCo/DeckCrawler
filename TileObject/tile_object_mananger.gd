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
	for baddie: Baddie in _get_tile_objects(Baddie):
		await baddie.movement.move(get_closest_friend(baddie.grid_coords).grid_coords)


static func _get_tile_objects(type: Script) -> Array[TileObject]:
	var output: Array[TileObject] = []
	for current in tile_objects:
		if is_instance_of(current, type):
			output.append(current)
	return output


#TODO return an array? Two objects same distance away?
static func _get_closest_tile_object(grid_coords: Vector2i, _tile_objects: Array[TileObject]) -> TileObject:
	var shortest_distance: int = 999 #TODO int.Max equal?
	var shortest_tile_object: TileObject = null
	for current: TileObject in _tile_objects:
		var current_distance: int = Room.get_distance(grid_coords, current.grid_coords)
		if current_distance < shortest_distance:
			shortest_distance = current_distance
			shortest_tile_object = current
	return shortest_tile_object
	
	
static func get_closest_baddie(grid_coords: Vector2i) -> Baddie:
	return _get_closest_tile_object(grid_coords, _get_tile_objects(Baddie))


static  func get_closest_friend(grid_coords: Vector2i) -> Friend:
	return _get_closest_tile_object(grid_coords, _get_tile_objects(Friend))
	

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
		if current.grid_coords == search_grid_coords:
			return current
	return null
