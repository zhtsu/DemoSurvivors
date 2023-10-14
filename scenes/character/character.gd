extends CharacterBody2D

class_name Character

const Enums = preload("res://scenes/global/enums.gd")
#
const ECharacterState = Enums.EState
const ECharacterDirection = Enums.EDirection

var character_name = "角色名称"
var speed : int = 1
var hp : float = 100.0

var physical_atk : float = 0.0
var magical_atk : float = 0.0

var physical_def : float = 0.0
var magical_def : float = 0.0
# 0.0 ~ 1.0
var physical_crit_bonus : float = 0.0
var magical_crit_bonus : float = 0.0
# 0.0 ~ 1.0
var physical_crit_chance : float = 0.0
var magical_crit_chance : float = 0.0

@export var spawn_position = Vector2(0, 0)

var direction = ECharacterDirection.Right
var state = ECharacterState.Idle
var size : Vector2

func _init_character():
	position = spawn_position
	size = $CollisionShape2D.shape.get_rect().size
	

# Make sure call this function once before _ready()
# Otherwise, the action script will not work
func _set_action_gdscript(script : Script):
	$Action.set_script(script)
