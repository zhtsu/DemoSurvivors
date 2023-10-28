class_name Main
extends Node

const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var option_dict : Dictionary
var player_data_list : Array[Dictionary]
var enemy_data_list : Array[Dictionary]
var map_data_list : Array[Dictionary]
var ability_data_list : Array[Dictionary]
#
var visible_enemy_list : Array[Enemy]


func find_ability_data(ability_name : String) -> Dictionary:
	for ability in ability_data_list:
		if ability["name"] == ability_name:
			return ability
	return {}


func _ready():
	var default_settings : Dictionary
	var json_file = FileAccess.open(Assets.path_default_options, FileAccess.READ)
	default_settings = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	# Create local user data file if not exist
	if not FileAccess.file_exists(Assets.path_local_options):
		var settings_user_data_file = FileAccess.open(
			Assets.path_local_options, FileAccess.WRITE)
		settings_user_data_file.store_line(JSON.stringify(default_settings, "\t"))
		settings_user_data_file.close()
		print_debug("Success to create local settings data file")
	
	json_file = FileAccess.open(Assets.path_local_options, FileAccess.READ)
	option_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	json_file = FileAccess.open(Assets.path_local_options, FileAccess.READ)
	option_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	# Read data from csv
	Methods.load_csv_to_array(Assets.path_player_table, player_data_list)
	Methods.load_csv_to_array(Assets.path_enemy_table, enemy_data_list)
	Methods.load_csv_to_array(Assets.path_map_table, map_data_list)
	Methods.load_csv_to_array(Assets.path_ability_table, ability_data_list)
	
	var main_menu = Assets.tscn_main_menu.instantiate()
	add_child(main_menu)
	
	# Make sure the function below called after modifying setting_dict 
	_apply_viewport_effect()
	$MusicPlayer.play()


func _apply_viewport_effect():
	$ViewportEffect.call("active_viewport_effect", option_dict["Effect"])
	
	
func get_music_player() -> AudioStreamPlayer:
	return $MusicPlayer


