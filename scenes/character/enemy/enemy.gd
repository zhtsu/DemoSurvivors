class_name Enemy
extends Character


signal destroyed


const Assets = preload("res://scenes/global/assets.gd")
const Methods = preload("res://scenes/global/methods.gd")

var enemy_size := Enums.EnemySize.Normal
var enemy_type := Enums.EnemyType.Common
var damage_type := Enums.EDamageType.Physical
var exp_volume := 1

var MAIN : Main
var player : Player

func _ready():
	_init_character()
	MAIN = get_tree().get_first_node_in_group("main")
	player = get_tree().get_first_node_in_group("player")
	$AnimatedSprite2D.play("Walk")
	direction = ECharacterDirection.Left


func init(enemy_data : Dictionary):
	var sprite_frames_path = Assets.dir_tres_enemy + enemy_data["sprite_frames_tres"]
	var sprite_frames = load(sprite_frames_path)
	$AnimatedSprite2D.sprite_frames = sprite_frames
	if not enemy_data["gdscript"] == "null":
		var gdscript_path = Assets.dir_enemy_actions + enemy_data["gdscript"]
		_set_action_gdscript(load(gdscript_path))
	if enemy_data["flying"] == "TRUE":
		self.set_collision_mask_value(1, false)
	enemy_size = Enums.EnemySize.get(enemy_data["size"])
	enemy_type = Enums.EnemyType.get(enemy_data["type"])
	character_name = enemy_data["name"]
	speed = int(enemy_data["speed"])
	hp = float(enemy_data["HP"])
	exp_volume = int(enemy_data["EXP"])
	physical_atk = float(enemy_data["physical_ATK"])
	physical_def = float(enemy_data["physical_DEF"])
	magical_atk = float(enemy_data["magical_DEF"])
	magical_def = float(enemy_data["magical_DEF"])
	physical_crit_bonus = float(enemy_data["physical_crit_bonus"])
	physical_crit_chance = float(enemy_data["physical_crit_chance"])
	magical_crit_bonus = float(enemy_data["magical_crit_bonus"])
	magical_crit_chance = float(enemy_data["magical_crit_chance"])
	state = ECharacterState.Walk
	

func _update_enemy_animation():
	if state == ECharacterState.Walk:
		$AnimatedSprite2D.play("Walk")
	elif state == ECharacterState.Damage:
		$AnimatedSprite2D.play("Damage")


func _physics_process(_delta):
	_update_enemy_flip()
	_update_enemy_animation()
	
	if hp <= 0.0:
		if MAIN.enemy_death_sound_array.is_empty():
			var death_sound = Assets.tscn_once_sound.instantiate()
			death_sound.init(Assets.a_enemy_death, -24.0)
			MAIN.enemy_death_sound_array.append(death_sound)
			get_tree().get_first_node_in_group("level").add_child(death_sound)
		_destroy_self()
	if position.distance_to(player.position) > 600.0:
		_destroy_self()
	
	move_and_collide(Vector2.ZERO)
	
	
func _update_enemy_flip():
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
	

func _destroy_self():
	# Create EXP stone
	var exp_stone = Assets.tscn_exp_stone.instantiate()
	exp_stone.exp_volume = randi_range(0, exp_volume)
	if exp_stone.exp_volume > float(exp_volume) / 2:
		exp_stone.position = position
		get_tree().get_first_node_in_group("level").add_child(exp_stone)
	# Death blood particles
	if MAIN.particles_emitter_array.size() < 10:
		var particles_emitter = Assets.tscn_particles_emitter.instantiate()
		particles_emitter.position = position
		MAIN.particles_emitter_array.append(particles_emitter)
		get_tree().get_first_node_in_group("level").add_child(particles_emitter)
	
	MAIN.visible_enemy_list.erase(self)
	destroyed.emit()
	queue_free()
	

func set_enable_collision(enable : bool):
	if enable:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = true


func _on_visible_on_screen_notifier_2d_screen_entered():
	if not MAIN.visible_enemy_list.has(self):
		MAIN.visible_enemy_list.append(self)
		set_enable_collision(true)
		


func _on_visible_on_screen_notifier_2d_screen_exited():
	if MAIN.visible_enemy_list.has(self):
		MAIN.visible_enemy_list.erase(self)
		set_enable_collision(false)

