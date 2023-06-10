extends Control

var SettingMenu_Scene = preload("res://Scenes/UI/SettingMenu.tscn")
var Settings:Dictionary
const SETTINGS_USER_DATA_PATH = "user://settings.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	$VirtualBoyGuy.play("Idle")
	$MaskDudeIdle.play("Idle")
	$PinkManIdle.play("Idle")
	$NinjaFrogIdle.play("Idle")
	
	# Create local user data file if not exist
	if not FileAccess.file_exists(SETTINGS_USER_DATA_PATH):
		# Read config settings data
		var SettingsJsonFile = FileAccess.open("res://Assets/Data/settings.json", FileAccess.READ)
		Settings = JSON.parse_string(SettingsJsonFile.get_as_text())
		print_debug("Settings:" + JSON.stringify(Settings))
		SettingsJsonFile.close()
		# Create user data for settings
		var SettingsUserDataFile = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.WRITE)
		SettingsUserDataFile.store_line(JSON.stringify(Settings, "\t"))
		SettingsUserDataFile.close()
		print_debug("Success to create settings data file")
	
	var SettingsUserDataFile = FileAccess.open(SETTINGS_USER_DATA_PATH, FileAccess.READ)
	if SettingsUserDataFile == null:
		print_debug("Fail to load data file")
		return
	Settings = JSON.parse_string(SettingsUserDataFile.get_as_text())
	SettingsUserDataFile.close()
	
	if Settings["OpenSounds"]:
		Sound()
	




func _on_setting_button_button_down():
	PlayButtonDownSound()
	var SettingMenu = SettingMenu_Scene.instantiate()
	SettingMenu.call("InitSettings", Settings)
	SettingMenu.connect("open_sounds", Mute)
	SettingMenu.connect("close_sounds", Sound)
	add_child(SettingMenu)


func _on_start_button_mouse_entered():
	PlayButtonHoverSound()


func _on_setting_button_mouse_entered():
	PlayButtonHoverSound()


func _on_exit_button_mouse_entered():
	PlayButtonHoverSound()


func _on_start_button_button_down():
	PlayButtonDownSound()


func _on_exit_button_button_down():
	get_tree().quit()
	
	
func Mute():
	get_tree().get_first_node_in_group("audio_mngr").call("Mute")
	

func Sound():
	get_tree().get_first_node_in_group("audio_mngr").call("Sound")
	
	
func PlayButtonDownSound():
	get_tree().get_first_node_in_group("audio_mngr").call("PlayButtonDown")
	
	
func PlayButtonHoverSound():
	get_tree().get_first_node_in_group("audio_mngr").call("PlayButtonHover")
