extends Node

# data
const DEFAULT_SETTINGS_FILE_PATH = "res://assets/data/default_settings.json"
const SETTINGS_USER_DATA_PATH = "user://settings.json"

var setting_dict : Dictionary

func _ready():
	var default_settings_file = FileAccess.open(DEFAULT_SETTINGS_FILE_PATH, FileAccess.READ)
	var default_settings = JSON.parse_string(default_settings_file.get_as_text())
	default_settings_file.close()
	
	# Create local user data file if not exist
	if not FileAccess.file_exists(SETTINGS_USER_DATA_PATH):
		var settings_user_data_file = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.WRITE)
		settings_user_data_file.store_line(JSON.stringify(default_settings, "\t"))
		settings_user_data_file.close()
		print_debug("Success to create local settings data file")
	
	var local_settings_file = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.READ)
	setting_dict = JSON.parse_string(local_settings_file.get_as_text())
	local_settings_file.close()
	
	# Sync settings data
	$MainMenu.setting_dict = setting_dict
	$MainMenu.call("_apply_settings")
	
	_apply_viewport_effect()


func _apply_viewport_effect():
	$ViewportEffect.call("active_viewport_effect", setting_dict["Effect"])
