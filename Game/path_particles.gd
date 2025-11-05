extends Node2D
class_name PathParticles


@export var path: Path2D
@export var path_follow: PathFollow2D

var action_particles: ActionParticles

func set_up(_gpu: ActionParticles) -> void:
	action_particles = _gpu
	path_follow.add_child(action_particles)
	action_particles.restart()


func curve_set_up(from: TileObjectComponent, to: TileObjectComponent) -> void:
	path.curve.clear_points()
	path.curve.add_point(from.center.global_position)
	path.curve.add_point(to.center.global_position)
	if path.curve.get_baked_length() <= 0:
		path.curve.set_point_position(1, to.center.global_position + Vector2.ONE * 0.001)
	

func tween_path_follow() -> void:
	path_follow.progress_ratio = 0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(path_follow, "progress_ratio", 1.0, action_particles.total_time)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN)
	await tween.finished
	queue_free()
