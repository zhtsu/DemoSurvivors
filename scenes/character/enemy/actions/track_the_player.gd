extends Node


var enemy_self : Enemy
var player : Player


# Enemy use the Encircle tracking when distance greater than track_way_distance
# Otherwise use the player's position as the tracking target
var track_way_distance := 200.0
var encircle_position_offset : Vector2


func _ready():
	enemy_self = owner as Enemy
	player = get_tree().get_first_node_in_group("player")
	encircle_position_offset = _get_encircle_position_offset(player.position)
	
	
func _get_encircle_position_offset(center : Vector2) -> Vector2:
	var angle = deg_to_rad(randf_range(0.0, 360.0))
	var position := center + Vector2.RIGHT.rotated(angle) * track_way_distance
	return position - center
	

func _physics_process(_delta):
	if not owner is Enemy:
		return
	if player == null:
		return
	
	var direct_track_offset : Vector2 = player.position - enemy_self.position
	var distance = player.position.distance_to(enemy_self.position)
	
	# Avoid to overlay the palyer
	var min_dist = player.size.x * 0.5
	if player.size.y < player.size.x:
		min_dist = player.size.y * 0.5
	
	var offset = direct_track_offset
	
	if distance > track_way_distance:
		offset = (player.position + encircle_position_offset) - enemy_self.position

	if distance > min_dist:
		enemy_self.position += offset.normalized() * enemy_self.speed * 0.1
		


