extends TileObject
class_name Being

@export var deck: Deck
@export var health: Health
@export var health_bar: HealthBar


#FIXME investigate why Being.tscn, Baddie.tscn and Player.tscn arent synced up on Being.tscn update
func _ready() -> void:
	super()
	if deck != null:
		deck.set_up(self)
	
	health.set_up()
	health.on_dead.connect(on_death)
	health_bar.set_up(health)


func on_death() -> void:
	pass
