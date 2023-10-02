extends Node


static func action(enemy : Enemy):
	var scene_tree = Engine.get_main_loop() as SceneTree
	var player : Player = scene_tree.get_first_node_in_group("player")
	var offset : Vector2 = player.position - enemy.position
	var distance = player.position.distance_to(enemy.position)
	
	var min_dist = player.size.x * 0.5
	if player.size.y < player.size.x:
		min_dist = player.size.y * 0.5
		
	if distance > min_dist:
		enemy.position += offset.normalized() * enemy.speed * 0.1
