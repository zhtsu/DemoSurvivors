extends Node2D

const Enums = preload("res://scenes/mngr/enums.gd")
#
const tscn_transition = preload("res://scenes/ui/transition.tscn")


func _ready():
	$Transition.connect("finished", _hide_transition)
	$Transition.call("display")
	
	
	
func _hide_transition():
	$Transition.hide()

