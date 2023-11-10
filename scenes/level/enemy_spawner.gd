class_name EnemySpawner
extends Node


const tscn_enemy = preload("res://scenes/character/enemy/enemy.tscn")


var map_data : Dictionary
var level : Level
var player : Player
var spawn_interval := 2.0
var spawn_count := 4
var max_enemy_count := 100
var current_enemy_count = 0
var spawned_enemy_names : PackedStringArray
var spawned_enemy_data_list : Array[Dictionary]

func init(in_map_data : Dictionary, in_player : Player, in_level : Level):
	map_data = in_map_data
	player = in_player
	level = in_level


func _ready():
	spawned_enemy_names = map_data["enemies"].rsplit("|", true, 100)
	for enemy_name in spawned_enemy_names:
		spawned_enemy_data_list.append(Data.find_enemy_data(enemy_name))
		
	_spawn_enemy()
	
	$SpawnTimer.start(spawn_interval)
	$AddMaxEnemyCountTimer.start()
	$AddSpawnCountTimer.start()


func _spawn_enemy():
	if current_enemy_count >= max_enemy_count:
		return
	
	# Viewport size
	var vs = get_viewport().get_visible_rect().size / 4
	var left_top = player.position - vs
	var right_bottom = player.position + vs
	var left_bottom = Vector2(player.position.x - vs.x, player.position.y + vs.y)
	var right_top = Vector2(player.position.x + vs.x, player.position.y - vs.y)
	
	# Vector4(startx, starty, endx, endy)
	var edges = [
		Vector4(left_top.x, left_top.y, right_top.x, right_top.y),
		Vector4(left_bottom.x, left_bottom.y, right_bottom.x, right_bottom.y),
		Vector4(left_top.x, left_top.y, left_bottom.x, left_bottom.y),
		Vector4(right_top.x, right_top.y, right_bottom.x, right_bottom.y)
	]
		
	print_debug(current_enemy_count)
	for i in spawn_count:
		# Random pick edge and position in the edge
		var rpe = edges.pick_random() as Vector4
		var x = randf_range(rpe.x, rpe.z)
		var y = randf_range(rpe.y, rpe.w)
		var random_position = Vector2(x, y)
		
		var enemy_data
		if map_data["enemies"] == "ALL":
			enemy_data = Data.enemy_data_list.pick_random()
		else:
			enemy_data = spawned_enemy_data_list.pick_random()
		
		var enemy = tscn_enemy.instantiate()
		if current_enemy_count > 300:
			enemy.set_enable_collision(false)
		enemy.call("init", enemy_data)
		enemy.connect("destroyed", _on_enemy_destroyed)
		enemy.spawn_position = random_position
		get_tree().get_first_node_in_group("level").add_child(enemy)
		current_enemy_count += 1
	
	
func _on_enemy_destroyed():
	current_enemy_count -= 1

	
func _on_timer_timeout():
	_spawn_enemy()


func _on_add_max_enemy_count_timer_timeout():
	max_enemy_count += 1


func _on_add_spawn_count_timer_timeout():
	spawn_count *= 2
	max_enemy_count *= 2
