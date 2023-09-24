extends Character

class_name Player

func set_position_smoothing(enabled : bool = true):
	$Camera2D.position_smoothing_enabled = enabled
	

func _physics_process(delta):
	_update_move(delta)
	

func _init_player():
	_init_character()
	$AnimatedSprite2D.play("Idle")
	$EffectAnimator.hide()
	appearing()
	
	
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


func _update_player(_delta):
	_update_player_animation()


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
		
	move_and_slide()


func _on_effect_animator_animation_finished():
	state = ECharacterState.Idle
	$AnimatedSprite2D.show()
	$EffectAnimator.hide()


