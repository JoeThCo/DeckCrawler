extends GPUParticles2D
class_name ActionParticles


func set_up(tile_object: TileObject) -> void:
	global_position = tile_object.center.global_position
	finished.connect(on_finished)
	restart()


func on_finished() -> void:
	queue_free()
