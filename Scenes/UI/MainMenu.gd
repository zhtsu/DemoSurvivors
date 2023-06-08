extends Control

var SettingMenu_Scene = preload("res://Scenes/UI/SettingMenu.tscn")
var Settings:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	$VirtualBoyGuy.play("Idle")
	$MaskDudeIdle.play("Idle")
	$PinkManIdle.play("Idle")
	$NinjaFrogIdle.play("Idle")
	
	# Read local settings
	var SettingsJsonFile = FileAccess.open("res://Assets/Data/settings.json", FileAccess.READ)
	if (SettingsJsonFile):
		Settings = JSON.parse_string(SettingsJsonFile.get_as_text())
		print_debug("Success to load and initialized settings:\n" + JSON.stringify(Settings))
	else:
		print_debug("Failed to load and initialized settings")
		
	if Settings["OpenSounds"]:
		$BGM.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_setting_button_button_down():
	$ButtonDownSound.play()
	var SettingMenu = SettingMenu_Scene.instantiate()
	SettingMenu.call("InitSettings", Settings)
	SettingMenu.connect("open_sounds", PlayBgm)
	SettingMenu.connect("close_sounds", StopBgm)
	add_child(SettingMenu)


func _on_start_button_mouse_entered():
	$ButtonHoveredSound.play()


func _on_setting_button_mouse_entered():
	$ButtonHoveredSound.play()


func _on_exit_button_mouse_entered():
	$ButtonHoveredSound.play()


func _on_start_button_button_down():
	$ButtonDownSound.play()


func _on_exit_button_button_down():
	get_tree().quit()
	
	
func PlayBgm():
	$BGM.play()
	

func StopBgm():
	$BGM.stop()
