extends Node2D

@export var PhysicalAtk = 0.0
@export var MagicAtk = 0.0

@export var PhysicalDef = 0.0
@export var MagicDef = 0.0

# 0.0 ~ 1.0
@export var PhysicalCritProb = 0.0
@export var MagicCritProb = 0.0

# 0.0 ~ 1.0
@export var PhysicalCritRate = 0.0
@export var MagicCritRate = 0.0
	

func CalPhysicalAtk() -> Dictionary:
	var CriticalPhysicalAtk = 0.0
	var IsCrit = false

	if randf_range(0.0, 1.0) < PhysicalCritProb:
		IsCrit = true
		CriticalPhysicalAtk = PhysicalAtk * randf_range(0.0, PhysicalCritRate)
	
	var Result = {
		"IsCrit": IsCrit,
		"Value": PhysicalAtk + CriticalPhysicalAtk	
	}
	
	return Result


func CalMagicAtk() -> Dictionary:
	var CriticalMagicAtk = 0.0
	var IsCrit = false

	if randf_range(0.0, 1.0) < MagicCritProb:
		IsCrit = true
		CriticalMagicAtk = MagicAtk * randf_range(0.0, MagicCritRate)
	
	var Result = {
		"IsCrit": IsCrit,
		"Value": MagicAtk + CriticalMagicAtk	
	}
	
	return Result
