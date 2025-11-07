extends SelectionComponent
class_name BaddieSelectionComponent


@export var baddie_ai: BaddieAIComponent


func get_baddie_selection() -> void:
	selection_complete.emit(baddie_ai.get_best_tile_object())
