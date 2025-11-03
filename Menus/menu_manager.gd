extends Control
class_name MenuManager


static var all_menus: Control


static func set_up(_am: Control) -> void:
	all_menus = _am
	display_menu("Game")


static func display_menu(menu_name: String) -> void:
	for child in all_menus.get_children():
		child.visible = menu_name == child.name
