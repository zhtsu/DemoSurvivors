class_name Projectile
extends Node2D


var spawn_position : Vector2 = Vector2(0.0, 0.0)
var velocity : Vector2 = Vector2(0.0, 0.0)
var speed : float = 1.0
var distance : float = 100.0
var damage_type : Enums.EDamageType = Enums.EDamageType.Physical
var damage_scale : float = 1.0


func init(in_spawn_position : Vector2, in_velocity : Vector2,
		  in_speed : float, in_distance : float, in_damage_scale : float):
	spawn_position = in_spawn_position
	velocity = in_velocity
	speed = in_speed
	distance = in_distance
	damage_scale = in_damage_scale
