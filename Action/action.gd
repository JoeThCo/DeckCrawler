extends Resource
class_name Action


signal action_complete


@export_category("Values")
@export var cost: int
enum SimpleTarget
{
	SELF,
	OTHER_TRAVEL,
	OTHER_CENTERED
}
@export var simple_target: SimpleTarget
var target: Target


@export_category("Meta Data")
@export var action_name: String = "Action Name"
@export_multiline var description: String = "No Description"
@export var icon: CompressedTexture2D
@export var particle_to_spawn: String


var owner_object: TileObjectComponent


func set_up(_to: TileObjectComponent) -> void:
	owner_object = _to
	
	match simple_target:
		SimpleTarget.SELF:
			target = SelfTarget.new()
		SimpleTarget.OTHER_TRAVEL:
			target = OtherTravel.new()
		SimpleTarget.OTHER_CENTERED:
			target = OtherCentered.new()
	target.set_up(owner_object)


func execute() -> void:
	if target is SelfTarget:
		do_action(owner_object)
		#await display_particles(owner_object, owner_object)
	elif target is OtherTarget:
		#FIXME Can target yourself, others only not you
		var other_tile_object: TileObjectComponent = await SignalBus.tile_object_selection 
		if target is OtherCentered:
			pass
			#await display_particles(other_tile_object, other_tile_object)
		elif target is OtherTravel:
			pass
			#await display_particles(owner_object, other_tile_object)
		do_action(other_tile_object)
	action_complete.emit()


func _to_string() -> String:
	return "({0}, {1})".format([Helper.get_resource_name(self), cost])


func do_action(_tile_object: TileObjectComponent) -> void:
	print("Action!")


#func display_particles(from: TileObjectComponent, to: TileObjectComponent) -> void:
	#if particle_to_spawn.is_empty(): return
	#var particle: PackedScene = load("res://Action/Particles/SpawnableParticles/" + particle_to_spawn + ".tscn")
	#var particle_instance: ActionParticles = particle.instantiate() as ActionParticles
	#if particle_instance is ActionParticles:
		#var path_particle_prefab: PackedScene = load("res://Action/Particles/path_particles.tscn")
		#var path_instance: PathParticles = path_particle_prefab.instantiate() as PathParticles
		#
		#Game.game_root.add_child(path_instance)
		#path_instance.set_up(particle_instance)
		#path_instance.position = Vector2.ZERO
		#path_instance.curve_set_up(from, to)
		#await path_instance.tween_path_follow()
