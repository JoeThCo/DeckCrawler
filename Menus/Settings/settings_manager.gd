extends Node

signal on_setting_updated(key: String, value)
static var settings_dict: Dictionary = {}


const MASTER_VOLUME_KEY: String = "Master_Volume"
const SFX_VOLUME_KEY: String = "SFX_Volume"
const MUSIC_VOLUME_KEY: String = "Music_Volume"


func _ready() -> void:
	on_setting_updated.connect(setting_updated)
	
	add_setting(SettingsManager.MASTER_VOLUME_KEY, 1.0)
	add_setting(SettingsManager.MUSIC_VOLUME_KEY, 0.75)
	add_setting(SettingsManager.SFX_VOLUME_KEY, 0.75)


func setting_updated(key: String, value) -> void:
	if key != SettingsManager.MASTER_VOLUME_KEY: return
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), lerp(-50, 0, value))

func add_setting(key: String, value) -> void:
	if not settings_dict.has(key):
		settings_dict[key] = value
		on_setting_updated.emit(key, value)
		print("ADD: {0} | {1}".format([key, value]))


func set_setting(key: String, value) -> void:
	if settings_dict.has(key):
		settings_dict[key] = value
		on_setting_updated.emit(key, value)
		print("SET: {0} | {1}".format([key, value]))


func get_setting(key: String):
	if settings_dict.has(key):
		return settings_dict[key]
	return null
	

func print_settings() -> void:
	for i in range(settings_dict.size()):
		print("{0} | {1}".format([settings_dict.keys()[i], settings_dict.values()[i]]))
