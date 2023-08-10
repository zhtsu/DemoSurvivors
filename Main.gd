extends Node


var MainMenu_Scene = preload("res://scenes/ui/main_menu.tscn")
var AudioMngr_Scene = preload("res://scenes/mngr/audio_mngr.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# var ScreenSize = get_viewport().size
	# Make sure to instantiate all Mngr first
	# Audio Mngr
	var AudioMngr = AudioMngr_Scene.instantiate()
	add_child(AudioMngr)
	
	# Main Menu
	var MainMenu = MainMenu_Scene.instantiate()
	add_child(MainMenu)
	

