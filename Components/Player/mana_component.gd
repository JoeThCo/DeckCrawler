extends Node
class_name ManaComponent

signal mana_gained
signal mana_lost


@export var starting_mana: int = MAX_MANA
var current_mana: int
const MAX_MANA: int = 10


func _ready() -> void:
	current_mana = starting_mana


func gain_mana(amount: int) -> void:
	current_mana += amount
	current_mana = clamp(current_mana, 0, MAX_MANA)
	mana_gained.emit(current_mana)


func lose_mana(amount: int) -> void:
	current_mana -= amount
	current_mana = clamp(current_mana, 0, MAX_MANA)
	mana_lost.emit(current_mana)
