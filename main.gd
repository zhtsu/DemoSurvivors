extends Node

const Assets = preload("res://scenes/common/assets.gd")
const Methods = preload("res://scenes/common/methods.gd")

var setting_dict : Dictionary
var player_data_list : Array

func _ready():
	var default_settings_file = FileAccess.open(Assets.path_default_settings, FileAccess.READ)
	var default_settings = JSON.parse_string(default_settings_file.get_as_text())
	default_settings_file.close()
	
	# Create local user data file if not exist
	if not FileAccess.file_exists(Assets.path_default_settings):
		var settings_user_data_file = FileAccess.open(
			Assets.path_default_settings, FileAccess.WRITE)
		settings_user_data_file.store_line(JSON.stringify(default_settings, "\t"))
		settings_user_data_file.close()
		print_debug("Success to create local settings data file")
	
	var local_settings_file = FileAccess.open(Assets.path_default_settings, FileAccess.READ)
	setting_dict = JSON.parse_string(local_settings_file.get_as_text())
	local_settings_file.close()
	
	# Read data from csv
	Methods.csv_to_array(Assets.path_player_table, player_data_list)
	
	# Sync data to $MainMenu
	$MainMenu.setting_dict = setting_dict
	$MainMenu.player_data_list = player_data_list
	$MainMenu.call("_apply_settings")
	
	_apply_viewport_effect()


func _apply_viewport_effect():
	$ViewportEffect.call("active_viewport_effect", setting_dict["Effect"])


