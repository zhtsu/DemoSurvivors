class_name Enemy
extends Character


const Assets = preload("res://scenes/global/assets.gd")

var enemy_size = Enums.EnemySize.Normal
var enemy_type = Enums.EnemyType.Common

func _ready():
	_init_character()
	$AnimatedSprite2D.play("Walk")
	direction = ECharacterDirection.Left


func init(enemy_data : Dictionary):
	var sprite_frames_path = Assets.dir_tres + enemy_data["sprite_frames_tres"]
	var sprite_frames = load(sprite_frames_path)
	$AnimatedSprite2D.sprite_frames = sprite_frames
	if not enemy_data["gdscript"] == "null":
		var gdscript_path = Assets.dir_enemy_actions + enemy_data["gdscript"]
		_set_action_gdscript(load(gdscript_path))
	enemy_size = Enums.EnemySize.get(enemy_data["size"])
	enemy_type = Enums.EnemyType.get(enemy_data["type"])
	character_name = enemy_data["name"]
	speed = int(enemy_data["speed"])
	physical_atk = float(enemy_data["physical_ATK"])
	physical_def = float(enemy_data["physical_DEF"])
	magical_atk = float(enemy_data["magical_DEF"])
	magical_def = float(enemy_data["magical_DEF"])
	physical_crit_bonus = float(enemy_data["physical_crit_bonus"])
	physical_crit_chance = float(enemy_data["physical_crit_chance"])
	magical_crit_bonus = float(enemy_data["magical_crit_bonus"])
	magical_crit_chance = float(enemy_data["magical_crit_chance"])


func _physics_process(_delta):
	_update_enemy_flip()
	move_and_collide(Vector2.ZERO)
	
func _update_enemy_flip():
	var player = get_tree().get_first_node_in_group("player")
	var player_size : Vector2 = player.size
	var player_pos : Vector2 = player.position
	
	var previous_direction = direction
	
	var vaild_invade_dist : float = player_size.x * 0.5
	if player_pos.x > position.x + vaild_invade_dist:
		direction = ECharacterDirection.Right
	elif player_pos.x < position.x - vaild_invade_dist:
		direction = ECharacterDirection.Left
	
	if direction != previous_direction:
		scale.x *= -1


func _on_hitbox_body_entered(_sbody):
	pass # Replace with function body.
