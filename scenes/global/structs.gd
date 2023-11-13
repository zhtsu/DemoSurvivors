extends Node


class Attributes:
	var physical_atk : float
	var magical_atk : float

	var physical_def : float
	var magical_def : float
	# 0.0 ~ 1.0
	var physical_crit_bonus : float
	var magical_crit_bonus : float
	# 0.0 ~ 1.0
	var physical_crit_chance : float
	var magical_crit_chance : float
	
	
class DamageData:
	var type : Enums.EDamageType
	var physical_damage : float
	var with_physical_crit : bool
	var magical_damage : float
	var with_magical_crit : bool
	
	
class ProjectileData:
	var spawn_position : Vector2 = Vector2(0.0, 0.0)
	var velocity : Vector2 = Vector2(0.0, 0.0)
	var speed : float = 1.0
	var distance : float = 100.0
	var damage_type : Enums.EDamageType = Enums.EDamageType.Physical
	var damage_scale : float = 1.0
	var knockback_distance : float = 0.0
	var penertration : int = 0
	
