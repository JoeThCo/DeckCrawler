extends Node2D
class_name PathParticles


@export var path: Path2D
@export var path_follow: PathFollow2D

var gpu_particles: GPUParticles2D


func set_up(_gpu: GPUParticles2D) -> void:
	gpu_particles = _gpu
	path_follow.add_child(gpu_particles)
	gpu_particles.restart()


func curve_set_up(from: TileObject, to: TileObject) -> void:
	path.curve.clear_points()
	path.curve.add_point(from.center.global_position)
	path.curve.add_point(to.center.global_position)
	if path.curve.get_baked_length() <= 0:
		path.curve.set_point_position(1, to.center.global_position + Vector2.ONE * 0.001)
	

func tween_path_follow() -> void:
	path_follow.progress_ratio = 0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(path_follow, "progress_ratio", 1.0, 1.0)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN)
	await tween.finished
	queue_free()
