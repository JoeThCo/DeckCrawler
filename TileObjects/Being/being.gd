extends TileObject
class_name Being


@export var movement_timer: Timer
@export var health: Health


func set_up(input_world: World) -> void:
	super(input_world)

	
func can_execute_card(player: Player, being: Being, card: Card) -> bool:
	var distance_away: int = world.get_distance_from_player(grid_coords)
	print("{0} vs {1}".format([distance_away, card.action.distance.get_distance()]))
	return self.tile_object_id == being.tile_object_id and card.action.distance.is_correct_distance(distance_away)
	

func get_pathfinding_path(end: Vector2i) -> PackedVector2Array:
	return world.get_pathfinding_path(grid_coords, end)


func tween_to(to: Vector2) -> void:
	if self == null: return
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", to, movement_timer.wait_time)
	await tween.finished


func move(to: Vector2i) -> void:
	var path: PackedVector2Array = get_pathfinding_path(to)
	movement_timer.start()
	world.set_point_empty(grid_coords)
	world.set_point_solid(path[1])
	await tween_to(path[1])
	
	
func take_damage(damage_action: DamageAction) -> void:
	health.take_damage(damage_action)
	
