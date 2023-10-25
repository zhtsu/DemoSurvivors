class_name Projectile
extends Node2D


const Methods = preload("res://scenes/global/methods.gd")


var player : Player
@export var spawn_position : Vector2 = Vector2(0.0, 0.0)
@export var velocity : Vector2 = Vector2(0.0, 0.0)
@export var speed : float = 4
var distance := 100.0
var acceleration = 1


func init(in_spawn_position : Vector2, in_velocity : Vector2, in_speed : float):
	spawn_position = in_spawn_position
	velocity = in_velocity
	speed = in_speed


func _ready():
	player = get_tree().get_first_node_in_group("player")
	position = spawn_position


func _physics_process(_delta):
	var direction = Vector2.RIGHT.rotated(velocity.angle())
	speed = min(speed + 2.0 * acceleration * acceleration, speed)
	position += direction * speed
	
	if position.distance_to(spawn_position) > distance:
		queue_free()
	


func _on_hit_box_area_entered(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		var damage_value = Methods.cal_damage(player.get_prop_dict(), hurt_box.owner.get_prop_dict())
		hurt_box.owner.take_damage(damage_value)
	
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hit_box_body_entered(_body):
	queue_free()
