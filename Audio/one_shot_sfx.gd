extends AudioStreamPlayer2D
class_name OneShotSFX

@export var min_volume: int = -50


func set_up(audio_stream: AudioStream) -> void:
	stream = audio_stream
	volume_db = lerp(min_volume, 0, SettingsManager.get_setting(SettingsManager.SFX_VOLUME_KEY))
	play()
	await finished
	queue_free()
