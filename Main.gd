extends Node


var MainMenu_Scene = preload("res://Scenes/UI/MainMenu.tscn")
var MusicMngr_Scene = preload("res://Scenes/Mngr/MusicMngr.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var ScreenSize = get_viewport().size
	# Main Menu
	var MainMenu = MainMenu_Scene.instantiate()
	add_child(MainMenu)
	# Music Mngr
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
