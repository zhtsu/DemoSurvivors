extends Control

const Enums = preload("res://scenes/mngr/enums.gd")
#
const tscn_map_forest = preload("res://scenes/map/map_forest.tscn")
const tscn_map_cave = preload("res://scenes/map/map_cave.tscn")
const tscn_map_desert = preload("res://scenes/map/map_desert.tscn")
const tscn_map_tundra = preload("res://scenes/map/map_tundra.tscn")
const tscn_map_challenge = preload("res://scenes/map/map_challenge.tscn")

@export var map_type : Enums.EMap = Enums.EMap.Forest


func set_map_type(in_map_type : Enums.EMap):
	if in_map_type == map_type:
		return
	
	map_type = in_map_type
	
	for child in $SubViewport.get_children():
		$SubViewport.remove_child(child)
	
	var map : Map
	
	if map_type == Enums.EMap.Forest:
		map = tscn_map_forest.instantiate()
	elif map_type == Enums.EMap.Desert:
		map = tscn_map_desert.instantiate()
	elif map_type == Enums.EMap.Tundra:
		map = tscn_map_tundra.instantiate()
	elif map_type == Enums.EMap.Challenge:
		map = tscn_map_challenge.instantiate()
	elif map_type == Enums.EMap.Cave:
		map = tscn_map_cave.instantiate()
		
	map.as_background = true
	$SubViewport.add_child(map)
