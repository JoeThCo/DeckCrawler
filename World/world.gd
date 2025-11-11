extends Node2D
class_name World

# Constants for grid dimensions and movement
const GRID_WIDTH := 12
const GRID_HEIGHT := 12
const DIRECTIONS := [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]
const MAX_ATTEMPTS = 250


const BASE_ROOMS := 8
const ROOM_COUNT_MULTIPLIER := 3.0


static var rooms: Array[Array] = []  # 2D array of room data or null
static var end_rooms: Array[Vector2i] = []
static var room_queue: Array[Vector2i] = []

static var start_cell: Vector2i
static var current_coords: Vector2i


static func set_up() -> void:
	while true:
		if generate_world(2):
			break

	current_coords = get_room_position(start_cell)
	World.print_floorplan()
	#print(current_coords)


static func generate_world(level: int) -> bool:
	# Reset state - initialize 2D array
	rooms = []
	for y in range(GRID_HEIGHT):
		var row: Array = []
		row.resize(GRID_WIDTH)
		row.fill(null)
		rooms.append(row)
	
	end_rooms.clear()
	room_queue.clear()
	
	# Random start position (skip x=0 columns)
	start_cell = Vector2i(randi_range(1, GRID_WIDTH - 1), randi_range(0, GRID_HEIGHT - 1))
	
	# Calculate number of rooms needed
	var room_count := calculate_room_count(level)
	
	# Try to generate a valid floorplan (with retries)
	for attempt in MAX_ATTEMPTS:
		if _generate_floorplan_attempt(room_count):
			if _validate_floorplan(room_count):
				return true
		# Reset for next attempt
		_clear_rooms_array()
		end_rooms.clear()
		room_queue.clear()
			
	print("Failed to generate valid floorplan after ", MAX_ATTEMPTS, " attempts")
	return false


static func _clear_rooms_array() -> void:
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			rooms[y][x] = null


static func calculate_room_count(level: int) -> int:
	return BASE_ROOMS + int(level * ROOM_COUNT_MULTIPLIER)


static func _generate_floorplan_attempt(target_room_count: int) -> bool:
	# Start with the starting room
	rooms[start_cell.y][start_cell.x] = {"type": "start", "neighbors": []}
	room_queue.append(start_cell)
	
	var rooms_added := 1
	var needs_reseed := target_room_count > 16
	
	while room_queue.size() > 0 and rooms_added < target_room_count:
		var current_cell = room_queue.pop_front()
		if room_queue.size() > 0:
			room_queue.remove_at(0)
		
		# Shuffle directions for randomness
		var shuffled_directions = DIRECTIONS.duplicate()
		shuffled_directions.shuffle()
		
		# Check all four cardinal directions
		for direction in shuffled_directions:
			if rooms_added >= target_room_count:
				break
				
			var neighbor_cell = current_cell + direction
			
			# Skip if neighbor is invalid or already occupied
			if not _is_valid_cell(neighbor_cell) or _has_room(neighbor_cell):
				continue
			
			# Check if neighbor has more than one filled neighbor
			if _count_filled_neighbors(neighbor_cell) > 1:
				continue
			
			# 50% chance to skip
			if randf() < 0.5:
				continue
			
			# Add the room
			rooms[neighbor_cell.y][neighbor_cell.x] = {"type": "normal", "neighbors": []}
			room_queue.append(neighbor_cell)
			rooms_added += 1
			
			# Update neighbor relationships
			rooms[current_cell.y][current_cell.x].neighbors.append(neighbor_cell)
			rooms[neighbor_cell.y][neighbor_cell.x].neighbors.append(current_cell)
		
		# Reseed if needed for large maps
		if needs_reseed and room_queue.size() == 0 and rooms_added < target_room_count:
			# Add some random rooms back to the queue to encourage more growth
			var filled_rooms = _get_all_filled_rooms()
			filled_rooms.shuffle()
			for room in filled_rooms.slice(0, min(3, filled_rooms.size())):
				if not room_queue.has(room):
					room_queue.append(room)
	
	# Identify true dead ends AFTER generation is complete
	_identify_dead_ends()
	return rooms_added >= target_room_count


static func _get_all_filled_rooms() -> Array[Vector2i]:
	var filled_rooms: Array[Vector2i] = []
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			if rooms[y][x] != null:
				filled_rooms.append(Vector2i(x, y))
	return filled_rooms


static func _identify_dead_ends():
	end_rooms.clear()
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			var cell = Vector2i(x, y)
			if _has_room(cell) and cell != start_cell:
				var room_data = rooms[y][x]
				if room_data.neighbors.size() == 1:
					end_rooms.append(cell)


static func _is_valid_cell(cell: Vector2i) -> bool:
	# Check bounds and exclude x=0 columns
	return cell.x >= 1 and cell.x < GRID_WIDTH and cell.y >= 0 and cell.y < GRID_HEIGHT


static func _has_room(cell: Vector2i) -> bool:
	if not _is_valid_cell(cell): return false
	return rooms[cell.y][cell.x] != null


static func is_room(direction: Vector2i) -> bool:
	return _has_room(current_coords + direction)


static func _count_filled_neighbors(cell: Vector2i) -> int:
	var count := 0
	for direction in DIRECTIONS:
		var neighbor = cell + direction
		if _is_valid_cell(neighbor) and _has_room(neighbor):
			count += 1
	return count


static func _validate_floorplan(room_count: int) -> bool:
	# Check if we have the right number of rooms
	if _count_filled_rooms() != room_count:
		return false
	
	var boss_room_candidates = end_rooms.duplicate()
	for candidate in boss_room_candidates:
		if _is_adjacent_to_start(candidate):
			return false
	
	return true


static func _count_filled_rooms() -> int:
	var count := 0
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			if rooms[y][x] != null:
				count += 1
	return count


static func _is_adjacent_to_start(cell: Vector2i) -> bool:
	for direction in DIRECTIONS:
		if cell + direction == start_cell:
			return true
	return false


# Utility functions to get information about the generated floorplan
static func get_rooms() -> Array[Array]:
	return rooms.duplicate(true)


static func get_end_rooms() -> Array[Vector2i]:
	return end_rooms.duplicate()


static func get_room_position(cell: Vector2i) -> Vector2:
	# Convert cell coordinates to actual position
	return Vector2(cell.x, cell.y)


# Debug function to print the floorplan
static func print_floorplan():
	print("Floorplan with ", _count_filled_rooms(), " rooms:")
	for y in range(GRID_HEIGHT):
		var row := ""
		for x in range(GRID_WIDTH):
			if x == 0:
				row += " "  # Skip x=0 columns visually
			else:
				var cell := Vector2i(x, y)
				if _has_room(cell):
					if cell == start_cell:
						row += "[S]"
					elif end_rooms.has(cell):
						row += "[E]"
					else:
						row += "[R]"
				else:
					row += "   "
		print(row)
