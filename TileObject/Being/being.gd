extends TileObject
class_name Being

@export var deck: Deck
@export var health: Health
@export var health_bar: HealthBar


func _ready() -> void:
	super()
	if deck != null:
		deck.set_up(self)
	
	health.set_up()
	health.on_dead.connect(on_death)
	health_bar.set_up(health)


func on_death() -> void:
	pass
