class_name Level
extends Node2D

const Enums = preload("res://scenes/global/enums.gd")
const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var player_data : Dictionary
var map_name := "Grass"
var active_player : Player
var active_map : Map
var resource_density := 0.1


func init(in_map_name : String, in_player_data : Dictionary):
	map_name = in_map_name
	player_data = in_player_data
	

func _ready():
	var MAIN = get_tree().get_first_node_in_group("main")
	MAIN.visible_enemy_list.clear()
	MAIN.enemy_death_sound_pool.clear()
	# Create player
	active_player = Assets.tscn_player.instantiate()
	active_player.init(player_data, MAIN)
	active_player.spawn_position = Vector2(576, 324)
	active_player.call("set_position_smoothing", false)
	active_player.connect("death", _pop_death_menu)
	add_child(active_player)
	# Init player state using created player
	$PlayerState.call("init", active_player)
	# Init enemy spawner
	var enemy_spawner = Assets.tscn_enemy_spawner.instantiate()
	enemy_spawner.call("init", map_name, active_player, self)
	add_child(enemy_spawner)
	# Create map
	active_map = Assets.tscn_map.instantiate()
	active_map.init(active_player, map_name)
	add_child(active_map)
	
	
func _pop_death_menu():
	get_tree().paused = true
	var ui_death = Assets.tscn_death.instantiate()
	add_child(ui_death)
	
