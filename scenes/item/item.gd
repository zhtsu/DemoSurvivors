class_name Item
extends Node2D


const Enums = preload("res://scenes/global/enums.gd")

# Weapon provides attribute bonuses to player
# Ability provides special effect to player (eg. Player can heal HP from attacks)
var type := Enums.ItemType.Weapon

@export var physical_atk = 0.0
@export var magical_atk = 0.0

@export var physical_def = 0.0
@export var magical_def = 0.0
# 0.0 ~ 1.0
@export var physical_crit_bonus = 0.0
@export var magical_crit_bonus = 0.0
# 0.0 ~ 1.0
@export var physical_crit_rate = 0.0
@export var magical_crit_rate = 0.0

var icon : Texture2D

# Make sure call this function once before _ready()
# Otherwise, the action script will not work
func _set_action_gdscript(action_script : Script):
	$Action.set_script(action_script)


func _ready():
	pass


