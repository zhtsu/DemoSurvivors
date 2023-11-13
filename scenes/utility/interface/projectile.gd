class_name Projectile
extends Node2D


var data := Structs.ProjectileData.new()


func init(projectile_data : Structs.ProjectileData):
	data.spawn_position = projectile_data.spawn_position
	data.velocity = projectile_data.velocity
	data.speed = projectile_data.speed
	data.distance = projectile_data.distance
	data.damage_type = projectile_data.damage_type
	data.damage_scale = projectile_data.damage_scale
	data.knockback_distance = projectile_data.knockback_distance
	data.penertration = projectile_data.penertration
