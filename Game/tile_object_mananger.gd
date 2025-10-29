extends Node2D
class_name TileObjectManager


static var spawn_parent: Node2D


static var spawn_dict = {
	"Player" : "res://TileObject/Player/player.tscn",
	"Baddie" : "res://TileObject/Baddie/baddie.tscn"
}

static var player: Player
static var tile_objects: Array[TileObject] = []


static func set_up(_sp: Node2D) -> void:
	spawn_parent = _sp
	tile_objects = []
	
	player = spawn_tile_object("Player", Vector2i.ZERO)
	player.movement.moved.connect(on_player_move)
	
	spawn_tile_object("Baddie", Vector2i.ONE * 2)
	spawn_tile_object("Baddie", Vector2i.ONE * -4)


static func on_player_move() -> void:
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
