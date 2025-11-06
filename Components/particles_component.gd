extends Node2D
class_name ParticlesComponent


@export var health: HealthComponent


@export_category("Particles")
@export var damage_particles: GPUParticles2D


func _ready() -> void:
	health.damaged.connect(damaged)
	

func damaged() -> void:
	damage_particles.restart()
