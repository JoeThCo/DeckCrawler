extends Control


@export var mana: ManaComponent
@export var mana_label: Label


func _ready() -> void:
	mana.mana_gained.connect(mana_gained)
	mana.mana_lost.connect(mana_lost)
	mana_label.text = str(mana.current_mana)


func mana_gained() -> void:
	mana_label.text = str(mana.current_mana)


func mana_lost() -> void:
	mana_label.text = str(mana.current_mana)
