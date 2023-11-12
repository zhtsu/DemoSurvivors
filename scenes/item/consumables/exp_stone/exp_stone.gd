class_name ExpStone
extends Item


const at_loot_exp_stone_green = preload("res://tress/loot/at_loot_exp_stone_green.tres")
const at_loot_exp_stone_blue = preload("res://tress/loot/at_loot_exp_stone_blue.tres")
const at_loot_exp_stone_orange = preload("res://tress/loot/at_loot_exp_stone_orange.tres")
const at_loot_exp_stone_red = preload("res://tress/loot/at_loot_exp_stone_red.tres")
const at_loot_exp_stone_purple = preload("res://tress/loot/at_loot_exp_stone_purple.tres")
const at_loot_exp_stone_black = preload("res://tress/loot/at_loot_exp_stone_black.tres")

var exp_volume : int
var player : Player


func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	var at_loot_exp_stone : AtlasTexture
	if exp_volume < 20:
		at_loot_exp_stone = at_loot_exp_stone_green
	elif exp_volume >= 20 and exp_volume < 40:
		at_loot_exp_stone = at_loot_exp_stone_blue
	elif exp_volume >= 40 and exp_volume < 60:
		at_loot_exp_stone = at_loot_exp_stone_orange
	elif exp_volume >= 60 and exp_volume < 80:
		at_loot_exp_stone = at_loot_exp_stone_red
	elif exp_volume >= 80 and exp_volume < 100:
		at_loot_exp_stone = at_loot_exp_stone_purple
	elif exp_volume >= 100:
		at_loot_exp_stone = at_loot_exp_stone_black
		
	super.init("EXP Stone", true, at_loot_exp_stone)


func _physics_process(_delta):
	if position.distance_to(player.position) > 400.0:
		Data.exp_stone_array.erase(self)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	Data.exp_stone_array.erase(self)
	queue_free()
