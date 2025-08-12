extends Node2D
class_name BaddieController

var world: World


func set_up(in_world: World) -> void:
	world = in_world
	
	SignalBus.player_turn_complete.connect(player_turn_complete)


func distance_sorter(a: Baddie, b: Baddie) -> bool:
	#this does world distance, NOT GRID TILES!!!
	return a.grid_coords.distance_squared_to(world.player.grid_coords) < b.grid_coords.distance_squared_to(world.player.grid_coords)


func player_turn_complete() -> void:
	var all_baddies: Array[Baddie] = get_all_baddies()
	var all_baddies_alive: Array[Baddie] = all_baddies.filter((func(b: Baddie): return !b.health.is_dead))
	var all_baddies_dead: Array[Baddie] = all_baddies.filter((func(b: Baddie): return b.health.is_dead))
	
	#kill dead ones first
	for baddie: Baddie in all_baddies_dead:
		if baddie.health.is_dead:
			await baddie.on_death()
	
	#alive, sort by distance from player
	all_baddies_alive.sort_custom(distance_sorter)
	for baddie: Baddie in all_baddies_alive:
		await baddie.move_towards_player(world.player.grid_coords)
		if baddie.can_attack_player():
			await baddie.attack_player(world.player)
			
	SignalBus.emit_baddie_controller_completed()


func get_all_baddies() -> Array[Baddie]:
	var local_baddies: Array[Baddie] = []
	for child: Node2D in %Baddies.get_children():
		if child is not Baddie: continue
		local_baddies.append(child as Baddie)
	return local_baddies


func get_baddie(search_baddie: Baddie) -> Baddie:
	for baddie: Baddie in get_all_baddies():
		if search_baddie.tile_object_id == baddie.tile_object_id:
			return baddie
	return null
