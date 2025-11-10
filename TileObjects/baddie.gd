extends TileObjectComponent
class_name BaddieThree

@export_category("Baddie")
@export var movement: MovementComponent
@export var health: HealthComponent
@export var baddie_ai: BaddieAIComponent


func  _ready() -> void:
	health.on_dead.connect(on_baddie_dead)
	
	
func on_baddie_dead() -> void:
	TileObjectManager.delete_tile_object(self)
	SFXManager.play_one_shot_sfx("Death")
