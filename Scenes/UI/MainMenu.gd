extends Control

var SettingMenu_Scene = preload("res://Scenes/UI/SettingMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VirtualBoyGuy.play("Idle")
	$MaskDudeIdle.play("Idle")
	$PinkManIdle.play("Idle")
	$NinjaFrogIdle.play("Idle")
	$BGM.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_setting_button_button_down():
	$ButtonDownSound.play()
	var SettingMenu = SettingMenu_Scene.instantiate()
	SettingMenu.connect("open_sounds", PlayBgm)
	SettingMenu.connect("close_sounds", PauseBgm)
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
	

func PauseBgm():
	$BGM.stop()
