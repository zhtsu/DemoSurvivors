extends Control

const Enums = preload("res://scenes/common/enums.gd")
const Assets = preload("res://scenes/common/assets.gd")

@export var map_type : Enums.EMap = Enums.EMap.Forest


func set_map_type(in_map_type : Enums.EMap):
	if in_map_type == map_type:
		return
	
	map_type = in_map_type
	
	for child in $SubViewport.get_children():
		$SubViewport.remove_child(child)
	
	var map : Map
	
	if map_type == Enums.EMap.Forest:
		map = Assets.tscn_map_forest.instantiate()
	elif map_type == Enums.EMap.Desert:
		map = Assets.tscn_map_desert.instantiate()
	elif map_type == Enums.EMap.Tundra:
		map = Assets.tscn_map_tundra.instantiate()
	elif map_type == Enums.EMap.Challenge:
		map = Assets.tscn_map_challenge.instantiate()
	elif map_type == Enums.EMap.Cave:
		map = Assets.tscn_map_cave.instantiate()
		
	map.as_background = true
	$SubViewport.add_child(map)
