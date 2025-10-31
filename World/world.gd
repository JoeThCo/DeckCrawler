extends Node2D
class_name World


# Constants for grid dimensions and movement
const GRID_WIDTH := 10
const GRID_HEIGHT := 10
const DIRECTIONS := [10, -10, 1, -1]
const MAX_ATTEMPTS = 250

const BASE_ROOMS := 8
const ROOM_COUNT_MULTIPLIER := 3.0

const HARD_TEN := 10 #FIXME Why is 10 needed for %


# Room data
static var rooms: Dictionary = {}  # cell_id -> room_data
static var end_rooms: Array[int] = []
static var room_queue: Array[int] = []

static var start_cell: int
static var current_coords: Vector2i


static func set_up() -> void:
	while true:
		if generate_world(2):
			break

	current_coords = get_room_position(start_cell)
	World.print_floorplan()
	print(current_coords)


static func generate_world(level: int) -> bool:
	# Reset state
	rooms.clear()
	end_rooms.clear()
	room_queue.clear()
	start_cell = randi_range(0, GRID_WIDTH * GRID_HEIGHT)
	
	# Calculate number of rooms needed
	var room_count := calculate_room_count(level)
	
	while true:
	# Try to generate a valid floorplan (with retries)
		for attempt in MAX_ATTEMPTS:
			if _generate_floorplan_attempt(room_count):
				if _validate_floorplan(room_count):
					return true
			# Reset for next attempt
			rooms.clear()
			end_rooms.clear()
			room_queue.clear()
			
	print("Failed to generate valid floorplan after ", MAX_ATTEMPTS, " attempts")
	return false


static func calculate_room_count(level: int) -> int:
	return BASE_ROOMS + int(level * ROOM_COUNT_MULTIPLIER)


static func _generate_floorplan_attempt(target_room_count: int) -> bool:
	# Start with the starting room
	rooms[start_cell] = {"type": "start", "neighbors": []}
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
			if not _is_valid_cell(neighbor_cell) or rooms.has(neighbor_cell):
				continue
			
			# Check if neighbor has more than one filled neighbor
			if _count_filled_neighbors(neighbor_cell) > 1:
				continue
			
			# 50% chance to skip
			if randf() < 0.5:
				continue
			
			# Add the room
			rooms[neighbor_cell] = {"type": "normal", "neighbors": []}
			room_queue.append(neighbor_cell)
			rooms_added += 1
			
			# Update neighbor relationships
			rooms[current_cell].neighbors.append(neighbor_cell)
			rooms[neighbor_cell].neighbors.append(current_cell)
		
		# Reseed if needed for large maps
		if needs_reseed and room_queue.size() == 0 and rooms_added < target_room_count:
			# Add some random rooms back to the queue to encourage more growth
			var room_keys = rooms.keys()
			room_keys.shuffle()
			for room in room_keys.slice(0, min(3, room_keys.size())):
				if not room_queue.has(room):
					room_queue.append(room)
	
	# Identify true dead ends AFTER generation is complete
	_identify_dead_ends()
	return rooms_added >= target_room_count


static func _identify_dead_ends():
	end_rooms.clear()
	for cell in rooms:
		# True dead ends have exactly one neighbor (they're leaves in the tree)
		if cell != start_cell and rooms[cell].neighbors.size() == 1:
			end_rooms.append(cell)


static func _is_valid_cell(cell: int) -> bool:
	# Extract coordinates
	var x := cell % HARD_TEN
	@warning_ignore("integer_division")
	var y := cell / HARD_TEN
	
	# Check bounds and exclude x=0 columns
	return x >= 1 and x <= GRID_WIDTH and y >= 0 and y < GRID_HEIGHT


static func _count_filled_neighbors(cell: int) -> int:
	var count := 0
	for direction in DIRECTIONS:
		var neighbor = cell + direction
		if rooms.has(neighbor):
			count += 1
	return count


static func _validate_floorplan(room_count: int) -> bool:
	# Check if we have the right number of rooms
	if rooms.size() != room_count:
		return false
	
	# Boss room cannot be adjacent to starting room
	var boss_room_candidates = end_rooms.duplicate()
	for candidate in boss_room_candidates:
		if _is_adjacent_to_start(candidate):
			return false
	
	return true


static func _is_adjacent_to_start(cell: int) -> bool:
	for direction in DIRECTIONS:
		if cell + direction == start_cell:
			return true
	return false


# Utility functions to get information about the generated floorplan
static func get_rooms() -> Dictionary:
	return rooms.duplicate(true)


static func get_end_rooms() -> Array[int]:
	return end_rooms.duplicate()


static func get_room_position(cell: int) -> Vector2:
	# Convert cell ID to actual coordinates
	var x := cell % HARD_TEN
	@warning_ignore("integer_division")
	var y := cell / HARD_TEN
	return Vector2(x, y)


# Debug function to print the floorplan
static func print_floorplan():
	print("Floorplan with ", rooms.size(), " rooms:")
	for y in range(GRID_HEIGHT):
		var row := ""
		for x in range(1, GRID_WIDTH + 1):  # Skip x=0 columns
			var cell := y * 10 + x
			if rooms.has(cell):
				if cell == start_cell:
					row += "[S]"
				elif end_rooms.has(cell):
					row += "[E]"
				else:
					row += "[R]"
			else:
				row += "   "
		print(row)
