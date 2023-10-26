extends Node2D


const Methods = preload("res://scenes/global/methods.gd")

var MAIN : Main
var player : Player
@export var spawn_position : Vector2 = Vector2(20.0, 20.0)
@export var velocity : Vector2 = Vector2(0.0, 0.0)
@export var speed : float = 4
var acceleration = 1
var target_enemy : Enemy


func init(in_spawn_position : Vector2, in_velocity : Vector2, in_speed : float):
	spawn_position = in_spawn_position
	velocity = in_velocity
	speed = in_speed


func _ready():
	player = get_tree().get_first_node_in_group("player")
	MAIN = get_tree().get_first_node_in_group("main")
	position = spawn_position
	
	_update_target_enemy()
	
	
func _physics_process(_delta):
	if not target_enemy == null:
		var offset = target_enemy.position - position
		speed = min(speed + 2.0 * acceleration * acceleration, speed)
		global_position += offset.normalized() * speed
	else:
		_update_target_enemy()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
	
	
func _update_target_enemy():
	var min_distance = 10000.0
	for enemy in MAIN.visible_enemy_list:
		var distance = player.position.distance_to(enemy.position)
		if distance < min_distance:
			min_distance = distance
			target_enemy = enemy
			
			
func _on_hit_box_area_entered(hurt_box : HurtBox):
	if hurt_box == null:
		return
	
	if hurt_box.owner is Enemy:
		var damage_value = Methods.cal_damage(player.get_prop_dict(), hurt_box.owner.get_prop_dict())
		hurt_box.owner.take_damage(damage_value * 0.4)
	
	queue_free()
