extends Character

class_name Player

var KeyMap = {}
var EXP = 0


# Called when the node enters the scene tree for the first time.
func InitPlayer():
	InitCharacter()
	LoadAndInitKeyMap()
	$EffectAnimator.hide()
	Appearing()
	
	
func Appearing():
	State = CharacterState.APPEARING


func Disappearing():
	State = CharacterState.DISAPPEARING


func UpdatePlayerAnimation():
	super.UpdateCharacterAnimation()
	if State == CharacterState.APPEARING:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Appearing")
	elif State == CharacterState.DISAPPEARING:
		$AnimatedSprite2D.hide()
		$EffectAnimator.show()
		$EffectAnimator.play("Disappearing")


func UpdatePlayer(delta):
	UpdateMove(delta)
	UpdatePlayerAnimation()
	UpdateCharacterDirection()


func LoadAndInitKeyMap():
	var KeyMapJsonFile = FileAccess.open("res://Assets/JSONs/key_map.json", FileAccess.READ)
	if (KeyMapJsonFile):
		KeyMap = KeyMapJsonFile.get_as_text()
		print_debug("Success to load and initialized key_map:\n" + KeyMap)
	else:
		print_debug("Failed to load and initialized key_map")


func UpdateMove(delta):
	if State == CharacterState.APPEARING or State == CharacterState.DISAPPEARING:
		return
	
	var Velocity:Vector2 = Vector2(0, 0)
	if Input.is_action_pressed("Up"):
		Velocity.y = -1
	elif Input.is_action_pressed("Down"):
		Velocity.y = 1
	if Input.is_action_pressed("Left"):
		Velocity.x = -1
	elif Input.is_action_pressed("Right"):
		Velocity.x = 1
	
	position += Velocity.normalized() * Speed * delta * 150
	
	if Velocity.length() > 0:
		State = CharacterState.WALK
	else:
		State = CharacterState.IDLE
	
	if Velocity.x > 0:
		Direction = CharacterDirection.RIGHT
	elif Velocity.x < 0:
		Direction = CharacterDirection.LEFT


func _on_effect_animator_animation_finished():
	State = CharacterState.IDLE
	$AnimatedSprite2D.show()
	$EffectAnimator.hide()
