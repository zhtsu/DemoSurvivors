extends Node


const tscn_enemy = preload("res://scenes/character/enemy/enemy.tscn")


var MAIN : Main
var map_name : String
var level : Level
var player : Player
var spawn_interval := 2.0
var max_enemy_count := 100
var current_enemy_count = 0


func init(in_map_name : String, in_player : Player, in_level : Level):
	map_name = in_map_name
	player = in_player
	level = in_level


func _ready():
	MAIN = get_tree().get_first_node_in_group("main")
	_spawn_enemy()


func _spawn_enemy():
	if current_enemy_count == max_enemy_count:
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

	# Random pick edge and position in the edge
	var rpe = edges.pick_random() as Vector4
	var x = randf_range(rpe.x, rpe.z)
	var y = randf_range(rpe.y, rpe.w)
	var random_position = Vector2(x, y)
	
	var enemy_data = MAIN.enemy_data_list[0]
	
	var enemy = tscn_enemy.instantiate()
	enemy.call("init", enemy_data)
	enemy.spawn_position = random_position
	get_tree().get_first_node_in_group("level").add_child(enemy)
	current_enemy_count += 1
	
	$Timer.start(spawn_interval)
	
	
	
	
func _on_timer_timeout():
	_spawn_enemy()
