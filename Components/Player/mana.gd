extends Node
class_name ManaComponent


signal mana_gained
signal mana_lost


@export var starting_mana: int = MAX_MANA
var current_mana: int
const MAX_MANA: int = 10


const ACTION_MANA_GAIN: int = 1


func _ready() -> void:
	current_mana = starting_mana


func gain_action_mana() -> void:
	gain_mana(ACTION_MANA_GAIN)


func gain_mana(amount: int) -> void:
	current_mana += amount
	current_mana = clamp(current_mana, 0, MAX_MANA)
	mana_gained.emit()


func lose_mana(amount: int) -> void:
	current_mana -= amount
	current_mana = clamp(current_mana, 0, MAX_MANA)
	mana_lost.emit()
