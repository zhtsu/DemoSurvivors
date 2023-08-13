extends Control

const setting_menu_scene = preload("res://scenes/ui/setting_menu.tscn")
const exit_popup_scene = preload("res://scenes/ui/popup.tscn")
const pick_character_scene = preload("res://scenes/ui/pick_character.tscn")
# data
const SETTINGS_USER_DATA_PATH = "user://settings.json"

var settings_config:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	$VirtualBoyGuy.play("Idle")
	$MaskDudeIdle.play("Idle")
	$PinkManIdle.play("Idle")
	$NinjaFrogIdle.play("Idle")
	
	# Create local user data file if not exist
	if not FileAccess.file_exists(SETTINGS_USER_DATA_PATH):
		# Read config settings data
		var settings_json_file = FileAccess.open("res://assets/data/settings.json", FileAccess.READ)
		settings_config = JSON.parse_string(settings_json_file.get_as_text())
		print_debug("Settings:" + JSON.stringify(settings_config))
		settings_json_file.close()
		# Create user data for settings
		var settings_user_data_file = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.WRITE)
		settings_user_data_file.store_line(JSON.stringify(settings_config, "\t"))
		settings_user_data_file.close()
		print_debug("Success to create settings data file")
	
	var settings_user_data_file = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.READ)
	if settings_user_data_file == null:
		print_debug("Fail to load data file")
		return
	settings_config = JSON.parse_string(settings_user_data_file.get_as_text())
	settings_user_data_file.close()
	
	if settings_config["OpenSounds"]:
		loud()


func _on_setting_button_button_down():
	_play_button_down_sound()
	var setting_menu = setting_menu_scene.instantiate()
	setting_menu.call("init_settings", settings_config)
	add_child(setting_menu)


func _on_start_button_mouse_entered():
	_play_button_hover_sound()


func _on_setting_button_mouse_entered():
	_play_button_hover_sound()


func _on_exit_button_mouse_entered():
	_play_button_hover_sound()


func _on_start_button_button_down():
	_play_button_down_sound()
	var pick_character = pick_character_scene.instantiate()
	add_child(pick_character)


func exit_game():
	get_tree().quit()


func _on_exit_button_button_down():
	_play_button_down_sound()
	var exit_popup = exit_popup_scene.instantiate()
	exit_popup.call("init_popup", "Are you sure to exit?", exit_game)
	add_child(exit_popup)
	
	
func mute():
	get_tree().get_first_node_in_group("audio_mngr").call("mute")
	

func loud():
	get_tree().get_first_node_in_group("audio_mngr").call("loud")
	
	
func _play_button_down_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")
	
	
func _play_button_hover_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_hover")
