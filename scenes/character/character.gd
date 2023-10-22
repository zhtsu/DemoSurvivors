class_name Character
extends CharacterBody2D


signal damage


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
var enemy_has_damage_interval := false

@export var spawn_position = Vector2(0, 0)

var direction = ECharacterDirection.Right
var state = ECharacterState.Idle
var size : Vector2
# Used for process damage logic
var previous_entered_area : HitBox


func _init_character():
	position = spawn_position
	size = $CollisionShape2D.shape.get_rect().size
	

# Make sure call this function once before _ready()
# Otherwise, the action script will not work
func _set_action_gdscript(script : Script):
	$Action.set_script(script)
	
	

func take_damage(damage_value : int):
	if self is Enemy:
		hp -= damage_value
		return
	
	if state == ECharacterState.Damage:
		state = ECharacterState.Idle
		return
	
	state = ECharacterState.Damage
	
	hp -= damage_value
	
	damage.emit()
	$DamageTimer.start(damage_interval)


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



func _on_damage_timer_timeout():
	if $HurtBox.get_overlapping_areas().size() > 0:
		$HurtBox.area_entered.emit(previous_entered_area)


func _on_hurt_box_area_exited(_area):
	state = ECharacterState.Idle
