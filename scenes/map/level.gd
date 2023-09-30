extends Node2D

const Enums = preload("res://scenes/common/enums.gd")
const Assets = preload("res://scenes/common/assets.gd")

var player_type : Enums.EPlayer = Enums.EPlayer.NinjaFrog
var map_type : Enums.EMap = Enums.EMap.Forest
var player : Player

func init(in_player_type : Enums.EPlayer, in_map_type : Enums.EMap):
	player_type = in_player_type
	map_type = in_map_type


func init_transition(in_color : Color):
	$Transition.call("init", Enums.ETransitionDirection.Reverse, in_color)
	$Transition.connect("finished", _hide_transition)
	$Transition.call("display")


func _ready():
	if map_type == Enums.EMap.Forest:
		add_child(Assets.tscn_map_forest.instantiate())
	elif map_type == Enums.EMap.Cave:
		add_child(Assets.tscn_map_cave.instantiate())
	elif map_type == Enums.EMap.Tundra:
		add_child(Assets.tscn_map_tundra.instantiate())
	elif map_type == Enums.EMap.Desert:
		add_child(Assets.tscn_map_desert.instantiate())
	elif map_type == Enums.EMap.Challenge:
		add_child(Assets.tscn_map_challenge.instantiate())
	
	if player_type == Enums.EPlayer.NinjaFrog:
		player = Assets.tscn_ninja_frog.instantiate()
	elif player_type == Enums.EPlayer.MaskDude:
		player = Assets.tscn_mask_dude.instantiate()
	elif player_type == Enums.EPlayer.PinkMan:
		player = Assets.tscn_pink_man.instantiate()
	elif player_type == Enums.EPlayer.VirtualGuy:
		player = Assets.tscn_virtual_guy.instantiate()

	if (player == null):
		print_debug("Player type error: ", player_type)
	else:
		player.spawn_position = Vector2(576, 324)
		player.call("set_position_smoothing", false)
		add_child(player)
	
func _hide_transition():
	$Transition.hide()
	if (player != null):
		player.call("set_position_smoothing", true)

