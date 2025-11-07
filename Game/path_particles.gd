extends Node2D
class_name PathParticles


@export var path: Path2D
@export var path_follow: PathFollow2D
@export var sprite: Sprite2D


func set_up(action: Action) -> void:
	sprite.texture = action.icon
	sprite.self_modulate = action.particle_color


func curve_set_up(from: TileObjectComponent, to: TileObjectComponent) -> void:
	path.curve.clear_points()
	path.curve.add_point(from.global_position)
	path.curve.add_point(to.global_position)
	if path.curve.get_baked_length() <= 0:
		path.curve.set_point_position(1, to.global_position + Vector2.ONE * 0.001)
	

func tween_path_follow(action: Action) -> void:
	path_follow.progress_ratio = 0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(path_follow, "progress_ratio", 1.0, action.action_time)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN)
	await tween.finished
	queue_free()
