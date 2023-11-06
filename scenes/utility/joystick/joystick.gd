extends Node2D


@export var up_action : String = "Up"
@export var down_action : String = "Down"
@export var left_action : String = "Left"
@export var right_action : String = "Right"


func _ready():
	if OS.has_feature("android"):
		show()
	else:
		queue_free()

