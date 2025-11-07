extends GPUParticles2D
class_name ActionParticles


@export var total_time: float = 0.25


func set_up(tile_object: TileObjectComponent) -> void:
	global_position = tile_object.center.global_position
	var timer: SceneTreeTimer = get_tree().create_timer(total_time)
	restart()
	await timer.timeout
	queue_free()
