extends Node


var enemy_self : Enemy
var player : Player


func _ready():
	enemy_self = owner as Enemy
	player = get_tree().get_first_node_in_group("player")
	

func _physics_process(_delta):
	if not owner is Enemy:
		return
	if player == null:
		return
	
	var offset : Vector2 = player.position - enemy_self.position
	var distance = player.position.distance_to(enemy_self.position)
	
	# Avoid to overlay the palyer
	var min_dist = player.size.x * 0.5
	if player.size.y < player.size.x:
		min_dist = player.size.y * 0.5
	
	if distance > min_dist:
		enemy_self.position += offset.normalized() * enemy_self.speed * 0.1
		


