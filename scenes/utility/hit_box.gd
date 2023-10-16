class_name HitBox
extends Area2D


var damage_value : int = 1


func _init():
	collision_layer = 16
	collision_mask = 0
