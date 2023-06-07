extends Control

var SettingMenuScene = preload("res://Scenes/UI/SettingMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VirtualBoyGuy.play("Idle")
	$MaskDudeIdle.play("Idle")
	$PinkManIdle.play("Idle")
	$NinjaFrogIdle.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()


func _on_setting_button_button_down():
	var SettingMenu = SettingMenuScene.instantiate()
