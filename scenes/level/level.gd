extends Node2D

const Enums = preload("res://scenes/global/enums.gd")
const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var player_data : Dictionary
var active_player_idx = 0
var active_map_name := "Grass"
var active_player : Player

func init(in_player_idx : int, in_map_name : String):
	active_player_idx = in_player_idx
	active_map_name = in_map_name


func init_transition(in_color : Color):
	$Transition.call("init", true, in_color)
	$Transition.connect("finished", _hide_transition)
	$Transition.call("display")


func _ready():
	active_player = Assets.tscn_player.instantiate()
	active_player.init(player_data)

	if (active_player == null):
		print_debug("Player type error: ", active_player_idx)
	else:
		active_player.spawn_position = Vector2(576, 324)
		active_player.call("set_position_smoothing", false)
		add_child(active_player)
		
	# Test
	var enemy_list : Array = []
	Methods.csv_to_array(Assets.path_enemy_table, enemy_list)
	for enemy_data in enemy_list:
		var enemy = Assets.tscn_enemy.instantiate()
		enemy.init(enemy_data)
		enemy.spawn_position = Vector2(500, 300)
		add_child(enemy)
	
func _hide_transition():
	$Transition.hide()
	if (active_player != null):
		active_player.call("set_position_smoothing", true)

