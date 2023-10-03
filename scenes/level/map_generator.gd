extends Node

const Enums = preload("res://scenes/global/enums.gd")
const Assets = preload("res://scenes/global/assets.gd")

# Used for realize infinite map
# Always make sure the player on the center map
# Map    Map    Map
# Map  > Map <  Map
# Map    Map    Map

# 3x3 matrix
const matrix_length := 3
# Map scene matrix
var map_matrix = [
	[Map.new(), Map.new(), Map.new()],
	[Map.new(), Map.new(), Map.new()],
	[Map.new(), Map.new(), Map.new()]
]


func _create_map(map_type : Enums.EMap, out_map : Map) -> void:
	if map_type == Enums.EMap.Forest:
		out_map = Assets.tscn_map_forest.instantiate()
	elif map_type == Enums.EMap.Cave:
		out_map = Assets.tscn_map_cave.instantiate()
	elif map_type == Enums.EMap.Tundra:
		out_map = Assets.tscn_map_tundra.instantiate()
	elif map_type == Enums.EMap.Desert:
		out_map = Assets.tscn_map_desert.instantiate()
	elif map_type == Enums.EMap.Challenge:
		out_map = Assets.tscn_map_challenge.instantiate()

func init(map_type : Enums.EMap):
	for i in range(matrix_length):
		for j in range(matrix_length):
			_create_map(map_type, map_matrix[i][j])
			
	print_debug(map_matrix)
