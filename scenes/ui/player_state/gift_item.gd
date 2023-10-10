extends Panel


@export var as_weapon = false

const at_item_dagger_ninja = preload("res://tress/at_item_dagger_ninja.tres")
const at_ability_the_hand_of_god = preload("res://tress/at_ability_the_hand_of_god.tres")

func _ready():
	if as_weapon:
		$TextureRect.texture = at_item_dagger_ninja
	else:
		$TextureRect.texture = at_ability_the_hand_of_god
