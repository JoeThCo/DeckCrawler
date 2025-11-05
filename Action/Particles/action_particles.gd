extends GPUParticles2D
class_name ActionParticles


@export var total_time: float = 0.25


func set_up(tile_object: TileObjectComponent) -> void:
	global_position = tile_object.center.global_position
	finished.connect(on_finished)
	restart()


func on_finished() -> void:
	queue_free()
