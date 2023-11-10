class_name Weapon
extends Item


var attr := Structs.Attributes.new()


func init_weapon(weapon_data : Dictionary):
	var weapon_icon = load(Assets.dir_tres_weapon + weapon_data["icon"]) as Texture2D
	super.init(weapon_data["name"], false, weapon_icon)
	attr.physical_atk = float(weapon_data["physical_ATK"])
	attr.magical_atk = float(weapon_data["magical_ATK"])
	attr.physical_def = float(weapon_data["physical_DEF"])
	attr.magical_def = float(weapon_data["magical_DEF"])
	attr.physical_crit_bonus = float(weapon_data["physical_crit_bonus"])
	attr.magical_crit_bonus = float(weapon_data["magical_crit_bonus"])
	attr.physical_crit_chance = float(weapon_data["physical_crit_chance"])
	attr.magical_crit_chance = float(weapon_data["magical_crit_chance"])

