extends Node2D

@export var physical_atk = 0.0
@export var magic_atk = 0.0

@export var physical_def = 0.0
@export var magic_def = 0.0

# 0.0 ~ 1.0
@export var physical_crit_prob = 0.0
@export var magic_crit_prob = 0.0

# 0.0 ~ 1.0
@export var physical_crit_rate = 0.0
@export var magic_crit_rate = 0.0
	

func cal_physical_atk() -> Dictionary:
	var critical_physical_atk = 0.0
	var crit = false

	if randf_range(0.0, 1.0) < physical_crit_prob:
		crit = true
		critical_physical_atk = physical_atk * randf_range(0.0, physical_crit_rate)
	
	var result = {
		"Crit": crit,
		"Value": physical_atk + critical_physical_atk
	}
	
	return result


func CalMagicAtk() -> Dictionary:
	var critical_magic_atk = 0.0
	var crit = false

	if randf_range(0.0, 1.0) < magic_crit_prob:
		crit = true
		critical_magic_atk = magic_atk * randf_range(0.0, magic_crit_rate)
	
	var result = {
		"IsCrit": crit,
		"Value": magic_atk + critical_magic_atk
	}
	
	return result
