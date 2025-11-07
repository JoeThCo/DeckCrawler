extends AudioStreamPlayer2D
class_name OneShotSFX


func set_up(audio_stream: AudioStream) -> void:
	stream = audio_stream
	play()
	await finished
	queue_free()
