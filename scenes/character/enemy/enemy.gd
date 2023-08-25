extends Character

class_name Enemy


@export var size = CharacterEnum.EEnemySize.Normal

func _track_player(delta):
	var player = get_tree().get_first_node_in_group("player")
	var distance : Vector2 = player.position - position
	position += distance.normalized() * speed * 0.1
	_update_enemy_flip()
	move_and_slide()


func _init_enemy():
	_init_character()
	$AnimatedSprite2D.play("Walk")
	direction = ECharacterDirection.Left
	
	
func _update_enemy_flip():
	var player = get_tree().get_first_node_in_group("player")
	var player_pos : Vector2 = player.position
	
	var previous_direction = direction
	
	if player_pos.x > position.x:
		direction = ECharacterDirection.Right
	else:
		direction = ECharacterDirection.Left
	
	if direction != previous_direction:
		scale.x *= -1
	
	print_debug(scale.y)
