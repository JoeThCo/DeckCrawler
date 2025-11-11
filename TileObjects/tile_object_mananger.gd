extends Node2D
class_name TileObjectManager


static var spawn_parent: Node2D


static var spawn_dict = {
	"Player" : "res://TileObjects/player.tscn",
	"Baddie" : "res://TileObjects/baddie.tscn",
	"Door" : "res://TileObjects/door.tscn"
}

static var all_spawned_tile_objects: Array[TileObjectComponent] = []


static func set_up(_sp: Node2D) -> void:
	all_spawned_tile_objects = []
	spawn_parent = _sp

	#spawn_tile_object("Baddie", Vector2i.ONE * 4)


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


static func _get_tile_objects(types: Array[Script]) -> Array:
	var output: Array[TileObjectComponent] = []
	for current in all_spawned_tile_objects:
		for type in types:
			if is_instance_of(current, type):
				output.append(current)
				break
	return output
	

static func get_closest(grid_coords: Vector2i, scripts: Array[Script]) -> TileObjectComponent:
	return _get_closest_tile_object_component(grid_coords, _get_tile_objects(scripts))


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
	
	
static func get_tile_object_at_grid_coords(tile_object: TileObjectComponent, grid_coords: Vector2i) -> TileObjectComponent:
	for current: TileObjectComponent in all_spawned_tile_objects:
		if current.movement.grid_coords != grid_coords: continue
		if current == tile_object: continue
		return current
	return null
