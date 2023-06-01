extends Node2D

class_name Character

enum CharacterState {
	IDLE,
	WALK,
	DAMAGE,
	APPEARING,
	DISAPPEARING
}

enum CharacterDirection {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var Speed:int = 1
@export var SpawnPosition = Vector2(0, 0):
	set = SetSpawnPosition

var Direction = CharacterDirection.RIGHT
var State = CharacterState.IDLE
var HP = 100

func SetSpawnPosition(Position:Vector2):
	SpawnPosition = Position

func InitCharacter():
	$AnimatedSprite2D.play("Idle")
	position = SpawnPosition


func UpdateCharacterAnimation():
	if State == CharacterState.IDLE:
		$AnimatedSprite2D.play("Idle")
	elif State == CharacterState.WALK:
		$AnimatedSprite2D.play("Walk")
	elif State == CharacterState.DAMAGE:
		$AnimatedSprite2D.play("Damage")


func UpdateCharacterDirection():
	if Direction == CharacterDirection.RIGHT:
		$AnimatedSprite2D.flip_h = false
	elif Direction == CharacterDirection.LEFT:
		$AnimatedSprite2D.flip_h = true
	
