extends Character

class_name Player

var health = 100
var exp = 0

# Called when the node enters the scene tree for the first time.
func init_player():
	init_character()
	$EffectAnimator.hide()
	appearing()
	
	
func appearing():
	state = CharacterState.APPEARING


func disappearing():
	state = CharacterState.DISAPPEARING


func UpdatePlayerAnimation():
	super.UpdateCharacterAnimation()
	if state == CharacterState.APPEARING:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Appearing")
	elif state == CharacterState.DISAPPEARING:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Disappearing")


func update_player(delta):
	update_move(delta)
	update_player_animation()
	update_character_direction()


func update_move(delta):
	if state == CharacterState.APPEARING or state == CharacterState.DISAPPEARING:
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
		state = CharacterState.WALK
	else:
		state = CharacterState.IDLE
	
	if velocity.x > 0:
		direction = CharacterDirection.RIGHT
	elif velocity.x < 0:
		direction = CharacterDirection.LEFT


func _on_effect_animator_animation_finished():
	state = CharacterState.IDLE
	$AnimatedSprite2D.show()
	$EffectAnimator.hide()
