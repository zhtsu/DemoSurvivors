extends Node2D

class_name Character

enum CharacterState {
	IDLE,
	WALK,
	DAMAGE
}

enum CharacterDirection {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var Speed:int = 1

var KeyMap = {}
var Direction = CharacterDirection.RIGHT
var State = CharacterState.IDLE
var HP = 100
var EXP = 0

func InitCharacter():
	$AnimatedSprite2D.play("Idle")

func LoadAndInitKeyMap():
	var KeyMapJsonFile = FileAccess.open("res://Assets/JSONs/key_map.json", FileAccess.READ)
	if (KeyMapJsonFile):
		KeyMap = KeyMapJsonFile.get_as_text()
		print_debug("Success to load and initialized key_map:\n" + KeyMap)
	else:
		print_debug("Failed to load and initialized key_map")

func ListenForMove(delta):
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
	
func UpdateAnimation():
	if State == CharacterState.IDLE:
		$AnimatedSprite2D.play("Idle")
	elif State == CharacterState.WALK:
		$AnimatedSprite2D.play("Walk")
	elif State == CharacterState.DAMAGE:
		$AnimatedSprite2D.play("Damage")
		
func UpdateDirection():
	if Direction == CharacterDirection.RIGHT:
		$AnimatedSprite2D.flip_h = false
	elif Direction == CharacterDirection.LEFT:
		$AnimatedSprite2D.flip_h = true
	
