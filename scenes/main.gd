class_name Main
extends Node

const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var option_dict : Dictionary
var player_data_list : Array[Dictionary]
var enemy_data_list : Array[Dictionary]
var map_data_list : Array[Dictionary]
var ability_data_list : Array[Dictionary]
var weapon_data_list : Array[Dictionary]

var visible_enemy_list : Array[Enemy]
# Only one element can exist
# Used to make sure create only one sound 
# when multiple enemies die at the same time
var enemy_death_sound_array : Array[OnceSound]
var player_damage_sound_array : Array[OnceSound]


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
	Methods.load_csv_to_array(Assets.path_weapon_table, weapon_data_list)
	
	var main_menu = Assets.tscn_main_menu.instantiate()
	add_child(main_menu)
	
	# Make sure the function below called after modifying setting_dict 
	_apply_viewport_effect()


func _apply_viewport_effect():
	$ViewportEffect.call("active_viewport_effect", option_dict["Effect"])
	
	
func get_music_player() -> AudioStreamPlayer:
	return $MusicPlayer


func set_bgm(bgm_name : String, db : float = 0):
	var bgm_path = Assets.dir_music + bgm_name
	$MusicPlayer.stop()
	$MusicPlayer.stream = load(bgm_path)
	$MusicPlayer.volume_db = db
	$MusicPlayer.play()
	
	
func find_ability_data(ability_name : String) -> Dictionary:
	for ability in ability_data_list:
		if ability["name"] == ability_name:
			return ability
	return {}


func find_enemy_data(enemy_name : String) -> Dictionary:
	for enemy in enemy_data_list:
		if enemy["name"] == enemy_name:
			return enemy
	return {}


func find_weapon_data(weapon_name : String) -> Dictionary:
	for weapon in weapon_data_list:
		if weapon["name"] == weapon_name:
			return weapon
	return {}


func find_map_data(map_name : String) -> Dictionary:
	for map in map_data_list:
		if map["name"] == map_name:
			return map
	return {}

