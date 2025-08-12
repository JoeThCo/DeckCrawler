extends TileMapLayer
class_name World


var player: Player
var pathfinding_grid: AStarGrid2D = AStarGrid2D.new()
const DISPLAY_COORDS: Vector2i = Vector2i(1, 17) 


func set_up() -> void:
	a_star_init()
	player = spawn_tile_object("player", Vector2i(0, 0), %Friendlies)
	
	spawn_tile_object("baddie", Vector2i(-10, -5), %Baddies)
	spawn_tile_object("baddie", Vector2i(-10, 0), %Baddies)
	spawn_tile_object("end_door", Vector2i(-10, 2), %Static)
		
		
func a_star_init() -> void:
	pathfinding_grid.region = get_used_rect()
	pathfinding_grid.cell_size = tile_set.tile_size
	pathfinding_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	pathfinding_grid.update()
	
	for cell: Vector2i in get_used_cells():
		pathfinding_grid.set_point_solid(cell, true)
		
		
func set_point_solid(cell: Vector2i) -> void:
	pathfinding_grid.set_point_solid(local_to_map(cell), true)
	
	
func set_point_empty(cell: Vector2i) -> void:
	pathfinding_grid.set_point_solid(cell, false)
		
		
func get_pathfinding_path(from: Vector2i, to: Vector2i) -> PackedVector2Array:
	return pathfinding_grid.get_point_path(from, to, true)


func get_distance_away(from: Vector2i, to: Vector2i) -> int:
	return len(get_pathfinding_path(from, to))


func get_distance_from_player(grid_coords: Vector2i) -> int:
	return get_distance_away(player.grid_coords, grid_coords)


func get_reachable_cells(start_cell: Vector2i, max_distance: int) -> PackedVector2Array:
	var reachable_cells := []
	var visited := {}
	var queue := []
	
	# Initialize with starting cell (distance 0)
	queue.append({"cell": start_cell, "distance": 0})
	visited[start_cell] = true
	
	while not queue.is_empty():
		var current = queue.pop_front()
		var cell = current.cell
		var distance = current.distance
		
		# Add to results if within distance
		if distance <= max_distance and distance > 0:  # Exclude start cell if distance > 0
			reachable_cells.append(cell)
		
		# Stop if we've reached max distance
		if distance >= max_distance:
			continue
		
		# Check all 4-directional neighbors (adjust for 8-directional if needed)
		for dir in [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]:
			var neighbor = cell + dir
			
			# Skip if out of bounds, already visited, or blocked
			if (
				not pathfinding_grid.is_in_boundsv(neighbor) or
				visited.has(neighbor) or
				pathfinding_grid.is_point_solid(neighbor)
			):
				continue
			
			# Mark as visited and add to queue
			visited[neighbor] = true
			queue.append({"cell": neighbor, "distance": distance + 1})
	
	return reachable_cells


func spawn_tile_object(tile_name: String, pos: Vector2i, parent: Node2D) -> TileObject:
	var path: String = "res://TileObjects/" + tile_name + ".tscn"
	var tile_object_prefab: PackedScene = load(path)
	var tile_object_instance : TileObject = tile_object_prefab.instantiate() as TileObject
	tile_object_instance.set_up(self)
	tile_object_instance.global_position = map_to_local(pos)
	tile_object_instance.name = tile_name
	parent.add_child(tile_object_instance)
	return tile_object_instance
	
	
func get_immediate_children_and_first_subchildren(parent: Node) -> Array[Node2D]:
	var all_children: Array[Node2D] = []
	for child in parent.get_children():
		all_children.append_array(child.get_children())
	return all_children
	
	
func get_being_at_coords(coords: Vector2i) -> Being:
	var search_coords: Vector2i = local_to_map(coords)
	for child: Node2D in get_immediate_children_and_first_subchildren(%TileObjects): #better way?
		if child is not Being: continue
		var being: Being = child as Being
		if being.grid_coords == search_coords:
			return being
	return null


func get_mouse_grid_coords() -> Vector2i:
	return local_to_map(get_local_mouse_position() - Vector2.ONE * tile_set.tile_size.x) 
