class_name Weapon
extends Item


const Assets = preload("res://scenes/global/assets.gd")

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



func init_weapon(weapon_data : Dictionary):
	var weapon_icon = load(Assets.dir_tres_weapon + weapon_data["icon"]) as Texture2D
	super.init(weapon_data["name"], false, weapon_icon)
	physical_atk = float(weapon_data["physical_ATK"])
	magical_atk = float(weapon_data["magical_ATK"])
	physical_def = float(weapon_data["physical_DEF"])
	magical_def = float(weapon_data["magical_DEF"])
	physical_crit_bonus = float(weapon_data["physical_crit_bonus"])
	magical_crit_bonus = float(weapon_data["magical_crit_bonus"])
	physical_crit_chance = float(weapon_data["physical_crit_chance"])
	magical_crit_chance = float(weapon_data["magical_crit_chance"])


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
