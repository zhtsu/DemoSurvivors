class_name Character
extends CharacterBody2D


signal damage

const Enums = preload("res://scenes/global/enums.gd")
const tscn_damage_popup = preload("res://scenes/utility/damage_popup/damage_popup.tscn")
#
const ECharacterState = Enums.EState
const ECharacterDirection = Enums.EDirection

var character_name = "角色名称"
var speed : float = 1
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

var damage_interval := 0.2

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
	
	
func take_damage(damage_data : Dictionary):
	if state == ECharacterState.Damage:
		state = ECharacterState.Idle
		if self is Enemy:
			state = ECharacterState.Walk
		return
	
	state = ECharacterState.Damage
	
	if self is Enemy:
		_popup_damage_value(damage_data)
	
	hp -= float(damage_data["Value"])
	damage.emit()
	$DamageTimer.start(damage_interval)


func _popup_damage_value(damage_data : Dictionary):
	var damage_type = Enums.EDamageType.values()[int(damage_data["Type"])]
	if damage_type == Enums.EDamageType.Both:
		var physical_damage_value = damage_data["PhysicalValue"]
		var physical_crit = damage_data["PhysicalCrit"]
		_create_damage_popup(physical_damage_value, Enums.EDamageType.Physical, physical_crit)
		var magical_damage_value = damage_data["MagicalValue"]
		var magical_crit = damage_data["PhysicalCrit"]
		_create_damage_popup(magical_damage_value, Enums.EDamageType.Magical, magical_crit)
	else:
		var damage_value = float(damage_data["Value"])
		var is_crit = bool(damage_data["Crit"])
		_create_damage_popup(damage_value, damage_type, is_crit)

func _create_damage_popup(damage_value : float, damage_type : Enums.EDamageType, is_crit : bool):
	var damage_popup = tscn_damage_popup.instantiate()
	damage_popup.init(damage_value, damage_type, is_crit)
	damage_popup.position = position
	get_tree().get_first_node_in_group("level").add_child(damage_popup)


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
	var overlapping_areas = $HurtBox.get_overlapping_areas()
	if overlapping_areas.size() > 0:
		for hit_box in overlapping_areas:
			$HurtBox.area_entered.emit(hit_box)
	else:
		state = ECharacterState.Idle
		if self is Enemy:
			state = ECharacterState.Walk


func _on_hurt_box_area_exited(_area):
	state = ECharacterState.Idle
	if self is Enemy:
		state = ECharacterState.Walk
