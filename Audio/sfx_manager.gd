extends Node2D
class_name SFXManager


static var sfx_dict: Dictionary = {
	"Damage" : "res://Audio/SFX/Damage.wav",
	"Heal" : "res://Audio/SFX/Heal.wav",
	"Death" : "res://Audio/SFX/Death.wav",
	"Move" : "res://Audio/SFX/Move.wav",
	"ActionCancel" : "res://Audio/SFX/ActionCancel.wav",
	"ActionMouseOver" : "res://Audio/SFX/ActionMouseOver.wav",
	"ActionPlayed" : "res://Audio/SFX/ActionPlayed.wav",
	"ActionSelect" : "res://Audio/SFX/ActionSelect.wav",
}


static func play_one_shot_sfx(sfx_name: String) -> void:
	var one_shot_prefab: PackedScene = load("res://Audio/one_shot_sfx.tscn")
	var one_shot: OneShotSFX = one_shot_prefab.instantiate() as OneShotSFX
	var audio_stream: AudioStream = load(sfx_dict[sfx_name]) as AudioStream
	Game.game_root.add_child(one_shot)
	one_shot.set_up(audio_stream)
