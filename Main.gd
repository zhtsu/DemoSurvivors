extends Node


var MainMenu_Scene = preload("res://Scenes/UI/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var ScreenSize = get_viewport().size
	var MainMenu = MainMenu_Scene.instantiate()
	add_child(MainMenu)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
