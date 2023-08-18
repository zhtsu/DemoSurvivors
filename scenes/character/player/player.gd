extends Character

class_name Player

var health = 100
var exp = 0

# Called when the node enters the scene tree for the first time.
func _init_player():
	_init_character()
	$EffectAnimator.hide()
	appearing()
	
	
func appearing():
	state = ECharacterState.Appearing


func disappearing():
	state = ECharacterState.Disappearing


func _update_player_animation():
	super._update_character_animation()
	if state == ECharacterState.Appearing:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Appearing")
	elif state == ECharacterState.Disappearing:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Disappearing")


func _update_player(delta):
	_update_move(delta)
	_update_player_animation()
	_update_character_direction()


func _update_move(delta):
	if state == ECharacterState.Appearing or state == ECharacterState.Disappearing:
		return
	
	var velocity : Vector2 = Vector2(0, 0)
	if Input.is_action_pressed("Up"):
		velocity.y = -1
	elif Input.is_action_pressed("Down"):
		velocity.y = 1
	if Input.is_action_pressed("Left"):
		velocity.x = -1
	elif Input.is_action_pressed("Right"):
		velocity.x = 1
	
	position += velocity.normalized() * speed * delta * 150
	
	if velocity.length() > 0:
		state = ECharacterState.Walk
	else:
		state = ECharacterState.Idle
	
	if velocity.x > 0:
		direction = ECharacterDirection.Right
	elif velocity.x < 0:
		direction = ECharacterDirection.Left


func _on_effect_animator_animation_finished():
	state = ECharacterState.Idle
	$AnimatedSprite2D.show()
	$EffectAnimator.hide()
