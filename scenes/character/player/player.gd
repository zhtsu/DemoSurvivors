class_name Player
extends Character


signal damage(causer : Enemy)
signal speak(witticism : String)
signal exp_added(amount : int)
signal level_up
signal item_added(item_name : String)

const Assets = preload("res://scenes/global/assets.gd")

var previous_hp := 100.0
var level_exp := 0.0
var previous_exp := 0.0
var witticism_dict : Dictionary
var current_witticism_pool : Array
var talk_speed : float = 1.0
# Used for UI
var icon : Texture2D


func _update_hp():
	$HpBar.value = hp


func _create_item_from_name(item_name : String):
	item_added.emit(item_name)
	

func _ready():
	_init_character()
	$HpBar.hide()
	$EffectAnimator.hide()
	appearing()
	await $EffectAnimator.animation_finished
	$HpBar.show()
	current_witticism_pool = witticism_dict["Common"]
	speak.emit(current_witticism_pool.pick_random())
	$Timer.start(randf_range(talk_speed, 30.0))
	_update_hp()
	

func _process(_delta):
	_update_player_animation()
	
	if not previous_hp == hp:
		$HpBar.value = hp
	previous_hp = hp
	

func init(player_data : Dictionary):
	icon = load(Assets.dir_tres + player_data["icon_tres"])
	var sprite_frames_path = Assets.dir_tres + player_data["sprite_frames_tres"]
	var sprite_frames = load(sprite_frames_path)
	$AnimatedSprite2D.sprite_frames = sprite_frames
	character_name = player_data["name"]
	speed = int(player_data["speed"])
	physical_atk = float(player_data["physical_ATK"])
	physical_def = float(player_data["physical_DEF"])
	magical_atk = float(player_data["magical_DEF"])
	magical_def = float(player_data["magical_DEF"])
	physical_crit_bonus = float(player_data["physical_crit_bonus"])
	physical_crit_chance = float(player_data["physical_crit_chance"])
	magical_crit_bonus = float(player_data["magical_crit_bonus"])
	magical_crit_chance = float(player_data["magical_crit_chance"])
	# Load witticisms data
	var witticism_json_path = Assets.dir_data + player_data["witticisms_json"]
	var json_file = FileAccess.open(witticism_json_path, FileAccess.READ)
	witticism_dict = JSON.parse_string(json_file.get_as_text())
	json_file.close()
	

func set_position_smoothing(enabled : bool = true):
	$EffectCamera.position_smoothing_enabled = enabled
	

func _physics_process(delta):
	_update_move(delta)
	
	
func appearing():
	state = ECharacterState.Appearing


func disappearing():
	state = ECharacterState.Disappearing


func _update_player_animation():
	if state == ECharacterState.Idle:
		$AnimatedSprite2D.play("Idle")
	elif state == ECharacterState.Walk:
		$AnimatedSprite2D.play("Walk")
	elif state == ECharacterState.Damage:
		$AnimatedSprite2D.play("Damage")
	#
	elif state == ECharacterState.Appearing:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Appearing")
	elif state == ECharacterState.Disappearing:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Disappearing")
	#
	if direction == ECharacterDirection.Right:
		$AnimatedSprite2D.flip_h = false
	elif direction == ECharacterDirection.Left:
		$AnimatedSprite2D.flip_h = true


func _update_move(delta):
	if state == ECharacterState.Appearing or state == ECharacterState.Disappearing:
		return
	
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		velocity.y = -1
	elif Input.is_action_pressed("Down"):
		velocity.y = 1
	if Input.is_action_pressed("Left"):
		velocity.x = -1
	elif Input.is_action_pressed("Right"):
		velocity.x = 1
	
	position += velocity.normalized() * speed * 50 * delta
	
	if velocity.length() > 0:
		state = ECharacterState.Walk
	else:
		state = ECharacterState.Idle
	
	if velocity.x > 0:
		direction = ECharacterDirection.Right
	elif velocity.x < 0:
		direction = ECharacterDirection.Left
		
	move_and_collide(Vector2.ZERO)

func _on_effect_animator_animation_finished():
	state = ECharacterState.Idle
	$AnimatedSprite2D.show()
	$EffectAnimator.hide()


func get_rand_witticism() -> String:
	return current_witticism_pool.pick_random()


func _on_timer_timeout():
	# Emit talk signal to update witticism in PlayerState
	speak.emit(current_witticism_pool.pick_random())
	$Timer.start(randf_range(talk_speed, 30.0))
	
	
func get_sprite_frames():
	return $AnimatedSprite2D.sprite_frames


