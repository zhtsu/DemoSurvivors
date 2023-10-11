extends Node

const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var option_dict : Dictionary


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
	
	# Make sure the function below called after modifying setting_dict 
	_apply_viewport_effect()
	$MusicPlayer2D.play()


func _apply_viewport_effect():
	$ViewportEffect.call("active_viewport_effect", option_dict["Effect"])
	
	
func get_music_player() -> AudioStreamPlayer2D:
	return $MusicPlayer2D


