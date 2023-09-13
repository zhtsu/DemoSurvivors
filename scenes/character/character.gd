extends CharacterBody2D

class_name Character

const CharacterEnum = preload("res://scenes/mngr/character_enum.gd")
#
const ECharacterState = CharacterEnum.EState
const ECharacterDirection = CharacterEnum.EDirection

@export var character_name = "角色名称"
@export var speed:int = 1
@export var spawn_position = Vector2(0, 0):
	set = _set_spawn_position

var direction = ECharacterDirection.Right
var state = ECharacterState.Idle

func _set_spawn_position(in_position : Vector2):
	spawn_position = in_position
	

func _init_character():
	position = spawn_position
