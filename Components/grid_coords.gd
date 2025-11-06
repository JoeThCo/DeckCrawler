extends Node2D
class_name GridCoordsComponent


@export var base_node: Node2D


var grid_coords: Vector2i:
	get:
		return Room.local_to_map(base_node.global_position)
