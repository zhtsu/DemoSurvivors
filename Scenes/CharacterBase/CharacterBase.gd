extends Node2D

class_name CharacterBase

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
@export var SpawnPostion = Vector2(0, 0)

var Direction = CharacterDirection.RIGHT
var State = CharacterState.IDLE
var HP = 100

func InitCharacter():
	$AnimatedSprite2D.play("Idle")
	position = SpawnPostion


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
	
