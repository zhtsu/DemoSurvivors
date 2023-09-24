extends Node2D

const Enums = preload("res://scenes/mngr/enums.gd")
#
const tscn_ninja_frog = preload("res://scenes/character/player/ninja_frog/ninja_frog.tscn")
const tscn_mask_dude = preload("res://scenes/character/player/mask_dude/mask_dude.tscn")
const tscn_pink_man = preload("res://scenes/character/player/pink_man/pink_man.tscn")
const tscn_virtual_guy = preload("res://scenes/character/player/virtual_guy/virtual_guy.tscn")
#
const tscn_map_forest = preload("res://scenes/map/map_forest.tscn")
const tscn_map_cave = preload("res://scenes/map/map_cave.tscn")
const tscn_map_desert = preload("res://scenes/map/map_desert.tscn")
const tscn_map_tundra = preload("res://scenes/map/map_tundra.tscn")
const tscn_map_challenge = preload("res://scenes/map/map_challenge.tscn")

var player_type : Enums.EPlayer = Enums.EPlayer.NinjaFrog
var map_type : Enums.EMap = Enums.EMap.Forest
var player : Player

func init(in_player_type : Enums.EPlayer, in_map_type : Enums.EMap):
	player_type = in_player_type
	map_type = in_map_type


func _ready():
	$Transition.connect("finished", _hide_transition)
	$Transition.call("display")
	
	if map_type == Enums.EMap.Forest:
		add_child(tscn_map_forest.instantiate())
	elif map_type == Enums.EMap.Cave:
		add_child(tscn_map_cave.instantiate())
	elif map_type == Enums.EMap.Tundra:
		add_child(tscn_map_tundra.instantiate())
	elif map_type == Enums.EMap.Desert:
		add_child(tscn_map_desert.instantiate())
	elif map_type == Enums.EMap.Challenge:
		add_child(tscn_map_challenge.instantiate())
	
	if player_type == Enums.EPlayer.NinjaFrog:
		player = tscn_ninja_frog.instantiate()
	elif player_type == Enums.EPlayer.MaskDude:
		player = tscn_mask_dude.instantiate()
	elif player_type == Enums.EPlayer.PinkMan:
		player = tscn_pink_man.instantiate()
	elif player_type == Enums.EPlayer.VirtualGuy:
		player = tscn_virtual_guy.instantiate()
	
	player.spawn_position = Vector2(576, 324)
	player.call("set_position_smoothing", false)
	add_child(player)
		
	
	
	
func _hide_transition():
	$Transition.hide()
	player.call("set_position_smoothing", true)

