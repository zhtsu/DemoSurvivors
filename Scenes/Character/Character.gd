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

@export var speed:int = 1
@export var spawn_position = Vector2(0, 0):
	set = _set_spawnPosition

var direction = CharacterDirection.RIGHT
var state = CharacterState.IDLE
var hp = 100

func _set_spawnPosition(in_position : Vector2):
	spawn_position = in_position

func InitCharacter():
	$AnimatedSprite2D.play("Idle")
	position = spawn_position


func UpdateCharacterAnimation():
	if state == CharacterState.IDLE:
		$AnimatedSprite2D.play("Idle")
	elif state == CharacterState.WALK:
		$AnimatedSprite2D.play("Walk")
	elif state == CharacterState.DAMAGE:
		$AnimatedSprite2D.play("Damage")


func UpdateCharacterDirection():
	if direction == CharacterDirection.RIGHT:
		$AnimatedSprite2D.flip_h = false
	elif direction == CharacterDirection.LEFT:
		$AnimatedSprite2D.flip_h = true
	
