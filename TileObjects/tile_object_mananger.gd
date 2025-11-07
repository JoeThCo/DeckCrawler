extends Node2D
class_name TileObjectManager


static var spawn_parent: Node2D


static var spawn_dict = {
	"Player" : "res://TileObjects/player.tscn",
	"Baddie" : "res://TileObjects/baddie.tscn",
	"Door" : "res://TileObject/Static/door.tscn"
}

static var player: PlayerThree
static var all_spawned_tile_objects: Array[TileObjectComponent] = []


static func set_up(_sp: Node2D) -> void:
	spawn_parent = _sp
	all_spawned_tile_objects = []
	
	player = spawn_tile_object("Player", Vector2i.ZERO)
	player.movement.moved.connect(player_move)
	player.deck.action_played.connect(action_played)
	#TODO do non player actions when action is played
	
	spawn_tile_object("Baddie", Vector2i.ONE * 4)
	#spawn_tile_object("Door", Vector2i.ONE * -4)


static func player_move() -> void:
	await do_non_player_actions()


static func action_played(_action_display: ActionDisplay) -> void:
	await do_non_player_actions()


static func do_non_player_actions() -> void:
	Game.player_turn()
	
	for baddie: TileObjectComponent in _get_tile_objects(BaddieThree):
		await baddie.baddie_ai.do_best_action()


static func _get_tile_objects(type: Script) -> Array:
	var output: Array[TileObjectComponent] = []
	for current in all_spawned_tile_objects:
		if is_instance_of(current, type):
			output.append(current)
	return output


#TODO return an array? Two objects same distance away?
static func _get_closest_tile_object_component(grid_coords: Vector2i, _tile_objects: Array[TileObjectComponent]) -> TileObjectComponent:
	var shortest_distance: int = 999 #TODO int.Max equal?
	var shortest_tile_object: TileObjectComponent = null
	for current: TileObjectComponent in _tile_objects:
		var current_distance: int = Room.get_distance(grid_coords, current.movement.grid_coords)
		if current_distance < shortest_distance:
			shortest_distance = current_distance
			shortest_tile_object = current
	return shortest_tile_object


static func _get_all_on_team(wanted_team: TeamComponent.Team) -> Array[TileObjectComponent]:
	var output: Array[TileObjectComponent] = []
	var wanted_int: int = int(wanted_team)
	for current: TileObjectComponent in all_spawned_tile_objects:
		if current.team.team & wanted_int:
			output.append(current)
	return output
	

static func get_closest_on_team(grid_coords: Vector2i, team: TeamComponent.Team) -> TileObjectComponent:
	return _get_closest_tile_object_component(grid_coords, _get_all_on_team(team))


static func spawn_tile_object(spawn_name: String, coords: Vector2i):
	var prefab: PackedScene = load(spawn_dict[spawn_name])
	var new_tile_obj: TileObjectComponent = prefab.instantiate() as TileObjectComponent
	spawn_parent.add_child(new_tile_obj)
	new_tile_obj.global_position = Room.map_to_global(coords)
	all_spawned_tile_objects.append(new_tile_obj)
	return new_tile_obj


static func delete_tile_object(tile_object: TileObjectComponent) -> void:
	all_spawned_tile_objects.erase(tile_object)
	tile_object.queue_free()


static func get_tile_object_at_global_coords(global: Vector2) -> TileObjectComponent:
	var search_grid_coords: Vector2i = Room.local_to_map(global)
	for current: TileObjectComponent in all_spawned_tile_objects:
		if current.movement.grid_coords == search_grid_coords:
			return current
	return null
#
#
#static func try_and_get_overlapping_tile_object(tile_object: TileObject) -> TileObject:
	#for current in tile_objects:
		#if current == tile_object: continue
		#if current.grid_coords == tile_object.grid_coords:
			#return current
	#return null
