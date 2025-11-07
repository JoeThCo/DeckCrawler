extends Resource
class_name Action


signal action_complete


@export_category("Values")
@export var cost: int
@export var action_time: float = 0.2


@export_category("Meta Data")
@export var action_name: String = ""
@export_multiline var description: String = "N/A"
@export var icon: CompressedTexture2D
@export var particle_color: Color


var owner_object: TileObjectComponent


func set_up(_to: TileObjectComponent) -> void:
	owner_object = _to


func execute(other_tile_object: TileObjectComponent) -> void:
	if other_tile_object == owner_object:
		do_action(owner_object)
	else:
		await display_particles(owner_object, other_tile_object)
		do_action(other_tile_object)
	action_complete.emit()


func do_action(_tile_object: TileObjectComponent) -> void:
	print("Action!")


func display_particles(from: TileObjectComponent, to: TileObjectComponent) -> void:
	var path_particle_prefab: PackedScene = load("res://Action/Particles/path_particles.tscn")
	var path_instance: PathParticles = path_particle_prefab.instantiate() as PathParticles
		
	Game.game_root.add_child(path_instance)
	path_instance.set_up(self)
	path_instance.position = Vector2.ZERO
	path_instance.curve_set_up(from, to)
	await path_instance.tween_path_follow(self)


func _to_string() -> String:
	return "({0}, {1})".format([Helper.get_resource_name(self), cost])
