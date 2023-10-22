class_name ExpStone
extends Item


const at_loot_exp_stone_green = preload("res://tress/at_loot_exp_stone_green.tres")
const at_loot_exp_stone_blue = preload("res://tress/at_loot_exp_stone_blue.tres")
const at_loot_exp_stone_orange = preload("res://tress/at_loot_exp_stone_orange.tres")
const at_loot_exp_stone_red = preload("res://tress/at_loot_exp_stone_red.tres")
const at_loot_exp_stone_purple = preload("res://tress/at_loot_exp_stone_purple.tres")
const at_loot_exp_stone_black = preload("res://tress/at_loot_exp_stone_black.tres")

@export var exp_volume : int


func _ready():
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
		
	super.init("EXP", at_loot_exp_stone, true)

