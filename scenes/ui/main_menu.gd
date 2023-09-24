extends Control

const tscn_setting_menu = preload("res://scenes/ui/setting_menu.tscn")
const tscn_popup = preload("res://scenes/ui/popup.tscn")
const tscn_pick_player = preload("res://scenes/ui/pick_player.tscn")
const tscn_about = preload("res://scenes/ui/about.tscn")
# data
const SETTINGS_USER_DATA_PATH = "user://settings.json"

var settings_config:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	$VirtualGuy.play("Idle")
	$MaskDude.play("Idle")
	$PinkMan.play("Idle")
	$NinjaFrog.play("Idle")
	
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
	var setting_menu_scene = tscn_setting_menu.instantiate()
	setting_menu_scene.call("init_settings", settings_config)
	add_child(setting_menu_scene)


func _on_start_button_mouse_entered():
	_play_button_hover_sound()


func _on_setting_button_mouse_entered():
	_play_button_hover_sound()


func _on_exit_button_mouse_entered():
	_play_button_hover_sound()


func _on_start_button_button_down():
	_play_button_down_sound()
	var pick_player_scene = tscn_pick_player.instantiate()
	add_child(pick_player_scene)




func _on_about_button_button_down():
	_play_button_down_sound()
	var about_scene = tscn_about.instantiate()
	add_child(about_scene)
	
	
func _on_collection_button_button_down():
	_play_button_down_sound()
	
	
func quit_game():
	get_tree().quit()
	
	
func _on_quit_button_button_down():
	_play_button_down_sound()
	var quit_popup_scene = tscn_popup.instantiate()
	quit_popup_scene.call("init_popup", "Are you sure to quit game?", quit_game)
	add_child(quit_popup_scene)

	
func mute():
	get_tree().get_first_node_in_group("audio_mngr").call("mute")
	

func loud():
	get_tree().get_first_node_in_group("audio_mngr").call("loud")
	
	
func _play_button_down_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_down")
	
	
func _play_button_hover_sound():
	get_tree().get_first_node_in_group("audio_mngr").call("play_button_hover")
