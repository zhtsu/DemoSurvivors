class_name Weapon
extends Item


@export var physical_atk = 0.0
@export var magical_atk = 0.0

@export var physical_def = 0.0
@export var magical_def = 0.0
# 0.0 ~ 1.0
@export var physical_crit_bonus = 0.0
@export var magical_crit_bonus = 0.0
# 0.0 ~ 1.0
@export var physical_crit_chance = 0.0
@export var magical_crit_chance = 0.0


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
