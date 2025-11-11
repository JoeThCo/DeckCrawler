extends Node
class_name TeamComponent

enum Team
{
	NONE = 0,
	PLAYER = 1,
	FRIEND = 2,
	BADDIE = 4,
	NPC = 8,
	STATIC = 16,
	ALLY = PLAYER | FRIEND,
	NON_NPC = PLAYER | FRIEND | BADDIE
}

@export var team: Team
