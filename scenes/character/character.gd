extends CharacterBody2D

class_name Character

enum ECharacterState {
	Idle,
	Walk,
	Damage,
	Appearing,
	Disappearing
}

enum ECharacterDirection {
	Up,
	Down,
	Left,
	Right
}

@export var speed:int = 1
@export var spawn_position = Vector2(0, 0):
	set = _set_spawn_position

var direction = ECharacterDirection.Right
var state = ECharacterState.Idle
var HP = 100

func _set_spawn_position(in_position : Vector2):
	spawn_position = in_position

func _init_character():
	$AnimatedSprite2D.play("Idle")
	position = spawn_position


func _update_character_animation():
	if state == ECharacterState.Idle:
		$AnimatedSprite2D.play("Idle")
	elif state == ECharacterState.Walk:
		$AnimatedSprite2D.play("Walk")
	elif state == ECharacterState.Damage:
		$AnimatedSprite2D.play("Damage")


func _update_character_flip():
	if direction == ECharacterDirection.Right:
		$AnimatedSprite2D.flip_h = false
	elif direction == ECharacterDirection.Left:
		$AnimatedSprite2D.flip_h = true
	
