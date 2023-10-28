class_name Item
extends Node2D


#
# Weapon provides attribute bonuses to player
# Ability provides special effect to player (eg. Player can heal HP from attacks)
#


# Item is visible in map when pickable is true
# And player can pick up it by collide the Item
@export var pickable : bool = false
var icon : Texture2D = null
var item_name : String = "Item"
var level : int = 1


func init(in_item_name : String = "Item", in_pickable : bool = false,
		  in_icon : Texture2D = null):
	item_name = in_item_name
	pickable = in_pickable
	if not in_icon == null:
		icon = in_icon
		$Sprite2D.texture = icon
	
	if pickable == false:
		$Sprite2D.hide()
		$Area2D.monitoring = false
		$Area2D.monitorable = false
	
	
func color() -> Color:
	return $Sprite2D.modulate
	
	
