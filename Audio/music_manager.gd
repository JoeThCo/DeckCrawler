extends Node


@export_category("Nodes")
@export var audio_stream_player: AudioStreamPlayer


@export_category("Songs")
@export var all_songs: Array[AudioStream] = []
var song_queue: Array[AudioStream] = []

var current_song: AudioStream = null

var play_time: float = 0
var resume_time: float = 0

signal on_song_end

signal on_play
signal on_pause
signal on_song_skipped


func _ready() -> void:
	song_queue.append_array(all_songs) 
	song_queue.shuffle()
	play()
	

func play() -> void:
	if current_song == null:
		current_song = song_queue[0]
	audio_stream_player.stream = current_song
	
	if resume_time > 0:
		print(resume_time)
		audio_stream_player.play(resume_time)
	else:
		audio_stream_player.play()
		
	play_time = get_time_from_start_seconds()
	on_play.emit()
	await audio_stream_player.finished
	on_song_end.emit()
	move_song_queue_along()
	play()
	print_song_queue()


func move_song_queue_along() -> void:
	#move queue along
	var last_song: AudioStream = song_queue.pop_at(0)
	song_queue.append(last_song)
	resume_time = 0
	current_song = null


func skip_song() -> void:
	audio_stream_player.finished.emit()
	on_song_skipped.emit()
	

func pause() -> void:
	resume_time = get_time_from_start_seconds() - play_time
	print(resume_time)
	audio_stream_player.stop()
	on_pause.emit()


func get_time_from_start_seconds() -> float:
	return float(Time.get_ticks_msec()) / 1000.0


func print_song_queue() -> void:
	print("Song Queue")
	for x: AudioStream in song_queue:
		print(x)
