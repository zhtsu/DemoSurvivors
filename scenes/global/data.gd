extends Node


var user_data_dict : Dictionary
var introductions : Dictionary
var player_data_list : Array[Dictionary]
var enemy_data_list : Array[Dictionary]
var map_data_list : Array[Dictionary]
var ability_data_list : Array[Dictionary]
var weapon_data_list : Array[Dictionary]

var visible_enemy_list : Array[Enemy]
# Used to make sure to play only one sound
# when multiple enemies die at the same time
var enemy_death_sound := AudioStreamPlayer.new()
var player_damage_sound := AudioStreamPlayer.new()
var particles_emitter_array : Array[ParticlesEmitter]


func _ready():
	var default_user_data : Dictionary
	var json_file = FileAccess.open(Assets.path_default_user_data, FileAccess.READ)
	default_user_data = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	# Create local user data file if not exist
	if not FileAccess.file_exists(Assets.path_local_user_data):
		var user_data_file = FileAccess.open(
			Assets.path_local_user_data, FileAccess.WRITE)
		user_data_file.store_line(JSON.stringify(default_user_data, "\t"))
		user_data_file.close()
		print_debug("Success to create local settings data file")
	
	json_file = FileAccess.open(Assets.path_local_user_data, FileAccess.READ)
	user_data_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	# Read data from csv
	Methods.load_csv_to_array(Assets.path_player_table, player_data_list)
	Methods.load_csv_to_array(Assets.path_enemy_table, enemy_data_list)
	Methods.load_csv_to_array(Assets.path_map_table, map_data_list)
	Methods.load_csv_to_array(Assets.path_ability_table, ability_data_list)
	Methods.load_csv_to_array(Assets.path_weapon_table, weapon_data_list)
	
	# Read introduction data
	json_file = FileAccess.open(Assets.path_introductions, FileAccess.READ)
	introductions = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	
	enemy_death_sound.volume_db = -24
	enemy_death_sound.stream = Assets.a_enemy_death
	add_child(enemy_death_sound)
	player_damage_sound.volume_db = -12
	player_damage_sound.stream = Assets.a_player_damage
	add_child(player_damage_sound)
	
	
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
	
	
func find_introduction(item_name : String, item_type : String) -> String:
	var intro_dict = introductions[item_type]
	return intro_dict[item_name]


