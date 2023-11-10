class_name Ability
extends Item


var cooldown : float = 2.0
var speed : float = 1.0
var damage_type : Enums.EDamageType = Enums.EDamageType.Physical
var damage_scale : float = 1.0
var distance : float = 100.0


func init_ability(ability_data : Dictionary):
	var ability_icon = load(Assets.dir_tres_ability + ability_data["icon"]) as Texture2D
	super.init(ability_data["name"], false, ability_icon)
	cooldown = float(ability_data["cooldown"])
	speed = float(ability_data["speed"])
	damage_type = Enums.EDamageType.get(ability_data["damage_type"])
	damage_scale = float(ability_data["damage_scale"])
	distance = float(ability_data["distance"])
