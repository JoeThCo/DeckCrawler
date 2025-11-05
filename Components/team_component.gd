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
}

const ALLY = Team.PLAYER | Team.FRIEND

@export var team: Team
