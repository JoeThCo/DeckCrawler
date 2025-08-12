extends Distance
class_name DistanceFrom


@export var distance_from: int = -1


func is_correct_distance(input_distance: int) -> bool:
	#print("{0} vs {1}".format([input_distance, distance_from]))
	return input_distance <= distance_from


func get_distance() -> int:
	return distance_from
