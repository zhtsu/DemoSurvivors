extends Node

const Assets = preload("res://scenes/global/assets.gd")

var item : Item
#
var default_rotation := 225.0
var spawn_position := Vector2(100.0, 300.0)
var angle := 0.0
var speed := 4.0
var distance := 400.0

func _ready():
	item = owner as Item
	item.add_to_group("projectile")
	item.rotation = deg_to_rad(default_rotation)
	item.rotate(angle)
	item.position = Vector2(spawn_position)
	

func _physics_process(_delta):
	var player : Player = get_tree().get_first_node_in_group("player")
	
	var direction = Vector2.RIGHT.rotated(angle)
	item.global_position += speed * direction
	
	if spawn_position.distance_to(item.global_position) > distance:
		item.queue_free()
		
	print_debug("Prjectile")
	
	
	
	
