class_name HurtBox
extends Area2D


const Methods = preload("res://scenes/global/methods.gd")
	
	

func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(hit_box : HitBox):
	if hit_box == null:
		return
	
	if not owner.has_method("take_damage"):
		return
	
	if owner is Character and hit_box.owner is Character:
		var damage_value = Methods.cal_damage(hit_box.owner.get_prop_dict(), owner.get_prop_dict())
		print_debug("damage: ", damage_value)
		owner.take_damage(damage_value)
