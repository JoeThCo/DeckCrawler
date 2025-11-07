extends Control
class_name Settings


@export var master_volume: SettingSlider
@export var music_volume: SettingSlider
@export var sfx_volume: SettingSlider


func _ready() -> void:
	master_volume.set_value(SettingsManager.get_setting(SettingsManager.MASTER_VOLUME_KEY))
	music_volume.set_value(SettingsManager.get_setting(SettingsManager.MUSIC_VOLUME_KEY))
	sfx_volume.set_value(SettingsManager.get_setting(SettingsManager.SFX_VOLUME_KEY))
	
	#_on_master_volume_setting_slider_value_changed(SettingsManager.get_setting(SettingsManager.MASTER_VOLUME_KEY))
	#_on_music_volume_setting_slider_value_changed(SettingsManager.get_setting(SettingsManager.MUSIC_VOLUME_KEY))
	#_on_sfx_volume_setting_slider_value_changed(SettingsManager.get_setting(SettingsManager.SFX_VOLUME_KEY))


func _on_main_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Menus/MainMenu/main_menu.tscn")


func _on_master_volume_setting_slider_value_changed(value: float) -> void:
	SettingsManager.set_setting(SettingsManager.MASTER_VOLUME_KEY, value)


func _on_music_volume_setting_slider_value_changed(value: float) -> void:
	SettingsManager.set_setting(SettingsManager.MUSIC_VOLUME_KEY, value)


func _on_sfx_volume_setting_slider_value_changed(value: float) -> void:
	SettingsManager.set_setting(SettingsManager.SFX_VOLUME_KEY, value)
