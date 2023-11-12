class_name Level
extends Node2D


var player_data : Dictionary
var map_data : Dictionary
var active_player : Player
var active_map : Map
var resource_density := 0.1


func init(in_map_data : Dictionary, in_player_data : Dictionary):
	map_data = in_map_data
	player_data = in_player_data
	

func _ready():
	Data.visible_enemy_list.clear()
	Data.particles_emitter_array.clear()
	# Create player
	active_player = Assets.tscn_player.instantiate()
	active_player.init(player_data)
	active_player.spawn_position = Vector2(576, 324)
	active_player.call("set_position_smoothing", false)
	active_player.connect("death", _pop_death_menu)
	add_child(active_player)
	# Init player state using created player
	$PlayerState.call("init", active_player)
	# Create map
	var map_name = map_data["name"]
	var map_bgm : String = map_data["BGM"]
	active_map = Assets.tscn_map.instantiate()
	active_map.init(active_player, map_name)
	add_child(active_map)
	# Change BGM
	get_tree().get_first_node_in_group("main").set_bgm(map_bgm, -12)
	# Init enemy spawner
	var enemy_spawner = Assets.tscn_enemy_spawner.instantiate()
	enemy_spawner.call("init", map_data, active_player, self)
	add_child(enemy_spawner)
	
	
func _pop_death_menu():
	get_tree().paused = true
	var ui_death = Assets.tscn_death.instantiate()
	add_child(ui_death)
	
