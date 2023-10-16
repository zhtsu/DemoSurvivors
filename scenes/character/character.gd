class_name Character
extends CharacterBody2D


const Enums = preload("res://scenes/global/enums.gd")
#
const ECharacterState = Enums.EState
const ECharacterDirection = Enums.EDirection

var character_name = "角色名称"
var speed : int = 1
var hp : int = 100

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

var damage_interval := 0.2

@export var spawn_position = Vector2(0, 0)

var direction = ECharacterDirection.Right
var state = ECharacterState.Idle
var size : Vector2
# Used for process damage logic
var previous_state = ECharacterState.Idle


func _init_character():
	position = spawn_position
	size = $CollisionShape2D.shape.get_rect().size
	

# Make sure call this function once before _ready()
# Otherwise, the action script will not work
func _set_action_gdscript(script : Script):
	$Action.set_script(script)
	
	

func take_damage(damage_value : int):
	if state == ECharacterState.Damage:
		return
	
	previous_state = state
	state = ECharacterState.Damage
	
	_damage_process(damage_value)
	
	$Timer.start(damage_interval)
	for connection in $Timer.get_signal_connection_list("timeout"):
		$Timer.disconnect(connection["signal"].get_name(), connection["callable"])
	$Timer.connect("timeout", _remove_damage_state)
	
	
func _damage_process(damage_value : int):
	hp -= damage_value

func _remove_damage_state():
	state = previous_state


func get_prop_dict():
	return {
		"physical_atk" : physical_atk,
		"magical_atk" : magical_atk,
		"physical_def" : physical_def,
		"magical_def" : magical_def,
		"physical_crit_bonus" : physical_crit_bonus,
		"magical_crit_bonus" : magical_crit_bonus,
		"physical_crit_chance" : physical_crit_chance,
		"magical_crit_chance" : magical_crit_chance
	}
