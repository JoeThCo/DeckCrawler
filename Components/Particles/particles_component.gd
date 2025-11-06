extends Node2D
class_name ParticlesComponent


@export var health: HealthComponent


@export_category("Particles")
@export var damage: GPUParticles2D
@export var healing: GPUParticles2D



func _ready() -> void:
	health.damaged.connect(damaged)
	health.healed.connect(healed)
	health.on_dead.connect(dead)


func damaged() -> void:
	damage.restart()


func dead() -> void:
	var parent:Node2D = damage.get_parent()
	parent.remove_child(damage)
	Game.game_root.add_child(damage)
	damage.global_position = parent.global_position #FIXME spawn at position
	damage.restart()
	
	await damage.finished
	damage.queue_free()


func healed() -> void:
	healing.restart()
