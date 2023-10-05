extends Control


const Assets = preload("res://scenes/global/assets.gd")

@export var map_name : String = "Grass"


func set_map_name(in_map_name : String):
	if in_map_name == map_name:
		return
	
	map_name = in_map_name
	
	for child in $SubViewport.get_children():
		$SubViewport.remove_child(child)
	
	#var map : Map
	
	#if map_type == Enums.EMap.Forest:
	#	map = Assets.tscn_map_forest.instantiate()
	#elif map_type == Enums.EMap.Desert:
	#	map = Assets.tscn_map_desert.instantiate()
	#elif map_type == Enums.EMap.Tundra:
	#	map = Assets.tscn_map_tundra.instantiate()
	#elif map_type == Enums.EMap.Challenge:
	#	map = Assets.tscn_map_challenge.instantiate()
	#elif map_type == Enums.EMap.Cave:
	#	map = Assets.tscn_map_cave.instantiate()
		
	#map.as_background = true
	#$SubViewport.add_child(map)
