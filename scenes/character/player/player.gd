extends Character

class_name Player


signal damage(causer : Enemy, ability : Ability)

const Assets = preload("res://scenes/global/assets.gd")


func _ready():
	_init_character()
	$AnimatedSprite2D.play("Idle")
	$EffectAnimator.hide()
	appearing()
	

func _process(_delta):
	_update_player_animation()


func init(player_data : Dictionary):
	var sprite_frames_path = Assets.dir_tres + player_data["sprite_frames_tres"] + ".tres"
	var sprite_frames = load(sprite_frames_path)
	$AnimatedSprite2D.sprite_frames = sprite_frames
	character_name = player_data["name"]
	speed = int(player_data["speed"])
	physical_atk = float(player_data["physical_ATK"])
	physical_def = float(player_data["physical_DEF"])
	magical_atk = float(player_data["magical_DEF"])
	magical_def = float(player_data["magical_DEF"])
	physical_crit_bonus = float(player_data["physical_crit_bonus"])
	physical_crit_prob = float(player_data["physical_crit_prob"])
	magical_crit_bonus = float(player_data["magical_crit_bonus"])
	magical_crit_prob = float(player_data["magical_crit_prob"])
	

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


