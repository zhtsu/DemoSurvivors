extends Node2D

const Enums = preload("res://scenes/global/enums.gd")
const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var player_data : Dictionary
var map_name := "Grass"
var active_player : Player
var active_map : Map
var resource_density := 0.1

func init(in_map_name : String):
	map_name = in_map_name


func init_transition(in_color : Color):
	$Transition.call("init", true, in_color)
	$Transition.connect("finished", _hide_transition)
	$Transition.call("display")


func _ready():
	# Create player
	active_player = Assets.tscn_player.instantiate()
	active_player.init(player_data)
	active_player.spawn_position = Vector2(576, 324)
	active_player.call("set_position_smoothing", false)
	add_child(active_player)
	# Init player state using created player
	$PlayerState.call("init", active_player)
	# Create map
	# Use load() instead of the preload() what in Assets to avoid cyclic reference
	var tscn_map_res = load(Assets.path_tscn_map)
	active_map = tscn_map_res.instantiate()
	active_map.init(active_player, map_name)
	add_child(active_map)
	
	# Test
	var enemy_list : Array = []
	Methods.load_csv_to_array(Assets.path_enemy_table, enemy_list)
	for enemy_data in enemy_list:
		var enemy = Assets.tscn_enemy.instantiate()
		enemy.init(enemy_data)
		enemy.spawn_position = Vector2(500, 300)
		add_child(enemy)
	
func _hide_transition():
	$Transition.hide()
	if (active_player != null):
		active_player.call("set_position_smoothing", true)

