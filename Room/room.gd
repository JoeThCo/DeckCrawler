extends Node2D
class_name Room


static var astar: AStarGrid2D
static var tile_map: TileMapLayer


const ROOM_SIZE: Vector2i = Vector2i(30, 20)
const WALL_COORDS: Vector2i = Vector2i(39, 15)
const TEMP_DOOR_COORDS: Vector2i = Vector2i(17, 20)


static func set_up(_tm) -> void:
	tile_map = _tm
	tile_map.clear()
	astar = AStarGrid2D.new()
	room_init()
	_a_star_init()

		
static func room_init() -> void:
	border_init()


static func border_init() -> void:
	@warning_ignore("integer_division")
	var half_y: int = ROOM_SIZE.y / 2
	@warning_ignore("integer_division")
	var half_x: int = ROOM_SIZE.x / 2
	
	var start_y: int = -half_y
	var start_x: int = -half_x
	var end_y: int = start_y + ROOM_SIZE.y - 1
	var end_x: int = start_x + ROOM_SIZE.x - 1
	
	# Top border
	for x in range(start_x, end_x + 1):
		tile_map.set_cell(Vector2i(x, start_y), 0, WALL_COORDS)
	
	# Bottom border
	for x in range(start_x, end_x + 1):
		tile_map.set_cell(Vector2i(x, end_y), 0, WALL_COORDS)
	
	# Left border (excluding corners already done)
	for y in range(start_y + 1, end_y):
		tile_map.set_cell(Vector2i(start_x, y), 0, WALL_COORDS)
	
	# Right border (excluding corners already done)
	for y in range(start_y + 1, end_y):
		tile_map.set_cell(Vector2i(end_x, y), 0, WALL_COORDS)
	
	tile_map.set_cell(Vector2i(start_x + half_x, start_y + 1), 0, TEMP_DOOR_COORDS)
	tile_map.set_cell(Vector2i(start_x + half_x, end_y - 1), 0, TEMP_DOOR_COORDS)
	tile_map.set_cell(Vector2i(start_x + 1, start_y + half_y), 0, TEMP_DOOR_COORDS)
	tile_map.set_cell(Vector2i(end_x - 1 , start_y + half_y), 0, TEMP_DOOR_COORDS)


static func _a_star_init() -> void:
	astar.region = tile_map.get_used_rect()
	astar.cell_size = tile_map.tile_set.tile_size
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	astar.update()
	
	for cell: Vector2i in tile_map.get_used_cells():
		astar.set_point_solid(cell, true)


static func local_to_map(local_position: Vector2) -> Vector2i:
	return tile_map.local_to_map(local_position)


static func map_to_global(map_position: Vector2i) -> Vector2:
	return tile_map.tile_set.tile_size * map_position


#FIXME something about this doesnt sit right, click on same tile returns 1
static func get_astar_path(from: Vector2i, to: Vector2i) -> PackedVector2Array:
	if astar.is_in_bounds(to.x, to.y):
		return astar.get_point_path(from, to, true)
	return [from]


static func get_distance(from: Vector2i, to: Vector2i) -> int:
	return get_astar_path(from, to).size()


static func is_valid_path(path: PackedVector2Array) -> bool:
	return is_valid_distance(path.size())


static func is_valid_distance(distance: int) -> bool:
	return distance > 1


static func get_reachable_cells(start_cell: Vector2i, max_distance: int) -> PackedVector2Array:
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
				not astar.is_in_boundsv(neighbor) or
				visited.has(neighbor) or
				astar.is_point_solid(neighbor)
			):
				continue
			
			# Mark as visited and add to queue
			visited[neighbor] = true
			queue.append({"cell": neighbor, "distance": distance + 1})
	
	return reachable_cells


static func get_mouse_grid_coords(local_mouse_coords: Vector2) -> Vector2i:
	return tile_map.local_to_map(local_mouse_coords - Vector2.ONE * tile_map.tile_set.tile_size.x) 


static func move_tiles(from: Vector2i, to: Vector2i, has_collision: bool = true) -> void:
	astar.set_point_solid(from, false)
	astar.set_point_solid(to, has_collision)
