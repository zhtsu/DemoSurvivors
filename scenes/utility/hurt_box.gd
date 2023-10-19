class_name HurtBox
extends Area2D


const Methods = preload("res://scenes/global/methods.gd")

var player : Player
	

func _ready():
	connect("area_entered", _on_area_entered)
	player = get_tree().get_first_node_in_group("player")

func _on_area_entered(hit_box : HitBox):
	if hit_box == null:
		return
	
	if not owner.has_method("take_damage"):
		return
	
	var damage_value : int
	if owner is Player and hit_box.owner is Enemy:
		damage_value = Methods.cal_damage(hit_box.owner.get_prop_dict(), owner.get_prop_dict())
	elif owner is Enemy and hit_box.owner is Projectile:
		damage_value = Methods.cal_damage(player.get_prop_dict(), owner.get_prop_dict())	
	owner.take_damage(damage_value)
